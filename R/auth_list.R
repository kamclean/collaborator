# report_auth-----------------------------------------
# Use: To generate an authorship list for all users
# df = a dataframe of at least 2 columns (name, group) for all users requiring authorship
# Note: name should be the full name of the person, and group could be the centre which they partcipated at
# subdivision = The colname of an additional variable in df by which to subdivide authorship. This could be a role (e.g. collaborator and validator) or region/country.

# name_sep = The character which will separate names (the default is ",")
# group_brachet = The brachets which will surround group (the default is "()")
# group_sep = The character which will separate groups (the default is ";")

# Output: Includes a file("auth_out.txt") saved in the working directory, and a copy printed in the console.
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
