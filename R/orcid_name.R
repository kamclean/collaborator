# orcid_name--------------------------------
# Documentation
#' Pull first name(s) and last name for a given list of orcid
#' @description Pull and format first name(s) and last name for a given list of orcid
#' @param data datafame containing a vector of ORCID (XXXX-XXXX-XXXX-XXXX format)
#' @param orcid Column name of vector containing ORCID (default = "orcid")
#' @param reason Logical value to determine whether output should include reasons for NA values (default = FALSE) or vector of ORCID (TRUE).
#' @param na.rm Remove NA (invalid ORCID) from output (default = TRUE)
#' @return Dataframe with 5 mandatory columns: orcid, full name, first name(s), last name, publication name.
#' @import dplyr
#' @import tidyr
#' @import tibble
#' @import xml2
#' @import stringr
#' @importFrom furrr future_map future_map_dfr
#' @importFrom httr GET content
#' @export

orcid_name <- function(data, orcid = "orcid", reason = FALSE, na.rm = FALSE){
  # Packages / Functions
  require(dplyr);require(furrr);require(httr);require(dplyr);
  require(tibble);require(tidyr);require(stringr);library(magrittr)

  data <- data %>%
    dplyr::mutate(orcid = pull(., orcid)) %>%
    dplyr::select(-starts_with("orcid_check_"),-starts_with("orcid_valid"), -starts_with("orcid_name_")) %>%
    collaborator::orcid_valid(orcid = orcid, reason = T, na.rm = F)

  # Check extract name from valid orcids
  input_orcid <- data %>%
    dplyr::filter(is.na(orcid_valid)==F) %>%
    dplyr::distinct(orcid_valid) %>%
    dplyr::pull(orcid_valid)

  # https://info.orcid.org/documentation/api-tutorials/api-tutorial-searching-the-orcid-registry/
  output <- input_orcid %>%
    furrr::future_map(function(x){
      tryCatch(
        httr::GET(url = paste0("https://pub.orcid.org/v3.0/",
                               x,
                               "/personal-details")) %>%
          httr::content(as = "parsed", encoding = "UTF-8"),


        error = function(e){NA})}) %>%
    furrr::future_map_dfr(function(x){

      if(is.null(x$name$path)==T){out <- tibble::tibble(orcid_check_access = "No",
                                                        "orcid_name_first" = NA,
                                                        "orcid_name_last" = NA,
                                                        "orcid_name_credit" = NA)}

      if(is.null(x$name$path)==F){out <-  tibble::tibble(orcid = x$name$path,
                                                         orcid_check_access = "Yes",
                                                         "orcid_name_first" = ifelse(is.null(x$name$`given-names`$value)==T,
                                                                                     NA, x$name$`given-names`$value),
                                                         "orcid_name_last" = ifelse(is.null(x$name$`family-name`$value)==T,
                                                                                    NA, x$name$`family-name`$value),
                                                         "orcid_name_credit" = ifelse(is.null(x$name$`credit-name`$value)==T,
                                                                                      NA, x$name$`credit-name`$value))}}) %>%
    dplyr::mutate(orcid_name_credit = ifelse(is.na(orcid_name_credit)==T&(is.na(orcid_name_first)==F&is.na(orcid_name_last)==F),
                                             paste0(orcid_name_first, " ", orcid_name_last), orcid_name_credit),
                  orcid_name_credit_first = stringr::str_remove(orcid_name_credit, orcid_name_last) %>% stringr::str_trim()) %>%
    dplyr::select(orcid, everything())


  final <- data %>%
    dplyr::select(-any_of(names(output)[! names(output) %in% c("orcid")])) %>%
    dplyr::left_join(output, by = c(orcid = "orcid")) %>%
    dplyr::mutate(orcid_check_access = ifelse(is.na(orcid_check_access)==T, "No", orcid_check_access)) %>%

    # Check if name extracted
    dplyr::mutate(orcid_check_name = ifelse(is.na(orcid_name_first)==T|is.na(orcid_name_last)==T, "No", "Yes")) %>%
    dplyr::mutate(orcid_valid_yn = ifelse(orcid_valid_yn=="Yes"&orcid_check_name=="Yes"&orcid_check_access=="Yes",
                                          "Yes", "No")) %>%
    dplyr::mutate(orcid_valid = ifelse(orcid_valid_yn=="No", NA, orcid_valid)) %>%
    dplyr::mutate(orcid_valid_reason = ifelse(is.na(orcid_valid_reason)==T&orcid_check_name=="No",
                                              "No first or last name recorded", orcid_valid_reason),
                  orcid_valid_reason = ifelse(is.na(orcid_check_access)==T&orcid_check_access=="No",
                                              "Unable to access orcid record", orcid_valid_reason)) %>%
    dplyr::select(everything(), orcid, orcid_valid, starts_with("orcid_name_"), starts_with("orcid_valid_"), starts_with("orcid_check_"))

  if(na.rm==T){final <- final %>% dplyr::filter(is.na(orcid_name_first)==F&is.na(orcid_name_last)==F)}

  if(na.rm==F&reason==F){final <- final %>% dplyr::select(-starts_with("orcid_check_"),-starts_with("orcid_valid_"))}

  return(final)}
