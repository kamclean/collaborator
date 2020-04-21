# user_assign-------------------------
# Documentation
#' Used to assign users to data access groups on a redcap project.
#' @description Used to assign users to data access groups on a redcap project with the same user rights as a current user (role). This can add new users or edit existing ones.

#' @param redcap_project_uri URI (Uniform Resource Identifier) for the REDCap instance.
#' @param redcap_project_token API (Application Programming Interface) for the REDCap project.
#' @param use_ssl Logical value whether verify the peer's SSL certificate should be evaluated (default=TRUE)
#' @param df_user Dataframe containing at least 2 columns (username, data_access_group)
#' @param role Username of user with the desired user rights
#' @import dplyr
#' @importFrom stringi stri_replace_all_fixed
#' @importFrom stringr str_sub
#' @importFrom RCurl postForm
#' @importFrom jsonlite toJSON prettify
#' @importFrom readr read_csv
#' @importFrom tidyr separate separate_rows
#' @return None (user rights uploaded directly into REDCap - user acccounts are still required to be entered manually)
#' @details # Sources of errors: (i) DAG has not been added on REDCap (this must be done prior to users being assigned). (ii) Username is not in an acceptable format (e.g. contains spaces, unavaliable characters, etc)
#' @export


# Function:
user_assign <- function(redcap_project_uri, redcap_project_token, df_user, role, use_ssl = TRUE){
  # Load required functions
  require(dplyr);require(RCurl);require(readr);require(tidyr);require(jsonlite)
  require(stringi);require(stringr)

  user_current <- RCurl::postForm(uri=redcap_project_uri,
                                  token= redcap_project_token,
                                  content='user',
                                  .opts = curlOptions(ssl.verifypeer = if(use_ssl==F){FALSE}else{TRUE}),
                                  format='csv') %>%
    readr::read_csv()

  role_forms <- user_current %>%
    dplyr::filter(username == role) %>% # select the user with the desired rights
    dplyr::select(forms) %>% # select form rights
    tidyr::separate_rows(forms, sep = ",") %>%
    tidyr::separate(col = forms, into = c("form", "right"), ":") %>%
    dplyr::mutate(forms = paste0(form, ": ", right)) %>%
    dplyr::summarise(forms = list(forms)) %>%
    jsonlite::toJSON() %>%
    stringi::stri_replace_all_fixed(., '[', '') %>%
    stringi::stri_replace_all_fixed(., ']', '') %>%
    stringi::stri_replace_all_fixed(., '{', '') %>%
    stringi::stri_replace_all_fixed(., '\"forms\":', '{') %>%
    stringi::stri_replace_all_fixed(., ': ', '": "') %>%
    stringi::stri_replace_all_fixed(., ',', ', ')

  # check json
  # role_forms %>% jsonlite::prettify()

  user_rights <- user_current %>%
    dplyr::filter(username == role) %>% # select the user with the desired rights
    dplyr::select(design:lock_records_customization) %>%
    dplyr::mutate(forms = role_forms) %>%
    jsonlite::toJSON() %>%
    stringi::stri_replace_all_fixed(., '}"', '}') %>%
    stringi::stri_replace_all_fixed(., '"forms":" ', '"forms":') %>%
    gsub("\\\\", "",.) %>%
    stringi::stri_replace_all_fixed(., '"forms\":\"', '"forms\":\ ')  %>%
    jsonlite::prettify() %>%
    as.character() %>%
    stringr::str_sub(17, nchar(.))

  df_user = df_user  %>%
    dplyr::mutate(data_access_group = ifelse(is.na(data_access_group)==T, "", data_access_group)) %>%
    dplyr::mutate(data_access_group = tolower(data_access_group) %>% iconv(to ="ASCII//TRANSLIT"),
                  username = tolower(username) %>% iconv(to ="ASCII//TRANSLIT")) %>%
    dplyr::mutate(json = paste0("[{\"username\" :\"", username,
                         "\",\"data_access_group\":\"", data_access_group,
                         "\",", user_rights))

  # check json
  # df_user$json[1] %>% jsonlite::prettify()


  for (i in 1:nrow(df_user)){
    print(i)
    res = try(RCurl::postForm(uri=redcap_project_uri,
                              token= redcap_project_token,
                              content='user',
                              .opts = curlOptions(ssl.verifypeer = if(use_ssl==F){FALSE}else{TRUE}),
                              format='json',
                              data = df_user$json[i]))


    if (class(res) == "try-error"){
      print(paste('error with: ', as.character(df_user$username[i])))}}
}
