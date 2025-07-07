# redcap_data-------------------------
# Documentation
#' Export REDCap dataset and label using metadata
#' @description Export the REDCap dataset, and use the metadata to classify the variables and label the columns.
#' @param redcap_project_uri URI (Uniform Resource Identifier) for the REDCap instance.
#' @param redcap_project_token API (Application Programming Interface) for the REDCap project.
#' @param forms A list of forms wanted to be extracted, rather the the full dataset (default = "all"). This MUST align with the form_name as per redcap_metadata().
#' @param report_id A specific REDCap report ID wanted to be extracted, rather the the full dataset (default = NULL).
#' @param filterlogic Filter wished to be applied to the redcap project prior to pulling. MUST be in REDCap format not R format (default = NULL).
#' @param checkbox_value Determine if output checkbox variables should be unchanged from the REDCap record export ("raw") or labelled ("label"). Default = "raw".
#' @param include_original Logical value to determine whether original data should be provided too (default = FALSE).
#' @param include_complete Logical value to determine whether columns specifiying if forms are complete should be retained.
#' @param include_label Logical value to determine whether ff_label should be used to apply the (human readable) label from REDCap to columns
#' @param include_surveyfield Logical value to determine whether survey fields are extracted (e.g. timestamps)
#' @param repeat_format The format the repeating instrument data should be provided in. Options include "long" (default), "wide" (each instance a separate column), or "list" (nested instances).
#' @import dplyr
#' @importFrom httr POST content
#' @importFrom readr read_csv
#' @importFrom lubridate as_date as_datetime
#' @importFrom tidyselect all_of
#' @importFrom tibble tibble
#' @return Three nested tibbles: (1) "exported": REDcap record export (unchanged) (2) labelled": REDcap record export with variables classified and columns labelled as specified via column_name and column_attr (3) "metadata": Cleaned metadata file for the REDCap dataset.
#' @export

# Function:

