# %ni%-------------------------
# Use: the inverse function of %in% (e.g. selects all not in)
"%ni%" <- function(x, y) {
  "%ni%" <- Negate("%in%")
  x %ni% y}
