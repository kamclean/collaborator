# redcap_label-------------------------
# Documentation
#' Export REDCap dataset and label using metadata
#' @description Export the REDCap dataset, and use the metadata to classify the variables and label the columns.
#' @param redcap_project_uri URI (Uniform Resource Identifier) for the REDCap instance.
#' @param redcap_project_token API (Application Programming Interface) for the REDCap project.
#' @param use_ssl Logical value whether verify the peer's SSL certificate should be evaluated (default=TRUE)
#' @param column_name Determine if output column names should be unchanged from the REDCap record export ("raw") or labelled ("label"). Default = "raw".
#' @param column_attr Determine if a labelled attribute should be applied and whether this should be the original ("raw") or labelled ("label") name. Default = NULL.
#' @import dplyr
#' @importFrom RCurl postForm
#' @importFrom readr read_csv
#' @importFrom lubridate as_date as_datetime
#' @importFrom tidyselect all_of
#' @importFrom tibble tibble
#' @return Three nested tibbles: (1) "exported": REDcap record export (unchanged) (2) labelled": REDcap record export with variables classified and columns labelled as specified via column_name and column_attr (3) "metadata": Cleaned metadata file for the REDCap dataset.
#' @export

# Function:
redcap_label <- function(redcap_project_uri, redcap_project_token, use_ssl = TRUE,
                         column_name = "raw", column_attr = NULL){

  require(dplyr);require(RCurl);require(readr);require(lubridate); require(tidyselect);require(tibble)

  # Label individual variables -----------------------------
  # Get metadata
  source("/home/kmclean/collaborator/R/updated/redcap_metadata.R")  # collaborator::redcap_metadata
  meta <- redcap_metadata(redcap_project_uri = redcap_project_uri,
                          redcap_project_token = redcap_project_token,
                          use_ssl = use_ssl)

  # Supported REDCap classes
  meta_factor <- meta %>% dplyr::filter(class=="factor")
  meta_numeric <- meta %>% dplyr::filter(class=="numeric")
  meta_date <- meta %>% dplyr::filter(class=="date")
  meta_datetime <- meta %>% dplyr::filter(class=="datetime")
  meta_logical <- meta %>% dplyr::filter(class=="logical")
  meta_file <- meta %>% dplyr::filter(class=="file")
  meta_character <- meta %>% dplyr::filter(class=="character")

  # Get data
  data_original <- RCurl::postForm(uri=redcap_project_uri,
                                   token = redcap_project_token,
                                   content='record',
                                   exportDataAccessGroups = 'true',
                                   .opts = curlOptions(ssl.verifypeer = if(use_ssl==F){FALSE}else{TRUE}),
                                   format='csv',
                                   raworLabel="raw") %>% readr::read_csv()

  data_labelled <- data_original

  # Factors
  if(nrow(meta_factor)>0){
    for(i in c(1:nrow(meta_factor))){
      data_labelled <- data_labelled %>%
        dplyr::mutate_at(dplyr::vars(meta_factor$variable_name[[i]]),
                         function(x){factor(x,
                                            levels = meta_factor$factor_level[[i]],
                                            labels = meta_factor$factor_label[[i]])})}}

  # Numeric
  if(nrow(meta_numeric)>0){
    for(i in c(1:nrow(meta_numeric))){
      data_labelled <- data_labelled %>%
        dplyr::mutate_at(dplyr::vars(meta_numeric$variable_name[[i]]),
                         function(x){as.numeric(x)})}}

  # Date
  if(nrow(meta_date)>0){
    for(i in c(1:nrow(meta_date))){
      data_labelled <- data_labelled %>%
        dplyr::mutate_at(dplyr::vars(meta_date$variable_name[[i]]),
                         function(x){lubridate::as_date(x)})}}

  # Datetime
  if(nrow(meta_datetime)>0){
    for(i in c(1:nrow(meta_datetime))){
      data_labelled <- data_labelled %>%
        dplyr::mutate_at(dplyr::vars(meta_datetime$variable_name[[i]]),
                         function(x){lubridate::as_datetime(x)})}}

  # Logical
  if(nrow(meta_logical)>0){
    for(i in c(1:nrow(meta_logical))){
      data_labelled <- data_labelled %>%
        dplyr::mutate_at(dplyr::vars(meta_logical$variable_name[[i]]),
                         function(x){as.logical(x)})}}

  # File
  if(nrow(meta_file)>0){
    for(i in c(1:nrow(meta_file))){
      data_labelled <- data_labelled %>%
        dplyr::mutate_at(dplyr::vars(meta_file$variable_name[[i]]),
                         function(x){ifelse(is.na(x)==T, FALSE, TRUE)})}}

  # Characters
  if(nrow(meta_character)>0){
    for(i in c(1:nrow(meta_character))){
      data_labelled <- data_labelled %>%
        dplyr::mutate_at(dplyr::vars(meta_character$variable_name[[i]]),
                         function(x){as.character(x)})}}

  # Special variables
  var_complete <- paste0(unique(meta$form_name), "_complete")
  data_labelled <- data_labelled %>%
    dplyr::mutate_at(dplyr::vars(tidyselect::all_of(var_complete)),
                     function(x){as.character(x) %>% factor(levels = c("0", "1","2"),
                                                            labels = c("Incomplete", "Unverified", "Complete"))}) %>%
    dplyr::mutate(redcap_data_access_group= factor(redcap_data_access_group, levels=sort(unique(redcap_data_access_group))))




  meta = tibble::tibble(variable_name = colnames(data_original)) %>%
    dplyr::left_join(meta, by = 'variable_name') %>%
    dplyr::mutate(class = ifelse(variable_name %in% c('redcap_data_access_group', var_complete), "factor", class),
                  form_name = ifelse(variable_name %in% var_complete, gsub("_complete", "", var_complete), form_name),
                  variable_label = ifelse(variable_name == 'redcap_data_access_group', 'REDCap Data Access Group', variable_label)) %>%
    dplyr::mutate(variable_label = ifelse(is.na(variable_label), variable_name, variable_label))

  # Label columns---------------------------------

  # column_attr = "raw" or "label"  (default NULL)
  if(is.null(column_attr)==F){

    var_label = function(x, var_label, ...){Hmisc::label(x) = var_label
    return(x)}

    if(column_attr=="label"){
      data_labelled = purrr::modify2(.x = data_labelled, # the first object to iterate over
                                     .y = meta$variable_label, # the second object to iterate over
                                     ~ var_label(.x, var_label = .y)) %>%
        dplyr::select(!!colnames(data_labelled))} #this gives it back in the right order

    if(column_attr=="raw"){
      data_labelled = purrr::modify2(.x = data_labelled, # the first object to iterate over
                                     .y = meta$variable_name, # the second object to iterate over
                                     ~ var_label(.x, var_label = .y)) %>%
        dplyr::select(!!colnames(data_labelled))}}

  # column_name = "raw" or "label" (default = raw)
  if(column_name == "label"){
    colnames(data_labelled) = meta$variable_label[which(colnames(data_labelled) %in% meta$variable_name)]}



  return(list("exported" = data_original, "labelled" = data_labelled, "metadata" = meta))}
