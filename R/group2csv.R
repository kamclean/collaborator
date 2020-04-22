# group2csv------------------------------
# Documentation
#' Split a tibble/dataframe into CSV by "group" variable
#' @description Split a tibble/dataframe by "group" variable, then save in a subfolder as CSV.
#' @param data Dataframe with at least 1 column - corresponding to a "group".
#' @param group Grouping variable (must be unique values) who will recieve unique email.
#' @param subfolder Folder within working directory (e.g. string entered into here::here()) where CSV will be stored. Default = "folder_csv".
#' @param file_prefix String to be prefixed to "group" when naming CSV file.
#' @param file_suffix String to be suffixed to "group" when naming CSV file.
#' @return Dataframe of group AND html code ("code") and/or csv file path ("file").
#' @import dplyr
#' @import magrittr
#' @import readr
#' @import here
#' @import tibble
#' @importFrom purrr map
#' @export

# Function
group2csv <- function(data, group, subfolder = "folder_csv", file_prefix = "", file_suffix = ""){
  require(dplyr);require(readr); require(here); require(purrr)

  dir.create(subfolder, showWarnings = FALSE)

  data <- data %>%
    dplyr::mutate(group = dplyr::pull(., group)) %>%
    dplyr::filter(is.na(group)==F)

  data_group <- data %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(file = paste0(subfolder, "/", file_prefix, unique(group), file_suffix, ".csv"))


  data %>%
    # Split by group into separate datasets
    dplyr::group_split(group) %>%

    purrr::map(function(x){readr::write_csv(x = x,
                                            path = paste0(subfolder, "/",
                                                          file_prefix, unique(x$group),
                                                          file_suffix, ".csv"))})

  return(data_group)}

