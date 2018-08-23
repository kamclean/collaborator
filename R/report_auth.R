# report_auth-----------------------------------------

# Documentation
#' Generate a formatted authorship list.
#' @description Used to generate a formatted authorship list for all users by group (the group the user belongs to e.g. the centre which they participated at). Optional subdivisions can be created to stratify users and groups. This could be a role (e.g. collaborator and validator) or region/country.
#' @param df Dataframe of at least 2 columns: "name".
#' @param group Column name of a variable in the dataframe by which to group authorship (the default is NULL).
#' @param subdivision Column name of an additional variable in the dataframe by which to subdivide authorship (the default is NULL).
#' @param name_sep Character(s) which will separate names within the group (the default is ",").
#' @param group_brachet Character(s) bracheting the group (the default is "()").
#' @param group_sep Character(s) which will separate the groups (the default is ";").
#' @return Generates a text file ("auth_out.txt").
#' @export

report_auth <- function(df, group = NULL, subdivision = NULL,
                        name_sep = ",", group_brachet = "()",group_sep = ";"){
  require("dplyr")
  require("stringr")
  require("stringi")
  require("tibble")
  require("readr")

  group_brachet_L = substr(group_brachet, 1, 1)
  group_brachet_R = substr(group_brachet, 2, 2)

  if(is.null(group)==TRUE&is.null(subdivision)==TRUE){
    auth_out <- df %>%

      dplyr::summarise(name_list = paste0(paste(c(name), collapse=paste0(name_sep, " ")),"."))

      readr::write_file(auth_out$name_list, path="auth_out.txt")}

  if(is.null(group)==FALSE&is.null(subdivision)==TRUE){
    auth_out <- df %>%
      mutate(group = pull(df, group)) %>%

      group_by(group) %>%

      dplyr::summarise(name_list = paste(c(name), collapse=paste0(name_sep, " "))) %>%

      mutate(name_group = paste0(name_list, " ",group_brachet_L, group,group_brachet_R, group_sep, " ")) %>%

      dplyr::summarise(auth_out = paste(c(name_group), collapse=" " )) %>%

      mutate(auth_out = stringi::stri_replace_last_fixed(auth_out, paste0(group_sep, " "), "."))

      readr::write_file(auth_out$auth_out, path="auth_out.txt")}

  if(is.null(group)==TRUE&is.null(subdivision)==FALSE){
     auth_out <- df %>%
      mutate(subdivision = pull(df, subdivision)) %>%

      select(subdivision, name) %>%

      group_by(subdivision) %>%

      dplyr::summarise(name_list = paste0(paste(c(name), collapse=paste0(name_sep, " ")),".")) %>%

      mutate(auth_out = paste0(name_list, "\n", sep="")) %>%

      mutate(auth_out_sd = paste0(subdivision, ": ", auth_out))

     write(auth_out$auth_out_sd, file="auth_out.txt")}

  if(is.null(group)==FALSE&is.null(subdivision)==FALSE){
    auth_out <- df %>%
      mutate(group = pull(df, group),
             subdivision = pull(df, subdivision)) %>%

      select(subdivision, group, name) %>%

      group_by(subdivision, group) %>%

      dplyr::summarise(name_list = paste(c(name), collapse=paste0(name_sep, " "))) %>%

      mutate(name_group = paste0(name_list, " ",group_brachet_L, group,group_brachet_R, group_sep, " ")) %>%

      dplyr::summarise(auth_out = paste(c(name_group), collapse=" " )) %>%

      mutate(auth_out = stringi::stri_replace_last_fixed(auth_out, paste0(group_sep, " "), ".")) %>%

      mutate(auth_out = paste0(auth_out, "\n", sep="")) %>%

      mutate(auth_out_sd = paste0(subdivision, ": ", auth_out))

    write(auth_out$auth_out_sd, file="auth_out.txt")}

  return(cat(read_file("auth_out.txt")))}
