# user_roles_n-----------------------------
# Use: To count the number of unique roles on the redcap project
# users_ignore = Vector of usernames to be excluded (e.g. those with unique rights)) - if none then enter as "".
user_roles_n <- function(redcap_project_uri, redcap_project_token, users_ignore){
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
    filter(username %ni% users_ignore) %>%
    dplyr::select(-c(username:data_access_group_id)) %>%
    unique() -> unique_roles

  print(paste0("There are ", nrow(unique_roles), " unique roles in this redcap project"))

  return(nrow(unique_roles))}
