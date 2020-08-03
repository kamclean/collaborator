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
#' @importFrom furrr future_map2 future_map_dfr
#' @importFrom stringr str_sub
#' @importFrom httr GET
#' @export



orcid_name <- function(data, orcid = "orcid", reason = FALSE, na.rm = FALSE){
  # Packages / Functions
  require(dplyr);require(furrr);require(xml2);require(dplyr);
  require(tibble);require(tidyr);require(stringr);library(magrittr)

  # Check orcid valid
  if("orcid_valid_yn" %in% names(data)){
    data <- data %>%
      dplyr::mutate(orcid = dplyr::pull(., orcid)) %>%
      dplyr::select(orcid, starts_with("orcid_valid"), starts_with("orcid_check_"))}else{
        data <- data %>%
          collaborator::orcid_valid(orcid = orcid, reason = T, na.rm = na.rm) %>%
          dplyr::mutate("orcid" = orcid_valid)}

  # Check extract name from valid orcids
  input_orcid <- data %>%
    dplyr::filter(is.na(orcid)==F) %>%
    dplyr::distinct(orcid) %>%
    dplyr::pull(orcid)

  output <- input_orcid %>%
    furrr::future_map2(.x = .,
                       .y = seq_along(1:length(.)),
                       function(.x,.y){
                         print(.y)

                         tryCatch(xml2::read_xml(httr::GET(url = paste0("https://pub.orcid.org/v3.0/",
                                                                        .x,
                                                                        "/personal-details"))),
                                  error = function(e){NA})})



  output <- output %>%
    furrr::future_map2_dfr(.x =., .y = seq_along(1:length(.)),
                           function(.x, .y){
                             print(.y)

                             if(is.na(.x)==T|length(.x %>% xml2::xml_find_all("personal-details:name"))==0){out <- tibble::tibble(orcid_check_access = "No",
                                                                                                                                  "orcid_name_first" = NA,
                                                                                                                                  "orcid_name_last" = NA,
                                                                                                                                  "orcid_name_credit" = NA)
                             }else{
                               out <- suppressWarnings(.x %>%
                                                         xml2::xml_find_all("personal-details:name") %>%
                                                         xml2::xml_find_all("personal-details:given-names|personal-details:family-name|personal-details:credit-name") %$%
                                                         tibble::tibble("name" = xml2::xml_name(.),
                                                                        "value" = xml2::as_list(.) %>% unlist()) %>%
                                                         dplyr::right_join(tibble::tibble("name" = c("given-names", "family-name", "credit-name")), by="name") %>%
                                                         tidyr::pivot_wider(names_from = "name",
                                                                            values_from = "value") %>%
                                                         dplyr::mutate(orcid_check_access = "Yes") %>%
                                                         dplyr::select(orcid_check_access,
                                                                       "orcid_name_first" = `given-names`,
                                                                       "orcid_name_last" = `family-name`,
                                                                       "orcid_name_credit" = `credit-name`))}

                             return(out)}) %>%
    dplyr::mutate(orcid = input_orcid) %>%
    dplyr::select(orcid, everything())



  final <- dplyr::left_join(data %>%
                              dplyr::select(-any_of(names(output)[! names(output) %in% c("orcid")])),
                            output %>%
                              dplyr::select(orcid,
                                            starts_with("orcid_name_"),
                                            starts_with("orcid_valid_"),
                                            starts_with("orcid_check_")),
                            by = c(orcid = "orcid")) %>%
    dplyr::mutate(orcid_check_access = ifelse(is.na(orcid_check_access)==T, "No", orcid_check_access)) %>%

    # Check if name extracted
    dplyr::mutate(orcid_check_name = ifelse(is.na(orcid_name_first)==T|is.na(orcid_name_last)==T, "No", "Yes")) %>%
    dplyr::mutate(orcid_valid_yn = ifelse(orcid_valid_yn=="Yes"&orcid_check_name=="Yes"&orcid_check_access=="Yes",
                                          "Yes", "No")) %>%
    dplyr::mutate(orcid_valid = ifelse(orcid_valid_yn=="No", NA, orcid_valid)) %>%
    dplyr::mutate(orcid_valid_reason = ifelse(is.na(orcid_valid_reason)==T&orcid_check_name=="No",
                                              "No first or last name recorded", orcid_valid_reason),
                  orcid_valid_reason = ifelse(is.na(orcid_check_access)==T&orcid_check_access=="No",
                                              "Unable to access orcid record", orcid_valid_reason))

  if(reason==F){final <- final %>% dplyr::select(-starts_with("orcid_check_"),-starts_with("orcid_valid_"))}

  if(na.rm==T){final <- final %>% dplyr::filter(is.na(orcid_name_first)==F&is.na(orcid_name_last)==F)}

  return(final)}
