# upload_file_unique-----------------------
# Documentation
#' Upload the same file to all records
#' @description Use to upload the same file to all records in record_id

#' @param redcap_project_uri URI (Uniform Resource Identifier) for the REDCap instance.
#' @param redcap_project_token API (Application Programming Interface) for the REDCap project.
#' @param record_id Vector of record ids which the file should be uploaded to.
#' @param var_upload The field name of the upload location
#' @param name_folder The location of the folder with files to be uploaded to all records in "record_id".
#' @param name_file_suffix Each file must start with the appropriate record_id and end with a file extension (".csv", ".txt", etc). Further characters can be incorported if desired before the file extention (e.g. "_result.txt")
#' @import dplyr
#' @importFrom purrr imap_dfr
#' @importFrom REDCapR redcap_upload_file_oneshot
#' @return Tibble of all records which the file could not be uploaded to
#' @export



upload_file_unique <- function(redcap_project_uri,
                               redcap_project_token,
                               record_id, var_upload,
                               name_folder, name_file_suffix){

  outcome <- purrr::imap_dfr(record_id,
                             ~ REDCapR::redcap_upload_file_oneshot(file_name = paste0(name_folder, record_id[.y], name_file_suffix),
                                                                   record = record_id[.y],
                                                                   redcap_uri = redcap_project_uri,
                                                                   token = redcap_project_token,
                                                                   field = var_upload))

  outcome <- outcome %>%
    dplyr::select(success, "record_id" = affected_ids, "error message" = raw_text) %>%
    dplyr::filter(success==FALSE)

  return(outcome)}



