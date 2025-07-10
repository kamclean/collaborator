# redcap_synth--------------------------------
# Documentation
#' Simulate data from REDCap metadata
#' @description Used to generate simulated data from REDCap metadata, incorporating repeating instruments, validation and branching logic (where present).
#' @param redcap_project_uri URI (Uniform Resource Identifier) for the REDCap instance.
#' @param redcap_project_token API (Application Programming Interface) for the REDCap project.
#' @param nrecords Numeric value of the number of unique records to simulate (default = 100). If there are repeating instruments, there will be more rows than this.
#' @param propmiss Proportion of data missing within each variable in the simulated data (only record_id is excempt)
#' @param sampledist A string specifying the data distribution for all numeric/date/datetime variables. Either "normal", "lskew", "rskew", "equal". (default = equal)
#' @return Tibble of simulated REDCap data
#' @import dplyr
#' @import tidyr
#' @import purrr
#' @import stringr
#' @import stringi
#' @import lubridate
#' @importFrom httr POST content
#' @importFrom rlang parse_expr
#'
#' @export
#'

redcap_synth <- function(redcap_project_uri, redcap_project_token, nrecords = 100, propmiss = 0.10, sampledist = "normal"){
  require(dplyr); require(httr); require(tidyr); require(stringr); require(purrr); require(stringi); require(rlang); require(lubridate)

  metadata <- redcap_metadata(redcap_project_uri = redcap_project_uri,
                              redcap_project_token = redcap_project_token) %>%
    select(-n)



  # v2 idea - separately set skew for each variable? (if wanted)
  simulation <- function(metadata, nrecords, propmiss, sampledist){

    # Establish what class each variable is
    var_character = metadata %>% filter(class=="character") %>% pull(variable_name)
    var_factor = metadata %>% filter(class=="factor") %>% pull(variable_name)
    var_numeric = metadata %>% filter(class=="numeric") %>% pull(variable_name)
    var_date = metadata %>% filter(class=="date") %>% pull(variable_name)
    var_datetime_hm = metadata %>% filter(class=="datetime_hm") %>% pull(variable_name)
    var_datetime_hms = metadata %>% filter(class=="datetime_hms") %>% pull(variable_name)

    metadata_character <- metadata %>%
      dplyr::filter(variable_name %in% var_character) %>%
      dplyr::filter(variable_name!="record_id") %>%
      # simulate factor levels
      dplyr::mutate(value = case_when(variable_validation=="email" ~ list(paste0("email", 1:nrecords, "@email.com")),
                                      TRUE ~ list(rep("Lorem ipsum dolor sit amet", nrecords))),
                    value = purrr::map(value, function(x){ifelse(1:nrecords %in% sample(1:nrecords, nrecords*propmiss, replace=F), NA, x)}))

    metadata_factor <- metadata %>%
      dplyr::filter(variable_name %in% var_factor) %>%
      dplyr::select(-variable_validation,-variable_validation_min,-variable_validation_max) %>%
      group_by(variable_name) %>%
      # simulate factor levels
      dplyr::mutate(value = purrr::map(factor_level, function(x){sample(x, nrecords, replace=TRUE)}),
                    value = purrr::map(value, function(x){ifelse(1:nrecords %in% sample(1:nrecords, nrecords*propmiss, replace=F), NA, x)}))

    rtnorm <- function(n, mean=NA, sd=0.25, lower=0, upper=1){
      mean = ifelse(is.na(mean)|| mean < lower || mean > upper, mean(c(lower, upper)), mean)

      data <- rnorm(n, mean=mean, sd=sd) # data

      if (!is.na(lower) && !is.na(upper)){ # adjust data to specified range
        drange <- range(data)           # data range
        irange <- range(lower, upper)   # input range
        data <- (data - drange[1])/(drange[2] - drange[1]) # normalize data (make it 0 to 1)
        data <- (data * (irange[2] - irange[1]))+irange[1]} # adjust to specified range

      return(data)}

    # https://stackoverflow.com/questions/19343133/setting-upper-and-lower-limits-in-rnorm

    metadata_numeric <- metadata %>%
      dplyr::filter(variable_name %in% c(var_numeric)) %>%
      dplyr::select(-factor_level) %>%
      dplyr::mutate(variable_validation_min = ifelse(is.na(variable_validation_min)==T,-10000, variable_validation_min),
                    variable_validation_max = ifelse(is.na(variable_validation_max)==T,10000, variable_validation_max),
                    sampledist = sampledist) %>%
      select(variable_name, variable_validation_min, variable_validation_max, sampledist) %>%
      dplyr::group_by(variable_name) %>%
      # simulate factor levels
      dplyr::mutate(value = purrr::map(variable_name,
                                       function(x){
                                         range = variable_validation_min:variable_validation_max
                                         sample(range, nrecords, replace=TRUE,

                                                prob = if(sampledist =="equal"){NULL}else{
                                                  case_when(sampledist=="normal" ~ c(sort(rtnorm(n=floor(length(range)/2))),
                                                                                     rev(sort(rtnorm(n=ceiling(length(range)/2))))),

                                                            sampledist=="lskew" ~ rev(sort(rtnorm(n=length(range))^5)),

                                                            sampledist=="rskew" ~ sort(rtnorm(n=length(range))^5))})}),
                    value = purrr::map(value, function(x){ifelse(1:nrecords %in% sample(1:nrecords, nrecords*propmiss, replace=F), NA, x)}))

    metadata_date <- metadata %>%
      dplyr::filter(variable_name %in% c(var_date)) %>%
      dplyr::select(-factor_level) %>%
      dplyr::mutate(variable_validation_min = case_when(is.na(variable_validation_min)==T ~ Sys.Date()-years(125),
                                                        TRUE ~ lubridate::as_date(variable_validation_min)),
                    variable_validation_max = case_when(is.na(variable_validation_max)==T ~ Sys.Date()+years(125),
                                                        TRUE~ lubridate::as_date(variable_validation_max))) %>%
      dplyr::group_by(variable_name) %>%
      # simulate factor levels
      dplyr::mutate(value = purrr::map(variable_name,
                                       function(x){
                                         range = variable_validation_min:variable_validation_max

                                         as_date(sample(range,
                                                        nrecords, replace=TRUE,
                                                        prob = if(sampledist =="equal"){NULL}else{
                                                          case_when(sampledist=="normal" ~ c(sort(rtnorm(n=floor(length(range)/2))),
                                                                                             rev(sort(rtnorm(n=ceiling(length(range)/2))))),

                                                                    sampledist=="lskew" ~ rev(sort(rtnorm(n=length(range))^5)),

                                                                    sampledist=="rskew" ~ sort(rtnorm(n=length(range))^5))}))}),
                    value = purrr::map(value, function(x){case_when(1:nrecords %in% sample(1:nrecords, nrecords*propmiss, replace=F) ~ NA_Date_, TRUE ~ x)}))

    metadata_datetime_hm <- metadata %>%
      dplyr::filter(variable_name %in% var_datetime_hm) %>%
      dplyr::select(-factor_level) %>%
      dplyr::mutate(variable_validation_min = case_when(is.na(variable_validation_min)==T ~ Sys.Date()-years(125),
                                                        TRUE ~ lubridate::as_date(variable_validation_min,format="%Y-%m-%d %H:%M")),
                    variable_validation_max = case_when(is.na(variable_validation_max)==T ~ Sys.Date()+years(125),
                                                        TRUE~ lubridate::as_date(variable_validation_max,format="%Y-%m-%d %H:%M"))) %>%
      dplyr::group_by(variable_name) %>%
      # simulate factor levels
      dplyr::mutate(value = purrr::map(variable_name,
                                       function(x){
                                         range = variable_validation_min:variable_validation_max

                                         sample(range,nrecords, replace=TRUE,

                                                prob = if(sampledist =="equal"){NULL}else{
                                                  case_when(sampledist=="normal" ~ c(sort(rtnorm(n=floor(length(range)/2))),
                                                                                     rev(sort(rtnorm(n=ceiling(length(range)/2))))),

                                                            sampledist=="lskew" ~ rev(sort(rtnorm(n=length(range))^5)),

                                                            sampledist=="rskew" ~ sort(rtnorm(n=length(range))^5))})}),
                    value = purrr::map(value, function(x){as_datetime(paste0(as_date(x)," ",
                                                                             sample(0:23, nrecords,replace=TRUE),":",sample(0:59, nrecords,replace=TRUE),
                                                                             sample(0:59, nrecords,replace=TRUE)),format="%Y-%m-%d %H:%M:%S")}),
                    value = purrr::map(value, function(x){case_when(1:nrecords %in% sample(1:nrecords, nrecords*propmiss, replace=F) ~ NA_Date_, TRUE ~ x)}))

    metadata_datetime_hms <- metadata %>%
      dplyr::filter(variable_name %in% var_datetime_hms) %>%
      dplyr::select(-factor_level) %>%
      dplyr::mutate(variable_validation_min = case_when(is.na(variable_validation_min)==T ~ Sys.Date()-years(125),
                                                        TRUE ~ lubridate::as_date(variable_validation_min,format="%Y-%m-%d %H:%M:%S")),
                    variable_validation_max = case_when(is.na(variable_validation_max)==T ~ Sys.Date()+years(125),
                                                        TRUE~ lubridate::as_date(variable_validation_max,format="%Y-%m-%d %H:%M:%S"))) %>%
      dplyr::group_by(variable_name) %>%
      # simulate factor levels
      dplyr::mutate(value = purrr::map(variable_name,
                                       function(x){
                                         range = variable_validation_min:variable_validation_max

                                         sample(range,nrecords, replace=TRUE,

                                                prob = if(sampledist =="equal"){NULL}else{
                                                  case_when(sampledist=="normal" ~ c(sort(rtnorm(n=floor(length(range)/2))),
                                                                                     rev(sort(rtnorm(n=ceiling(length(range)/2))))),

                                                            sampledist=="lskew" ~ rev(sort(rtnorm(n=length(range))^5)),

                                                            sampledist=="rskew" ~ sort(rtnorm(n=length(range))^5))})}),
                    value = purrr::map(value, function(x){as_datetime(paste0(as_date(x)," ",
                                                                             sample(0:23, nrecords,replace=TRUE),":",sample(0:59, nrecords,replace=TRUE),":",
                                                                             sample(0:59, nrecords,replace=TRUE)),format="%Y-%m-%d %H:%M:%S")}),
                    value = purrr::map(value, function(x){case_when(1:nrecords %in% sample(1:nrecords, nrecords*propmiss, replace=F) ~ NA_Date_, TRUE ~ x)}))

    output <- bind_rows(metadata_character %>% select(variable_name, value),
                        metadata_factor %>% select(variable_name, value),
                        metadata_numeric %>% select(variable_name, value),
                        metadata_date %>% select(variable_name, value),
                        metadata_datetime_hm %>% select(variable_name, value),
                        metadata_datetime_hms %>% select(variable_name, value)) %>%
      pivot_wider(names_from = "variable_name", values_from = "value") %>%
      tidyr::unnest(everything()) %>%
      select(any_of(metadata$variable_name))

    return(output)}

  df <- metadata %>%
    filter(form_repeat=="No") %>%
    simulation(nrecords=nrecords, propmiss = propmiss, sampledist = sampledist) %>%
    mutate(record_id= paste0("SIM-", 1:n())) %>%
    select(any_of(c("record_id", "redcap_data_access_group")), everything())
View(df)
  # Incorporate repeating instruments if present
  if(nrow(metadata %>% filter(form_repeat=="Yes"))>0){
    # simulate repeating instrument data
    rpt <- metadata %>%
      filter(form_repeat=="Yes") %>%
      simulation(nrecords=nrow(df)*10, propmiss = propmiss, sampledist = sampledist) %>%
      mutate(record_id = sample(df$record_id, 10*nrow(df), replace=T),
             redcap_repeat_instrument = sample(metadata %>% filter(form_repeat=="Yes") %>% pull(form_name) %>% unique(),
                                               10*nrow(df), replace=T))  %>%
      group_by(record_id, redcap_repeat_instrument) %>%
      dplyr::mutate(redcap_repeat_instance = 1:n()) %>%
      dplyr::arrange(record_id, redcap_repeat_instrument, redcap_repeat_instance)

    # combine with baseline data
    df <- left_join(df, rpt, by = "record_id") %>%
      select(record_id, redcap_repeat_instrument, redcap_repeat_instance, everything())


    # ensure that repeating data not duplicated across forms (only appears for specific form)
    repeatingformvars <- metadata %>%
      filter(form_repeat=="Yes") %>%
      group_by(form_name)  %>%
      summarise(variable_name = list(variable_name))

    df <- reduce(.init = df,
                   1:nrow(repeatingformvars),
                   function(df, i) {

                     vars_to_null <- repeatingformvars %>%
                       filter(form_name != repeatingformvars$form_name[i]) %>%
                       unnest(variable_name) %>%
                       pull(variable_name)

                     df %>%
                       mutate(across(all_of(vars_to_null),
                                     function(x){ifelse(redcap_repeat_instrument == repeatingformvars$form_name[i], NA,x)}))})}


  # account for branching logic if present
  # Format branching logic
  df_branch <- metadata %>%
    dplyr::select(variable_name, variable_label, variable_type, branch_logic) %>%
    dplyr::mutate(branch_logic = iconv(tolower(branch_logic), to ="ASCII//TRANSLIT")) %>%
    filter(is.na(branch_logic)==F) %>%
    # clean branching logic
    dplyr::mutate(branch_logic = str_trim(branch_logic) %>% str_squish() %>% str_replace_all("\n", " "),
                  branch_logic = str_replace_all(branch_logic, "\\[|\\]", ""),
                  branch_logic = str_replace_all(branch_logic, "=", "=="),
                  branch_logic = str_replace_all(branch_logic, "<>", "!="),
                  branch_logic = str_replace_all(branch_logic, "!==", "!="),
                  branch_logic = str_replace_all(branch_logic, ">==", ">="),
                  branch_logic = str_replace_all(branch_logic, "> ==", ">="),
                  branch_logic = str_replace_all(branch_logic, "<==", "<="),
                  branch_logic = str_replace_all(branch_logic, " or ", "| "),
                  branch_logic = str_replace_all(branch_logic, " and ", " & "),
                  branch_logic = str_replace_all(branch_logic, "$ ", "$"))

  if(nrow(df_branch)>0){
    df <- reduce(.init = df,
                   1:nrow(df_branch),
                   function(df, i) {

                     df %>%
                       mutate(across(df_branch$variable_name[i], function(x){case_when(!!rlang::parse_expr(df_branch$branch_logic[i]) ~ x, TRUE ~ NA)}))})}


  # Label factors following implementing branching logic
  df_factor <- metadata %>%filter(class=="factor")
  if(nrow(df_factor)>0){

    df <- reduce(.init = df,
                   1:nrow(df_factor),
                   function(df, i) {

                     df %>%
                       mutate(across(df_factor$variable_name[i],
                                     function(x){factor(x,
                                                        levels = unlist(df_factor$factor_level[i]),
                                                        labels = unlist(df_factor$factor_label[i]))}))})}

  return(df)}

