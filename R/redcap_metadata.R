# redcap_metadata--------------------------------
# Documentation
#' Export REDCap metadata (with individual checkbox variables if present) and variable class in R.
#' @description Used to generate high quality summary data for REDCap projects at overall, and DAG-specific level.
#' @param redcap_project_uri URI (Uniform Resource Identifier) for the REDCap instance.
#' @param redcap_project_token API (Application Programming Interface) for the REDCap project.
#' @param use_ssl Logical value whether to verify the peer's SSL certificate should be evaluated during the API pull (default=TRUE)
#' @return Tibble of REDCap project metadata (with individual checkbox variables if present) and variable class in R.
#' @import dplyr
#' @importFrom RCurl postForm
#' @importFrom readr read_csv
#' @importFrom tidyr separate_rows
#' @importFrom purrr map
#' @importFrom stringr str_split_fixed
#'
#' @export

redcap_metadata <- function(redcap_project_uri, redcap_project_token, use_ssl = TRUE){
  require(dplyr); require(RCurl); require(readr); require(tidyr); require(stringr); require(purrr)

  df_meta <- RCurl::postForm(uri=redcap_project_uri,
                             token = redcap_project_token,
                             content='metadata',
                             .opts = curlOptions(ssl.verifypeer = if(use_ssl==F){FALSE}else{TRUE}),
                             format='csv',
                             raworLabel="raw") %>%
    readr::read_csv() %>%
    dplyr::select(form_name, "matrix_name" = matrix_group_name, "variable_name" = field_name, "variable_type" = field_type,
                  "variable_validation" = text_validation_type_or_show_slider_number,
                  "variable_validation_min" = text_validation_min, "variable_validation_max" = text_validation_max,
                  "branch_logic" = branching_logic, "variable_identifier" = identifier,"variable_required" =required_field,
                  "variable_label" = field_label, select_choices_or_calculations) %>%

    # remove any html coding from text
    dplyr::mutate(variable_label = gsub("<.*?>", "", variable_label)) %>%
    dplyr::filter(! variable_type %in% c("descriptive"))

  # add in checkbox variables
  if("checkbox" %in% df_meta$variable_type){
  df_meta_xbox <- df_meta %>%
    dplyr::filter(variable_type %in% "checkbox") %>%
    tidyr::separate_rows(select_choices_or_calculations, sep = " \\| ", convert = FALSE) %>%
    dplyr::mutate(factor_n = stringr::str_split_fixed(select_choices_or_calculations, ", ", 2)[,1],
                  select_choices_or_calculations = stringr::str_split_fixed(select_choices_or_calculations, ", ", 2)[,2]) %>%
    dplyr::mutate(variable_name_original = variable_name,
                  variable_name = paste0(variable_name, "___", factor_n),
                  variable_label = paste0(variable_label, " {", select_choices_or_calculations, "}"))

  df_meta <- df_meta %>%
    dplyr::mutate(factor_n = NA,
                  variable_name_original = variable_name) %>%
    dplyr::filter(! variable_type %in% "checkbox") %>%
    dplyr::bind_rows(df_meta_xbox) %>%
    dplyr::mutate(variable_name_original = factor(variable_name_original, levels = df_meta$variable_name)) %>%
    dplyr::arrange(variable_name_original, factor_n) %>%
    dplyr::select(-variable_name_original, -factor_n)}

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
    tidyr::separate_rows(select_choices_or_calculations, sep = " \\| ") %>%
    dplyr::mutate(factor_level = stringr::str_split_fixed(select_choices_or_calculations, ", ", 2)[,1],
                  factor_label = stringr::str_split_fixed(select_choices_or_calculations, ", ", 2)[,2]) %>%
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
    dplyr::mutate(class = ifelse(variable_type %in% c("slider", "calc")|(variable_type=="text" & variable_validation %in% "number"),
                                 "numeric", class),
                  class = ifelse(variable_type == "text" & grepl("date_", variable_validation), "date", class),
                  class = ifelse(variable_type == "text" & grepl("datetime_", variable_validation), "datetime", class),
                  class = ifelse(variable_type %in% "truefalse", "logical", class),
                  class = ifelse(variable_type == "file", "file", class),
                  class = ifelse(is.na(class), "character", class))
  return(output)}
