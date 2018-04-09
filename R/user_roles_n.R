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
    unique() %>%
    cbind.data.frame(., role = c(1:nrow(.))) %>%
    left_join(user_current, ., by =  colnames(user_current)[which(colnames(user_current)=="design"):which(colnames(user_current)=="forms")]) %>%
    select(role, everything())%>%
    arrange(role) -> unique_roles_full

  unique_roles_full %>%
    group_by(role) %>%
    dplyr::summarise(username = head(username)[1]) -> unique_roles_examples

  print(paste0("There are ", nrow(unique_roles_example), " unique roles in this redcap project"))

  return(list(full = unique_roles_full, examples = unique_roles_examples))}
