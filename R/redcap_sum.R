# redcap_sum--------------------------------
# Documentation
#' Generate REDCap summary data.
#' @description Used to generate high quality summary data for REDCap projects at overall, and DAG-specific level.
#' @param redcap_project_uri URI (Uniform Resource Identifier) for the REDCap instance.
#' @param redcap_project_token API (Application Programming Interface) for the REDCap project.
#' @param use_ssl Logical value whether to verify the peer's SSL certificate should be evaluated during the API pull (default=TRUE)
#' @param centre_sum Logical value to determine whether data access group-level summaries will be produced (Default = TRUE).
#' @param n_top_dag When centre_sum = TRUE, defines output of the number of centres with the most records uploaded (default is top 10).
#' @param var_include Vector of names of variables that are desired to be specifically used to assess data completness (alternate method from using "var_exclude").
#' @param var_exclude Vector of names of variables that are desired to be excluded from assessment of data completness (any NA value will be counted as incomplete).
#' @param user_include Vector of redcap usernames that are desired to be included in the user count (note all users not assigned to a DAG will automatically be excluded).
#' @param user_exclude Vector of redcap usernames that are desired to be excluded from the user count (note all users not assigned to a DAG will automatically be excluded).
#' @param record_include Vector of redcap record_id that are desired to be included in the record count.
#' @param record_exclude Vector of redcap record_id that are desired to be excluded from the record count.
#' @param dag_include Vector of redcap data access group names that are desired to be included in the record count.
#' @param dag_exclude Vector of redcap data access group names that are desired to be excluded from the record count.
#' @return Nested dataframes of (i) overall summary statistics for the project ("sum_overall") (ii). DAG-specific summary statistics for the project ("dag_all") (iii). DAGs with no data uploaded, but users assigned ("dag_nodata") (iv). DAGs with <100% completeness ("dag_incom") (v). The top n recruiting centres ("dag_top_n").
#' @import dplyr
#' @importFrom scales percent
#' @importFrom lubridate day month year origin
#' @importFrom RCurl postForm curlOptions
#' @importFrom readr read_csv
#' @export

