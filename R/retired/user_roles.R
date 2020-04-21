# user_roles-----------------------------
# Documentation
#' Assign named roles to REDCap users
#' @description Used to assign a role name to current redcap users based on the example users given in role_users_example. Note: The number of roles should match the output from user_roles_n.
#' @param data
#' @param redcap_project_uri URI (Uniform Resource Identifier) for the REDCap instance.
#' @param redcap_project_token API (Application Programming Interface) for the REDCap project.
#' @param role_users_example Dataframe with 2 columns: role (specifiying the name of the role), and username (the username with the desired rights to be associated with the role).
#' @param use_ssl Logical value whether verify the peer's SSL certificate should be evaluated (default=TRUE)
#' @import dplyr
#' @importFrom tidyr unite
#' @importFrom RCurl postForm
#' @importFrom readr read_csv
#' @importFrom zoo na.locf
#' @return Dataframe of REDCap project users with an additional "role" column.
#' @export

# Function:
user_roles <- function(data = NULL, redcap_project_uri = NULL, redcap_project_token = NULL, role_users_example, use_ssl = TRUE){
  require(dplyr);require(readr);require(tidyr); require(zoo); require(RCurl)

  if(is.null(data)==F&(is.null(redcap_project_uri)==T|is.null(redcap_project_token)==T)){
    user_current <- data %>%
      dplyr::select(username, email, firstname, lastname, expiration,
                    data_access_group, data_access_group_id, design, user_rights,
                    data_access_groups, data_export, reports, stats_and_charts,
                    manage_survey_participants, calendar, data_import_tool, data_comparison_tool,
                    logging, file_repository, data_quality_create, data_quality_execute, api_export,
                    api_import, mobile_app, mobile_app_download_data,
                    record_create, record_rename, record_delete, lock_records_all_forms,
                    lock_records, lock_records_customization, forms) %>%
      tidyr::unite(col = "role_rights", design:forms, sep = "; ", remove = F) %>%
      dplyr::left_join(role_users_example, by = c("username")) %>%
      dplyr::select(role, role_rights, everything()) %>%
      dplyr::arrange(role_rights, role) %>%
      dplyr::mutate(role = zoo::na.locf(role)) %>%
      dplyr::select(-role_rights)}


  if(is.null(data)==T&(is.null(redcap_project_uri)==F&is.null(redcap_project_token)==F)){
  user_current <- RCurl::postForm(uri=redcap_project_uri,
                                  token= redcap_project_token,
                                  content='user',
                                  .opts = curlOptions(ssl.verifypeer = if(use_ssl==F){FALSE}else{TRUE}),
                                  format='csv') %>%
    readr::read_csv() %>%
    dplyr::left_join(role_users_example, by="username") %>%
    tidyr::unite(col = "role_rights", design:forms, sep = "; ", remove = F) %>%
    dplyr::mutate(role_rights = as.numeric(factor(role_rights))) %>%
    dplyr::select(role, role_rights, everything()) %>%
    dplyr::group_by(role_rights) %>%
    dplyr::arrange(role_rights, role) %>%
    dplyr::mutate(role = zoo::na.locf(role)) %>%
    dplyr::ungroup() %>%
    dplyr::select(-role_rights)}

  return(user_current)}
