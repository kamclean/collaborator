# user_manage-------------------------
# Documentation
#' Used to manage REDCap project users
#' @description Used to manage users - whether to change users present, or their specific roles and data access groups on a redcap project.

#' @param redcap_project_uri URI (Uniform Resource Identifier) for the REDCap instance.
#' @param redcap_project_token API (Application Programming Interface) for the REDCap project.
#' @param users Vector of usernames or a dataframe containing at least 1 column ("username"). Further columns specifying individual patients to be removed ("remove") or assigned to roles ("role") or data access groups ("dag") can be added.
#' @param role String of a single role ID, role name or username of user with the desired user rights to be applied to ALL users specified in "users"  (use a column in users if wanting to be different for each user). Must specify "none" if no assignment of role.
#' @param dag String of a unique DAG to ALL users specified in "users" will be assigned to (use a column in users if wanting to be different for each user). Must specify "none" if no assignment of DAG.
#' @param remove Logical value indicating if ALL users specified in "users" are to be removed  (use a column in users if wanting to be different for each user). Default is FALSE (no users to be removed).
#' @import dplyr
#' @importFrom httr POST content
#' @importFrom readr read_csv
#' @importFrom tibble enframe
#' @importFrom tidyr pivot_wider
#' @return Nested tibbles of the outcome (1) "correct" users with the correct allocation specified (2) "error" users with an allocation unable to be completed. User acccounts are still required to be entered manually.
#' @export

