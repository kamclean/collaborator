# upload_record_new-----------------------
# Documentation
#' Upload new records to REDCap project
#' @description Use to upload new records to REDCap project

#' @param redcap_project_uri URI (Uniform Resource Identifier) for the REDCap instance.
#' @param redcap_project_token API (Application Programming Interface) for the REDCap project.
#' @param df_new Dataframe of record_id (mandatory), and other columns (optional) that match the names / required formats of the original dataset. Columns not specified will be uploaded as blank.
#' @import dplyr
#' @importFrom REDCapR redcap_read_oneshot redcap_write_oneshot
#' @return REDCap project updated to include new record_id.
#' @export

upload_record_new <- function(redcap_project_uri,
                              redcap_project_token,
                              df_new){

  "%ni%" <- Negate("%in%")

  # Get original dataset
  df_original <- REDCapR::redcap_read_oneshot(redcap_uri=redcap_project_uri,
                                              token = redcap_project_token,
                                              export_data_access_groups = TRUE)$data


  # Ensure not overriding existing record_id (must be new)
  df_new <- dplyr::filter(df_new, record_id %ni% df_original$record_id)

  # Create new (clean) records
  df_clean <- df_original %>%
    dplyr::select(-(one_of(names(df_new)))) %>%
    head(nrow(df_new)) %>%
    dplyr::mutate_at(vars(ends_with("_complete")), function(x){x=0}) %>%
    dplyr::mutate_at(vars(-ends_with("_complete")), function(x){x=NA})

  # New dataset (same column order as original dataset - for merge)
  df_new_upload <- dplyr::bind_cols(df_new,df_clean) %>%
    dplyr::select(names(df_original))

  # Upload updated dataset
  REDCapR::redcap_write_oneshot(ds = rbind.data.frame(df_original, df_new_upload),
                                redcap_uri = redcap_project_uri,
                                token = redcap_project_token)}
