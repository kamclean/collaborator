# user_roles_n-----------------------------
# Documentation
#' Identifies unique REDCap user roles
#' @description Used to count the number of unique roles (e.g. unique combinations of user rights) on the REDCap project. Note: this replaces the function of roles on the user rights page of the REDCap.
#' @param redcap_project_uri URI (Uniform Resource Identifier) for the REDCap instance.
#' @param redcap_project_token API (Application Programming Interface) for the REDCap project.
#' @param users_ignore Vector of usernames to be excluded (e.g. those with unique rights). Default is none (e.g. "").
#' @return Nested dataframe of (i) Dataframe of all users numbered by unique role. (ii) Dataframe of each role with an example user with those user rights.
#' @export

# Function:
user_roles_n <- function(redcap_project_uri, redcap_project_token, users_ignore = ""){
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

  user_current %>%
    dplyr::select(-c(username:data_access_group_id)) %>%
    unique() %>%
    cbind.data.frame(., role = c(1:nrow(.))) %>%
    left_join(user_current, ., by =  colnames(user_current)[which(colnames(user_current)=="design"):which(colnames(user_current)=="forms")]) %>%
    filter(username %ni% users_ignore) %>%
    select(role, everything())%>%
    arrange(role) -> unique_roles_full

  unique_roles_full %>%
    group_by(role) %>%
    dplyr::summarise(username = head(username)[1]) -> unique_roles_examples

  print(paste0("There are ", nrow(unique_roles_examples), " unique roles in this redcap project"))

  return(list(full = unique_roles_full, examples = unique_roles_examples))}
