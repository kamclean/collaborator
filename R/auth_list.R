# report_auth-----------------------------------------

# Documentation
#' Generate a formatted authorship list.
#' @description Used to generate a formatted authorship list for all users by group (the group the user belongs to e.g. the centre which they participated at). Optional subdivisions can be created to stratify users and groups. This could be a role (e.g. collaborator and validator) or region/country.
#' @param df Dataframe of at least 2 columns: "name" and "group".
#' @param name_sep Character(s) which will separate names within the group (the default is ",").
#' @param group_brachet Character(s) bracheting the group (the default is "()").
#' @param group_sep Character(s) which will separate the groups (the default is ";").
#' @param subdivision Column name of an additional variable in the dataframe by which to subdivide authorship (the default is NULL).
#' @return Generates a text file ("auth_out.txt").

# Function:
report_auth <- function(df, name_sep = ",", group_brachet = "()",group_sep = ";", subdivision = NULL){
  require("dplyr")
  require("stringr")
  require("stringi")
  require("tibble")

  group_brachet_L = substr(group_brachet, 1, 1)
  group_brachet_R = substr(group_brachet, 2, 2)

  if(is.null(subdivision)==T){
    auth_out <- df %>%
      group_by(group) %>%

      dplyr::summarise(name_list = paste(c(name), collapse=paste0(name_sep, " "))) %>%

      mutate(name_group = paste0(name_list, " ",group_brachet_L, group,group_brachet_R, group_sep, " ")) %>%

      dplyr::summarise(auth_out = paste(c(name_group), collapse=" " )) %>%

      mutate(auth_out = stringi::stri_replace_last_fixed(auth_out, paste0(group_sep, " "), "."))

    write(auth_out$auth_out, file="auth_out.txt")}



  else{
    auth_out_sd <- df %>%
      mutate(subdivision = pull(df, subdivision)) %>%

      select(subdivision, group, name) %>%

      group_by(subdivision, group) %>%

      dplyr::summarise(name_list = paste(c(name), collapse=paste0(name_sep, " "))) %>%

      mutate(name_group = paste0(name_list, " ",group_brachet_L, group,group_brachet_R, group_sep, " ")) %>%

      dplyr::summarise(auth_out = paste(c(name_group), collapse=" " )) %>%

      mutate(auth_out = stringi::stri_replace_last_fixed(auth_out, paste0(group_sep, " "), ".")) %>%

      mutate(auth_out = paste0(auth_out, "\n", sep="")) %>%

      mutate(auth_out_sd = paste0(subdivision, ": ", auth_out))

    write(auth_out_sd$auth_out_sd, file="auth_out.txt")}

  visualise_list <- cat(read_file("auth_out.txt"))

  return(visualise_list)}
