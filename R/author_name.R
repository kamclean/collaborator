# author_name--------------------------------
# Documentation
#' Pull first name(s) and last name for a given list of orcid
#' @description Pull and format first name(s) and last name for a given list of orcid
#' @param data datafame containing a vectors of the author name (split into first_name and last_name)
#' @param first_name Column name of vector containing the first and middle name(s) (default = "first_name")
#' @param last_name Column name of vector containing the last or family name (default = "last_name")
#' @param initial Should the first / middle name(s) be converted to initial (default = TRUE)
#' @param position initial to "left" or "right" of last name (default = "right")
#' @param initial_max Maximum number of digits (default = 3)
#' @return Vector of the combined name composing the full author name in the requested format.
#' @import dplyr
#' @importFrom purrr map_chr
#' @importFrom stringr str_sub str_split str_to_title
#' @importFrom Hmisc capitalize
#' @export

author_name <- function(data, first_name = "first_name", last_name = "last_name", initial=T, position = "right", initial_max=3){
  require(dplyr);require(purrr); require(stringr); require(Hmisc)

  output <- data %>%
    dplyr::mutate_at(vars(first_name, last_name),
                     function(x){purrr::map_chr(x,
                                             function(y){ifelse(stringr::str_detect(y, "^[[:upper:][:space:][:punct:]]+$"),
                                                                stringr::str_replace_all(y,"^[[:alpha:]]+|[[:space:][:punct:]][[:alpha:]]+",
                                                                                         stringr::str_to_title),y)})}) %>%
    dplyr::mutate(first_name = dplyr::pull(., first_name),
                  last_name = dplyr::pull(., last_name)) %>%
    dplyr::mutate(last_name = Hmisc::capitalize(last_name)) %>%
    dplyr::mutate(initial_name = purrr::map_chr(stringr::str_split(first_name," "),
                                                function(x){stringr::str_sub(x,1,1) %>% paste(collapse = "")}))%>%
    dplyr::mutate(initial_name = toupper(initial_name),
                  name_yn = ifelse(is.na(first_name)==T|is.na(last_name)==T, "No", "Yes"))

  if(initial==T&position == "right"){output <- output %>% dplyr::mutate(author_name = ifelse(name_yn=="Yes", paste0(last_name, " ", initial_name), NA))}
  if(initial==F&position == "right"){output <- output %>% dplyr::mutate(author_name = ifelse(name_yn=="Yes", paste0(last_name, " ", first_name), NA))}
  if(initial==T&position == "left"){output <- output %>% dplyr::mutate(author_name = ifelse(name_yn=="Yes", paste0(initial_name, " ", last_name), NA))}
  if(initial==F&position == "left"){output <- output %>% dplyr::mutate(author_name = ifelse(name_yn=="Yes", paste0(first_name, " ", last_name), NA))}

  return(output %>% select(-initial_name, -name_yn, -first_name, -last_name))}
