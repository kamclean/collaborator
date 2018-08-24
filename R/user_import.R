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
#' @return Returns a csv file for upload ("user.import_[date generated].csv"), and a dataframe.
#' @export

# Function
user_import <- function(df, username, first_name, last_name, email,
                        institution = "", sponser="", expiration="", comments=""){
  require("readr")
  require("dplyr")

  df %>%
  dplyr::mutate(col_blank = "") -> df

  df %>%
  dplyr::mutate(var_username = pull(df, username),
                var_first_name = pull(df, first_name),
                var_last_name = pull(df, last_name),
                var_email = pull(df, email)) %>%

  dplyr::mutate(var_institution = cbind(dplyr::pull(df, ifelse(institution!="", institution, col_blank))),
                var_sponser = cbind(dplyr::pull(df, ifelse(sponser!="", sponser, col_blank))),
                var_expiration = cbind(dplyr::pull(df, ifelse(expiration!="", expiration, col_blank))),
                var_comments = cbind(dplyr::pull(df, ifelse(comments!="", comments, col_blank)))) %>%

  dplyr::select("Username" = var_username,
                "First name" = var_first_name,
                "Last name" = var_last_name,
                "Email address" = var_email,
                "Institution ID" = var_institution,
                "Sponsor username" = var_sponser,
                "Expiration" = var_expiration,
                "Comments" = var_comments) -> user_import_df

user_import_df %>%
  write_csv(path=paste0("user.import_",paste0(Sys.Date(), ".csv")))

return(user_import_df)}
