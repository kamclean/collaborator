# test_collaborator_all-------------------
library(collaborator)

# Test report_auth----------------------
test_out_report_auth1 <- "Almond S, Andersen J, Ashton A, Avila E, Ayala N, Barker S, Beech J, Berry A, Bowen P, Bradford J, Cameron G, Cantrell G, Carlson F, Carrillo J, Cervantes S, Chamberlain H, Chan K, Chung L, Clifford K, Conley M, Cullen F, Dalby D, Dean O, Dodson D, Downes A, Duffy L, Ellwood M, Erickson K, Fenton U, Ferry A, Finney R, Flores R, Fox B, Francis F, Frazier U, Fuentes A, Galindo C, Gardiner F, Gibbons H, Gould C, Halliday S, Hanna L, Hardy E, Herman K, Hicks A, Hodge M, Holder C, Hollis S, Houston M, Huff J, Jensen L, Kane K, Kearns U, Keenan L, Kent M, Knights G, Lees S, Lennon J, Livingston F, Mackie L, Marks H, Michael P, Mooney A, Morin Y, Moses S, Mustafa W, Nicholson L, Ochoa A, O'Doherty H, Olsen H, O'Neill L, Owens I, Paine R, Patrick S, Petty O, Phillips A, Pitt A, Plant N, Prosser E, Randolph T, Richmond S, Riddle C, Riggs M, Rojas E, Rossi P, Rowe P, Saunders R, Skinner I, Smart F, Stokes P, Villa Z, Wall R, Wardle A, Werner R, Whitfield A, Whitney M, William C, Woods B, Wynn J, Yang K."

testthat::test_that("report_auth produces list",
                    {testthat::expect_equal(capture.output(report_auth(data_author)),
                                            test_out_report_auth1)})

test_out_report_auth2 <- "Wales: Finney R + Frazier U + Paine R + Patrick S + Petty O + Villa Z [hospital R} -  Cantrell G + Huff J + Rowe P + Woods B + Yang K [hospital S}."

testthat::test_that("report_auth produces list",
                    {testthat::expect_equal(capture.output(report_auth(data_author,
                                                                       group="hospital", subdivision = "country",
                                                                       name_sep = " +", group_brachet = "[}",group_sep = " -"))[7],
                                            test_out_report_auth2)})

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
