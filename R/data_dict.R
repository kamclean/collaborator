# data_dict--------------------------------

# Documentation
#' Generate a data dictionary.
#' @description Used to generate an easily sharable data dictionary for an R dataframe. This supports the following classes: numeric, integer, logical, Date, character, String, factor, ordered.
#' @param df Dataframe.
#' @param var_exclude Vector of names of variables that are desired to be excluded from the data dictionary (default: NULL).
#' @param var_include Vector of names of variables that are desired to be included in the data dictionary (default: NULL).
#' @param label Where present, include the variable label for each variable
#' @return Dataframe with 4 columns: variable (variable name), class (variable class), na_pct (the percentage of data which is NA for that variable), and value (an appropriate summary for the variable class).
#' @import dplyr
#' @import tibble
#' @import tidyr
#' @importFrom purrr map
#' @importFrom lubridate ymd origin is.Date
#' @importFrom stats median
#' @export


# Function:
data_dict <- function(df, var_include = NULL, var_exclude=NULL, label = FALSE){
  require(dplyr);require(purrr);require(tibble);require(tidyr);require(lubridate);require(stats)
  extract_labels = function(.data){
    # Struggled to make this work and look elegant!
    # Works but surely there is a better way.
    df.out = lapply(.data, function(x) {
      vlabel = attr(x, "label")
      list(vlabel = vlabel)}) %>%
      do.call(rbind, .)
    df.out = data.frame(vname = rownames(df.out), vlabel = unlist(as.character(df.out)),
                        stringsAsFactors = FALSE)
    df.out$vfill = df.out$vlabel
    df.out$vfill[df.out$vlabel == "NULL"] = df.out$vname[df.out$vlabel=="NULL"]
    return(df.out)}

  if(is.null(var_exclude)==F){df <- df %>% dplyr::select(-one_of(var_exclude))}

  if(is.null(var_include)==F){df <- df %>% dplyr::select(all_of(var_include))}

  dict <- df %>%
    purrr::map(function(x){class(x) %>%
        paste(collapse="") %>%
        gsub("labelled", "", .)}) %>%
    tibble::enframe(name ="variable", value = "class") %>%
    dplyr::mutate(n_na = purrr::map(df, function(x){is.na(x) %>% sum()})) %>%
    tidyr::unnest(cols = c(class, n_na)) %>%
    dplyr::mutate(na_pct = paste0(format(round(n_na / nrow(df) *100, 1), nsmall=1), "%"))

  # Create numeric values
  value_num   <- NULL
  if(nrow(dplyr::filter(dict, class=="numeric"|class=="integer"))>0){
    value_num <- df %>%
      dplyr::select_if(function(x){is.numeric(x)|is.integer(x)}) %>%
      tidyr::pivot_longer(cols = everything(), names_to = "variable") %>%
      dplyr::group_split(variable) %>%
      purrr::map(function(x){x %>% dplyr::summarise(variable = unique(variable),
                                                    mean = mean(value, na.rm = T) %>% signif(3),
                                                    median = stats::median(value, na.rm = T) %>% signif(3),
                                                    min = min(value, na.rm = T) %>% signif(3),
                                                    max = max(value, na.rm = T) %>% signif(3))}) %>%
      dplyr::bind_rows() %>%
      dplyr::mutate(value = paste0("Mean: ", mean,"; Median: ",median, "; Range: ", min, " to ", max)) %>%
      dplyr::select(variable, value)}

  # Create date values
  value_date   <- NULL
  if(nrow(dplyr::filter(dict, class=="Date"))>0){
     value_date <- df %>%
       dplyr::select_if(function(x){lubridate::is.Date(x)}) %>%
       tidyr::pivot_longer(cols = everything(), names_to = "variable") %>%
       dplyr::group_split(variable) %>%
       purrr::map(function(x){x %>% dplyr::summarise(variable = unique(variable),
                                                     min = min(value, na.rm = T),
                                                     max = max(value, na.rm = T))}) %>%
       dplyr::bind_rows() %>%
       dplyr::mutate(value = paste0("Range: ", min, " to ", max)) %>%
       dplyr::select(variable, value)}

  # Create logical values
  value_logic   <- NULL
  if(nrow(dplyr::filter(dict, class=="logical"))>0){
    value_logic <- df %>%
      dplyr::select_if(function(x){is.logical(x)}) %>%
      tidyr::pivot_longer(cols = everything(), names_to = "variable") %>%
      dplyr::group_split(variable) %>%
      purrr::map(function(x){x %>% dplyr::summarise(variable = unique(variable),
                                                    value = paste(head(value, 10), collapse = ", "))}) %>%
      dplyr::bind_rows() %>%
      dplyr::select(variable, value)}

  # Create character values
  value_char   <- NULL
  if(nrow(dplyr::filter(dict, class=="character"|class=="String"))>0){
    value_char <- df %>%
      dplyr::select_if(function(x){is.character(x)}) %>%
      tidyr::pivot_longer(cols = everything(), names_to = "variable") %>%
      dplyr::group_split(variable) %>%
      purrr::map(function(x){x %>% dplyr::summarise(variable = unique(variable),
                                                    n_unique = length(unique(value)),
                                                    value = paste(head(unique(value), 10), collapse = ", "))}) %>%
      dplyr::bind_rows() %>%
      dplyr::mutate(value = paste0(n_unique, " Unique: ",value)) %>%
      dplyr::select(variable, value)}

  # Create factor values
  value_factor   <- NULL; var_factor <- NULL
  if(nrow(dplyr::filter(dict, class=="factor"|class=="orderedfactor"))>0){
    var_factor <- df %>%
      dplyr::select_if(function(x){is.factor(x)|is.ordered(x)})

    value_factor <- var_factor %>%
      purrr::map(function(x){tibble::tibble("n_levels" = nlevels(x),
                                            "levels" = paste0(levels(x) %>% head(10), collapse = ", "))}) %>%
      dplyr::bind_rows() %>%
      dplyr::mutate(variable = colnames(var_factor),
                    value = paste0(n_levels, " Levels: ",levels)) %>%
      dplyr::select(variable, value)}


  class_supported <- c("factor", "character", "String", "Date", "numeric", "logical", "orderedfactor")

  dict_full <- dplyr::bind_rows(value_factor, value_char, value_logic, value_date, value_num) %>%
    dplyr::left_join(dict, by = "variable") %>%
    dplyr::mutate(value = ifelse(class %in% class_supported, value, "Class not supported")) %>%
    dplyr::mutate(variable = factor(variable, levels = colnames(df))) %>%
    dplyr::arrange(variable) %>% dplyr::mutate(variable = as.character(variable)) %>%
    dplyr::select(variable, class, value, na_pct)

  if(label ==TRUE){
    dict_full <- df %>%
      extract_labels() %>%
      tibble::as_tibble() %>%
      dplyr::select("variable" = vname, "label" = vfill) %>%
      dplyr::right_join(dict_full, by = "variable") %>%
      dplyr::select(variable, label, everything())}



  return(dict_full)}
