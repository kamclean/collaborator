# user_roles-----------------------------
# Documentation
#' Assign named roles to REDCap users
#' @description Used to assign a role name to current redcap users based on the example users given in role_users_example. Note: The number of roles should match the output from user_roles_n.
#' @param redcap_project_uri URI (Uniform Resource Identifier) for the REDCap instance.
#' @param redcap_project_token API (Application Programming Interface) for the REDCap project.
#' @param role_users_example Dataframe with 2 columns: role (specifiying the name of the role), and username (the username with the desired rights to be associated with the role).
#' @return Dataframe of REDCap project users with an additional "role" column.

# Function:
user_roles <- function(redcap_project_uri, redcap_project_token, role_users_example){
  # Load required packages
  require("dplyr")
  require("readr")
  require("RCurl")

  postForm(
    uri=redcap_project_uri,
    token= redcap_project_token,
    content='user',
    format='csv') %>%
    read_csv() -> user_current

  merge.data.frame(user_current, role_users_example, by="username") %>%
    dplyr::select(-c(username:data_access_group_id)) -> role_rights

  role_rights %>%
    dplyr::select(-role) %>%
    colnames() -> colnames_rights

  merge.data.frame(user_current,role_rights,by=colnames_rights) %>%
    dplyr::select(role, username:data_access_group_id, design:forms) %>%
    arrange(role) -> role_users_project

  return(role_users_project)}
