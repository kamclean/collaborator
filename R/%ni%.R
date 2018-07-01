# %ni%-------------------------
# Description
#' Not %in% operator
#' @description The inverse function of %in% (e.g. selects all not in).

# Function:
`%ni%` <- function(x,y){
  '%ni%' <- Negate('%in%')
  return(x %ni% y)}
