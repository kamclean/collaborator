# redcap_sum--------------------------------
# Documentation
#' Generate REDCap summary data.
#' @description Used to generate high quality summary data for REDCap projects at overall, and DAG-specific level.
#' @param redcap_project_uri URI (Uniform Resource Identifier) for the REDCap instance.
#' @param redcap_project_token API (Application Programming Interface) for the REDCap project.
#' @param centre_sum Logical input (TRUE/FALSE) to determine whether data access group-level summaries will be produced (Default = TRUE).
#' @param n_top_dag When centre_sum = TRUE, defines output of the number of centres with the most records uploaded (default is top 10).
#' @param var_exclude Vector of names of variables that are desired to be excluded from assessment of data completness (any NA value will be counted as incomplete).
#' @param var_complete Vector of names of variables that are desired to be specifically used to assess data completness (alternate method from using "var_exclude").
#' @param user_exclude Vector of redcap usernames that are desired to be excluded from the user count (note all users not assigned to a DAG will automatically be excluded).
#' @param record_exclude Vector of redcap record_id that are desired to be excluded from the record count.
#' @param dag_exclude Vector of redcap data access group names that are desired to be excluded from the record count.
#' @param record_dag_field Name of the data access group variable in the redcap record API output (default is: redcap_data_access_group).
#' @param user_dag_field Name of the data access group variable in the redcap user API output (default is: data_access_group).
#' @return Nested dataframes of (i) overall summary statistics for the project ("sum_overall") (ii). DAG-specific summary statistics for the project ("dag_all") (iii). DAGs with no data uploaded, but users assigned ("dag_nodata") (iv). DAGs with <100% completeness ("dag_incom") (v). The top n recruiting centres ("dag_top_n").
#' @importFrom dplyr filter mutate arrange select summarise pull
#' @importFrom magrittr "%>%"
#' @importFrom lubridate day month year origin
#' @export

redcap_sum <- function(redcap_project_uri, redcap_project_token,
                       centre_sum = T, n_top_dag = 10,
                       var_exclude = "", var_complete = "",
                       user_exclude = "", record_exclude = "",dag_exclude = "",
                       record_dag_field = "redcap_data_access_group",
                       user_dag_field = "data_access_group"){
  # Prepare dataset----------------
  # Load functions / packages
  "%ni%" <- Negate("%in%")

  # Dataframe of current records----------------------------
  # Load data from REDCap
  df_record <- RCurl::postForm(uri=redcap_project_uri,
                               token = redcap_project_token,
                               content='record',
                               exportDataAccessGroups = 'true',
                               format='csv',
                               raworLabel="raw") %>%
    readr::read_csv()

  # Exclude rows / columns from df_record
  var_form_complete <- colnames(df_record)[grepl("_complete", colnames(df_record), fixed=TRUE)]

  # Clean dataset (remove record_exclude / var_exclude / dag_exclude, and keep var_complete)
  df_record <- df_record %>%
    dplyr::mutate(dag = pull(df_record[which(colnames(df_record)==record_dag_field)])) %>%
    dplyr::filter(record_id %ni% record_exclude) %>%
    dplyr::filter(dag %ni% dag_exclude) %>%
    dplyr::filter(is.na(dag)==F) %>%
    dplyr::select(colnames(.)[colnames(.) %ni% c(var_exclude, var_form_complete)])

  if(length(var_complete)>1&var_complete[1]!=""){
    df_record <- df_record %>%
      dplyr::select(colnames(.)[colnames(.) %in% c("dag", var_complete)])}



  # Summarise record by DAG
  df_record_sum_dag <- df_record %>%
    # count the number of NA by row
    dplyr::mutate(com = apply(., 1, function(x) sum(is.na(x)))) %>%

    # reverse binary (make 1 = complete record)
    dplyr::mutate(com = ifelse(com>0, 0, 1)) %>%
    dplyr::group_by(dag) %>%

    # count number of records / number of complete records by centre
    dplyr::summarise(record_all = n(),
                     record_com = sum(com)) %>%
    dplyr::mutate(prop_com = record_com/record_all,
                  pct_com = trimws(paste0(format(round(record_com/record_all*100, 1), nsmall=1), "%")))

  # Summarise all records
  df_record_sum_all <- df_record_sum_dag %>%
    dplyr::select(dag, record_all, record_com) %>%
    dplyr::summarise(record_all = sum(record_all),
                     record_com = sum(record_com)) %>%
    dplyr::mutate(prop_com = record_com/record_all,
                  pct_com = trimws(paste0(format(round(record_com/record_all*100, 1), nsmall=1), "%")))


  # Dataframe of current users----------------------------
  # Load data from REDCap
  df_user <- RCurl::postForm(uri=redcap_project_uri,
                             token = redcap_project_token,
                             content='user',
                             exportDataAccessGroups = 'true',
                             format='csv',
                             raworLabel="raw") %>%
    readr::read_csv()

  # Clean dataset (remove user_exclude)
  df_user <- df_user %>%
    dplyr::mutate(dag = dplyr::pull(df_user[which(colnames(df_user)==user_dag_field)])) %>%
    dplyr::filter(username %ni% user_exclude) %>%
    dplyr::filter(is.na(dag)==F) %>%
    dplyr::filter(dag %ni% dag_exclude) %>%
    dplyr::select(dag)

  # Summarise user by DAG
  df_user_sum_dag <- df_user %>%
    dplyr::group_by(dag) %>%
    dplyr::summarise(user_all = n())

  # Summarise all records
  df_user_sum_all <- df_user %>%
    dplyr::summarise(user_all = n())

  # Overall summary output ---------------------------
  sum_overall <- cbind.data.frame(df_record_sum_all,
                                  record_dag = nrow(df_record_sum_dag),
                                  df_user_sum_all,
                                  last_update = paste(lubridate::day(Sys.Date()),
                                                      lubridate::month(Sys.Date(), label=TRUE),
                                                      lubridate::year(Sys.Date()),sep="-")) %>%
    dplyr::select("n_record_all" = record_all, "n_record_com" = record_com,
                  prop_com, pct_com,
                  "n_dag" = record_dag, n_users = "user_all",
                  last_update)

  if(centre_sum==F){redcap_summary <- sum_overall}

  # DAG summary output ---------------------------
  if(centre_sum==T){

    sum_dag_all <- dplyr::full_join(df_record_sum_dag, df_user_sum_dag, by="dag") %>%
      dplyr::mutate(record_all = ifelse(is.na(record_all)==T, 0,record_all),
                    last_update = paste(lubridate::day(Sys.Date()),
                                        lubridate::month(Sys.Date(), label=TRUE),
                                        lubridate::year(Sys.Date()),sep="-")) %>%
      dplyr::arrange(-record_all)

    sum_dag_nodata <- dplyr::filter(sum_dag_all, record_all==0)
    sum_dag_incom <- dplyr::filter(sum_dag_all, prop_com<1)
    sum_dag_top <- dplyr::select(sum_dag_all, "top_n_dag" = dag, record_all) %>%
      head(., n_top_dag)


    # combine output
    redcap_summary <- list("sum_overall" = sum_overall,
                           "dag_all" = sum_dag_all,
                           "dag_nodata" = sum_dag_nodata,
                           "dag_incom" = sum_dag_incom,
                           "dag_top_n" = sum_dag_top)}

  return(redcap_summary)}
