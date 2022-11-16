# redcap_format_repeat--------------------------------
# Documentation
#' Change structure of repeating data
#' @description Change structure of repeating data from redcap_data from long to either list or wide.
#' @param data Output from redcap_data$data
#' @param format The format the repeating instrument data should be provided in. Options include "long" (default), "wide" (each instance a separate column), or "list" (nested instances).
#' @return Dataframe
#' @import dplyr
#' @import tidyr
#' @export

# Function:

redcap_format_repeat <- function(data, format = "long"){

  if(("redcap_repeat_instance" %in% names(data))==F){stop("Must contain repeating instruments.")}


  if(format=="long"){output <- data}

  if(format%in% c("list", "wide")){

    data_repeat <- data %>%
      dplyr::select(record_id, redcap_repeat_instance:last_col())

    data_norepeat <- data %>%
      dplyr::select(-all_of(names(data_repeat)[! (names(data_repeat) %in% "record_id")]))

    if(format=="list"){
      data_repeat <- data_repeat %>%
        dplyr::group_by(record_id) %>%
        dplyr::summarise(across(everything(), function(x){list(x)}))}

    if(format=="wide"){
      data_repeat <- data_repeat %>%
        dplyr::group_by(record_id) %>%
        tidyr::pivot_wider(id_cols = "record_id", names_from = "redcap_repeat_instance",
                           values_from = names(data_repeat)[! (names(data_repeat) %in% c("record_id", "redcap_repeat_instance"))],
                           names_prefix = "instance")}

    output <- data_norepeat %>%
      dplyr::distinct() %>%
      left_join(data_repeat, by = c("record_id"))}

  return(output)}
