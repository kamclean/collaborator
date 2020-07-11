# orcid_valid--------------------------------
# Documentation
#' Validate vector of ORCID
#' @description Validate vector of ORCID based number of digits / format / checksum.
#' @param data datafame containing a vector of ORCID
#' @param orcid Column name of vector containing ORCID (default = "orcid")
#' @param reason Logical value to determine whether output should include reasons for validity (default = FALSE) or vector of ORCID (TRUE).
#' @param na.rm Remove NA (invalid ORCID) from output
#' @return Vector of orcid (reason = FALSE) or tibble with columns specifying the validation checks failed by the ORCID ("check_" columns)
#' @import dplyr
#' @importFrom tibble enframe
#' @importFrom tidyr separate drop_na
#' @importFrom stringr str_sub str_remove_all
#' @export

orcid_valid <- function(data, orcid = "orcid", reason = FALSE, na.rm = FALSE){
  require(dplyr);require(tibble);require(tidyr);require(stringr)
  check_numeric <- function(x){suppressWarnings(is.numeric(as.numeric(x))==T&is.na(as.numeric(x))==F)}

  # https://support.orcid.org/hc/en-us/articles/360006897674-Structure-of-the-ORCID-Identifier.
  out <- data %>%
    dplyr::mutate(orcid = dplyr::pull(., orcid)) %>%
    dplyr::select(orcid) %>%
    tibble::rowid_to_column(var = "name") %>%
    dplyr::mutate(orcid_raw = stringr::str_remove_all(orcid, pattern = "[[:punct:]]") %>%
                    stringr::str_trim() %>% toupper(),
                  check_present = ifelse(is.na(orcid)==F, "Yes", "No")) %>%
    dplyr::mutate(check_length = ifelse(is.na(orcid_raw)==F&nchar(orcid_raw)==16, "Yes", "No")) %>%
    dplyr::mutate(digit15 = ifelse(check_length=="Yes", stringr::str_sub(orcid_raw,1,15), NA),
                  digit16 = ifelse(check_length=="Yes", stringr::str_sub(orcid_raw,16,16), NA)) %>%
    dplyr::mutate(check_format = ifelse(check_numeric(digit15)==T&(check_numeric(digit16)==T|digit16=="X"), "Yes", "No")) %>%
    dplyr::select(name, orcid_raw, "orcid_original" = orcid, check_present, check_length, check_format)

  orcid_valid <- out %>%
    dplyr::filter_at(vars(contains("check_")), all_vars(.=="Yes")) %>%
    dplyr::select(name, orcid_raw) %>%

    #separate each number
    dplyr::mutate(orcid = gsub('(?=(?:.{1})+$)', "-", orcid_raw, perl = TRUE) %>%
                    stringr::str_sub(2, nchar(.))) %>%
    tidyr::separate(col = orcid, into = paste0("orcid_", seq(1:16)), sep ="-", remove =F) %>%
    dplyr::mutate_at(vars(orcid_1:orcid_15), as.numeric) %>%
    dplyr::mutate(check_digit =  orcid_1*2,
                  check_digit = (orcid_2+check_digit)*2,
                  check_digit = (orcid_3+check_digit)*2,
                  check_digit = (orcid_4+check_digit)*2,
                  check_digit = (orcid_5+check_digit)*2,
                  check_digit = (orcid_6+check_digit)*2,
                  check_digit = (orcid_7+check_digit)*2,
                  check_digit = (orcid_8+check_digit)*2,
                  check_digit = (orcid_9+check_digit)*2,
                  check_digit = (orcid_10+check_digit)*2,
                  check_digit = (orcid_11+check_digit)*2,
                  check_digit = (orcid_12+check_digit)*2,
                  check_digit = (orcid_13+check_digit)*2,
                  check_digit = (orcid_14+check_digit)*2,
                  check_digit = (orcid_15+check_digit)*2) %>%
    dplyr::mutate(check_digit = check_digit %% 11) %>% # %% == remainder
    dplyr::mutate(check_digit = (12-check_digit) %% 11) %>%
    dplyr::mutate(check_digit = ifelse(check_digit==10, "X", ifelse(check_digit==11, 0, check_digit))) %>%
    dplyr::mutate(check_sum = ifelse(as.character(check_digit)==as.character(orcid_16), "Yes", "No")) %>%
    dplyr::select(orcid_raw, check_sum) %>%
    dplyr::distinct()

  out <- out %>%
    dplyr::left_join(orcid_valid, by = "orcid_raw") %>%
    dplyr::mutate_at(vars(contains("check_")), function(x){ifelse(is.na(x)==T, "No", x)}) %>%
    dplyr::mutate(valid_yn = ifelse(check_present=="Yes"&check_length=="Yes"&check_format=="Yes"&check_sum=="Yes",
                                    "Yes", "No"),
                  orcid_valid = ifelse(valid_yn=="Yes",orcid_raw, NA)) %>%
    dplyr::mutate(reason = ifelse(check_present=="No", "Missing ORCID", ""),
                  reason = ifelse(check_present=="Yes"&check_length=="No",
                                       paste0(reason,", Not 16 characters"), reason),
                  reason = ifelse(check_present=="Yes"&check_format=="No",
                                       paste0(reason,", Not ORCID format"), reason),
                  reason = ifelse(check_present=="Yes"&check_sum=="No",
                                       paste0(reason,", Failed checksum"), reason)) %>%
    dplyr::mutate(reason = stringr::str_remove(reason, "^, ")) %>%
    dplyr::mutate(reason = ifelse(reason =="", NA, reason)) %>%

    dplyr::mutate(orcid_valid = gsub('(?=(?:.{4})+$)', "-", orcid_valid, perl = TRUE) %>% stringr::str_sub(2, nchar(.))) %>%
    dplyr::select("orcid" = orcid_original,
                  "orcid_valid_yn" = valid_yn, orcid_valid, "orcid_valid_reason" = reason,
                  starts_with("check_")) %>%
    dplyr::rename_at(vars(starts_with("check_")), function(x){stringr::str_replace(x, "check_", "orcid_check_")})

  data_out <- dplyr::bind_cols(data, dplyr::select(out, -orcid))

  if(na.rm==T){data_out <- data_out %>% dplyr::filter(is.na(orcid_valid)==F)}

  if(reason==F){data_out <- data_out %>% dplyr::select(-starts_with("orcid_check_"), -orcid_valid_yn, -orcid_valid_reason)}

  return(data_out)}
