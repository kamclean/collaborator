# redcap_sum--------------------------------
# Documentation
#' Generate REDCap summary data.
#' @description Used to generate high quality summary data for REDCap projects at overall, and DAG-specific level.
#' @param redcap_project_uri URI (Uniform Resource Identifier) for the REDCap instance.
#' @param redcap_project_token API (Application Programming Interface) for the REDCap project.
#' @param import A list of new DAGs to import into the project (Default = NULL).
#' @param remove A list of current DAGs to delete in the project (Default = NULL).
#' @return A dataframe of DAGs specifiying those which are new, deleted, or unchanged (-).
#' @import dplyr
#' @importFrom tibble enframe
#' @importFrom httr POST content
#' @importFrom readr read_csv
#' @export

# Function:
dag_manage <- function(redcap_project_uri, redcap_project_token,
                       import = NULL, remove = NULL){
  # Load required functions
  require(dplyr);require(httr);require(tibble)

  # Allow flexible use of either just a unique name or also allow label of dag
  # Stop if unique_group_name > 18 characters

  dag_current <- httr::POST(url=redcap_project_uri,
                            body = list("token"= redcap_project_token, content='dag',
                                        action='export', format='csv')) %>%
    httr::content(show_col_types = FALSE)

  if(is.null(import)==F){
  if(TRUE %in% c(nchar(import)>18)){
    stop(paste0("Please ensure <18 characters for all unique_group_name: ",
                paste0(import[nchar(import)>18], collapse = ", ")))}

  # Export and format existing dags (including if none already exist)


  dag_import <- import %>%
    tibble::enframe(name = NULL, value = "data_access_group_name") %>%
    dplyr::mutate(data_access_group_name =  iconv(data_access_group_name, to ="ASCII//TRANSLIT")) %>%
    dplyr::anti_join(dag_current,by = "data_access_group_name")


  # Import DAGs into project
  if(nrow(dag_import) > 0){

  dag_import <- dag_import %>%
    dplyr::mutate(data_access_group_name = paste0('{"data_access_group_name":"',
                                                  data_access_group_name, '","unique_group_name":""}')) %>%
    dplyr::summarise(data_access_group_name = paste0(data_access_group_name, collapse = ", ")) %>%
    dplyr::mutate(data_access_group_name = paste0("[", data_access_group_name, "]")) %>%
    dplyr::pull(data_access_group_name)


  httr::POST(url=redcap_project_uri,
             body = list("token"= redcap_project_token, data= dag_import,
                         content='dag',action='import',
                         format='json',returnFormat='json'), encode = "form")}}

  if(is.null(remove)==F){



    dag_remove <- remove %>%
      tibble::enframe(name = NULL, value = "dags") %>%
      dplyr::mutate(n =  1:n()-1) %>%
      dplyr::mutate(out = paste0("'dags[", n, "]'='",dags, "'")) %>%
      dplyr::summarise(dags = paste0(out, collapse = ",")) %>%
      dplyr::pull(dags)


    eval(parse(text = paste0("httr::POST(url=redcap_project_uri,
               body = list('token'= redcap_project_token, data= dag_import,
                           content='dag',action='delete',",
                             dag_remove,
                             ", returnFormat='json'), encode = 'form')")))}


  dag_updated <- httr::POST(url=redcap_project_uri,
                            body = list("token"= redcap_project_token, content='dag',
                                        action='export', format='csv')) %>%
    httr::content(show_col_types = FALSE)

out <- full_join(dag_current %>% mutate("status"  = 1),
                 dag_updated %>% mutate("status"  = 1),
                 by = c("data_access_group_name", "unique_group_name")) %>%
  dplyr::mutate(status = case_when(is.na(status.x)==T&is.na(status.y)==F ~ "added",
                                   is.na(status.x)==F&is.na(status.y)==T ~ "removed",
                                   TRUE ~ "-")) %>%
  dplyr::select(-status.x, -status.y)

return(out)}