redcap_data <- function(redcap_project_uri, redcap_project_token, forms = "all", report_id = NULL, filterlogic = NULL,
                        checkbox_value = "label", repeat_format = "long",
                        include_original = F, include_complete = F, include_surveyfield = F, include_label = F){

  require(dplyr);require(httr);require(readr);require(lubridate); require(tidyselect);require(tibble)

  # Load required data--------------------

  # Project metadata
  metadata <-  collaborator::redcap_metadata(redcap_project_uri = redcap_project_uri,
                                             redcap_project_token = redcap_project_token) %>%
    dplyr::filter(variable_type!="descriptive")


  var_admin = c("record_id", "redcap_data_access_group", "redcap_repeat_instrument", "redcap_repeat_instance")

  if(paste0(forms, collapse = "")!="all"){
    metadata <- metadata %>%
      filter(form_name %in% forms | variable_name %in% var_admin)}

  altrecord_id <- metadata %>%
    filter(variable_name=="record_id") %>%
    pull(altrecord_id)

  if(is.na(altrecord_id)==T){altrecord_id=NULL}

  # Project data
  include_surveyfield = ifelse(include_surveyfield==T, "true", "false")

  if(paste0(forms, collapse = "")=="all"){
    if(is.null(filterlogic)==T){filterlogic=""}

    if(is.null(report_id)==T){
      data <- httr::POST(url = redcap_project_uri,
                         body = list("token"=redcap_project_token,
                                     content='record',
                                     action='export',
                                     format='csv',
                                     type='flat',
                                     csvDelimiter='',
                                     rawOrLabel='raw',
                                     rawOrLabelHeaders='raw',
                                     filterLogic=filterlogic,
                                     exportCheckboxLabel='false',
                                     exportSurveyFields=include_surveyfield,
                                     exportDataAccessGroups='true',
                                     returnFormat='json'),
                         encode = "form") %>%
        httr::content(type = "text/csv",show_col_types = FALSE,
                      guess_max = 100000, encoding = "UTF-8")}

    if(is.null(report_id)==F){
      data <- httr::POST(url = redcap_project_uri,
                         body = list("token"=redcap_project_token,
                                     content='report',
                                     format='csv',
                                     report_id = report_id,
                                     type='flat',
                                     csvDelimiter='',
                                     filterLogic=filterlogic,
                                     rawOrLabel='raw',
                                     rawOrLabelHeaders='raw',
                                     exportCheckboxLabel='false',
                                     exportSurveyFields=include_surveyfield,
                                     exportDataAccessGroups='true',
                                     returnFormat='json'),
                         encode = "form") %>%
        httr::content(type = "text/csv",show_col_types = FALSE,
                      guess_max = 100000, encoding = "UTF-8")

      # metadata contains only data in report
      metadata <- metadata %>%
        filter(variable_name %in% c(names(data), altrecord_id))}}


  if(paste0(forms, collapse = "")!="all"){
    formlist = tibble(forms) %>%
      mutate(n = 1:n()-1,
             formname = paste0("forms[", n, "]")) %>%
      select(-n) %>% tidyr::pivot_wider(names_from = "formname", values_from = "forms") %>%
      as.list()

    if(is.null(filterlogic)==T){filterlogic=""}

    if(is.null(altrecord_id)==T){recordidexport = list("fields[0]" = "record_id")}
    if(is.null(altrecord_id)==F){recordidexport = list("fields[0]" = altrecord_id)}

    data <- httr::POST(url = redcap_project_uri,
                       body = c(list("token"=redcap_project_token,
                                     content='record',
                                     action='export',
                                     format='csv',
                                     type='flat',
                                     filterLogic=filterlogic,
                                     csvDelimiter='',
                                     rawOrLabel='raw',
                                     rawOrLabelHeaders='raw',
                                     exportCheckboxLabel='false',
                                     exportSurveyFields=include_surveyfield,
                                     exportDataAccessGroups='true',
                                     returnFormat='json'),
                                formlist,
                                recordidexport),
                       encode = "form") %>%
      httr::content(type = "text/csv",show_col_types = FALSE,
                    guess_max = 100000, encoding = "UTF-8")}

  # rename alternative record_id to record_id
  if(is.null(altrecord_id)==F){data <- data %>%
    rename("record_id" = all_of(altrecord_id))}

  data <- data %>%
    select(any_of(var_admin), everything())


  var_complete <- NULL
  if(include_complete==F){data <- data %>% select(-ends_with("_complete"))}
  if(include_complete==T){
    var_complete <- data %>%
      dplyr::select(ends_with("_complete")) %>% names()

  metadata <- metadata %>%
    bind_rows(tibble::tibble(variable_name = var_complete)) %>%
    dplyr::mutate(class = ifelse(variable_name %in% var_complete, "factor", class),
                  form_name = ifelse(variable_name %in% var_complete,
                                     stringr::str_remove_all(variable_name, "_complete"),
                                     form_name),
                  variable_type = ifelse(variable_name %in% var_complete, "dropdown", variable_type),
                  variable_identifier = ifelse(variable_name %in% var_complete, "No", variable_identifier),
                  variable_required = ifelse(variable_name %in% var_complete, "No", variable_required),
                  variable_label = ifelse(variable_name %in% var_complete, variable_name, variable_label),
                  select_choices_or_calculations = ifelse(variable_name %in% var_complete,
                                                          c("0, Incomplete | 1, Unverified | 2, Complete"),
                                                          factor_label),
                  factor_level = ifelse(variable_name %in% var_complete,
                                        list(c(0, 1, 2)),
                                        factor_label),
                  factor_label = ifelse(variable_name %in% var_complete,
                                        list(c("Incomplete","Unverified","Complete")),
                                        factor_label)) %>%
    dplyr::group_by(form_name) %>%
    tidyr::fill(arm, redcap_event_name, .direction = "down") %>%
    dplyr::ungroup()}

  data_labelled <- data %>% dplyr::select(-ends_with("___"))

  # Format-------------------
  # Repeating instruments
  if("redcap_data_access_group" %in% names(data_labelled)){data_labelled <- data_labelled %>%
    dplyr::mutate(redcap_data_access_group= factor(redcap_data_access_group, levels=sort(unique(redcap_data_access_group))))}

  if(!("redcap_data_access_group" %in% names(data_labelled))){data_labelled <- data_labelled %>%
    dplyr::mutate(redcap_data_access_group= factor(NA))}

  if("redcap_event_name" %in% names(data_labelled)){data_labelled <- data_labelled %>%
    dplyr::mutate(redcap_event_name= factor(redcap_event_name, levels=sort(unique(redcap_event_name))))}

  if(("redcap_repeat_instance" %in% names(data_labelled))==T){

    form_repeat <- data_labelled %>%
      filter(is.na(redcap_repeat_instrument)==F) %>%
      pull(redcap_repeat_instrument) %>% unique()

    record_repeat <- data_labelled %>%
      filter(is.na(redcap_repeat_instrument)==F) %>%
      pull(record_id) %>% unique()

    var_norepeat <- metadata %>%
      dplyr::mutate(form_repeat = ifelse(form_name %in% form_repeat, "Yes", "No"))%>%
      filter(form_repeat=="No") %>%
      filter(! variable_name %in% c("record_id","redcap_data_access_group")) %>%
      dplyr::pull(variable_name)

    var_repeat <- metadata %>%
      dplyr::mutate(form_repeat = ifelse(form_name %in% form_repeat, "Yes", "No"))%>%
      filter(form_repeat=="Yes") %>%
      dplyr::pull(variable_name)

    data_labelled <- data_labelled %>%
      dplyr::mutate(redcap_repeat_instrument= factor(redcap_repeat_instrument, levels=sort(unique(redcap_repeat_instrument))),
                    redcap_repeat_instance = as.numeric(redcap_repeat_instance),
                    redcap_repeat_instance = ifelse(is.na(redcap_repeat_instance)==T, 0, redcap_repeat_instance)) %>%
      group_by(record_id, redcap_data_access_group,redcap_repeat_instance) %>%
      tidyr::fill(all_of(var_repeat), .direction = "updown") %>%
      group_by(record_id, redcap_data_access_group) %>%
      tidyr::fill(any_of(c(var_norepeat, "redcap_repeat_instrument")), .direction = "downup") %>%
      dplyr::ungroup() %>%
      dplyr::mutate(redcap_repeat_instance = ifelse(record_id %in% record_repeat, redcap_repeat_instance, 1)) %>%
      filter(redcap_repeat_instance!=0) %>%
      dplyr::distinct() %>%
      dplyr::arrange(record_id, redcap_data_access_group,redcap_repeat_instance)}

  # Format checkbox variables
  if(checkbox_value=="label"){
    metadata <- metadata %>%
      dplyr::group_by(variable_name) %>%
      dplyr::mutate(factor_level = ifelse(variable_type=="checkbox", list(c(0,1)),factor_level),
                    factor_label = ifelse(variable_type=="checkbox", list(c("Unchecked", select_choices_or_calculations)),factor_label)) %>%
      dplyr::ungroup()}

  var_new <- names(data_labelled)[! (names(data_labelled) %in% metadata$variable_name)]
  if(length(var_new)>0){

    metadata <- metadata %>%
      bind_rows(tibble::tibble(variable_name = var_new)) %>%
      dplyr::mutate(class = ifelse(variable_name %in% var_new, "character", class),
                    variable_type = ifelse(variable_name %in% var_new, "character", variable_type),
                    variable_identifier = ifelse(variable_name %in% var_new, "No", variable_identifier),
                    variable_required = ifelse(variable_name %in% var_new, "No", variable_required),
                    variable_label = ifelse(variable_name %in% var_new, variable_name, variable_label),
                    variable_name = factor(variable_name, levels = names(data_labelled))) %>%
      arrange(variable_name)%>%
      dplyr::mutate(variable_name = as.character(variable_name))}

  # Supported REDCap classes
  meta_factor <- metadata %>% dplyr::filter(class=="factor") %>% dplyr::filter(! (variable_type=="checkbox"&select_choices_or_calculations==""))
  meta_numeric <- metadata %>% dplyr::filter(class=="numeric")
  meta_date <- metadata %>% dplyr::filter(class=="date")
  meta_datetime <- metadata %>% dplyr::filter(class=="datetime")
  meta_logical <- metadata %>% dplyr::filter(class=="logical")
  meta_file <- metadata %>% dplyr::filter(class=="file")
  meta_character <- metadata %>% dplyr::filter(class=="character")



  var_restricted <- metadata %>%
    dplyr::filter(variable_identifier=="Yes") %>%
    dplyr::pull(variable_name)

  # If dates are also restricted
  if(TRUE %in% c(meta_date$variable_name %in% names(data_labelled))==F){
    var_restricted <- unique(c(var_restricted, meta_date$variable_name)) }

  # if patient identifiable (and don't have access, add blank columns)
  if(length(var_restricted)>0){
    if(unique(var_restricted %in% names(data))==F){
      data_labelled <- data_labelled %>%
        dplyr::bind_cols(tibble::enframe(var_restricted, name = NULL, value = "variable") %>%
                           dplyr::mutate(value = list(rep(NA, nrow(data_labelled)))) %>%
                           tidyr::pivot_wider(names_from = "variable") %>%
                           tidyr::unnest(cols = everything())) %>%
        dplyr::select(all_of(names(data_labelled)))}}

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
        dplyr::mutate_at(dplyr::vars(any_of(meta_numeric$variable_name[[i]])),
                         function(x){as.numeric(x)})}}

  # Date
  if(nrow(meta_date)>0){
    for(i in c(1:nrow(meta_date))){
      data_labelled <- data_labelled %>%
        dplyr::mutate_at(dplyr::vars(any_of(meta_date$variable_name[[i]])),
                         function(x){lubridate::as_date(x)})}}


  # Datetime
  if(nrow(meta_datetime)>0){
    for(i in c(1:nrow(meta_datetime))){
      data_labelled <- data_labelled %>%
        dplyr::mutate_at(dplyr::vars(any_of(meta_datetime$variable_name[[i]])),
                         function(x){format(lubridate::as_datetime(x),format="%Y-%m-%d %H:%M:%S")})}}

  # Logical
  if(nrow(meta_logical)>0){
    for(i in c(1:nrow(meta_logical))){
      data_labelled <- data_labelled %>%
        dplyr::mutate_at(dplyr::vars(any_of(meta_logical$variable_name[[i]])),
                         function(x){as.logical(x)})}}

  # File
  if(nrow(meta_file)>0){
    for(i in c(1:nrow(meta_file))){
      data_labelled <- data_labelled %>%
        dplyr::mutate_at(dplyr::vars(any_of(meta_file$variable_name[[i]])),
                         function(x){ifelse(is.na(x)==T, FALSE, TRUE)})}}

  # Characters
  if(nrow(meta_character)>0){
    for(i in c(1:nrow(meta_character))){
      data_labelled <- data_labelled %>%
        dplyr::mutate_at(dplyr::vars(any_of(meta_character$variable_name[[i]])),
                         function(x){as.character(x)})}}

  metadata = tibble::tibble(variable_name = colnames(data)) %>%
    dplyr::left_join(metadata, by = 'variable_name') %>%
    dplyr::mutate(class = ifelse(variable_name %in% c('redcap_data_access_group', var_complete), "factor", class),
                  form_name = ifelse(variable_name %in% var_complete, gsub("_complete", "", var_complete), form_name),
                  form_name = ifelse(variable_name=="redcap_data_access_group", lag(form_name,1), form_name),
                  variable_label = ifelse(variable_name == 'redcap_data_access_group', 'REDCap Data Access Group', variable_label)) %>%
    dplyr::mutate(variable_label = ifelse(is.na(variable_label), variable_name, variable_label))

  if(("redcap_repeat_instance" %in% names(data_labelled))==T){
    metadata <- metadata %>%
      dplyr::mutate(form_repeat = ifelse(form_name %in% form_repeat, "Yes", "No"))}

  if(repeat_format %in% c("list", "wide")){
    data_labelled <- collaborator::redcap_format_repeat(data = data_labelled, format = repeat_format)}

  if(("redcap_repeat_instance" %in% names(data_labelled))==F){
    metadata <- metadata %>%
      dplyr::mutate(form_repeat = "No")}

  if(include_label==T){

    ff_label <- function(.var, variable_label){
      attr(.var, "label") = variable_label
      return(.var)}

    data_labelled <- purrr::map2_dfc(.x = data_labelled,
                                     .y = metadata$variable_label,
                                     function(.x, .y){finalfit::ff_label(.x, .y)})}


  if(include_original==F){return(list("data" = data_labelled, "metadata" = metadata))}
  if(include_original==T){return(list("data" = data_labelled, "metadata" = metadata,"original" = data))}

}
