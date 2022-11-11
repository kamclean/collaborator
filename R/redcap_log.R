# redcap_log--------------------------------
# Documentation
#' Export the redcap log
#' @description Export the redcap log to gain insight into redcap changes over time
#' @param redcap_project_uri URI (Uniform Resource Identifier) for the REDCap instance.
#' @param redcap_project_token API (Application Programming Interface) for the REDCap project.
#' @param date_start Limit to the start date extracted in the format of YYYY-MM-DD (default = NULL)
#' @param date_end  Limit to the end date extracted in the format of YYYY-MM-DD (default = NULL)
#' @param item A list of all types of events wanted to be exported (default = NULL aka all). These can include "record", "user", "page_view","lock_record", "manage", "record_add", "record_edit", "record_delete", "export".
#' @return Logging record of the specified events
#' @import dplyr
#' @importFrom purrr map_df
#' @importFrom lubridate day month year origin
#' @importFrom httr POST content
#' @importFrom readr read_csv
#' @export
#'

redcap_log <- function(redcap_project_uri, redcap_project_token,
                       date_start = NULL, date_end = NULL,
                       item = NULL){

  if(is.null(date_start)==T){date_start=''}else{date_start = paste0(date_start, " 00:00")}
  if(is.null(date_end)==T){date_end=''}else{date_end = paste0(date_end, " 23:59")}
  if(is.null(item)==T){item=''}


  df_log <- item %>%
    purrr::map_df(function(x){
      httr::POST(url = redcap_project_uri,
                 body = list("token"=redcap_project_token, content='log',
                             logtype=x,
                             user='', record='',
                             beginTime = date_start, endTime = date_end,
                             format='csv', returnFormat='json'),

                 encode = "form") %>%
        httr::content(type = "text/csv",show_col_types = FALSE,
                      guess_max = 100000, encoding = "UTF-8")})

  return(df_log)}
