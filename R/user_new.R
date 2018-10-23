# user_new-----------------------
# Documentation
#' Generates a dataframe of all new users
#' @description Used to compare a dataframe of all usernames to those currently allocated on REDCap to determine any new users requiring assigned

#' @param redcap_project_uri URI (Uniform Resource Identifier) for the REDCap instance.
#' @param redcap_project_token API (Application Programming Interface) for the REDCap project.
#' @param user_all.df Dataframe of all users containing at least 1 column ("username")
#' @param users_exception = Vector of any usernames to be excluded.
#' @importFrom dplyr filter
#' @importFrom readr read_csv
#' @importFrom RCurl postForm
#' @return Original dataframe containing only usernames not yet allocated to the REDCap project
#' @export

# Function:
user_new <- function(redcap_project_uri, redcap_project_token, user_all.df, users_exception){
   "%ni%" <- Negate("%in%")

  RCurl::postForm(
    uri=redcap_project_uri,
    token= redcap_project_token,
    content='user',
    format='csv') %>%
    readr::read_csv() -> user_current

  user_all.df %>%
    dplyr::filter(username %ni% users_exception) %>%
    dplyr::filter(username %ni% user_current$username) -> users_new

  return(users_new)}
