# orcid_name--------------------------------
# Documentation
#' Pull first name(s) and last name for a given list of orcid
#' @description Pull and format first name(s) and last name for a given list of orcid
#' @param list_orcid List of orcid ids (XXXX-XXXX-XXXX-XXXX format)
#' @param initial Should the first / middle name(s) be converted to initial (default = TRUE)
#' @param position initial to "left" or "right" of last name (default = "right")
#' @param initial_max Maximum number of digits (default = 3)
#' @param reason Logical value to determine whether output should include reasons for NA values (default = FALSE) or vector of ORCID (TRUE).
#' @param na.rm Remove NA (invalid ORCID) from output (default = TRUE)
#' @return Dataframe with 5 mandatory columns: orcid, full name, first names, initials, and last name.
#' @import dplyr
#' @import tidyr
#' @import tibble
#' @import xml2
#' @importFrom purrr map_df
#' @importFrom stringr str_sub
#' @export

orcid_name <- function(list_orcid, initial = TRUE, initial_max = 3, position = "right", reason = FALSE, na.rm = TRUE){
  require(dplyr);require(purrr);require(xml2);require(dplyr);require(tibble);require(tidyr);require(stringr)

  valid <- orcid_valid(list_orcid, reason = reason, na.rm = na.rm)

  if(tibble::is_tibble(valid)){input_orcid <- dplyr::pull(valid, orcid)}else{input_orcid <- valid}

  output <- purrr::map_df(na.omit(input_orcid) %>% as.character(), function(x){
    # Extract from ORCID API
    eval <- tryCatch(xml2::read_xml(paste0("https://pub.orcid.org/v2.1/", x, "/personal-details")),error = function(e){NA})

    # Return empty tibble or xml output if ORCID valid
    if(is.na(eval)==T){tibble::tibble("orcid" = x, check_access = "No", "first_name" = NA, "last_name" = NA)}else{
      eval <- suppressWarnings(eval %>%
                                 xml2::xml_find_all("personal-details:name") %>%
                                 xml2::xml_find_all("personal-details:given-names|personal-details:family-name") %$%
                                 tibble::tibble("name" = xml2::xml_name(.), "value" = xml2::as_list(.) %>% unlist()) %>%
                                 dplyr::right_join(tibble::tibble("name" = c("given-names", "family-name")), by="name") %>%
                                 tidyr::pivot_wider(names_from = "name", values_from = "value") %>%
                                 dplyr::mutate(orcid = x,
                                               check_access = "Yes") %>%
                                 dplyr::select(orcid,check_access, "first_name" = `given-names`, "last_name" = `family-name`))}})

  if(tibble::is_tibble(valid)==F){valid <- tibble::enframe(valid, name = NULL, value = "orcid")}

  if(na.rm == F & reason == T){
  output <- tibble::enframe(list_orcid, name = NULL, value = "orcid") %>%
    dplyr::left_join(output, by = "orcid") %>%
    dplyr::left_join(dplyr::select(valid, -orcid), by = c("orcid" = "orcid_original")) %>%
    dplyr::select(orcid, ends_with("_name"), starts_with("check_"))}

  if(na.rm == F & reason == F){
    output <- tibble::enframe(list_orcid, name = NULL, value = "orcid") %>%
      dplyr::left_join(output, by = "orcid") %>%
      dplyr::select(orcid, ends_with("_name"))}

  if(na.rm == T){
    output <- output %>%
      dplyr::left_join(valid, by = c("orcid")) %>%
      dplyr::select(orcid, ends_with("_name"), starts_with("check_"))}

  name2initial <- function(x){
    out <- suppressWarnings(tibble::enframe(x) %>%
                       tidyr::separate(value, " ", into = paste0("i_", rep(1:initial_max))) %>%
                       dplyr::mutate_at(vars(starts_with("i_")), function(x){stringr::str_sub(x, 1,1) %>% toupper()}) %>%
                       tidyr::unite(starts_with("i_"), col = "initial", sep = " ", na.rm= T) %>% dplyr::pull(initial))
    return(out)}

  output <- output %>%
    dplyr::mutate(check_name = ifelse(is.na(first_name)==T|is.na(last_name)==T, "No", "Yes")) %>%
    dplyr::mutate(initial = ifelse(check_name=="Yes", name2initial(first_name), NA))

  if(initial==T&position == "right"){output <- output %>% dplyr::mutate(full_name = ifelse(check_name=="Yes", paste0(last_name, " ", initial), NA))}
  if(initial==F&position == "right"){output <- output %>% dplyr::mutate(full_name = ifelse(check_name=="Yes", paste0(last_name, " ", first_name), NA))}
  if(initial==T&position == "left"){output <- output %>% dplyr::mutate(full_name = ifelse(check_name=="Yes", paste0(initial, " ", last_name), NA))}
  if(initial==F&position == "left"){output <- output %>% dplyr::mutate(full_name = ifelse(check_name=="Yes", paste0(first_name, " ", last_name), NA))}

  if(reason==F){final <- output %>% dplyr::select(orcid, full_name, first_name, initial, last_name)}else{
  final <- output %>% dplyr::select(orcid, full_name, first_name, initial, last_name, starts_with("check_"))}

  if(na.rm==T){final <- final %>% dplyr::filter(is.na(full_name)==F)}

  return(final)}
