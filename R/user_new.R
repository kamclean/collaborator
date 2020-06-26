# user_new-----------------------
# Documentation
#' Generates a dataframe of all new users
#' @description Used to compare a dataframe of all usernames to those currently allocated on REDCap to determine any new users requiring assigned
#' @param redcap_project_uri URI (Uniform Resource Identifier) for the REDCap instance.
#' @param redcap_project_token API (Application Programming Interface) for the REDCap project.
#' @param df_user_update Dataframe of all users containing at least 1 column ("username")
#' @param user_exclude = Vector of any usernames to be excluded.
#' @param use_ssl Logical value whether verify the peer's SSL certificate should be evaluated (default=TRUE)
#' @import dplyr
#' @importFrom readr read_csv
#' @importFrom RCurl postForm curlOptions
#' @return Original dataframe containing only usernames not yet allocated to the REDCap project
#' @export

# Function:
user_new <- function(redcap_project_uri, redcap_project_token, df_user_update, user_exclude, use_ssl = TRUE){

  df_user_update <- df_user_update %>% dplyr::mutate_all(tolower)
  user_exclude <- tolower(user_exclude)

  require(RCurl);require(readr);require(dplyr)
  user_current <- RCurl::postForm(uri=redcap_project_uri, token= redcap_project_token,
                                  .opts = RCurl::curlOptions(ssl.verifypeer = if(use_ssl==F){FALSE}else{TRUE}),
                                  content='user',  format='csv') %>%
    readr::read_csv()

  users_new <- df_user_update %>%
    dplyr::mutate_all(tolower) %>%
    dplyr::filter(! username %in% user_exclude) %>%
    dplyr::filter(! username %in% user_current$username)

  return(users_new)}
