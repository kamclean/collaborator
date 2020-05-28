# report_auth-----------------------------------------
# Documentation
#' Generate a formatted authorship list.
#' @description Used to generate a formatted authorship list for all users by group (the group the user belongs to e.g. the centre which they participated at). Optional subdivisions can be created to stratify users and groups. This could be a role (e.g. collaborator and validator) or region/country.
#' @param df Dataframe with authors in rows.
#' @param group Column name of a variable in the dataframe by which to group authorship (the default is NULL).
#' @param subdivision Column name of an additional variable in the dataframe by which to subdivide authorship (the default is NULL).
#' @param name_sep Character(s) which will separate names within the group (the default is ", ").
#' @param group_brachet Character(s) bracheting the group (the default is "()").
#' @param group_sep Character(s) which will separate the groups (the default is "; ").
#' @param path Path or connection to write to as .txt file.
#' @import dplyr
#' @importFrom stringr str_sub
#' @importFrom readr write_file read_file
#' @return Returns a formated string (and an optional .txt file specified using path)
#' @export

report_auth <- function(df, name, group = NULL, subdivision = NULL, path = NULL,
                        name_sep = ", ", group_brachet = "()",group_sep = "; "){

  require(stringr);require(readr);require(dplyr)


  if(is.null(group)==FALSE&length(group)>1){group <- head(group,1)
  print("More than 1 group supplied - only first value used as group")}

  if(is.null(subdivision)==FALSE&length(subdivision)>1){subdivision <- head(subdivision,1)
  print("More than 1 subdivision supplied - only first value used as subdivision")}

  group_brachet_L = stringr::str_sub(group_brachet, 1, 1)
  group_brachet_R = stringr::str_sub(group_brachet, 2, 2)

  df <- df %>% dplyr::mutate(name = dplyr::pull(., name))


  # No groups / subdivisions
  if(is.null(group)==TRUE&is.null(subdivision)==TRUE){
    output <- df %>%
      dplyr::summarise(auth_out = paste(name, collapse=name_sep) %>% paste0("."))

    if(is.null(path)==F){readr::write_file(output$auth_out, path=path)}}

  # Just groups
  if(is.null(group)==FALSE&is.null(subdivision)==TRUE){
    output <- df %>%
      dplyr::mutate(group = dplyr::pull(., group)) %>%

      dplyr::group_by(group) %>%

      dplyr::summarise(name_list = paste(name, collapse=name_sep)) %>%

      dplyr::mutate(name_group = paste0(name_list, " ",group_brachet_L, group, group_brachet_R)) %>%

      dplyr::summarise(auth_out = paste(name_group, collapse = group_sep) %>% paste0("."))

    if(is.null(path)==F){readr::write_file(output$auth_out, path=path)}}

  # Just subdivisions
  if(is.null(group)==TRUE&is.null(subdivision)==FALSE){
    output <- df %>%
      dplyr::mutate(subdivision = dplyr::pull(., subdivision)) %>%

      dplyr::group_by(subdivision) %>%

      dplyr::summarise(name_list = paste(name, collapse=name_sep) %>% paste0(".")) %>%

      dplyr::mutate(auth_out = paste0(subdivision, ": ", name_list)) %>%

      dplyr::select(auth_out)

    if(is.null(path)==F){readr::write_file(output$auth_out, path=path)}}


  # Groups and subdivisions
  if(is.null(group)==FALSE&is.null(subdivision)==FALSE){
    output <- df %>%
      dplyr::mutate(group = dplyr::pull(., group),
                    subdivision = dplyr::pull(., subdivision)) %>%

      dplyr::select(subdivision, group, name) %>%

      dplyr::group_by(subdivision, group) %>%
      dplyr::summarise(name_list = paste(name, collapse=name_sep)) %>%

      # add group characteristics
      dplyr::mutate(name_group = paste0(name_list, " ",group_brachet_L, group, group_brachet_R)) %>%

      # combine groups (by subdivision)
      dplyr::summarise(auth_out = paste(name_group, collapse = group_sep) %>% paste0(".")) %>%

      dplyr::mutate(auth_out = paste0(subdivision, ": ", auth_out)) %>%

      dplyr::select(auth_out)

    if(is.null(path)==F){readr::write_file(output$auth_out, path=path)}}


  return(gsub("\n\n", " ", output$auth_out))}
