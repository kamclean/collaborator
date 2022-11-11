# user_summarise--------------------------------
# Documentation
#' Summarise the REDCap user dataframe by group (data access group)
#' @description Group current REDCap project users by DAG (and role) to provide a summarised dataframe of users, names, and emails.
#' @param data Dataset previously exported of users authorized for a project (5 required columns: data_access_group, username, firstname, lastname, email)
#' @param redcap_project_uri URI (Uniform Resource Identifier) for the REDCap instance.
#' @param redcap_project_token API (Application Programming Interface) for the REDCap project.
#' @param use_ssl Logical value whether to verify the peer's SSL certificate should be evaluated during the API pull (default=TRUE)
#' @param user_exclude Vector of usernames to be excluded e.g. those with unique rights (default = NULL).
#' @return Dataframe summarising the user dataframe by group (data access group), number of users, and username/fullname/emails (separated by ";").
#' @import dplyr
#' @importFrom httr POST content
#' @importFrom readr read_csv
#' @export


# Function
user_summarise <- function(redcap_project_uri, redcap_project_token,
                           user_exclude = NULL, role_exclude = NULL){

  require(httr); require(dplyr); require(stringr); require(tidyr)

  user <- collaborator::user_role(redcap_project_uri = redcap_project_uri,
                            redcap_project_token = redcap_project_token,
                    remove_id = F)$all %>%
    dplyr::filter(! (username %in% user_exclude)) %>%
    dplyr::filter(! (role_name %in% role_exclude)) %>%

    # select relevant columns
    dplyr::select(data_access_group, username, firstname, lastname, email)

  output <- user %>%
    # must have an email and data_access_group
    dplyr::filter(is.na(email)==F) %>%

    # ensure no special characters
    dplyr::mutate(across(everything(), function(x){iconv(x, to ="ASCII//TRANSLIT")}),
                  across(contains("name"), function(x){stringr::str_replace_all(x, ";", "")})) %>%

    #summarise by DAG
    dplyr::group_by(data_access_group) %>%
    dplyr::summarise(user_n = n(),
                     user_usernames = paste(paste0(username), collapse = "; "),
                     user_fullnames = paste(paste0(firstname, " ", lastname), collapse = "; "),
                     user_firstnames = paste(paste0(firstname), collapse = "; "),
                     user_lastnames = paste(paste0(lastname), collapse = "; "),
                     user_email = paste0(email, collapse = "; "), .groups = "drop")

  return(output)}
