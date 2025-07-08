# redcap_metadata--------------------------------
# Documentation
#' Export REDCap metadata (with individual checkbox variables if present) and variable class in R.
#' @description Used to generate high quality summary data for REDCap projects at overall, and DAG-specific level.
#' @param redcap_project_uri URI (Uniform Resource Identifier) for the REDCap instance.
#' @param redcap_project_token API (Application Programming Interface) for the REDCap project.
#' @param descriptive Logical value whether to include descriptive fields within the dataset (default = FALSE)
#' @return Tibble of REDCap project metadata (with individual checkbox variables if present) and variable class in R.
#' @import dplyr
#' @importFrom httr POST content
#' @importFrom tidyr separate_rows
#' @importFrom purrr map
#' @importFrom stringr str_split_fixed
#' @importFrom stringi stri_replace_all_fixed
#'
#' @export

redcap_metadata <- function(redcap_project_uri, redcap_project_token, descriptive = FALSE){
  require(dplyr); require(httr); require(tidyr); require(stringr); require(purrr); require(stringi)

  if(descriptive==F){var_descriptive <- NULL}

  df_meta <- httr::POST(url = redcap_project_uri,
                        body = list("token"=redcap_project_token,
                                    content='metadata',
                                    action='export',
                                    format='csv',
                                    type='flat',
                                    returnFormat='json'),
                        encode = "form") %>%
    httr::content(type = "text/csv",show_col_types = FALSE,
                  guess_max = 100000, encoding = "UTF-8") %>%
    dplyr::select(form_name, "matrix_name" = matrix_group_name, "variable_name" = field_name, "variable_type" = field_type,
                  "variable_validation" = text_validation_type_or_show_slider_number,
                  "variable_validation_min" = text_validation_min, "variable_validation_max" = text_validation_max,
                  "branch_logic" = branching_logic, "variable_identifier" = identifier,"variable_required" =required_field,
                  "variable_label" = field_label, select_choices_or_calculations) %>%

    # remove any html coding from text
    dplyr::mutate(variable_label = ifelse(variable_type=="descriptive", variable_label, gsub("<.*?>", "", variable_label))) %>%
    dplyr::mutate(variable_identifier = ifelse(variable_identifier=="y"&is.na(variable_identifier)==F, "Yes", "No"),
                  variable_required = ifelse(variable_required=="y"&is.na(variable_required)==F, "Yes", "No"),
                  n = 1:n(),
                  altrecord_id = case_when(n==1&variable_name!="record_id" ~ variable_name,
                                           TRUE ~ NA),
                  variable_name = case_when(n==1&variable_name!="record_id" ~ "record_id",
                                            TRUE ~ variable_name)) %>%
    dplyr::filter(! variable_type %in% var_descriptive)

  # add in checkbox variables
  if("checkbox" %in% df_meta$variable_type){
    df_meta_xbox <- df_meta %>%
      dplyr::filter(variable_type %in% "checkbox") %>%
      tidyr::separate_rows(select_choices_or_calculations, sep = "\\|", convert = FALSE) %>%
      dplyr::mutate(factor_n = trimws(stringr::str_split_fixed(select_choices_or_calculations, ", ", 2)[,1]),
                    select_choices_or_calculations = stringr::str_split_fixed(trimws(select_choices_or_calculations), ", ", 2)[,2]) %>%
      dplyr::mutate(variable_name_original = variable_name,
                    variable_xbox_original = paste0(variable_name, "(", factor_n, ")"),
                    variable_name = paste0(variable_name, "___", factor_n),
                    variable_label = paste0(variable_label, " {", select_choices_or_calculations, "}"))

    df_meta <- df_meta %>%
      dplyr::mutate(factor_n = NA,
                    variable_name_original = variable_name,
                    variable_xbox_original = NA) %>%
      dplyr::filter(! variable_type %in% "checkbox") %>%
      dplyr::bind_rows(df_meta_xbox) %>%
      dplyr::mutate(variable_name_original = factor(variable_name_original, levels = df_meta$variable_name)) %>%
      # dplyr::arrange(variable_name_original, factor_n) %>% ? Error: `...` is not empty.
      dplyr::select(-variable_name_original, -factor_n,-variable_xbox_original)

    for(i in c(1:nrow(df_meta_xbox))){
      df_meta <- df_meta %>%
        dplyr::mutate(branch_logic = iconv(tolower(as.character(branch_logic)), to ="ASCII//TRANSLIT"),
                      variable_name = iconv(tolower(as.character(variable_name)), to ="ASCII//TRANSLIT")) %>%
        dplyr::mutate(branch_logic = stringi::stri_replace_all_fixed(branch_logic,
                                                                     df_meta_xbox$variable_xbox_original[[i]],
                                                                     df_meta_xbox$variable_name[[i]]))}}



  # Factors
  factor_01 <- NULL
  factor_other <- NULL

  if("checkbox" %in% df_meta$variable_type| "yesno" %in% df_meta$variable_type){
    factor_01 <- df_meta %>%
      dplyr::filter(variable_type %in% c("checkbox", "yesno")) %>%
      dplyr::mutate(factor_level = rep(list(c(0, 1)), nrow(.)),
                    factor_label = rep(list(c("No", "Yes")),nrow(.))) %>%
      dplyr::select(variable_name, factor_level, factor_label)}

  if("radio" %in% df_meta$variable_type| "dropdown" %in% df_meta$variable_type){
    factor_other <- df_meta %>%
      dplyr::filter(variable_type %in% c("radio", "dropdown")) %>%
      tidyr::separate_rows(select_choices_or_calculations, sep = "\\|") %>%
      dplyr::mutate(select_choices_or_calculations = trimws(select_choices_or_calculations)) %>%
      dplyr::mutate(factor_level = stringr::str_split_fixed(select_choices_or_calculations, ", ", 2)[,1],
                    factor_label = stringr::str_split_fixed(select_choices_or_calculations, ", ", 2)[,2]) %>%
      dplyr::group_by(variable_name, factor_label) %>%
      dplyr::mutate(factor_dup =1:n()) %>%
      dplyr::ungroup() %>%
      dplyr::mutate(factor_label = ifelse(factor_dup>1, paste0(factor_label, "_", factor_dup), factor_label)) %>%
      dplyr::group_by(variable_name) %>%
      dplyr::summarise(factor_level = list(factor_level),
                       factor_label = list(factor_label)) %>%
      dplyr::ungroup()}

  factor_all <- dplyr::bind_rows(factor_01, factor_other)

  if(nrow(factor_all)>0){
    df_meta <- df_meta %>%
      dplyr::left_join(factor_all, by = "variable_name") %>%
      dplyr::mutate(class = purrr::map(factor_level, function(x){ifelse(is.null(x)==T, NA, "factor")})) %>%
      dplyr::mutate(class = as.character(class) %>% ifelse(.=="NA", NA, .)) %>%
      dplyr::select(class, everything())}else{df_meta <- df_meta %>%
        dplyr::mutate(class = NA, factor_level = NA, factor_label = NA) %>%
        dplyr::select(class, everything())}

  # Other variable types
  output <- df_meta %>%
    dplyr::mutate(class = ifelse(variable_type %in% c("slider", "calc")|(variable_type=="text" & variable_validation %in% c("number", "integer")),
                                 "numeric", class),
                  class = ifelse(variable_type == "text" & grepl("date_", variable_validation), "date", class),
                  class = ifelse(variable_type == "text" & grepl("datetime_", variable_validation), "datetime", class),
                  class = ifelse(variable_type %in% "truefalse", "logical", class),
                  class = ifelse(variable_type == "file", "file", class),
                  class = ifelse(is.na(class), "character", class)) %>%

    # have sliders have a variable_validation_min and variable_validation_max
    # (not directly exported - have to rely on labels from select_choices_or_calculations)
    mutate(slidersplit =ifelse(variable_type=="slider", str_split(select_choices_or_calculations, " \\| "), NA),
           variable_validation_min = ifelse(is.na(slidersplit)==F, map_chr(slidersplit, function(x){head(x, 1)}), variable_validation_min),
           variable_validation_max = ifelse(is.na(slidersplit)==F, map_chr(slidersplit, function(x){tail(x, 1)}), variable_validation_max)) %>%

    mutate(across(variable_validation_min:variable_validation_max,
                  function(x){case_when(class=="date"&x=="today" ~ as.character(Sys.Date()),
                                        class=="datetime"&x=="today" ~ paste0(Sys.Date(), " 23:59:59"),
                                        TRUE ~ x)}))

  # Get event / arm data
  df_event <- tryCatch(httr::POST(url = redcap_project_uri,
                                  body = list("token"=redcap_project_token,
                                              content='formEventMapping',
                                              action='export',
                                              format='csv',
                                              type='flat',
                                              returnFormat='json'),
                                  encode = "form") %>%
                         httr::content(type = "text/csv",show_col_types = FALSE,
                                       guess_max = 100000, encoding = "UTF-8"), error=function(e) NULL)


  if(nrow(df_event)>0){
    df_event <- df_event %>%
      group_by(form) %>%
      dplyr::summarise_all(function(x){unique(x) %>% list()}) %>%
      dplyr::rename("arm" = arm_num, "redcap_event_name" = unique_event_name, "form_name" = form)

    output <- output %>%
      dplyr::left_join(df_event,by = "form_name") %>%
      dplyr::select(form_name, variable_name, matrix_name, class, everything())}else{output <- output %>% dplyr::mutate(arm = list(NA), redcap_event_name = list(NA))}

  return(output)}
