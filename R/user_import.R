# user_import-----------------------------------------

# Documentation
#' Generate a csv file that can be used to upload new user accounts to REDCap directly (via control centre)
#' @description Used to generate a csv file that can be used to upload new user accounts to REDCap directly (via control centre). This requires a dataframe of at least 4 mandatory columns (corresponding to: username, first name, last name, and email address) and 4 optional columns (corresponding to: institution, sponser, expiration, comments). All optional columns will be blank unless otherwise specified.
#' @param df Dataframe of at least 4 mandatory columns (corresponding to: username, first name, last name, and email address) and 4 optional columns (corresponding to: institution, sponser, expiration, comments).
#' @param username Column name (Mandatory) which corresponds to "Username".
#' @param first_name Column name (Mandatory) which corresponds to "First name".
#' @param last_name Column name (Mandatory) which corresponds to "Last name".
#' @param email Column name (Mandatory) which corresponds to "Email address".
#' @param institution Column name (Optional/Recommended) which corresponds to "Institution ID". Can be used to record the data_access_group / centre of the user.
#' @param sponser Column name (Optional) which corresponds to "Sponsor username".
#' @param expiration Column name (Optional) which corresponds to "Expiration"). Must be in YYYY-MM-DD HH:MM or MM/DD/YYYY HH:MM format.
#' @param comments Column name (Optional) which corresponds to "Comments").
#' @return Returns a csv file for upload ("user.import_[date generated].csv"), and a dataframe.
#' @export

# Function
user_import <- function(df, username, first_name, last_name, email,
                        institution = "", sponser="", expiration="", comments=""){
  require("readr")
  require("dplyr")

df %>%
  mutate(username = pull(df, username),
         first_name = pull(df, first_name),
         last_name = pull(df, last_name),
         email = pull(df, email),
         institution = pull(df, institution),
         sponser = pull(df, sponser),
         expiration = pull(df, expiration),
         comments = pull(df, comments)) %>%
  dplyr::select("Username" = username,
                "First name" = first_name,
                "Last name" = last_name,
                "Email address" = email,
                "Institution ID" = institution,
                "Sponsor username" = sponser,
                "Expiration" = expiration,
                "Comments" = comments) -> user_import_df
user_import_df %>%
  write_csv(path=paste0("user.import_",paste0(Sys.Date(), ".csv")))

return(user_import_df)}
