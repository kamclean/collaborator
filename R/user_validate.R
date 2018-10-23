# user_validate-------------------------
# Documentation
#' Validates users have been allocated correctly
#' @description Used to check all users have been appropriately (dag_unallocated) and correctly (dag_incorrect) allocated to a DAG, and that all user forms rights have been uploaded correctly. Note: if NA, this will default to view & edit access for all forms.
#' @param redcap_project_uri URI (Uniform Resource Identifier) for the REDCap instance.
#' @param redcap_project_token API (Application Programming Interface) for the REDCap project.
#' @param users.df Dataframe containing at least 2 columns (username, data_access_group)
#' @param users_exception Vector of usernames to be excluded from comparison (e.g. users who should have access to the whole dataset (dag = NA) or are associated with multiple DAGs in users.df).
#' @return Nested dataframe of (i) Users with NA access rights to forms (ii) Users with an unallocated DAG (iii). Users with an incorrect DAG.
#' @importFrom dplyr filter mutate select arrange left_join group_by summarise
#' @importFrom RCurl postForm
#' @importFrom tibble as_tibble
#' @importFrom readr read_csv
#' @export

# Function:
user_validate <- function(redcap_project_uri, redcap_project_token, users.df, users_exception){
  '%ni%' <- Negate('%in%')

  RCurl::postForm(
    uri=redcap_project_uri,
    token= redcap_project_token,
    content='user',
    format='csv') %>%
    readr::read_csv() -> user_current

  user_current %>%
    dplyr::select(username, data_access_group, forms) %>%
    dplyr::filter(is.na(forms)==T) %>%
    tibble::as_tibble() -> forms_na

  user_current %>%
    dplyr::select(username, data_access_group)  %>%
    dplyr::filter(is.na(data_access_group)) %>%
    dplyr::filter(username %ni% users_exception) -> dag_unallocated

  merge.data.frame(users.df, user_current, by = "username") %>%
    dplyr::select("username" = username,
           "DAG_user_new" = data_access_group.x,
           "DAG_user_current" = data_access_group.y) %>%
    dplyr::filter(username %ni% users_exception) %>%
    dplyr::filter(DAG_user_new!=substr(DAG_user_current, 1, 18)) %>%
    tibble::as_tibble() -> dag_incorrect

  check.output <- list("forms_na" = forms_na,
                       "dag_unallocated" = dag_unallocated,
                       "dag_incorrect" = dag_incorrect)
  return(check.output)}
