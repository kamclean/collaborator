# report_miss---------------------------------------
# Documentation
#' Generate a missing data report for a REDCap project.
#' @description Used to generate a report of record-level + redcap_data_access_group-level missing data within a REDCap project (which accounts for branching logic in the dataframe).
#' @param redcap_project_uri URI (Uniform Resource Identifier) for the REDCap instance.
#' @param redcap_project_token API (Application Programming Interface) for the REDCap project.
#' @param missing_threshold The overall proportion of missing data that is acceptable (default = 0.05).
#' @param var_include Vector of names of variables that are desired to be specifically used to assess data completness (alternate method from using "var_exclude").
#' @param var_exclude Vector of names of variables that are desired to be excluded from assessment of data completness (any NA value will be counted as incomplete).
#' @param record_include Vector of redcap record_id that are desired to be included in the record count.
#' @param record_exclude Vector of redcap record_id that are desired to be excluded from the record count.
#' @param dag_include Vector of redcap data access group names that are desired to be included in the record count.
#' @param dag_exclude Vector of redcap data access group names that are desired to be excluded from the record count.
#' @param record_id String of variable name which fufills the record_id role (default = "record_id")
#' @import dplyr
#' @import tibble
#' @importFrom stringr str_split_fixed
#' @importFrom stringi stri_replace_all_fixed
#' @importFrom scales percent
#' @importFrom httr POST content
#' @importFrom readr read_csv
#' @importFrom tidyr separate_rows
#' @importFrom tidyselect all_of
#' @return Nested dataframe with a summary of missing data at the redcap_data_access_group level and the record level.
#' @export

