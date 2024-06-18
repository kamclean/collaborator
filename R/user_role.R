# user_role-----------------------------
# Documentation
#' Identifies unique REDCap user roles
#' @description Used to count the number of unique roles (e.g. unique combinations of user rights) on the REDCap project. Note: this replaces the function of roles on the user rights page of the REDCap.
#' @param redcap_project_uri URI (Uniform Resource Identifier) for the REDCap instance.
#' @param redcap_project_token API (Application Programming Interface) for the REDCap project.
#' @param user_exclude Vector of usernames to be excluded (e.g. those with unique rights). Default is none (e.g. "").
#' @param remove_id Logical value to remove identifying details of users (e.g. name, email). Default is TRUE
#' @param show_rights  Logical value to show user rights allocated to each role. Default is FALSE
#' @import dplyr
#' @importFrom httr POST content
#' @return Dataframe of all users by unique role
#' @export


# Function:
user_role <- function(redcap_project_uri, redcap_project_token, user_exclude = NULL, remove_id = T, show_rights = F){
  require(httr); require(dplyr)

  # PULL users
  user_current <- httr::POST(url=redcap_project_uri,
                             body = list("token"= redcap_project_token, content='user',
                                         action='export', format='csv')) %>%
    httr::content(show_col_types = FALSE)


  user_rights <- user_current%>%
    dplyr::select(-any_of(c("email","firstname","lastname","expiration",
                            "data_access_group","data_access_group_id"))) %>%
    dplyr::rename_with(function(x){paste0("right_", x)}) %>%
    dplyr::rename("username" = "right_username")

  # Add user role (if used)

  pull_role <- httr::POST(url=redcap_project_uri,
                          body = list("token"= redcap_project_token, content='userRole',
                                      action='export', format='csv')) %>%
    httr::content(show_col_types = FALSE)

  role = tibble::tibble("role_id" = NA, "role_name" = NA)
  user_role = tibble::tibble("role_id" = NA, "role_name" = NA, "username" = NA)

  if(is.null(pull_role)==F){
    role <- pull_role  %>%
      dplyr::select( "role_name" = role_label,"role_id" = unique_role_name)

    user_role <- httr::POST(url=redcap_project_uri,
                            body = list("token"= redcap_project_token, content='userRoleMapping',
                                        action='export', format='csv')) %>%
      httr::content(show_col_types = FALSE) %>%
      dplyr::rename("role_id" = unique_role_name) %>%
      full_join(role, by = "role_id") %>%
      dplyr::select(role_name, role_id,username)}


  all <- user_current %>%
    dplyr::select(username:data_access_group_id)  %>%
    filter(is.na(username)==F) %>%
    left_join(user_role %>%
                dplyr::mutate(role_name = factor(role_name)) %>%
                dplyr::arrange(role_name), by = "username") %>%
    dplyr::ungroup()


  if(remove_id==T){
    all <- all %>%
      select(-all_of(c("email", "firstname", "lastname", "expiration")))}


  sum <- all %>%
    dplyr::left_join(user_rights, by = "username") %>%
    dplyr::select(-any_of(c("email","firstname","lastname","expiration","data_access_group","data_access_group_id"))) %>%
    group_by(across(c(-all_of("username")))) %>%
    dplyr::summarise(n = n(),
                     username = list(unique(username)),
                     .groups = "drop") %>%
    dplyr::full_join(role,by = c("role_name", "role_id")) %>%
    dplyr::mutate(role_name = factor(role_name, levels = sort(role$role_name))) %>%
    dplyr::arrange(role_name) %>%
    dplyr::mutate(n = ifelse(is.na(n)==T, 0, n)) %>%
    dplyr::select(role_name, role_id, n, username, everything())

  if(show_rights==F){sum <- sum %>% select(-starts_with("right_"))}



  return(list("sum" = sum, "all" = all))}
