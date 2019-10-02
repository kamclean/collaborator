# upload_file_same-----------------------
# Documentation
#' Upload the same file to all records
#' @description Use to upload the same file to all records in record_id

#' @param redcap_project_uri URI (Uniform Resource Identifier) for the REDCap instance.
#' @param redcap_project_token API (Application Programming Interface) for the REDCap project.
#' @param record_id Vector of record ids which the file should be uploaded to.
#' @param var_upload The field name of the upload location
#' @param name_file The location of the file to be uploaded to all records in "record_id".
#' @import dplyr
#' @importFrom purrr imap_dfr
#' @importFrom REDCapR redcap_upload_file_oneshot
#' @return Tibble of all records which the file could not be uploaded to.
#' @export

# if you want to upload the same file to all
upload_file_same <- function(redcap_project_uri,
                             redcap_project_token,
                             record_id,var_upload,
                             name_file){



  outcome <- purrr::imap_dfr(record_id,
                             ~ REDCapR::redcap_upload_file_oneshot(file_name = name_file,
                                                                   record = record_id[.y],
                                                                   redcap_uri = redcap_project_uri,
                                                                   token = redcap_project_token,
                                                                   field = var_upload))
  outcome <- outcome %>%
    dplyr::select(success, "record_id" = affected_ids, "error message" = raw_text) %>%
    dplyr::filter(success==FALSE)

  return(outcome)}
