# user_assign-------------------------
# Documentation
#' Used to assign users to data access groups on a redcap project.
#' @description Used to assign users to data access groups on a redcap project with the same user rights as a current user (role). This can add new users or edit existing ones.

#' @param redcap_project_uri URI (Uniform Resource Identifier) for the REDCap instance.
#' @param redcap_project_token API (Application Programming Interface) for the REDCap project.
#' @param users.df Dataframe containing at least 2 columns (username, data_access_group)
#' @param role Username of user with the desired user rights
#' @importFrom dplyr filter mutate select summarise group_by ungroup
#' @importFrom stringi stri_replace_all_fixed
#' @importFrom RCurl postForm
#' @importFrom jsonlite toJSON prettify
#' @importFrom readr read_csv
#' @importFrom tidyr separate
#' @return None (user rights uploaded directly into REDCap - user acccounts are still required to be entered manually)
#' @details # Sources of errors: (i) DAG has not been added on REDCap (this must be done prior to users being assigned). (ii) Username is not in an acceptable format (e.g. contains spaces, unavaliable characters, etc)
#' @export

# Function:
user_assign <- function(redcap_project_uri, redcap_project_token, users.df, role){
  # Load required functions
  "%ni%" <- Negate("%in%")

  user_current <- RCurl::postForm(
    uri=redcap_project_uri,
    token= redcap_project_token,
    content='user',
    format='csv') %>%
    readr::read_csv()

  user_current %>%
    dplyr::filter(username == role) %>% # select the user with the desired rights
    dplyr::select(forms) %>% # select form rights
    as.character() %>%
    strsplit(split = ",") %>%
    unlist() %>%
    cbind.data.frame(forms = .) %>%
    tidyr::separate(forms, c("form", "right"), ":") %>%
    dplyr::mutate(forms = paste0(as.character(form), ': ', as.character(right))) -> role_forms

  user_current %>%
    dplyr::filter(username == role) %>% # select the user with the desired rights
    dplyr::select(forms) %>%
    dplyr::mutate(forms = list(role_forms$forms)) %>%
    dplyr::select(forms) %>%
    jsonlite::toJSON() %>%
    stringi::stri_replace_all_fixed(., '[', '') %>%
    stringi::stri_replace_all_fixed(., ']', '') %>%
    stringi::stri_replace_all_fixed(., '{', '') %>%
    stringi::stri_replace_all_fixed(., '\"forms\":', '{') %>%
    stringi::stri_replace_all_fixed(., ': ', '": "') %>%
    stringi::stri_replace_all_fixed(., ',', ', ') -> role_forms

  user_current %>%
    dplyr::filter(username == role) %>% # select the user with the desired rights
    dplyr::select(design:lock_records_customization) %>%
    dplyr::mutate(forms = role_forms) %>%
    jsonlite::toJSON() %>%
    stringi::stri_replace_all_fixed(., '}"', '}') %>%
    stringi::stri_replace_all_fixed(., '"forms":" ', '"forms":') -> user_rights

  user_rights %>%
    as.character() %>%
    gsub("\\\\", "",.) %>%
    stringi::stri_replace_all_fixed(., '"forms\":\"', '"forms\":\ ')  %>%
    jsonlite::prettify() %>%
    as.character() %>%
    substr(., 17, nchar(.[1])) -> user_rights

  users.df = users.df  %>%
    dplyr::mutate(json = paste0("[{\"username\" :\"", username,
                         "\",\"data_access_group\":\"", data_access_group,
                         "\",", user_rights))

  users.df$json[1] %>%
    jsonlite::prettify() %>%
    print()

  for (i in 1:nrow(users.df)){
    print(i)
    res = try(RCurl::postForm(
      uri=redcap_project_uri,
      token= redcap_project_token,
      content='user',
      format='json',
      data = users.df$json[i]))

    if (class(res) == "try-error"){
      print(paste('error with: ', as.character(users.df$username[i])))}}
}
