# orcid_pull_name--------------------------------

# Documentation
#' Pull first name(s) and last name for a given list of orcid
#' @description
#'
#' @param list_orcid List of orcid ids (XXXX-XXXX-XXXX-XXXX format)
#' @param initials Should the first / middle name(s) be converted to initials (default = TRUE)
#' @param position initials to "left" or "right" of last name (default = "right")
#' @return Dataframe with 3 mandatory columns: orcid, first names (fn_orcid) and last name (ln_orcid)
#' @importFrom dplyr filter mutate arrange select summarise
#' @import magrittr
#' @importFrom purrr map safely transpose
#' @importFrom tibble as_tibble
#' @importFrom stringr str_split_fixed
#' @importFrom xml2 as_list read_html
#' @importFrom data.table rbindlist
#' @export

# Function:
orcid_pull_name <- function(list_orcid, initials = TRUE, position = "right"){
  require(dplyr)

  # Pull orcid information / select out name
  df <- purrr::map(list_orcid, purrr::safely(function(x){xml2::as_list(xml2::read_html(paste0("https://pub.orcid.org/v2.1/",
                                                                                              x,
                                                                                              "/personal-details")))$`html`$`body`$`personal-details`$name %>%

      cbind.data.frame(orcid = x, fn_orcid = .$`given-names`[[1]], ln_orcid = .$`family-name`[[1]]) %>%
      .[which(colnames(.) %in% c("orcid", "fn_orcid", "ln_orcid"))]}))

  # If orcid invalid, then replace with NA
  df <- purrr::transpose(df)[["result"]] %>%
    purrr::map(function(x){if(is.null(x)==T){cbind.data.frame("orcid" = NA, fn_orcid = NA, ln_orcid = NA)}else{x}}) %>%
    data.table::rbindlist() %>%
    dplyr::mutate_all(as.character) %>%
    tibble::as_tibble() %>%
    dplyr::mutate(orcid = ifelse(is.na(orcid)==T, list_orcid, orcid))

  df <- df %>%
    dplyr::mutate(i1 = toupper(substr(stringr::str_split_fixed(fn_orcid, " ", 3)[,1],1,1)),
                  i2 = toupper(substr(stringr::str_split_fixed(fn_orcid, " ", 3)[,2],1,1)),
                  i3 = toupper(substr(stringr::str_split_fixed(fn_orcid, " ", 3)[,3],1,1))) %>%
    dplyr::mutate(initial_orcid = gsub(" ", "", paste0(i1, i2, i3)),
                  ln_orcid = ifelse(grepl("^[[:upper:]]+$", ln_orcid)==F,
                                    ln_orcid,
                                    paste0(substr(ln_orcid, 1,1),
                                           tolower(substr(ln_orcid, 2, nchar(ln_orcid)))))) %>%
    dplyr::mutate(fn_final = gsub(" ", "", paste0(i1, i2, i3))) %>%
    dplyr::select(orcid, fn_orcid, ln_orcid, initial_orcid,fn_final)

  if(initials==FALSE){df <- df %>% dplyr::mutate(fn_final = fn_orcid)}

  df <- df %>%
    dplyr::mutate(full_name_orcid = ifelse(is.na(fn_orcid)==F&is.na(ln_orcid)==F,
                                      paste0(ln_orcid, " ",fn_final),
                                      NA))

  if(position == "left"){df <- df %>%
    dplyr::mutate(full_name_orcid = ifelse(is.na(fn_orcid)==F&is.na(ln_orcid)==F,
                                      paste0(fn_final," ", ln_orcid),
                                      NA))}
  return(df)}
