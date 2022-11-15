# redcap_compare--------------------------------
# Documentation
#' Compare multiple REDCap projects to determine discrepancies in structure or user rights.
#' @description Used to compare multiple REDCap projects to determine discrepancies in structure or user rights.
#' @param redcap_project_uri URI (Uniform Resource Identifier) for the REDCap instance (must all be on same REDCap instance)
#' @param redcap_token_list List of API (Application Programming Interface) for the REDCap projects.
#' @param comparison What should be compared - project structure ("metadata") or user roles ("role").
#' @return Nested tibble of the full comparison across projects ("full") and the specific discrepancies ("discrepancies").
#' @import dplyr
#' @import tibble
#' @importFrom httr POST content
#' @importFrom purrr map_chr map_df is_empty map
#' @importFrom readr read_csv
#' @importFrom stringr str_split
#' @export

redcap_compare <- function(redcap_project_uri, redcap_token_list, comparison){


  output <- NULL
  if(comparison=="metadata"){
    metadata <- redcap_token_list %>%
      purrr::map_df(function(x){

        title = httr::POST(url = redcap_project_uri,
                           body = list("token"=x,
                                       content='project',
                                       format='csv',
                                       returnFormat='json'), encode = "form") %>%
          httr::content(type = "text/csv",show_col_types = FALSE,
                        guess_max = 100000, encoding = "UTF-8") %>%
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

    output <- list("full" = full %>% dplyr::filter(n==length(redcap_token_list)),
                   "discrepancies" =discrepancies)}


  if(comparison=="role"){
    userdata <- redcap_token_list %>%
      purrr::map_df(function(x){

        title = httr::POST(url = redcap_project_uri,
                           body = list("token"=x,
                                       content='project',
                                       format='csv',
                                       returnFormat='json'), encode = "form") %>%
          httr::content(type = "text/csv",show_col_types = FALSE,
                        guess_max = 100000, encoding = "UTF-8") %>%
          dplyr::pull(project_title)

        out <- user_role(redcap_project_uri = redcap_project_uri, redcap_project_token =x,
                         show_rights = T, remove_id = T)$sum %>%
          dplyr::mutate(project = title) %>%

          dplyr::select(project, role_name, "user_n" = n, user_name = "username", everything())

        return(out)}) %>%
      dplyr::mutate(project = factor(project))

    user_constant <- c("project", "role_name", "user_n", "user_name")

    full <- userdata %>%
      group_by(across(starts_with("right_"))) %>%
      dplyr::summarise(n = n(),
                       project = list(as.character(unique(project))),
                       role_name = list(as.character(unique(role_name))),
                       user_name = unique(user_name),
                       .groups = "drop") %>%
      dplyr::mutate(user_n = purrr::map_chr(user_name, function(x){length(x)}),
                    user_name = purrr::map(user_name, function(x){unique(x) %>% paste0(collapse = "; ")}),
                    project = purrr::map(project, function(x){unique(x) %>% paste0(collapse = "; ")}),
                    role_name = purrr::map(role_name, function(x){unique(x) %>% paste0(collapse = "; ")})) %>%
      dplyr::select(any_of(user_constant), everything())

    keep_col <- full %>%
      dplyr::filter(n!=length(redcap_token_list)) %>%
      purrr::map_chr(function(x){length(unique(x)) > 1}) %>% tibble::enframe() %>% filter(value ==T) %>%
      dplyr::pull(name)

    discrepancies <- full %>%
      dplyr::filter(n!=length(redcap_token_list)) %>%
      dplyr::select(all_of(user_constant), dplyr::all_of(keep_col))

    output <- list("full" = full)}


  return(output)}
