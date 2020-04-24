# email_format--------------------------------
# Documentation
#'Prepare df_email in a standard format for email_send function.
#' @description  Prepare df_email in a standard format for email_send function.
#' @param df_email Dataframe with at least 2 columns - corresponding to a "group" and and "email" (e.g. output from user_summarise). Email addresses must be a string separated by a comma or semi-colon (not a list variable).
#' @param group Grouping variable (must be unique values) who will recieve unique email.
#' @param recipient_main String corresponding to column name containing the main intended email recipients within the group.
#' @param recipient_cc String corresponding to column name containing email recipients within the group intended to be cc'd.
#' @param recipient_bcc String corresponding to column name containing email recipients within the group intended to be bcc'd.
#' @param subject String corresponding to the subject line of the emails - subjects can be made group specific using square brachets "[]" around a column name within the dataset.
#' @return Dataframe with 5 mandatory columns: group, recipients (recipient_main, recipient_cc & recipient_bcc), and subject.
#' @import dplyr
#' @importFrom stringr str_detect str_split
#' @importFrom purrr map
#' @importFrom tidyr pivot_wider unite
#' @importFrom tibble enframe
#' @export

# Function
email_format <- function(df_email, group = "data_access_group", subject,
                         recipient_main = NULL,recipient_cc = NULL,recipient_bcc = NULL){

  require(dplyr);require(stringr);require(purrr);require(tidyr);require(tibble)

  data <- df_email %>%
    # standardise names of variables
    dplyr::mutate(group = dplyr::pull(., group),
                  recipient_main = if(is.null(recipient_main)==T){""}else{dplyr::pull(., recipient_main)},
                  recipient_cc  = if(is.null(recipient_cc)==T){""}else{dplyr::pull(., recipient_cc)},
                  recipient_bcc = if(is.null(recipient_bcc)==T){""}else{dplyr::pull(., recipient_bcc)})

  # Create subject lines (including those unique if specified)
  # variable names to be inserted must be []

  if(stringr::str_detect(subject, "\\[")&stringr::str_detect(subject, "\\]")){
    subject_split <- subject %>% stringr::str_split("\\[|\\]")


    df_subject_split <- rep(subject_split, nrow(data)) %>%
      purrr::map(function(x){tibble::enframe(x) %>% tidyr::pivot_wider(names_prefix = "col_")}) %>%
      dplyr::bind_rows()

    df_subject_split[which(unlist(subject_split) %in% names(data))] <- dplyr::select(data[which(names(data) %in% unlist(subject_split))],
                                                                                     unlist(subject_split)[unlist(subject_split) %in% names(data)])

    subject_final <- df_subject_split %>%
      tidyr::unite(col = "subject", everything(), sep="") %>%
      dplyr::pull(subject)}else{subject_final <- rep(subject, nrow(data))}

  var_original <- c(group, recipient_main, recipient_cc, recipient_bcc)

  out <- data %>%
    dplyr::mutate(subject = subject_final) %>%
    dplyr::select(-dplyr::one_of(var_original[! var_original %in% ""])) %>%
    dplyr::select(group, recipient_main, recipient_cc, recipient_bcc, subject, dplyr::everything())

  return(out)}
