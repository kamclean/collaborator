# redcap_compare--------------------------------
# Documentation
#' Compare multiple REDCap projects to determine discrepancies in structure or user rights.
#' @description Used to compare multiple REDCap projects to determine discrepancies in structure or user rights.
#' @param redcap_project_uri URI (Uniform Resource Identifier) for the REDCap instance (must all be on same REDCap instance)
#' @param redcap_token_list List of API (Application Programming Interface) for the REDCap projects.
#' @param comparison What should be compared - project structure ("metadata") or user rights ("rights").
#' @return Nested tibble of the full comparison across projects ("full") and the specific discrepancies ("discrepancies").
#' @import dplyr
#' @import purrr
#' @import tibble
#' @importFrom RCurl postForm
#' @importFrom readr read_csv
#' @importFrom stringr str_split
#' @export

redcap_compare <- function(redcap_project_uri, redcap_token_list, comparison){
  require(dplyr); require(purrr); require(tibble)
  require(RCurl); require(readr); require(stringr)


  output <- NULL
  if(comparison=="metadata"){
    metadata <- redcap_token_list %>%
      purrr::map_df(function(x){

        title = RCurl::postForm(uri=redcap_project_uri,token=x, content='project', format='csv') %>% readr::read_csv() %>%
          dplyr::pull(project_title)

        out <- collaborator::redcap_metadata(redcap_project_uri = redcap_project_uri, redcap_project_token = x) %>%
          dplyr::mutate(project = title) %>%
          dplyr::select(project, everything())


        return(out)}) %>%
      dplyr::mutate(project = factor(project),
                    variable_name = factor(variable_name, levels = unique(variable_name)))

    meta_constant <- c("project", "n")


    full <- metadata %>%
      dplyr::group_by(variable_name, variable_label, variable_type,
                      variable_validation, variable_validation_min, variable_validation_max,
                      factor_level, factor_label,
                      branch_logic) %>%
      dplyr::summarise(n = n(),
                       project = paste0(unique(project), collapse = ", "),
                       .groups = "drop") %>%
      dplyr::select(all_of(meta_constant), everything())

    keep_col <- full %>%
      dplyr::filter(n!=length(redcap_token_list)) %>%
      purrr::map_chr(function(x){length(unique(x)) > 1}) %>% tibble::enframe() %>% filter(value ==T) %>%
      dplyr::pull(name)

    if(purrr::is_empty(keep_col)){keep_col <- NULL}else{keep_col <- c("variable_name", keep_col)}

    discrepancies <- full %>%
      dplyr::filter(n!=length(redcap_token_list)) %>%
      dplyr::select(all_of(meta_constant), dplyr::all_of(c(keep_col)))

    output <- list("full" = full,
                   "discrepancies" =discrepancies)}




  if(comparison=="rights"){
    userdata <- redcap_token_list %>%
      purrr::map_df(function(x){

        title = RCurl::postForm(uri=redcap_project_uri,token=x, content='project', format='csv') %>% readr::read_csv() %>%
          dplyr::pull(project_title)

        out <- collaborator:::user_role(redcap_project_uri = redcap_project_uri, redcap_project_token =x)$full %>%
          dplyr::select(-any_of(c("email", "firstname", "lastname", "expiration", "data_access_group", "data_access_group_id"))) %>%
          dplyr::mutate(project = title) %>%
          dplyr::group_by(across(-username)) %>%
          dplyr::summarise(.groups = "drop",
                           user_name = paste0(username, collapse = "; "),
                           user_n = n()) %>%
          dplyr::select(project, role, user_n, user_name, everything())

        return(out)}) %>%
      dplyr::mutate(project = factor(project))

    user_constant <- c("project", "n", "role", "user_name", "user_n")

    full <- userdata %>%
      dplyr::group_by(across(design:forms)) %>%
      dplyr::summarise(n = n(),
                       project = paste0(unique(project), collapse = ", "),
                       role = paste0(unique(role), collapse = ", "),
                       user_name = paste0(user_name, collapse = "; "),
                       .groups = "drop") %>%
      dplyr::select(any_of(user_constant), everything()) %>%

      dplyr::mutate(user_name = stringr::str_split(user_name, "; ")) %>%
      dplyr::mutate(user_n = purrr::map(user_name, function(x){unique(x) %>% length()}),
                    user_name = purrr::map(user_name, function(x){unique(x) %>% paste0(collapse = "; ")}))



    keep_col <- full %>%
      dplyr::filter(n!=length(redcap_token_list)) %>%
      purrr::map_chr(function(x){length(unique(x)) > 1}) %>% tibble::enframe() %>% filter(value ==T) %>%
      dplyr::pull(name)

    if(purrr::is_empty(keep_col)){keep_col <- NULL}else{keep_col <- c("variable_name", keep_col)}

    discrepancies <- full %>%
      dplyr::filter(n!=length(redcap_token_list)) %>%
      dplyr::select(all_of(user_constant), dplyr::all_of(keep_col))

    output <- list("full" = full,
                   "discrepancies" =discrepancies)}


  return(output)}
