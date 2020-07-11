# redcap_label-------------------------
# Documentation
#' Export REDCap dataset and label using metadata
#' @description Export the REDCap dataset, and use the metadata to classify the variables and label the columns.
#' @param redcap_project_uri URI (Uniform Resource Identifier) for the REDCap instance.
#' @param redcap_project_token API (Application Programming Interface) for the REDCap project.
#' @param use_ssl Logical value whether verify the peer's SSL certificate should be evaluated (default=TRUE)
#' @param column_name Determine if output column names should be unchanged from the REDCap record export ("raw") or labelled ("label"). Default = "raw".
#' @param column_attr Determine if a labelled attribute should be applied and whether this should be the original ("raw") or labelled ("label") name. Default = NULL.
#' @param checkbox_value Determine if output checkbox variables should be unchanged from the REDCap record export ("raw") or labelled ("label"). Default = "raw".
#' @import dplyr
#' @importFrom RCurl postForm curlOptions
#' @importFrom readr read_csv
#' @importFrom lubridate as_date as_datetime
#' @importFrom tidyselect all_of
#' @importFrom tibble tibble
#' @return Three nested tibbles: (1) "exported": REDcap record export (unchanged) (2) labelled": REDcap record export with variables classified and columns labelled as specified via column_name and column_attr (3) "metadata": Cleaned metadata file for the REDCap dataset.
#' @export

redcap_project_uri = Sys.getenv("surginf_url")
redcap_project_token = Sys.getenv("twist_api_wgh")
data = NULL
metadata = NULL
column_name = "raw"
column_attr = NULL
checkbox_value = "label"
use_ssl = TRUE
# Function:
redcap_label <- function(data = NULL, metadata = NULL,
                         redcap_project_uri  = NULL, redcap_project_token  = NULL, use_ssl = TRUE,
                         column_name = "raw", column_attr = NULL, checkbox_value = "label"){

  require(dplyr);require(RCurl);require(readr);require(lubridate); require(tidyselect);require(tibble)

  # Load required data--------------------
  # Project data
  if(is.null(redcap_project_uri)==F&is.null(redcap_project_token)==F&is.null(data)==T){
    data <- RCurl::postForm(uri=redcap_project_uri,
                            token = redcap_project_token,
                            content='record',
                            exportDataAccessGroups = 'true',
                            .opts = RCurl::curlOptions(ssl.verifypeer = if(use_ssl==F){FALSE}else{TRUE}),
                            format='csv',
                            raworLabel="raw") %>% readr::read_csv()}

  data_labelled <- data

  # Project metadata
  if(is.null(redcap_project_uri)==F&is.null(redcap_project_token)==F&is.null(metadata)==T){
    metadata <- redcap_metadata(redcap_project_uri = redcap_project_uri,
                                               redcap_project_token = redcap_project_token,
                                               use_ssl = use_ssl)}

  # Format-------------------
  # Format checkbox variables
  if(checkbox_value=="label"){
    metadata <- metadata %>%
      dplyr::group_by(variable_name) %>%
      dplyr::mutate(factor_level = ifelse(variable_type=="checkbox", list(c(0,1)),factor_level),
                    factor_label = ifelse(variable_type=="checkbox", list(c("Unchecked", select_choices_or_calculations)),factor_label)) %>%
      dplyr::ungroup()}


var_required <- metadata %>%
  dplyr::filter(variable_identifier=="Yes") %>%
  dplyr::pull(variable_name)


  # if patient identifiable (and don't have access, add blank columns)
  if(unique(var_required %in% names(data))==F){
    data_labelled <- data_labelled %>%
    dplyr::bind_cols( tibble::enframe(var_required, name = NULL, value = "variable") %>%
                        dplyr::mutate(value = list(rep(NA, nrow(data_labelled)))) %>%
                        tidyr::pivot_wider(names_from = "variable") %>%
                        tidyr::unnest(cols = everything())) %>%
    dplyr::select(all_of(names(data_labelled)))}

  # Supported REDCap classes
  meta_factor <- metadata %>% dplyr::filter(class=="factor")
  meta_numeric <- metadata %>% dplyr::filter(class=="numeric")
  meta_date <- metadata %>% dplyr::filter(class=="date")
  meta_datetime <- metadata %>% dplyr::filter(class=="datetime")
  meta_logical <- metadata %>% dplyr::filter(class=="logical")
  meta_file <- metadata %>% dplyr::filter(class=="file")
  meta_character <- metadata %>% dplyr::filter(class=="character")


  # Factors
  if(nrow(meta_factor)>0){
    for(i in c(1:nrow(meta_factor))){
      data_labelled <- data_labelled %>%
        dplyr::mutate_at(dplyr::vars(meta_factor$variable_name[[i]]),
                         function(x){factor(x,
                                            levels = meta_factor$factor_level[[i]],
                                            labels = meta_factor$factor_label[[i]])}) %>%
        dplyr::mutate_at(dplyr::vars(meta_factor$variable_name[[i]]),
                         function(x){forcats::fct_recode(x, NULL = "Unchecked")})}}

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
  var_complete <- paste0(unique(metadata$form_name), "_complete")
  data_labelled <- data_labelled %>%
    dplyr::mutate_at(dplyr::vars(tidyselect::all_of(var_complete)),
                     function(x){as.character(x) %>% factor(levels = c("0", "1","2"),
                                                            labels = c("Incomplete", "Unverified", "Complete"))})

  if("redcap_data_access_group" %in% names(data_labelled)){data_labelled <- data_labelled %>%
    dplyr::mutate(redcap_data_access_group= factor(redcap_data_access_group, levels=sort(unique(redcap_data_access_group))))}

  if("redcap_event_name" %in% names(data_labelled)){data_labelled <- data_labelled %>%
    dplyr::mutate(redcap_event_name= factor(redcap_event_name, levels=sort(unique(redcap_event_name))))}

  if("redcap_repeat_instance" %in% names(data_labelled)){data_labelled <- data_labelled %>%
    dplyr::mutate(redcap_repeat_instrument= factor(redcap_repeat_instrument, levels=sort(unique(redcap_repeat_instrument))),
                  redcap_repeat_instance = as.numeric(redcap_repeat_instance))}

  metadata = tibble::tibble(variable_name = colnames(data)) %>%
    dplyr::left_join(metadata, by = 'variable_name') %>%
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
                                     .y = metadata$variable_label, # the second object to iterate over
                                     ~ var_label(.x, var_label = .y)) %>%
        dplyr::select(!!colnames(data_labelled))} #this gives it back in the right order

    if(column_attr=="raw"){
      data_labelled = purrr::modify2(.x = data_labelled, # the first object to iterate over
                                     .y = metadata$variable_name, # the second object to iterate over
                                     ~ var_label(.x, var_label = .y)) %>%
        dplyr::select(!!colnames(data_labelled))}}

  # column_name = "raw" or "label" (default = raw)
  if(column_name == "label"){
    colnames(data_labelled) = metadata$variable_label[which(colnames(data_labelled) %in% metadata$variable_name)]}

  return(list("exported" = data, "labelled" = data_labelled, "metadata" = metadata))}
