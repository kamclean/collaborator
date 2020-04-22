# report_miss---------------------------------------
# Documentation
#' Generate a missing data report for a REDCap project.
#' @description Used to generate a report of record-level + redcap_data_access_group-level missing data within a REDCap project (which accounts for branching logic in the dataframe).
#' @param redcap_project_uri URI (Uniform Resource Identifier) for the REDCap instance.
#' @param redcap_project_token API (Application Programming Interface) for the REDCap project.
#' @param var_include Vector of names of variables that are desired to be specifically used to assess data completness (alternate method from using "var_exclude").
#' @param var_exclude Vector of names of variables that are desired to be excluded from assessment of data completness (any NA value will be counted as incomplete).
#' @param record_include Vector of redcap record_id that are desired to be included in the record count.
#' @param record_exclude Vector of redcap record_id that are desired to be excluded from the record count.
#' @param dag_include Vector of redcap data access group names that are desired to be included in the record count.
#' @param dag_exclude Vector of redcap data access group names that are desired to be excluded from the record count.
#' @param use_ssl Logical value whether verify the peer's SSL certificate should be evaluated (default=TRUE)
#' @import dplyr
#' @import tibble
#' @importFrom stringr str_split_fixed
#' @importFrom stringi stri_replace_all_fixed
#' @importFrom scales percent
#' @importFrom RCurl postForm curlOptions
#' @importFrom readr read_csv
#' @importFrom tidyr separate_rows
#' @importFrom tidyselect all_of
#' @return Nested dataframe with a summary of missing data at the redcap_data_access_group level and the record level.
#' @export

# Function:
report_miss <- function(redcap_project_uri, redcap_project_token, use_ssl = TRUE, missing_threshold = 0.05,
                        var_include = NULL, var_exclude = NULL, record_exclude = NULL, record_include = NULL,
                        dag_include = NULL, dag_exclude = NULL){
  # Prepare dataset----------------
  # Load functions / packages
  require(dplyr);require(tibble);require(stringr); require(stringi);require(scales);
  require(RCurl);require(readr);require(tidyr);require(tidyselect)

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


  # Data dictionary set-up---------------------
  # Convert data dictionary branching to R format

  df_meta <- redcap_metadata(redcap_project_uri = redcap_project_uri,
                             redcap_project_token = redcap_project_token,
                             use_ssl = use_ssl) %>%
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
    dplyr::arrange(variable_name) %>% dplyr::mutate(variable_name = as.character(variable_name)) %>%
    dplyr::select(variable_name, branch_logic)

  # Determine missing data-------------------------------
  # 1. Determine branching variables
  redcap_dd_branch <- df_meta %>% dplyr::filter(is.na(branch_logic)==F)
  redcap_dd_nobranch <- df_meta %>%
    dplyr::filter(is.na(branch_logic)==T) %>%
    dplyr::filter(! variable_name %in% c("record_id", "redcap_data_access_group")) %>%
    dplyr::pull(variable_name)

  # 2. Convert branching to present ("."), missing ("M") or appropriately missing ("NA") based on branching logic
  if(nrow(redcap_dd_branch)>0){

    for(i in 1:nrow(redcap_dd_branch)) {

      # evaluate branching logic within dataset
      output <- parse(text=eval(redcap_dd_branch$branch_logic[[i]])) %>%
        eval() %>% tibble::enframe(name = NULL, value = "logic_fufilled") %>%

        # add in original data
        dplyr::mutate(variable_data = dplyr::pull(df_record, redcap_dd_branch$variable_name[[i]])) %>%

        # if the branching logic has not been fufilled (value==F or NA) then NA
        dplyr::mutate(variable_out = ifelse(is.na(logic_fufilled)==T|logic_fufilled==F, NA,

                                            # if logic_fufilled == T, and the data is NA then "Missing"
                                            ifelse(is.na(variable_data)==T, "M", "."))) %>%
        dplyr::pull(variable_out)

      df_record[eval(redcap_dd_branch$variable_name[[i]])] <- output}}

  # 3. Convert non-branching to present (".") or missing ("M") based on NA status
  df_record <- df_record %>%
    dplyr::mutate_all(as.character) %>%
    dplyr::mutate_at(tidyselect::all_of(redcap_dd_nobranch), function(x){ifelse(is.na(x)==T, "M", ".")})

  # Clean dataset
  if(is.null(var_exclude==F)){df_record <- df_record %>% dplyr::select(-one_of(var_exclude))}
  if(is.null(var_include==F)){df_record <- df_record %>% dplyr::select(record_id, redcap_data_access_group,
                                                                                   tidyselect::all_of(var_include))}

  if(is.null(dag_exclude==F)){df_record <- df_record %>% dplyr::filter(! redcap_data_access_group %in% dag_exclude)}
  if(is.null(dag_include==F)){df_record <- df_record %>% dplyr::filter(redcap_data_access_group %in% dag_include)}

  if(is.null(record_exclude==F)){df_record <- df_record %>% dplyr::filter(! record_id %in% record_exclude)}
  if(is.null(record_include==F)){df_record <- df_record %>% dplyr::filter(record_id %in% record_include)}


  # Create missing data reports---------------------------
  # Patient-level
  data_missing_pt <- df_record %>%
    dplyr::mutate(miss_n = rowSums(dplyr::select(., -dplyr::one_of("record_id", "redcap_data_access_group"))=="M", na.rm=T),
                  fields_n = rowSums(is.na(dplyr::select(., -dplyr::one_of("record_id", "redcap_data_access_group")))==F)) %>%
    dplyr::mutate(miss_prop = miss_n/fields_n) %>%
    dplyr::mutate(miss_pct = scales::percent(miss_prop),
                  miss_threshold = factor(ifelse(miss_prop>missing_threshold, "Yes", "No"))) %>%
    dplyr::select(record_id, redcap_data_access_group, miss_n:miss_threshold, everything())

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