redcap_sum <- function(redcap_project_uri = NULL, redcap_project_token = NULL, use_ssl = TRUE,
                       centre_sum = TRUE, n_top_dag = 10,
                       var_include = NULL, var_exclude = NULL,
                       user_include = NULL, user_exclude = NULL,
                       dag_exclude = NULL, dag_include = NULL,
                       record_include = NULL, record_exclude = NULL){

  # Load functions / packages
  require(dplyr);require(scales);require(lubridate);require(RCurl);require(readr)

  # Dataframe of current records----------------------------
  # Load data from REDCap
  df_record <- RCurl::postForm(uri=redcap_project_uri,
                               token = redcap_project_token,
                               content='record',
                               exportDataAccessGroups = 'true',
                               .opts = RCurl::curlOptions(ssl.verifypeer = if(use_ssl==F){FALSE}else{TRUE}),
                               format='csv',
                               raworLabel="raw")

  df_record <- suppressWarnings(readr::read_csv(df_record)) %>%
    dplyr::select(-contains("_complete")) %>%
    dplyr::filter(is.na(redcap_data_access_group)==F)

  # Clean dataset
  if(is.null(var_exclude==F)){df_record <- df_record %>% dplyr::select(-one_of(var_exclude))}
  if(is.null(var_include==F)){df_record <- df_record %>% dplyr::select(redcap_data_access_group, all_of(var_include))}

  if(is.null(dag_exclude==F)){df_record <- df_record %>% dplyr::filter(! redcap_data_access_group %in% dag_exclude)}
  if(is.null(dag_include==F)){df_record <- df_record %>% dplyr::filter(redcap_data_access_group %in% dag_include)}

  if(is.null(record_exclude==F)){df_record <- df_record %>% dplyr::filter(! record_id %in% record_exclude)}
  if(is.null(record_include==F)){df_record <- df_record %>% dplyr::filter(record_id %in% record_include)}


  # Summarise record by DAG
  df_record_sum_dag <- df_record %>%
    # count the number of NA by row (1 = complete record)
    dplyr::mutate(com = ifelse(rowSums(is.na(.)==T)>0, 0, 1)) %>%
    dplyr::group_by(redcap_data_access_group) %>%

    # count number of records / number of complete records by centre
    dplyr::summarise(record_all = n(),
                     record_com = sum(com)) %>%
    dplyr::mutate(prop_com = record_com/record_all,
                  pct_com = scales::percent(prop_com))

  # Summarise all records
  df_record_sum_all <- df_record_sum_dag %>%
    dplyr::select(redcap_data_access_group, record_all, record_com) %>%

    # count number of records / number of complete records overall
    dplyr::summarise(record_dag = nrow(.),
                     record_all = sum(record_all),
                     record_com = sum(record_com)) %>%
    dplyr::mutate(prop_com = record_com/record_all,
                  pct_com = scales::percent(prop_com))

  # Dataframe of current users----------------------------
  # Load data from REDCap
  df_user <- RCurl::postForm(uri=redcap_project_uri,
                             token = redcap_project_token,
                             content='user',
                             .opts = curlOptions(ssl.verifypeer = if(use_ssl==F){FALSE}else{TRUE}),
                             exportDataAccessGroups = 'true',
                             format='csv',
                             raworLabel="raw")

  df_user <- suppressWarnings(readr::read_csv(df_user)) %>%
    dplyr::select("redcap_data_access_group" = data_access_group, username) %>%
    dplyr::filter(is.na(redcap_data_access_group)==F)

  # Clean dataset
  if(is.null(dag_exclude==F)){df_user <- df_user %>% dplyr::filter(! redcap_data_access_group %in% dag_exclude)}
  if(is.null(dag_include==F)){df_user <- df_user %>% dplyr::filter(redcap_data_access_group %in% dag_include)}

  if(is.null(user_exclude==F)){df_user <- df_user %>% dplyr::filter(! username %in% user_exclude)}
  if(is.null(user_include==F)){df_user <- df_user %>% dplyr::filter(username %in% user_include)}


  # Summarise user by DAG
  df_user_sum_dag <- df_user %>%
    dplyr::group_by(redcap_data_access_group) %>%
    dplyr::summarise(user_all = n())

  # Summarise all records
  df_user_sum_all <- df_user %>%
    dplyr::summarise(user_all = n())

  # Overall summary output ---------------------------
  sum_overall <- dplyr::bind_cols(df_record_sum_all,
                                  df_user_sum_all,
                                  last_update = paste(lubridate::day(Sys.Date()),
                                                      lubridate::month(Sys.Date(), label=TRUE),
                                                      lubridate::year(Sys.Date()), sep="-")) %>%
    dplyr::select("n_record_all" = record_all, "n_record_com" = record_com,
                  prop_com, pct_com, "n_dag" = record_dag, n_users = "user_all",
                  last_update)

  if(centre_sum==F){report_summary <- sum_overall}

  # DAG summary output ---------------------------
  if(centre_sum==T){

    sum_dag_all <- dplyr::full_join(df_record_sum_dag, df_user_sum_dag, by="redcap_data_access_group") %>%
      dplyr::mutate(record_all = ifelse(is.na(record_all)==T, 0,record_all),
                    last_update = paste(lubridate::day(Sys.Date()),
                                        lubridate::month(Sys.Date(), label=TRUE),
                                        lubridate::year(Sys.Date()),sep="-")) %>%
      dplyr::arrange(-record_all)

    # combine output
    report_summary <- list("sum_overall" = sum_overall,
                           "dag_all" = sum_dag_all,
                           "dag_nodata" = dplyr::filter(sum_dag_all, record_all==0),
                           "dag_incom" = dplyr::filter(sum_dag_all, prop_com<1),
                           "dag_top_n" = dplyr::select(sum_dag_all, "top_n_dag" = redcap_data_access_group, record_all) %>% head(n_top_dag))}

  return(report_summary)}
