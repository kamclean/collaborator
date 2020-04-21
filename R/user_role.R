# user_role-----------------------------
# Documentation
#' Identifies unique REDCap user roles
#' @description Used to count the number of unique roles (e.g. unique combinations of user rights) on the REDCap project. Note: this replaces the function of roles on the user rights page of the REDCap.
#' @param redcap_project_uri URI (Uniform Resource Identifier) for the REDCap instance.
#' @param redcap_project_token API (Application Programming Interface) for the REDCap project.
#' @param users_ignore Vector of usernames to be excluded (e.g. those with unique rights). Default is none (e.g. "").
#' @import dplyr
#' @importFrom RCurl postForm curlOptions
#' @importFrom readr read_csv
#' @importFrom tidyr unite
#' @return Nested dataframe of (i) Dataframe of all users numbered by unique role. (ii) Dataframe of each role with an example user with those user rights.
#' @export

# Function:
user_role <- function(redcap_project_uri, redcap_project_token, users_ignore = NULL, use_ssl = TRUE){
  require(RCurl); require(dplyr); require(readr); require(tidyr)

  user_current <- RCurl::postForm(
    uri=redcap_project_uri,
    token= redcap_project_token,
    content='user',
    .opts = RCurl::curlOptions(ssl.verifypeer = if(use_ssl==F){FALSE}else{TRUE}),
    format='csv') %>%
    readr::read_csv()

  if(is.null(users_ignore)==F){user_current %>% dplyr::filter(! user_current %in% users_ignore)}

  unique_roles_full <- user_current %>%
    tidyr::unite(col = "role", design:forms, sep = "; ", remove = F) %>%
    dplyr::mutate(role = as.numeric(factor(role))) %>%
    dplyr::select(role, everything())

  unique_roles_examples <- unique_roles_full %>%
    dplyr::group_by(role) %>%
    dplyr::summarise(username = head(username, 1))

  return(list(full = unique_roles_full, examples = unique_roles_examples))}
