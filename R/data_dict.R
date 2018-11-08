# data_dict--------------------------------

# Documentation
#' Generate a data dictionary.
#' @description Used to generate an easily sharable data dictionary for an R dataframe. This supports the following classes: numeric, integer, logical, Date, character, String, factor, orderedfactor.
#'
#' @param df Dataframe.
#' @param var_exclude Vector of names of variables that are desired to be excluded from the data dictionary (the default is "" e.g. none).
#' @return Dataframe with 4 columns: variable (variable name), class (variable class), na_pct (the percentage of data which is NA for that variable), and values (an appropriate summary for the variable class).
#' @importFrom dplyr filter mutate arrange select summarise
#' @import magrittr
#' @importFrom tibble as_tibble rownames_to_column
#' @importFrom stringr str_count str_split_fixed
#' @importFrom lubridate ymd origin
#' @importFrom gdata reorder.factor
#' @export

# Function:
data_dict <- function(df, var_exclude=""){

  "%ni%" <- Negate("%in%")

  df.2 <- df %>%
    dplyr::select(colnames(.)[colnames(df) %ni% c(var_exclude)])

  dd.1 <- cbind(sapply(df.2, class))

  dd.1 <- cbind.data.frame(class = dd.1, is.na = colSums(sapply(df.2, is.na)))

  dd.1 %>%
    dplyr::mutate(class = sapply(class,function(x) paste(unlist(x),collapse=""))) %>%
    dplyr::mutate(class = gsub("labelled", "", class)) %>%
    dplyr::mutate(variable = rownames(dd.1)) %>%
    dplyr::mutate(na_pct = paste0(format(round(is.na / nrow(df.2) *100, 1), nsmall=1), "%")) %>%
    dplyr::select(variable, class, na_pct) -> dd.1

  # Set values_class as NULL
  values_num   <- NULL
  values_date  <- NULL
  values_logic <- NULL
  values_char  <- NULL
  values_fact  <- NULL

  # Create numeric values
  dd.1 %>%
    dplyr::filter(class=="numeric"|class=="integer") %>%
    dplyr::select(variable) %>%
    unlist()  -> var_num

  colMax <- function(data) sapply(data, max, na.rm = TRUE)
  colMin <- function(data) sapply(data, min, na.rm = TRUE)
  colMed <- function(data) sapply(data, median, na.rm = TRUE)

  if(identical(var_num, character(0))==F){
  cbind.data.frame(variable = var_num,
    mean = colMeans(df.2[var_num], na.rm = TRUE),
    median = colMed(df.2[var_num]),
    min = colMin(df.2[var_num]),
    max = colMax(df.2[var_num])) %>%

      dplyr::mutate(values = paste("Mean:", format(round(mean, 1), nsmall=1),
                                   "Median:", format(round(median, 1), nsmall=1),
                                   "Range:", format(round(min, 1), nsmall=1), "to", format(round(max, 1), nsmall=1))) %>%
    dplyr::select(variable, values) -> values_num}

  # Create date values
  dd.1 %>%
    dplyr::filter(class=="Date") %>%
    dplyr::select(variable) %>%
    unlist()   -> var_date


  if(identical(var_date, character(0))==F){
    cbind.data.frame(variable = var_date,
                     min = lubridate::ymd(as.Date(colMin(select(df.2, var_date)), origin=lubridate::origin)),
                     max = lubridate::ymd(as.Date(colMax(select(df.2, var_date)), origin=lubridate::origin))) %>%
      dplyr::mutate(values = paste("Range: ", min, "to", max)) %>%
      dplyr::select(variable, values) -> values_date}

  # Create logic values
  dd.1 %>%
    dplyr::filter(class=="logical") %>%
    dplyr::select(variable) %>%
    unlist()   -> var_logic

  colList <- function(data) sapply(data, function(x) c(x[1:10]))

  if(identical(var_logic, character(0))==F){

    df.2 %>%
      dplyr::select(var_logic) %>%
      colList() %>%
      tibble::as_tibble() %>%
      dplyr::summarise(variable = var_logic,
                       values = as.list(.)) %>%
      dplyr::mutate(values = as.character(values)) %>%
      dplyr::mutate(values = gsub("\\(|\\]","",values)) %>%
      dplyr::mutate(values = substr(values, 2, nchar(values))) %>%
      dplyr::mutate(values = gsub(')',"",values)) %>%
      dplyr::mutate(values = gsub(", NA","",values)) %>%

      select(variable, values) -> values_logic}

  # Create character values
  dd.1 %>%
    filter(class=="character"|class=="String") %>%
    dplyr::select(variable) %>%
    unlist()   -> var_char

  colUnique <- function(data) lapply(data, function(x) gsub(", NA", "",
                                                            paste0(length(unique(x)),
                                                                   " Unique: ",
                                                                   paste(sort(unique(x)[1:10]), collapse=", "))))

  if(identical(var_char, character(0))==F){

    df.2 %>%
      dplyr::select(var_char) %>%
      colUnique() %>%
      cbind(variable = var_char, .) %>%
      tibble::as_tibble()  %>%
      dplyr::mutate(variable = as.character(variable),
             values = as.character(.)) %>%
      dplyr::mutate(values = ifelse(stringr::str_split_fixed(values, " ", 2)[1]==(stringr::str_count(values, ",")+2),
                             paste0(values, ", NA"),
                             values)) %>%
      select(variable, values) -> values_char}

  # Create factor values
  dd.1 %>%
    filter(class=="factor"|class=="orderedfactor") %>%
    dplyr::select(variable) %>%
    unlist() %>%  as.vector() -> var_fact

  colLevels <- function(data) lapply(data, function(x) gsub(", NA", "", paste0(length(levels(x))," Levels: ", paste(levels(x)[1:10], collapse=", "))))

  if(identical(var_fact, character(0))==F){

    df.2 %>%
      dplyr::select(var_fact) %>%
      colLevels() %>%
      tibble::as.tibble() %>% t() %>% as.data.frame() %>%
      tibble::rownames_to_column(., var="variable") %>%
      dplyr::select(variable, values="V1") -> values_fact}

  df.values <- rbind.data.frame(values_fact,
                                values_char,
                                values_logic,
                                values_date,
                                values_num)

  dd.out <- merge.data.frame(dd.1, df.values, by="variable")

  dd.1 %>%
    dplyr::filter(variable %ni% dd.out$variable) -> dd_class

  if(nrow(dd_class)!=0){

    dd_class %>%
      dplyr::mutate(values = "Class not supported") -> dd_class

   dd.out <- rbind.data.frame(dd.out, dd_class)}

  dd.out %>%
    dplyr::mutate(variable = gdata::reorder.factor(variable, new.order=colnames(df.2))) %>%
    dplyr::arrange(variable) %>%
    dplyr::select(variable, class, values, na_pct) -> dd.out

  return(dd.out)}
