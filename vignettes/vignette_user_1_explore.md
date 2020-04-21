# Collaborator: Redcap User Management 1. Explore Current Users

Management of user rights in REDCap becomes increasingly laborious as
the scale of the research project expands (e.g. with the number of
users, and the number of data access groups).

However, while “role name” is an incredibly useful user management tool
within REDCap, this is not currently exportable alongside user rights
using the REDCap API. The following functions provide methods to count /
explore / apply user roles to exported REDCap user rights of a project.

## `user_role()`

Use `user_role()` to count the number of unique user “roles” within the
REDCap Project (e.g. the number of unique combinations of user rights).

The output from `user_role()` is a nested dataframe of:

**1). $full:** A dataframe of all user rights of the redcap project
(with an additional column called “role” which numbers users 1:n
according to their unique role).

``` r
# Example output from user_role()
# please note all names are randomly generated
user_role_out <- collaborator::user_role(redcap_project_uri = Sys.getenv("collaborator_test_uri"),
                                         redcap_project_token = Sys.getenv("collaborator_test_token"))

user_role_full <- user_role_out$full %>%
  dplyr::mutate(email = ifelse(username %in% c("eharrison", "kmclean"), "", email))

knitr::kable(user_role_full)
```

| role | username      | email                    | firstname | lastname   | expiration | data\_access\_group | data\_access\_group\_id | design | user\_rights | data\_access\_groups | data\_export | reports | stats\_and\_charts | manage\_survey\_participants | calendar | data\_import\_tool | data\_comparison\_tool | logging | file\_repository | data\_quality\_create | data\_quality\_execute | api\_export | api\_import | mobile\_app | mobile\_app\_download\_data | record\_create | record\_rename | record\_delete | lock\_records\_all\_forms | lock\_records | lock\_records\_customization | forms                           |
| ---: | :------------ | :----------------------- | :-------- | :--------- | :--------- | :------------------ | ----------------------: | -----: | -----------: | -------------------: | -----------: | ------: | -----------------: | ---------------------------: | -------: | -----------------: | ---------------------: | ------: | ---------------: | --------------------: | ---------------------: | ----------: | ----------: | ----------: | --------------------------: | -------------: | -------------: | -------------: | ------------------------: | ------------: | ---------------------------: | :------------------------------ |
|    1 | a\_barker     | <a_barker@email.com>     | Aleesha   | Barker     | NA         | hospital\_a         |                    4117 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | a\_hanna      | <a_hanna@email.com>      | Aleesha   | Hanna      | NA         | hospital\_d         |                    4120 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | a\_hicks      | <a_hicks@email.com>      | Alyssa    | Hicks      | NA         | hospital\_e         |                    4121 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | a\_lees       | <a_lees@email.com>       | Aleesha   | Lees       | NA         | hospital\_h         |                    4124 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | a\_nicholson  | <a_nicholson@email.com>  | Alyssa    | Nicholson  | NA         | hospital\_i         |                    4125 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | c\_avila      | <c_avila@email.com>      | Chanice   | Avila      | NA         | NA                  |                      NA |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | c\_gould      | <c_gould@email.com>      | Chanice   | Gould      | NA         | hospital\_b         |                    4118 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | c\_kent       | <c_kent@email.com>       | Chanice   | Kent       | NA         | hospital\_f         |                    4122 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | c\_michael    | <c_michael@email.com>    | Chanice   | Michael    | NA         | hospital\_h         |                    4124 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | f\_almond     | <f_almond@email.com>     | Fleur     | Almond     | NA         | NA                  |                      NA |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | f\_galindo    | <f_galindo@email.com>    | Fleur     | Galindo    | NA         | hospital\_a         |                    4117 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | f\_livingston | <f_livingston@email.com> | Fleur     | Livingston | NA         | hospital\_g         |                    4123 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | h\_herman     | <h_herman@email.com>     | Hailie    | Herman     | NA         | hospital\_d         |                    4120 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | h\_mustafa    | <h_mustafa@email.com>    | Hailie    | Mustafa    | NA         | hospital\_i         |                    4125 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | k\_ashton     | <k_ashton@email.com>     | Kester    | Ashton     | NA         | NA                  |                      NA |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | k\_gibbons    | <k_gibbons@email.com>    | Kester    | Gibbons    | NA         | hospital\_b         |                    4118 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | k\_marks      | <k_marks@email.com>      | Kester    | Marks      | NA         | hospital\_h         |                    4124 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | l\_cervantes  | <l_cervantes@email.com>  | Leroy     | Cervantes  | NA         | hospital\_a         |                    4117 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | l\_jensen     | <l_jensen@email.com>     | Leroy     | Jensen     | NA         | hospital\_e         |                    4121 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | l\_paine      | <l_paine@email.com>      | Leroy     | Paine      | NA         | hospital\_j         |                    4126 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | m\_owens      | <m_owens@email.com>      | Martha    | Owens      | NA         | hospital\_j         |                    4126 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | r\_bradford   | <r_bradford@email.com>   | Ralph     | Bradford   | NA         | hospital\_c         |                    4119 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | r\_hodge      | <r_hodge@email.com>      | Ralph     | Hodge      | NA         | hospital\_i         |                    4125 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | r\_ochoa      | <r_ochoa@email.com>      | Ralph     | Ochoa      | NA         | hospital\_i         |                    4125 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | s\_ayala      | <s_ayala@email.com>      | Samiha    | Ayala      | NA         | NA                  |                      NA |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | s\_beech      | <s_beech@email.com>      | Shanelle  | Beech      | NA         | hospital\_b         |                    4118 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | s\_hardy      | <s_hardy@email.com>      | Shanelle  | Hardy      | NA         | hospital\_e         |                    4121 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | s\_knights    | <s_knights@email.com>    | Samiha    | Knights    | NA         | hospital\_f         |                    4122 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | s\_moses      | <s_moses@email.com>      | Shanelle  | Moses      | NA         | hospital\_h         |                    4124 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | y\_andersen   | <y_andersen@email.com>   | Yaseen    | Andersen   | NA         | NA                  |                      NA |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | y\_cameron    | <y_cameron@email.com>    | Yara      | Cameron    | NA         | hospital\_d         |                    4120 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | y\_holder     | <y_holder@email.com>     | Yara      | Holder     | NA         | hospital\_e         |                    4121 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | y\_mackie     | <y_mackie@email.com>     | Yaseen    | Mackie     | NA         | hospital\_g         |                    4123 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | y\_o’doherty  | NA                       | NA        | NA         | NA         | hospital\_j         |                    4126 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | y\_odoherty   | <y_odoherty@email.com>   | Yara      | O’Doherty  | NA         | hospital\_j         |                    4126 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    2 | eharrison     |                          | Ewen      | Harrison   | NA         | NA                  |                      NA |      1 |            1 |                    1 |            1 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              1 |              1 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    3 | kmclean       |                          | Kenneth   | McLean     | NA         | NA                  |                      NA |      1 |            1 |                    1 |            1 |       1 |                  1 |                            1 |        1 |                  1 |                      1 |       1 |                1 |                     1 |                      1 |           1 |           1 |           1 |                           1 |              1 |              0 |              1 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |

