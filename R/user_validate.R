# user_validate-------------------------
# Documentation
#' Validates users have been allocated correctly
#' @description Used to check all users have been appropriately (dag_unallocated) and correctly (dag_incorrect) allocated to a DAG, and that all user forms rights have been uploaded correctly. Note: if NA, this will default to view & edit access for all forms.
#' @param redcap_project_uri URI (Uniform Resource Identifier) for the REDCap instance.
#' @param redcap_project_token API (Application Programming Interface) for the REDCap project.
#' @param df_user_master Optional dataframe containing at least 2 columns (username, data_access_group) used to evaluate incorrect DAG, and compare to users currently uploaded
#' @param user_exclude = Vector of any usernames to be excluded.
#' @param use_ssl Logical value whether verify the peer's SSL certificate should be evaluated (default=TRUE)
#' @return Nested dataframe of (i) Users with NA access rights to forms (ii) Users with an unallocated DAG (iii). Users with an incorrect DAG according to df_user_master.  (iv). Users absent from the redcap project, but present in df_user_master.  (v). Users present on the redcap project, but absent in df_user_master.
#' @import dplyr
#' @importFrom RCurl postForm
#' @importFrom purrr discard
#' @importFrom stringr str_sub
#' @importFrom readr read_csv
#' @export

# Function:
user_validate <- function(redcap_project_uri, redcap_project_token, use_ssl = TRUE, df_user_master = NULL, user_exclude = NULL){
  require(dplyr);require(purrr);require(stringr); require(RCurl);require(readr)

  user_current <- RCurl::postForm(uri=redcap_project_uri, token= redcap_project_token,
                                  .opts = curlOptions(ssl.verifypeer = if(use_ssl==F){FALSE}else{TRUE}),
                                  content='user',  format='csv') %>%
    readr::read_csv()

  if(is.null(user_exclude)==F){user_current <- user_current %>% dplyr::filter(! username %in% user_exclude)}
  if(is.null(user_exclude)==F){df_user <- df_user %>% dplyr::filter(! username %in% user_exclude)}

  user_forms_na <- user_current %>%
    dplyr::select(username, data_access_group, forms) %>%
    dplyr::filter(is.na(forms)==T)

  if(nrow(user_forms_na)==0){user_forms_na <- NULL}

  dag_unallocated <- user_current %>%
    dplyr::select(username, data_access_group)  %>%
    dplyr::filter(is.na(data_access_group)==T)

  if(nrow(dag_unallocated)==0){dag_unallocated <- NULL}

  dag_incorrect <- NULL
  user_toadd <- NULL
  user_toremove <- NULL
  if(is.null(df_user_master)==F){
    dag_incorrect <- dplyr::left_join(dplyr::select(df_user_master, username, "dag_updated" = data_access_group),
                                      dplyr::select(user_current, username,"dag_current" = data_access_group), by = "username") %>%
      dplyr::mutate_all(function(x){as.character(x) %>% tolower() %>% stringr::str_sub(start = 1, end = 18)}) %>%
      dplyr::filter(dag_current!=dag_updated)


    user_toadd <- df_user_master %>%
      dplyr::filter(! username %in% user_current$username)

    user_toremove <- user_current %>%
      dplyr::filter(! username %in% df_user_master$username)

    if(nrow(dag_incorrect)==0){dag_incorrect <- NULL}
    if(nrow(user_toadd)==0){user_toadd <- NULL}
    if(nrow(user_toremove)==0){user_toremove <- NULL}}

  output <- list("forms_na" = user_forms_na,
                 "dag_unallocated" = dag_unallocated,
                 "dag_incorrect" = dag_incorrect,
                 "user_toadd" = user_toadd,
                 "user_toremove" = user_toremove) %>%
    purrr::discard(is.null)


  return(output)}
