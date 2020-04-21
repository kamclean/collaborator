# user_summarise--------------------------------
# Documentation
#' Summarise the REDCap user dataframe by group (data access group)
#' @description Group current REDCap project users by DAG (and role) to provide a summarised dataframe of users, names, and emails.
#' @param data Dataset previously exported of users authorized for a project (5 required columns: data_access_group, username, firstname, lastname, email)
#' @param redcap_project_uri URI (Uniform Resource Identifier) for the REDCap instance.
#' @param redcap_project_token API (Application Programming Interface) for the REDCap project.
#' @param use_ssl Logical value whether to verify the peer's SSL certificate should be evaluated during the API pull (default=TRUE)
#' @param user_exclude Vector of usernames to be excluded e.g. those with unique rights (default = NULL).
#' @return Dataframe summarising the user dataframe by group (data access group), number of users, and username/fullname/emails (separated by ";").
#' @import dplyr
#' @importFrom RCurl postForm
#' @importFrom readr read_csv
#' @export

# Function
user_summarise <- function(data = NULL, redcap_project_uri = NULL, redcap_project_token = NULL,
                           user_exclude = NULL, use_ssl=TRUE){

  require(RCurl); require(dplyr); require(readr)

  if(is.null(data)==F&(is.null(redcap_project_uri)==T|is.null(redcap_project_token)==T)){
    user_current <- data %>%
      dplyr::select(data_access_group, username, firstname, lastname, email)}

  if(is.null(data)==T&(is.null(redcap_project_uri)==F&is.null(redcap_project_token)==F)){

    user_current <- RCurl::postForm( uri=redcap_project_uri,
                                     token= redcap_project_token,
                                     content='user',
                                     .opts = curlOptions(ssl.verifypeer = if(use_ssl==F){FALSE}else{TRUE}),
                                     format='csv') %>%
      readr::read_csv() %>%

      # select relevant columns
      dplyr::select(data_access_group, username, firstname, lastname, email)}

  # Exclude required users
  if(is.null(user_exclude)==F){user_current <- user_current %>% dplyr::mutate(! username %in% user_exclude)}

  output <- user_current %>%
    # must have an email and data_access_group
    dplyr::filter(is.na(data_access_group)==F&is.na(email)==F) %>%

    # ensure no special characters
    dplyr::mutate_all(function(x){iconv(x, to ="ASCII//TRANSLIT")}) %>%
    dplyr::mutate_at(vars(contains("name")), function(x){gsub(";", "", x)}) %>%

    #summarise by DAG
    dplyr::group_by(data_access_group) %>%
    dplyr::summarise(user_n = n(),
                     user_usernames = paste(paste0(username), collapse = "; "),
                     user_fullnames = paste(paste0(firstname, " ", lastname), collapse = "; "),
                     user_email = paste0(email, collapse = "; ")) %>%
    dplyr::ungroup()


  return(output)}