# Function:
report_miss <- function(redcap_project_uri, redcap_project_token, missing_threshold = 0.05,
                        var_include = NULL, var_exclude = NULL, record_exclude = NULL, record_include = NULL,
                        dag_include = NULL, dag_exclude = NULL, record_id = "record_id"){
  # Prepare dataset----------------
  # Load functions / packages

  df_record <-  httr::POST(url = redcap_project_uri,
                           body = list("token"=redcap_project_token,
                                       content='record',
                                       action='export',
                                       format='csv',
                                       type='flat',
                                       csvDelimiter='',
                                       rawOrLabel='raw',
                                       rawOrLabelHeaders='raw',
                                       exportCheckboxLabel='false',
                                       exportSurveyFields='false',
                                       exportDataAccessGroups='true',
                                       returnFormat='json'),
                           encode = "form") %>%
    httr::content(type = "text/csv",show_col_types = FALSE,
                  guess_max = 100000, encoding = "UTF-8") %>%
    dplyr::select(-contains("_complete"))

  # Data dictionary set-up---------------------
  # Convert data dictionary branching to R format

  df_metadata <- collaborator::redcap_metadata(redcap_project_uri = redcap_project_uri,
                                               redcap_project_token = redcap_project_token)

  # Format branching logic
  df_meta <- df_metadata %>%
    dplyr::select(variable_name, variable_label, variable_type, branch_logic) %>%
    dplyr::mutate(branch_logic = iconv(tolower(as.character(branch_logic)), to ="ASCII//TRANSLIT")) %>%

    # clean branching logic
    dplyr::mutate(branch_logic = gsub("\n", " ", branch_logic)) %>%
    dplyr::mutate(branch_logic = gsub("   ", " ", branch_logic)) %>%
    dplyr::mutate(branch_logic = gsub("  ", " ", branch_logic)) %>%
    dplyr::mutate(branch_logic = gsub("\\[|\\]", "", branch_logic)) %>%
    dplyr::mutate(branch_logic = gsub("=", "==", branch_logic)) %>%
    dplyr::mutate(branch_logic = gsub("<>", "!=", branch_logic)) %>%
    dplyr::mutate(branch_logic = gsub("!==", "!=", branch_logic)) %>%
    dplyr::mutate(branch_logic = gsub(">==", ">=", branch_logic)) %>%
    dplyr::mutate(branch_logic = gsub("> ==", ">=", branch_logic)) %>%
    dplyr::mutate(branch_logic = gsub("<==", "<=", branch_logic)) %>%
    dplyr::mutate(branch_logic = gsub(" or ", "| df_record$", branch_logic)) %>%
    dplyr::mutate(branch_logic = gsub(" and ", " & df_record$", branch_logic)) %>%
    dplyr::mutate(branch_logic = gsub("$ ", "$", branch_logic)) %>%
    dplyr::mutate(branch_logic = ifelse(is.na(branch_logic)==F, paste0("df_record$", branch_logic), NA)) %>%

    dplyr::mutate(branch_logic = stringi::stri_replace_all_fixed(branch_logic, "df_record$(((", "(((df_record$")) %>%
    dplyr::mutate(branch_logic = stringi::stri_replace_all_fixed(branch_logic, "df_record$((", "((df_record$")) %>%
    dplyr::mutate(branch_logic = stringi::stri_replace_all_fixed(branch_logic, "df_record$(", "(df_record$"))

  # Clean final data dictionary
  df_meta <- df_meta %>%
    dplyr::bind_rows(dplyr::bind_cols("variable_name" = "redcap_data_access_group",
                                      "variable_label" = "REDCap Data Access Group",
                                      "variable_type" = NA,
                                      "branch_logic" = NA)) %>%
    dplyr::mutate(variable_name = factor(variable_name, levels = colnames(df_record))) %>% # only variables in the dataset
    dplyr::filter(is.na(variable_name)==F) %>%
    dplyr::arrange(variable_name) %>% dplyr::mutate(variable_name = as.character(variable_name)) %>%
    dplyr::select(variable_name, branch_logic)


  # Identify if repeating forms present / which variables
  if(("redcap_repeat_instrument" %in% names(df_record))==F){
    df_metadata <- df_metadata %>% dplyr::mutate(form_repeat = "No")}

  if(("redcap_repeat_instrument" %in% names(df_record))==T){

    form_repeat <- df_record %>%
      filter(is.na(redcap_repeat_instrument)==F) %>%
      pull(redcap_repeat_instrument) %>% unique()

    df_metadata <- df_metadata %>%
      dplyr::mutate(form_repeat = ifelse(form_name %in% form_repeat, "Yes", "No"))

    record_repeat <- df_record %>%
      filter(is.na(redcap_repeat_instrument)==F) %>%
      pull(record_id) %>% unique()

    var_repeat <- df_metadata %>%
      filter(form_repeat=="Yes") %>%
      dplyr::pull(variable_name)

    var_norepeat <- df_metadata %>%
      filter(form_repeat=="No") %>%
      dplyr::pull(variable_name)

    df_record <- df_record %>%
      dplyr::mutate(redcap_repeat_instrument= factor(redcap_repeat_instrument, levels=sort(unique(redcap_repeat_instrument))),
                    redcap_repeat_instance = as.numeric(redcap_repeat_instance),
                    redcap_repeat_instance = ifelse(is.na(redcap_repeat_instance)==T, 0, redcap_repeat_instance)) %>%
      group_by(record_id, redcap_data_access_group,redcap_repeat_instance) %>%
      tidyr::fill(all_of(var_repeat), .direction = "updown") %>%
      group_by(record_id, redcap_data_access_group) %>%
      tidyr::fill(all_of(var_norepeat), .direction = "down") %>%
      dplyr::ungroup() %>%
      dplyr::select(-redcap_repeat_instrument) %>%
      dplyr::mutate(redcap_repeat_instance = ifelse(record_id %in% record_repeat, redcap_repeat_instance, 1)) %>%
      filter(redcap_repeat_instance!=0) %>%
      dplyr::distinct() %>%
      dplyr::arrange(record_id, redcap_data_access_group,redcap_repeat_instance)}


  # Determine missing data-------------------------------
  # 1. Determine branching variables
  redcap_dd_branch <- df_meta %>% dplyr::filter(is.na(branch_logic)==F)
  redcap_dd_nobranch <- df_meta %>%
    dplyr::filter(is.na(branch_logic)==T) %>%
    dplyr::filter(! variable_name %in% c("record_id", "redcap_data_access_group")) %>%
    dplyr::pull(variable_name)

  # 2. Convert branching to present ("."), missing ("M") or appropriately missing ("NA") based on branching logic
  if(nrow(redcap_dd_branch)>0){

    df_record_clean <- df_record %>%
      dplyr::mutate_all(function(x){as.character(x)})

    for(i in 1:nrow(redcap_dd_branch)) {

      df_record_clean <- df_record_clean %>%
        # evaluate branching logic within dataset
        dplyr::mutate(logic_fufilled = parse(text=eval(redcap_dd_branch$branch_logic[[i]])) %>% eval(),

                      # add in original data
                      variable_data = dplyr::pull(., redcap_dd_branch$variable_name[[i]])) %>%

        # if the branching logic has not been fufilled (value==F or NA) then NA
        dplyr::mutate(variable_out = ifelse(is.na(logic_fufilled)==T|logic_fufilled==F, NA,

                                            # if logic_fufilled == T, and the data is NA then "Missing"
                                            ifelse(is.na(variable_data), "M", "."))) %>%
        dplyr::select(-all_of(redcap_dd_branch$variable_name[[i]])) %>%
        dplyr::rename_at(vars(matches("variable_out")), function(x){redcap_dd_branch$variable_name[[i]]})}}


  # 3. Convert non-branching to present (".") or missing ("M") based on NA status
  df_record_clean <- df_record_clean %>%
    dplyr::mutate(across(everything(), as.character)) %>%
    dplyr::mutate(across(tidyselect::all_of(redcap_dd_nobranch), function(x){ifelse(is.na(x)==T, "M", ".")})) %>%
    dplyr::select(-logic_fufilled, -variable_data)

  # 4. Re-combine checkbox variables
  xbox_names <- df_metadata %>%
    dplyr::filter(variable_type=="checkbox") %>%
    dplyr::mutate(variable_name_original = stringr::str_split_fixed(variable_name, "___", 2)[,1]) %>%
    dplyr::select(variable_name_original, variable_name) %>%
    dplyr::group_by(variable_name_original) %>%
    dplyr::summarise(variable_name = list(variable_name))

  for(i in 1:nrow(xbox_names)){
    df_record_clean <- df_record_clean %>%
      tidyr::unite(col = !!eval(unique(xbox_names$variable_name_original[i])),
                   tidyselect::all_of(c(xbox_names$variable_name[[i]])), na.rm = T, remove = T)}

  df_record_clean <- df_record_clean %>%
    dplyr::mutate_at(vars(all_of(xbox_names$variable_name_original)), function(x){ifelse(x=="", NA, ".")})

  # Clean dataset
  if(is.null(var_exclude)==F){df_record_clean <- df_record_clean %>% dplyr::select(-tidyselect::any_of(var_exclude))}
  if(is.null(var_include)==F){df_record_clean <- df_record_clean %>% dplyr::select(record_id, redcap_data_access_group, tidyselect::any_of(var_include))}

  if(is.null(dag_exclude)==F){df_record_clean <- df_record_clean %>% dplyr::filter(! redcap_data_access_group %in% dag_exclude)}
  if(is.null(dag_include)==F){df_record_clean <- df_record_clean %>% dplyr::filter(redcap_data_access_group %in% dag_include)}

  if(is.null(record_exclude)==F){df_record_clean <- df_record_clean %>% dplyr::filter(! record_id %in% record_exclude)}
  if(is.null(record_include)==F){df_record_clean <- df_record_clean %>% dplyr::filter(record_id %in% record_include)}

  # Create missing data reports---------------------------
  xbox_remove <- df_metadata %>%
    dplyr::filter(variable_type == "checkbox") %>%
    dplyr::filter(stringr::str_split_fixed(variable_name, "___", 2)[,2]!="1") %>%
    dplyr::pull(variable_name)

  # Patient-level
  if(("redcap_repeat_instance" %in% names(df_record_clean))==F){
  data_missing_pt <- df_record_clean %>%
    dplyr::rename("record_id" = eval(record_id)) %>%
    # remove checkbox variables (will always be the same value) except the first and rename
    dplyr::select(-any_of(xbox_remove)) %>%
    dplyr::rename_all(function(x){stringr::str_remove(x, "___1")}) %>%
    dplyr::mutate(miss_n = rowSums(dplyr::select(., -dplyr::one_of("record_id", "redcap_data_access_group"))=="M", na.rm=T),
                  fields_n = rowSums(is.na(dplyr::select(., -dplyr::one_of("record_id", "redcap_data_access_group")))==F)) %>%
    dplyr::mutate(miss_prop = miss_n/fields_n) %>%
    dplyr::mutate(miss_pct = scales::percent(miss_prop),
                  miss_threshold = factor(ifelse(miss_prop>missing_threshold, "Yes", "No"))) %>%
    dplyr::select(record_id, redcap_data_access_group, miss_n:miss_threshold, everything())}


  if(("redcap_repeat_instance" %in% names(df_record_clean))==T){
    data_missing_pt <- df_record_clean %>%
      dplyr::rename("record_id" = eval(record_id)) %>%
      # remove checkbox variables (will always be the same value) except the first and rename
      dplyr::select(-any_of(xbox_remove)) %>%
      dplyr::rename_all(function(x){stringr::str_remove(x, "___1")}) %>%
      dplyr::relocate(redcap_repeat_instance, var_repeat, .after = last_col()) %>%
      redcap_format_repeat(format = "wide") %>%
      dplyr::mutate(miss_n = rowSums(dplyr::select(., -dplyr::one_of("record_id", "redcap_data_access_group"))=="M", na.rm=T),
                    fields_n = rowSums(is.na(dplyr::select(., -dplyr::one_of("record_id", "redcap_data_access_group")))==F)) %>%
      dplyr::mutate(miss_prop = miss_n/fields_n) %>%
      dplyr::mutate(miss_pct = scales::percent(miss_prop),
                    miss_threshold = factor(ifelse(miss_prop>missing_threshold, "Yes", "No"))) %>%
      dplyr::select(record_id, redcap_data_access_group, miss_n:miss_threshold, everything())}

  # Centre-level
  data_missing_cen <- data_missing_pt %>%
    dplyr::select(redcap_data_access_group, miss_n, fields_n, miss_threshold) %>%

    dplyr::group_by(redcap_data_access_group) %>%

    dplyr::summarise(n_pt = n(),
                     n_threshold = sum(miss_threshold=="Yes"),
                     cen_miss_n = sum(miss_n),
                     cen_field_n = sum(fields_n)) %>%

    dplyr::mutate(cen_miss_prop = cen_miss_n/cen_field_n) %>%

    dplyr::mutate(cen_miss_pct = scales::percent(cen_miss_prop))

  # Create output
  data_missing <- list("group" = data_missing_cen,"record" = data_missing_pt)

  return(data_missing)}
