# test_collaborator_all-------------------
library(collaborator)


# Test data_dict ----------------------
testthat::test_that("data_dict excludes variables",
                    {testthat::expect_equal(as.character(data_dict(collaborator::example_data_dict, var_exclude = c("id_num","sex"))$variable[8]),
                                            "op_procedure_code")})

testthat::test_that("data_dict check character",
                    {testthat::expect_equal(as.character(data_dict(collaborator::example_data_dict)$values[1]),
                                            "20 Unique: 1, 10, 2, 3, 4, 5, 6, 7, 8, 9")})

testthat::test_that("data_dict check numeric",
                    {testthat::expect_equal(as.character(data_dict(collaborator::example_data_dict)$values[2]),
                                            "Mean: 50.7 Median: 49.5 Range: 22.0 to 79.0")})

testthat::test_that("data_dict check factor",
                    {testthat::expect_equal(as.character(data_dict(collaborator::example_data_dict)$values[3]),
                                            "2 Levels: female, male")})

testthat::test_that("data_dict check Orderedfactor",
                    {testthat::expect_equal(as.character(data_dict(collaborator::example_data_dict)$values[4]),
                                            "5 Levels: I, II, III, IV, V")})

testthat::test_that("data_dict check logical",
                    {testthat::expect_equal(as.character(data_dict(collaborator::example_data_dict)$values[5]),
                                            "TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, TRUE, TRUE, FALSE, TRUE")})

testthat::test_that("data_dict check Date",
                    {testthat::expect_equal(as.character(data_dict(collaborator::example_data_dict)$values[7]),
                                            "Range:  2018-07-29 to 2018-08-11")})

testthat::test_that("data_dict check NA calculation",
                    {testthat::expect_equal(as.character(data_dict(collaborator::example_data_dict)$na_pct[11]),
                                            "45.0%")})

testthat::test_that("data_dict check NA calculation",
                    {testthat::expect_equal(as.character(data_dict(collaborator::example_data_dict)$na_pct[1]),
                                            " 0.0%")})
