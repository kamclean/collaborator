# email_send-------------------------------
# Documentation
#' Send group-specific emails and attatchments via gmailR.
#' @description Send group-specific emails and attatchments via gmailR (must have previously set up GmailR on R instance)
#' @param df_email Dataframe containing a minimum of the output from email_format function and a column corresponding to the email body pathway.
#' @param sender Email address from the sender (should match the details specified using gmailr::gm_auth_configure()).
#' @param email_body String of column names of the HTML code to attach as the email body (default = "body"). Note html files cannot be sent at present using gmailR.
#' @param attach List of column names of files to attach. Each column must contain a full path for each file for each group.
#' @param zip Logical value to send attachments as a ZIP folder (default = FALSE). Requires an attachment via "attach".
#' @param draft Logical value to create as a draft email (default: TRUE) or send immediately (FALSE)
#' @return Vector of paths for each group-specific HTML file (append to df_email to use in send_email function)
#' @import dplyr
#' @import gmailr
#' @importFrom stringr str_sub
#' @importFrom tidyr pivot_longer
#' @importFrom zip zipr
#' @importFrom purrr map2
#' @importFrom stringi stri_locate_last_fixed
#' @export

# Function

email_send <- function(df_email, sender, body = "body", attach = NULL, zip = F, draft = TRUE){
  require(dplyr);require(gmailr);  require(stringr); require(tidyr)
  require(zip); require(purrr);require(stringi)

  df_email %>%
    dplyr::mutate(body = dplyr::pull(., body)) %>%
    dplyr::group_split(group) %>%
    purrr::map2(., seq_along(.), function(x, y){

      # Generate email
      test_email <- gmailr::gm_mime() %>%
        gmailr::gm_from(sender) %>%
        gmailr::gm_to(x$recipient_main) %>%
        gmailr::gm_cc(x$recipient_cc) %>%
        gmailr::gm_bcc(x$recipient_bcc) %>% #
        gmailr::gm_subject(x$subject) %>%

        # htmltools::includeHTML(x$body where x$body is the file path) can be used here to add an HTML file
        # note HTML file will not display properly if sent directly via gmailR (can be sent as a draft, then sent from within gmail).
        gmailr::gm_html_body(x$body)

      # Generate attachments
      attach_email <- NULL
      if(is.null(attach)==F){

        attach_email <- x %>%
          dplyr::select(group, attach) %>%
          tidyr::pivot_longer(cols = -group) %>%
          dplyr::mutate(type = stringr::str_sub(value,
                                                stringi::stri_locate_last_fixed(value, ".")[,"start"]+1,
                                                nchar(value)))

        path_zip <- attach_email %>%
          head(1) %>% dplyr::pull(value) %>%
          stringr::str_sub(.,1,stringi::stri_locate_last_fixed(., "/")[,"start"]) %>%
          paste0("zip/")

        if(nrow(attach_email)>0){

          if(zip==F){

            for(j in 1:nrow(attach_email)){test_email <- test_email %>%
              gmailr::gm_attach_file(attach_email$value[j],type= attach_email$type[j])}}

          if(zip==T){

            dir.create(path_zip, showWarnings = FALSE)

            group_zip_name <- paste0(path_zip, unique(attach_email$group), ".zip")

            zip::zipr(zipfile = group_zip_name, files = attach_email$value)

            test_email <- test_email %>%
              gmailr::gm_attach_file(group_zip_name, type= "zip")}}

        # Send email (draft as default)
      }

      if(draft==FALSE){gmailr::gm_send_message(test_email)}else{gmailr::gm_create_draft(test_email)}

      print(paste0(y, " (", x$group, ")"))})}