# Function:
user_manage <- function(redcap_project_uri, redcap_project_token, users,
                        role = NULL, dag = NULL, remove = FALSE){

  # Load required functions
  require(dplyr);require(httr);require(readr);require(tidyr)


  user_current <- collaborator::user_role(redcap_project_uri=redcap_project_uri,
                                          redcap_project_token = redcap_project_token)

  role_current <- c(levels(user_current$sum$role_name), user_current$sum$role_id, unlist(user_current$sum$username))
  role_current <- c(na.omit(role_current), "none")

  dag_current <- c(collaborator::dag_manage(redcap_project_uri=redcap_project_uri,
                                            redcap_project_token = redcap_project_token)$unique_group_name, "none")

  is.defined <- function(sym) {
    sym <- deparse(substitute(sym))
    env <- parent.frame()
    exists(sym, env)}

  if(is.defined("users")==T){

    if(is.vector(users)){users <- users %>%
      tibble::enframe(name=NULL, value = "username") %>%
      dplyr::mutate(role = ifelse(is.null(role)==T, NA, role),
                    dag = ifelse(is.null(dag)==T, NA, dag))}

    # Remove users-------------------------
    # if no remove column, add column
    user_remove <- NULL
    if(! "remove" %in% names(users)&is.null(remove)==F){users <- users %>% mutate(remove = remove)}

    # Ensure remove column logical / no NA
    if(is.logical(users$remove)==F){stop("Remove column must be logical (TRUE / FALSE)")}
    users <- users %>%
      dplyr::mutate(remove = ifelse(is.na(remove)==T, FALSE, remove)) %>%
      dplyr::mutate(role = ifelse(remove==T, NA, role),
                    dag = ifelse(remove==T, NA, dag))

    user_remove <- users %>% filter(remove==TRUE)

    if(nrow(user_remove)>0){
      user_delete <- user_remove %>%
        dplyr::mutate(n =  1:n()-1) %>%
        dplyr::mutate(out = paste0("'users[", n, "]'='",username, "'")) %>%
        dplyr::summarise(users = paste0(out, collapse = ",")) %>%
        dplyr::pull(users)

      eval(parse(text = paste0("httr::POST(url=redcap_project_uri,
               body = list('token'= redcap_project_token,
                           content='user',action='delete',",
                               user_delete,
                               ", returnFormat='json'), encode = 'form')")))}


    # Add / change users in roles------------------------
    user_amend <- users %>%
      filter(remove==F)

    user_add <- NULL
    if(remove==F&nrow(user_amend)>0){

      # if no role column:
      ## AND no role specified, error
      if(! "role" %in% names(user_amend)&is.null(role)==T){stop("No roles provided. If no role is to be assigned, use 'none'.")}

      ## BUT a role specified, make a column
      if(! "role" %in% names(user_amend)&is.null(role)==F){user_amend <- user_amend %>% mutate(role = role)}

      # if NA in role column:
      if(NA %in% user_amend$role){stop("No role provided for one or more usernames. If no role is to be assigned, use 'none'.")}

      # if role not recognised:
      role_missing <- user_amend %>% filter(! role %in% role_current)
      if(nrow(role_missing)>0){stop(paste0("One or more unrecognised roles: ", paste0(dag_missing$role, collapse = ", ")))}

      user_add <- user_amend %>%
        filter(! (username %in% user_current$all$username))

      if(nrow(user_add)>0){
        import_user <- user_add %>%
          dplyr::mutate(json = paste0('{"username":"', username, '"}')) %>%
          dplyr::summarise(json = paste0(json, collapse = ", ")) %>%
          dplyr::mutate(json = paste0("[", json, "]")) %>%
          dplyr::pull(json)

        httr::POST(url=redcap_project_uri,
                   body = list("token"= redcap_project_token, content='user',
                               data = import_user,
                               action='import', format='json'))}

      # Assign role to user
      import_role <- user_amend %>%
        dplyr::mutate(unique_role_name = ifelse(role=="none", "", role)) %>%
        dplyr::left_join(user_current$sum %>% select(-username,-n), by = c("unique_role_name"="role_name")) %>%
        dplyr::mutate(role_id = ifelse(is.na(role_id), "", role_id)) %>%
        dplyr::mutate(json = paste0('{"username":"', username, '","unique_role_name":"', role_id,'"}')) %>%
        dplyr::summarise(json = paste0(json, collapse = ", ")) %>%
        dplyr::mutate(json = paste0("[", json, "]")) %>%
        dplyr::pull(json)

      httr::POST(url=redcap_project_uri,
                 body = list("token"= redcap_project_token, content='userRoleMapping',
                             data = import_role,
                             action='import', format='json'))}


    # Add / Assign DAG to user-------------------------
    if(remove==F&nrow(user_amend)>0){
      if(length(dag_current)>1&dag_current[1]!="none"){

        # if no DAG column:
        ## AND no DAG specified, error
        if(! "dag" %in% names(user_amend)&is.null(dag)==T){stop("No DAG provided. If no DAG is to be assigned, use 'none'.")}

        ## BUT a DAG specified, make a column
        if(! "dag" %in% names(user_amend)&is.null(dag)==F){user_amend <- user_amend %>% mutate(dag = dag)}

        # if NA in DAG column:
        if(NA %in% user_amend$dag){stop("No DAG provided for one or more usernames. If no DAG is to be assigned, use 'none'.")}

        # if dag not recognised:
        dag_missing <- user_amend %>% filter(! dag %in% dag_current)
        if(nrow(dag_missing)>0){stop(paste0("One or more unrecognised DAGs: ", paste0(dag_missing$dag, collapse = ", ")))}


        # Assign DAG to user
        import_dag <- user_amend %>%
          dplyr::mutate(redcap_data_access_group = ifelse(dag=="none", "", dag)) %>%
          dplyr::mutate(json = paste0('{"username":"', username, '","redcap_data_access_group":"', redcap_data_access_group,'"}')) %>%
          dplyr::summarise(json = paste0(json, collapse = ", ")) %>%
          dplyr::mutate(json = paste0("[", json, "]")) %>%
          dplyr::pull(json)

        httr::POST(url=redcap_project_uri,
                   body = list("token"= redcap_project_token, content='userDagMapping',
                               data = import_dag,
                               action='import', format='json'))}}



    # Compare changes -------------------------
    user_update <- user_role(redcap_project_uri=redcap_project_uri,
                             redcap_project_token = redcap_project_token)$all %>%
      dplyr::mutate(type = "new",
                    present = 1) %>%
      select(type, username, "role" = role_name, "dag" = data_access_group,present) %>%
      bind_rows(user_current$all %>%
                  dplyr::mutate(type = "old",
                                present = 1) %>%
                  select(type, username, "role" = role_name, "dag" = data_access_group,present)) %>%
      dplyr::mutate(role = as.character(role),
                    role = ifelse(is.na(role)==T, "none", role),
                    dag = ifelse(is.na(dag)==T, "none", dag)) %>%
      tidyr::pivot_wider(id_cols = "username", names_from = "type", values_from =c("role", "dag","present")) %>%

      dplyr::mutate(status_intended = case_when(username %in% user_add$username ~ "added",
                                                username %in% user_remove$username ~ "removed",
                                                TRUE ~ NA_character_))

    out <- users %>%
      select(username,"role_intended" = "role",  "dag_intended" = "dag") %>%
      full_join(user_update, by = "username") %>%
      filter(username %in% c(users$username, user_add$username, user_remove$username)) %>%
      dplyr::mutate(role_correct = ifelse(role_intended==role_new|(is.na(role_intended)==T&is.na(role_new)==T), "Yes", "No"),
                    dag_correct = ifelse(dag_intended==dag_new|(is.na(dag_intended)==T&is.na(dag_new)==T), "Yes", "No"),
                    status_correct = case_when(is.na(present_old)==F&is.na(present_new)==T&username %in% user_add$username ~ "Not added",
                                               is.na(present_old)==T&is.na(present_new)==F&username %in% user_remove$username ~ "Not removed",
                                               TRUE ~ "Yes")) %>%


      dplyr::mutate(action = case_when(is.na(present_old)==F&is.na(present_new)==F ~ "unchanged",
                                       is.na(present_old)==F&is.na(present_new)==T ~ "remove",
                                       is.na(present_old)==T&is.na(present_new)==F ~ "add",
                                       is.na(present_old)==T&is.na(present_new)==T ~ "absent"),
                    role = case_when(action=="remove" ~ paste0(role_old, " --> NA"),
                                     action=="add" ~ paste0("NA --> ",role_new),
                                     action=="absent" ~ NA_character_,
                                     action=="unchanged" & role_old==role_new ~ role_old,
                                     action=="unchanged" & role_old!=role_new ~ paste0(role_old, " --> ",role_new)),
                    dag = case_when(action=="remove" ~ paste0(dag_old, " --> NA"),
                                    action=="add" ~ paste0("NA --> ",dag_new),
                                    action=="absent" ~ NA_character_,
                                    action=="unchanged" & dag_old==dag_new ~ dag_old,
                                    action=="unchanged" & dag_old!=dag_new ~ paste0(dag_old, " --> ",dag_new)),
                    action = case_when(action=="unchanged"&str_detect(role, "-->")==T&str_detect(dag, "-->")==T ~ "change (dag/role)",
                                       action=="unchanged"&str_detect(role, "-->")==F&str_detect(dag, "-->")==T ~ "change (dag)",
                                       action=="unchanged"&str_detect(role, "-->")==T&str_detect(dag, "-->")==F ~ "change (role)",
                                       TRUE ~ action))
    correct <- out %>%
      filter(role_correct=="Yes"&dag_correct=="Yes"&status_correct=="Yes") %>%
      select(username, action, role, dag)

    error = out %>%
      filter(role_correct=="No"|dag_correct=="No"|status_correct!="Yes") %>%
      dplyr::select(username, action, status_intended, role, role_intended, dag, dag_intended)

    return(list("correct" = correct, "error" = error))}

  if(is.defined("users")==F){return(user_current)}}



