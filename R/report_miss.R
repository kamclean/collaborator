# report_miss---------------------------------------
# Use: Generate a report of patient-level + centre-level missing data.
# df_project = (must be in RAW format e.g. factors as numbers)
# df_datdic = The data dictionary as directly exported from REDCap
# var_exclude = all variables to be excluded from missing data analysis.

report_miss <- function(df_project, df_datdic, var_exclude){
  # Prepare dataset----------------
  # Load functions / packages
  "%ni%" <- Negate("%in%")
  require("dplyr")
  require("stringr")
  require("stringi")
  require("tibble")

  # Exclude columns from project dataframe
  var_form_complete <- colnames(df_project)[grepl("_complete", colnames(df_project), fixed=TRUE)]

  df_project <- df_project %>%
    select(colnames(.)[colnames(df_project) %ni% c(var_exclude, var_form_complete)])


  # Data dictionary set-up---------------------
  # Convert data dictionary branching to R format
  df_datdic <- df_datdic %>%
    select(variable = "Variable / Field Name", branch_logic = "Branching Logic (Show field only if...)",
           field_type = "Field Type", field_values = "Choices, Calculations, OR Slider Labels")%>%
    filter(variable!="record_id") %>%
    filter(field_type %ni% c("descriptive", "notes")) %>%
    mutate(branch_logic = gsub("\\[|\\]", "", branch_logic)) %>%
    mutate(branch_logic = gsub("=", "==", branch_logic)) %>%
    mutate(branch_logic = gsub("<>", "!=", branch_logic)) %>%
    mutate(branch_logic = gsub(" or ", "| df_project$", branch_logic)) %>%
    mutate(branch_logic = gsub(" and ", " & df_project$", branch_logic)) %>%
    mutate(branch_logic = gsub(" AND ", " & df_project$", branch_logic)) %>%
    mutate(branch_logic = ifelse(is.na(branch_logic)==F, paste0("df_project$", branch_logic), NA)) %>%
    mutate(branch_logic = stri_replace_all_fixed(branch_logic, "(", "___")) %>% # checkbox variables
    mutate(branch_logic = stri_replace_all_fixed(branch_logic, ")", ""))

  # Add in checkbox variables if present
  if("checkbox" %in% df_datdic$field_type){
    df_datdic %>%
      select(variable, branch_logic, field_type,field_values) %>%
      filter(field_type =="checkbox") %>%
      mutate(nvalues = str_count(field_values, "\\|")+1) -> var_checkbox

    var_checkbox %$%
      rep(variable, nvalues) %>%
      as.tibble() %>%
      group_by(value) %>%
      mutate(n_check = row_number()) %>%
      mutate(variable_old = as.character(value)) %>%
      mutate(variable = paste0(value, "___", n_check)) %>%
      ungroup() %>%
      merge.data.frame(., var_checkbox, by.x = "value", by.y = "variable") %>%
      select(variable_old, variable, branch_logic,field_type, field_values) -> var_checkbox

    df_datdic <- df_datdic %>%
      filter(variable %ni% var_checkbox$variable_old) %>% # remove original checkbox variables
      rbind.data.frame(., var_checkbox[,-which(colnames(var_checkbox)=="variable_old")]) # add in new checkbox variables
  }

  # Clean final data dictionary
  df_datdic <- df_datdic %>%
    filter(variable %ni% c(var_exclude, var_form_complete)) %>% # remove all variables that have been removed in the dataframe
    filter(variable %in% colnames(df_project)) %>% # only variables in the dataset
    select(variable, branch_logic)

  # Determine missing data-------------------------------
  # 1. Branching variables
  # A. Select branching variables
  df_datdic %>%
    filter(is.na(branch_logic)==F) -> redcap_dd_branch

  # B. Convert to present (""), missing ("M") or appropriately missing ("NA") based on branching logic
  for(i in 1:nrow(redcap_dd_branch)) {
    x <- ifelse(eval(parse(text=eval(redcap_dd_branch$branch_logic[[i]])))==F, NA, # if the if the branching logic has not been fufilled then NA
                ifelse(is.na(eval(parse(text=paste0("df_project$", eval(redcap_dd_branch$variable[[i]])))))& # if the question hasn't been answered
                         eval(parse(text=eval(redcap_dd_branch$branch_logic[[i]]))), # and if the branching logic is fufilled or
                       "M", ""))
    df_project[eval(redcap_dd_branch$variable[[i]])] <- x}

  # 2. Non-branching variables
  # A. Select non-branching variables
  df_datdic %>%
    filter(is.na(branch_logic)==T) -> redcap_dd_nobranch

  # B. Replace with  present ("") or missing ("M") based on NA status
  df_project %>%
    mutate_at(colnames(df_project)[colnames(df_project) %in% redcap_dd_nobranch$variable],
              funs(replace(., is.na(.)==F, ""))) %>%
    mutate_at(colnames(df_project)[colnames(df_project) %in% redcap_dd_nobranch$variable],
              funs(replace(., is.na(.)==T, "M"))) -> data_missing_pt

  # Create missing data reports---------------------------
  # Patient-level
  data_missing_pt %>%
    mutate(miss_n = rowSums(.=="M", na.rm=T),
           fields_n = rowSums(is.na(.))) %>%
    mutate(miss_prop = miss_n/fields_n) %>%
    mutate(miss_pct = paste0(format(round(miss_prop*100, 1), nsmall=1),"%"),
           miss_95 = ifelse((1-miss_prop)<0.95, "Yes", "No")) %>%
    select(record_id, redcap_data_access_group, miss_n:miss_95, everything()) -> data_missing_pt

  # Centre-level
  data_missing_pt %>%
    select(redcap_data_access_group, miss_n, fields_n, miss_95) %>%
    as.tibble() %>%
    group_by(redcap_data_access_group) %>%
    dplyr::summarise(n_pt = n(), n_pt95 = sum(miss_95=="Yes"),
                     cen_miss_n = sum(miss_n), cen_field_n = sum(fields_n)) %>%
    mutate(cen_miss_prop = cen_miss_n/cen_field_n) %>%
    mutate(cen_miss_pct = paste0(format(round(cen_miss_prop*100, 1), nsmall=1),"%")) -> data_missing_cen

  # Create output
  data_missing <- list("data_missing_cen" = data_missing_cen,"data_missing_pt" = data_missing_pt)

  return(data_missing)}
