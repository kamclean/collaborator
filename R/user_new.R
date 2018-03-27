# user_new-----------------------
# Use: To compare a df of all users to those currently on redcap to determine the new users requiring upload
# user_all.df = Dataframe of all users containing at least 1 column (username)
# users_exception = Vector of usernames to be excluded as not present in user_all.df (e.g. admin users))
user_new <- function(redcap_project_uri, redcap_project_token, user_all.df, users_exception){
  # Load required packages
  require("dplyr")
  require("readr")
  require("RCurl")
  "%ni%" <- Negate("%in%")


  postForm(
    uri=redcap_project_uri,
    token= redcap_project_token,
    content='user',
    format='csv') %>%
    read_csv() -> user_current

  user_all.df %>%
    filter(username %ni% users_exception) %>%
    filter(username %ni% user_current$username) -> users_new

  return(users_new)}
