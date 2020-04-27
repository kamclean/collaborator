# email_body
# Documentation
#' Split a tibble/dataframe by "group" variable, then save HTML file and/or code (e.g. for email body in send_email function)
#' @description Split a tibble/dataframe by "group" variable, then save HTML file and/or code (e.g. for email body in send_email function)
#' @param data Dataframe with at least 1 column - corresponding to the "group".
#' @param group Grouping variable (must be unique values) who will recieve unique email.
#' @param rmd_file String of the path of the RMD file with an HTML output (email body) within working directory.
#' @param html_output List of desired html outputs with "code" (html code) and "file" options (html file path). (Default = both "code" and "file")
#' @param subfolder Folder within working directory where HTML file will be stored - only required if file %in% html_output. (Default = "folder_html")
#' @param file_prefix String to be prefixed to "group" when naming HTML file - only required if file %in% html_output.
#' @param file_suffix String to be suffixed to "group" when naming HTML file - only required if file %in% html_output.
#' @return Dataframe of group AND html code ("code") and/or html file path ("file") depending on html_output.
#' @import dplyr
#' @importFrom here here
#' @importFrom rmarkdown render
#' @importFrom purrr map
#' @importFrom stringr str_split_fixed
#' @importFrom rvest html_node
#' @importFrom xml2 read_html
#' @importFrom tibble enframe

#' @export

# Function
email_body <- function(data, group, rmd_file, html_output = c("code", "file"),
                       subfolder = here::here("folder_html"), file_prefix = "", file_suffix = ""){

  require(dplyr); require(here); require(rmarkdown); require(purrr)
  require(stringr); require(rvest); require(xml2); require(tibble)

  html_doc2code <- function(x){
    map(x, function(y){xml2::read_html(y) %>%
        rvest::html_node("div") %>%
        as.character() %>%
        gsub("\r|\n|</div>", "", .) %>%
        tibble::enframe() %>%
        dplyr::mutate(value = stringr::str_split_fixed(value, "><div id=",2)[,2]) %>%
        dplyr::mutate(value = stringr::str_split_fixed(value, ">",2)[,2]) %>%
        dplyr::pull(value)}) %>%
      unlist()}

  if("code" %in% html_output & (! "file" %in% html_output)){
    output <- data %>%
      dplyr::mutate(group = pull(., group)) %>%
      dplyr::filter(is.na(group)==F) %>%
      # Split by group into separate datasets
      dplyr::group_split(group) %>%

      # convert rmarkdown into html code
      purrr::map(function(x){y <- rmarkdown::render(input = rmd_file, quiet=TRUE, params = x) %>% html_doc2code() %>% unlist()

      return(dplyr::bind_cols("group" = x$group, "code" = y))}) %>%

      dplyr::bind_rows()

    # remove html file created
    file.remove(gsub(".Rmd", ".html", rmd_file))}

  if("file" %in% html_output){
    dir.create(subfolder, showWarnings = FALSE)

    data <- data %>%
      dplyr::mutate(group = dplyr::pull(., group)) %>%
      dplyr::filter(is.na(group)==F) %>%
      dplyr::mutate(file = paste0(subfolder, "/",file_prefix, group,file_suffix, ".html"))


    data %>%
      # Split by group into separate datasets
      dplyr::group_split(group) %>%

      purrr::map(function(x){rmarkdown::render(input = rmd_file, output_file = x$file, quiet=TRUE, params = x)})

    output <- data %>% dplyr::select(group, file)

    if("code" %in% html_output){output <- output %>%
      dplyr::mutate(code = html_doc2code(file)) %>%
      dplyr::select(group, code, file)}}

  return(output)}
