# user_import-----------------------------------------

# Documentation
#' Generate a csv file to upload new user accounts to REDCap
#' @description Used to generate a csv file that can be used to upload new user accounts to REDCap directly (via control centre). This requires a dataframe of at least 4 mandatory columns (corresponding to: username, first name, last name, and email address) and 4 optional columns (corresponding to: institution, sponser, expiration, comments). All optional columns will be blank unless otherwise specified.
#' @param df Dataframe of at least 4 mandatory columns (corresponding to: username, first name, last name, and email address) and 4 optional columns (corresponding to: institution, sponser, expiration, comments).
#' @param username Column name (Mandatory) which corresponds to "Username".
#' @param first_name Column name (Mandatory) which corresponds to "First name".
#' @param last_name Column name (Mandatory) which corresponds to "Last name".
#' @param email Column name (Mandatory) which corresponds to "Email address".
#' @param institution Column name (Optional/Recommended) which corresponds to "Institution ID". Can be used to record the data_access_group / centre of the user.
#' @param sponser Column name (Optional) which corresponds to "Sponsor username".
#' @param expiration Column name (Optional) which corresponds to "Expiration". Must be in YYYY-MM-DD HH:MM or MM/DD/YYYY HH:MM format.
#' @param comments Column name (Optional) which corresponds to "Comments".
#' @param path Path or connection to write to as .csv file.
#' @importFrom dplyr filter mutate select summarise group_by ungroup
#' @importFrom readr write_csv
#' @return Returns a dataframe formated for REDCap user import (and an optional CSV file specified using path)
#' @export

# Function

user_import <- function(df, username, first_name, last_name, email,
                        institution = NULL, sponser = NULL, expiration = NULL, comments = NULL,
                        path = NULL){
  require(dplyr);require(readr)
  user_import_df <- df %>%
    dplyr::mutate("Username" = dplyr::pull(., username),
                  "First name" = dplyr::pull(., first_name),
                  "Last name" = dplyr::pull(., last_name),
                  "Email address" = pull(., email)) %>%
    dplyr::mutate("Institution ID" = if(is.null(institution)==T){""}else{dplyr::pull(., institution)},
                  "Sponsor username" = if(is.null(sponser)==T){""}else{dplyr::pull(., sponser)},
                  "Expiration" = if(is.null(expiration)==T){""}else{dplyr::pull(., expiration)},
                  "Comments" = if(is.null(comments)==T){""}else{dplyr::pull(., comments)}) %>%
    dplyr::select(Username:Comments) %>%
    dplyr::mutate_at(vars(`Institution ID`:Comments), function(x){ifelse(is.na(x)==T, "", x)})

  if(is.null(path)==T){user_import_df %>% readr::write_csv(path=path)}

  return(user_import_df)}


