# user_role-----------------------------
# Documentation
#' Identifies unique REDCap user roles
#' @description Used to count the number of unique roles (e.g. unique combinations of user rights) on the REDCap project. Note: this replaces the function of roles on the user rights page of the REDCap.
#' @param redcap_project_uri URI (Uniform Resource Identifier) for the REDCap instance.
#' @param redcap_project_token API (Application Programming Interface) for the REDCap project.
#' @param user_exclude Vector of usernames to be excluded (e.g. those with unique rights). Default is none (e.g. "").
#' @import dplyr
#' @importFrom httr POST content
#' @return Dataframe of all users by unique role
#' @export

# Function:
user_role <- function(redcap_project_uri, redcap_project_token, user_exclude = NULL, remove_id = T){
  require(httr); require(dplyr); require(stringr); require(purrr)

  role <- httr::POST(url=redcap_project_uri,
                     body = list("token"= redcap_project_token, content='userRole',
                                 action='export', format='csv')) %>%
    httr::content(show_col_types = FALSE)  %>%
    dplyr::select("role_id" = unique_role_name, "role_name" = role_label)

  user_role <- httr::POST(url=redcap_project_uri,
                          body = list("token"= redcap_project_token, content='userRoleMapping',
                                      action='export', format='csv')) %>%
    httr::content(show_col_types = FALSE) %>%
    dplyr::rename("role_id" = unique_role_name) %>%
    full_join(role, by = "role_id") %>%
    dplyr::select(role_name, role_id,username)

  user_current <- httr::POST(url=redcap_project_uri,
                             body = list("token"= redcap_project_token, content='user',
                                         action='export', format='csv')) %>%
    httr::content(show_col_types = FALSE)  %>%
    dplyr::select(username:data_access_group_id)

  all <- user_role %>%
    dplyr::mutate(role_name = factor(role_name)) %>%
    dplyr::arrange(role_name) %>%
    left_join(user_current, by = "username") %>%
    dplyr::ungroup()  %>%
    filter(is.na(username)==F)

  if(remove_id==T){
    all <- all %>%
      select(-all_of(c("email", "firstname", "lastname", "expiration")))}

  sum <- all %>%
    dplyr::group_by(role_name, role_id) %>%
    dplyr::summarise(n = n(),
                     username = list(unique(username)),
                     .groups = "drop") %>%
    dplyr::full_join(role,by = c("role_name", "role_id")) %>%
    dplyr::mutate(role_name = factor(role_name, levels = sort(role$role_name))) %>%
    dplyr::arrange(role_name) %>%
    dplyr::mutate(n = ifelse(is.na(n)==T, 0, n))

  return(list("sum" = sum, "all" = all))}
