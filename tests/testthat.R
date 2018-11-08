Sys.setenv("R_TESTS" = "") # https://github.com/r-lib/testthat/issues/86
library(testthat)
library(collaborator)

test_check("collaborator")