**ii). $example:** A dataframe of each role (1:n) and an example
username with those rights (can be used as input for the `user_role()`
function).

``` r
user_role_example <- user_role_out$example

knitr::kable(user_role_example)
```

| role | username  |
| ---: | :-------- |
|    1 | a\_barker |
|    2 | eharrison |
|    3 | kmclean   |

The `user_role()$example` output (aka `user_role_example`) can be used
to apply user-friendly labels (instead of numbers) to the “role” column
in the `user_role()$full` output (aka `user_role_full`).

``` r
library(dplyr)
user_role_full <- user_role_full %>%
  # assign roles based on "username" (from inspecting `user_role()$example` output)
  dplyr::mutate(role = factor(role,
                              levels=c(1:max(role)),
                              labels=c("collaborator","validator", "administrator")))

knitr::kable(table(user_role_full$role))
```

| Var1          | Freq |
| :------------ | ---: |
| collaborator  |   35 |
| validator     |    1 |
| administrator |    1 |

#### Usage of `user_role()`

Use `user_role()` to apply named roles to all users according to example
users with those rights. E.g. In the example above, everyone with the
same user rights as the example collaborator “a\_barker” will be
assigned the “collaborator” role.

This allows further analyses to be done using roles which are not
currently possible within REDCap (e.g. tables, plots, etc), and can be
used to subsequently automatically upload and allocate user rights (see
[Redcap User Management: 2. Assign User
Rights](https://github.com/kamclean/collaborator/blob/master/vignettes/vignette_user_2_assign.md))

   

## `user_validate()`

Use `user_validate()` to explore the rights of current users, and
identify significant errors in assignment of user rights. This is a
useful tool whether user rights are allocated manually, or
[automatically](https://github.com/kamclean/collaborator/blob/master/vignettes/vignette_user_2_assign.Rmd).

The output from `user_validate()` is up to 5 nested dataframes (only
present if errors
exist):

``` r
user_validate_out <- collaborator::user_validate(redcap_project_uri = Sys.getenv("collaborator_test_uri"),
                                   redcap_project_token = Sys.getenv("collaborator_test_token"),
                                   df_user_master = collaborator::example_df_user, user_exclude = c("kmclean", "eharrison"))
```

### a). `$dag_unallocated`

Unallocated data access groups is a common error during manual
assignment of user rights. **In this case these users will be able to
access all records (within their form rights) in the REDCap project**.

``` r
knitr::kable(user_validate_out$dag_unallocated)
```

| username    | data\_access\_group |
| :---------- | :------------------ |
| c\_avila    | NA                  |
| f\_almond   | NA                  |
| k\_ashton   | NA                  |
| s\_ayala    | NA                  |
| y\_andersen | NA                  |

  - The `$dag_unallocated` output will highlight the individual users
    currently on REDCap with NA recorded for their DAG.

  - However, not all unallocated DAGS are “incorrect” - some users
    (e.g. administrators) may require to view any records on the
    project. It is recommended that in this case these users are
    excluded using `user_exclude`.

### b). `$dag_incorrect`

The incorrect allocation of data access groups is a common error during
manual assignment of user rights. **In this case these users will have
access to and be able to upload records within another DAG in the REDCap
project**.

  - This uses the `df_user_master` input (which must contain at least 2
    columns: `username` and `data_access_group`) and compares this to
    the current users on REDCap.

  - The `$dag_incorrect` output will highlight the individual users with
    discrepancies in the DAGs recorded so that these can be corrected.

  - However, not all discrepancies are “incorrect” - some users may be
    participating within multiple DAGs and so will be highlighted. It is
    recommended that in this case these users are either excluded using
    `user_exclude` or have separate usernames created for each DAG
    (recommended).

### c). `$user_toadd` and `$user_toremove`

Often in an ongoing project, there are users that are required to be
added or removed over time.

  - This uses the `df_user_master` input (which must contain at least 2
    columns: `username` and `data_access_group`) and compares this to
    the current users on REDCap to determine which users are missing
    from REDCap (`$user_toadd`) or missing from the `df_user_master`
    (`$user_toremove`).

### d). `$forms_na`

Unallocated form rights is a possible error during automatic assignment
of user rights. **In this case these users will have view and edit
rights to all forms (within their DAG) on the REDCap project**.

  - The `$forms_na` output will highlight the individual users currently
    on REDCap with NA recorded for their form rights (e.g. ability to
    access data collection instruments).

  - This can occur in the specific circumstance where REDCap user “Role
    Names” are being used, and the name of a data collection instrument
    is changed **after** the “role name” is created but **without**
    editing and saving the existing user role on REDCap. Once this role
    is confirmed with the changed names of the forms, this error should
    disappear.
