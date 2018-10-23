Collaborator: Redcap User Management 1. Explore Current Users
=============================================================

Management of user rights in REDCap becomes increasingly laborious as
the scale of the research project expands (e.g. with the number of
users, and the number of data access groups).

However, while “role name” is an incredibly useful user management tool
within REDCap, this is not currently exportable alongside user rights
using the REDCap API. The following functions provide methods to count /
explore / apply user roles to exported REDCap user rights of a project.

`user_roles_n()`
----------------

Use `user_roles_n()` to count the number of unique user “roles” within
the REDCap Project (e.g. the number of unique combinations of user
rights).

There are 3 outputs from `user_roles_n()`:

**a). A string stating “There are n unique roles in this redcap
project”.**

**b). A nested dataframe of:**

**i). $full:** A dataframe of all user rights of the redcap project
(with an additional column called “role” which numbers users 1:n
according to their unique role).

    # Example output from user_roles_n()
    user_roles_n_full <- user_roles_n(redcap_project_uri, redcap_project_token)$full # please note all names are randomly generated

    ## [1] "There are 3 unique roles in this redcap project"

    user_roles_n_full

    ## # A tibble: 36 x 33
    ##     role username  email    firstname lastname expiration data_access_gro…
    ##    <int> <chr>     <chr>    <chr>     <chr>    <chr>      <chr>           
    ##  1     1 a_barker  a_barke… Aleesha   Barker   <NA>       hospital_a      
    ##  2     1 a_hicks   a_hicks… Alyssa    Hicks    <NA>       hospital_e      
    ##  3     1 a_lees    a_lees@… Aleesha   Lees     <NA>       hospital_g      
    ##  4     1 a_nichol… a_nicho… Alyssa    Nichols… <NA>       hospital_i      
    ##  5     1 c_avila   c_avila… Chanice   Avila    <NA>       <NA>            
    ##  6     1 c_gould   c_gould… Chanice   Gould    <NA>       hospital_b      
    ##  7     1 c_kent    c_kent@… Chanice   Kent     <NA>       hospital_f      
    ##  8     1 c_michael c_micha… Chanice   Michael  <NA>       hospital_h      
    ##  9     1 f_almond  f_almon… Fleur     Almond   <NA>       <NA>            
    ## 10     1 f_galindo f_galin… Fleur     Galindo  <NA>       hospital_a      
    ## # ... with 26 more rows, and 26 more variables:
    ## #   data_access_group_id <int>, design <int>, user_rights <int>,
    ## #   data_access_groups <int>, data_export <int>, reports <int>,
    ## #   stats_and_charts <int>, manage_survey_participants <int>,
    ## #   calendar <int>, data_import_tool <int>, data_comparison_tool <int>,
    ## #   logging <int>, file_repository <int>, data_quality_create <int>,
    ## #   data_quality_execute <int>, api_export <int>, api_import <int>,
    ## #   mobile_app <int>, mobile_app_download_data <int>, record_create <int>,
    ## #   record_rename <int>, record_delete <int>,
    ## #   lock_records_all_forms <int>, lock_records <int>,
    ## #   lock_records_customization <int>, forms <chr>

**ii). $examples:** A dataframe of each role (1:n) and an example
username with those rights (can be used as input for the `user_roles()`
function).

    user_roles_n_eg <- user_roles_n(redcap_project_uri, redcap_project_token)$examples

    ## [1] "There are 3 unique roles in this redcap project"

    user_roles_n_eg

    ## # A tibble: 3 x 2
    ##    role username
    ##   <int> <chr>   
    ## 1     1 a_barker
    ## 2     2 a_hanna 
    ## 3     3 kmclean

`user_roles()`
--------------

### a). Set-up input `role_users_example` dataframe

This can be created de novo, or the `user_roles_n()` $example output can
be used. It is recommended that user-friendly labels are applied instead
of the original numbering of unique roles.

    library(dplyr)
    user_role_examples <- user_roles_n_eg %>%
      dplyr::mutate(role = factor(role,
                           levels=c(1:nrow(.)),
                           labels=c("collaborator","validator", "administrator"))) %>%
      dplyr::mutate(role = as.character(role))

    user_role_examples

    ## # A tibble: 3 x 2
    ##   role          username
    ##   <chr>         <chr>   
    ## 1 collaborator  a_barker
    ## 2 validator     a_hanna 
    ## 3 administrator kmclean

### b). Usage of `user_roles()`

Use `user_roles()` to apply named roles to all users according to
example users with those rights. E.g. In the example above, everyone
with the same user rights as the example collaborator “a\_barker” will
be assigned the “collaborator” role.

    user_roles_full <- user_roles(redcap_project_uri, redcap_project_token, user_role_examples)
    user_roles_full

    ##             role     username                  email firstname   lastname
    ## 1  administrator      kmclean   mcleankaca@gmail.com   Kenneth     McLean
    ## 2   collaborator     a_barker     a_barker@email.com   Aleesha     Barker
    ## 3   collaborator     k_ashton     k_ashton@email.com    Kester     Ashton
    ## 4   collaborator      a_hicks      a_hicks@email.com    Alyssa      Hicks
    ## 5   collaborator       a_lees       a_lees@email.com   Aleesha       Lees
    ## 6   collaborator  a_nicholson  a_nicholson@email.com    Alyssa  Nicholson
    ## 7   collaborator      c_avila      c_avila@email.com   Chanice      Avila
    ## 8   collaborator      c_gould      c_gould@email.com   Chanice      Gould
    ## 9   collaborator       c_kent       c_kent@email.com   Chanice       Kent
    ## 10  collaborator    c_michael    c_michael@email.com   Chanice    Michael
    ## 11  collaborator     f_almond     f_almond@email.com     Fleur     Almond
    ## 12  collaborator    f_galindo    f_galindo@email.com     Fleur    Galindo
    ## 13  collaborator f_livingston f_livingston@email.com     Fleur Livingston
    ## 14  collaborator     h_herman     h_herman@email.com    Hailie     Herman
    ## 15  collaborator    h_mustafa    h_mustafa@email.com    Hailie    Mustafa
    ## 16  collaborator      s_hardy      s_hardy@email.com  Shanelle      Hardy
    ## 17  collaborator    k_gibbons    k_gibbons@email.com    Kester    Gibbons
    ## 18  collaborator      k_marks      k_marks@email.com    Kester      Marks
    ## 19  collaborator   y_andersen   y_andersen@email.com    Yaseen   Andersen
    ## 20  collaborator  l_cervantes  l_cervantes@email.com     Leroy  Cervantes
    ## 21  collaborator     l_jensen     l_jensen@email.com     Leroy     Jensen
    ## 22  collaborator      l_paine      l_paine@email.com     Leroy      Paine
    ## 23  collaborator      m_owens      m_owens@email.com    Martha      Owens
    ## 24  collaborator   r_bradford   r_bradford@email.com     Ralph   Bradford
    ## 25  collaborator      r_hodge      r_hodge@email.com     Ralph      Hodge
    ## 26  collaborator      r_ochoa      r_ochoa@email.com     Ralph      Ochoa
    ## 27  collaborator      s_ayala      s_ayala@email.com    Samiha      Ayala
    ## 28  collaborator      s_beech      s_beech@email.com  Shanelle      Beech
    ## 29  collaborator   y_odoherty   y_odoherty@email.com      Yara  O'Doherty
    ## 30  collaborator     y_holder     y_holder@email.com      Yara     Holder
    ## 31  collaborator      s_moses      s_moses@email.com  Shanelle      Moses
    ## 32  collaborator  y_o'doherty                   <NA>      <NA>       <NA>
    ## 33  collaborator     y_mackie     y_mackie@email.com    Yaseen     Mackie
    ## 34     validator      a_hanna      a_hanna@email.com   Aleesha      Hanna
    ## 35     validator    s_knights    s_knights@email.com    Samiha    Knights
    ## 36     validator    y_cameron    y_cameron@email.com      Yara    Cameron
    ##    expiration data_access_group data_access_group_id design user_rights
    ## 1        <NA>              <NA>                   NA      1           1
    ## 2        <NA>        hospital_a                 4117      0           0
    ## 3        <NA>              <NA>                   NA      0           0
    ## 4        <NA>        hospital_e                 4121      0           0
    ## 5        <NA>        hospital_g                 4123      0           0
    ## 6        <NA>        hospital_i                 4125      0           0
    ## 7        <NA>              <NA>                   NA      0           0
    ## 8        <NA>        hospital_b                 4118      0           0
    ## 9        <NA>        hospital_f                 4122      0           0
    ## 10       <NA>        hospital_h                 4124      0           0
    ## 11       <NA>              <NA>                   NA      0           0
    ## 12       <NA>        hospital_a                 4117      0           0
    ## 13       <NA>        hospital_g                 4123      0           0
    ## 14       <NA>        hospital_d                 4120      0           0
    ## 15       <NA>        hospital_i                 4125      0           0
    ## 16       <NA>        hospital_d                 4120      0           0
    ## 17       <NA>        hospital_b                 4118      0           0
    ## 18       <NA>        hospital_h                 4124      0           0
    ## 19       <NA>              <NA>                   NA      0           0
    ## 20       <NA>        hospital_a                 4117      0           0
    ## 21       <NA>        hospital_e                 4121      0           0
    ## 22       <NA>        hospital_j                 4126      0           0
    ## 23       <NA>        hospital_j                 4126      0           0
    ## 24       <NA>        hospital_c                 4119      0           0
    ## 25       <NA>        hospital_f                 4122      0           0
    ## 26       <NA>        hospital_i                 4125      0           0
    ## 27       <NA>              <NA>                   NA      0           0
    ## 28       <NA>        hospital_b                 4118      0           0
    ## 29       <NA>        hospital_j                 4126      0           0
    ## 30       <NA>        hospital_e                 4121      0           0
    ## 31       <NA>        hospital_h                 4124      0           0
    ## 32       <NA>        hospital_j                 4126      0           0
    ## 33       <NA>        hospital_g                 4123      0           0
    ## 34       <NA>        hospital_d                 4120      0           0
    ## 35       <NA>        hospital_f                 4122      0           0
    ## 36       <NA>        hospital_c                 4119      0           0
    ##    data_access_groups data_export reports stats_and_charts
    ## 1                   1           1       1                1
    ## 2                   0           2       1                1
    ## 3                   0           2       1                1
    ## 4                   0           2       1                1
    ## 5                   0           2       1                1
    ## 6                   0           2       1                1
    ## 7                   0           2       1                1
    ## 8                   0           2       1                1
    ## 9                   0           2       1                1
    ## 10                  0           2       1                1
    ## 11                  0           2       1                1
    ## 12                  0           2       1                1
    ## 13                  0           2       1                1
    ## 14                  0           2       1                1
    ## 15                  0           2       1                1
    ## 16                  0           2       1                1
    ## 17                  0           2       1                1
    ## 18                  0           2       1                1
    ## 19                  0           2       1                1
    ## 20                  0           2       1                1
    ## 21                  0           2       1                1
    ## 22                  0           2       1                1
    ## 23                  0           2       1                1
    ## 24                  0           2       1                1
    ## 25                  0           2       1                1
    ## 26                  0           2       1                1
    ## 27                  0           2       1                1
    ## 28                  0           2       1                1
    ## 29                  0           2       1                1
    ## 30                  0           2       1                1
    ## 31                  0           2       1                1
    ## 32                  0           2       1                1
    ## 33                  0           2       1                1
    ## 34                  0           2       1                1
    ## 35                  0           2       1                1
    ## 36                  0           2       1                1
    ##    manage_survey_participants calendar data_import_tool
    ## 1                           1        1                1
    ## 2                           1        1                0
    ## 3                           1        1                0
    ## 4                           1        1                0
    ## 5                           1        1                0
    ## 6                           1        1                0
    ## 7                           1        1                0
    ## 8                           1        1                0
    ## 9                           1        1                0
    ## 10                          1        1                0
    ## 11                          1        1                0
    ## 12                          1        1                0
    ## 13                          1        1                0
    ## 14                          1        1                0
    ## 15                          1        1                0
    ## 16                          1        1                0
    ## 17                          1        1                0
    ## 18                          1        1                0
    ## 19                          1        1                0
    ## 20                          1        1                0
    ## 21                          1        1                0
    ## 22                          1        1                0
    ## 23                          1        1                0
    ## 24                          1        1                0
    ## 25                          1        1                0
    ## 26                          1        1                0
    ## 27                          1        1                0
    ## 28                          1        1                0
    ## 29                          1        1                0
    ## 30                          1        1                0
    ## 31                          1        1                0
    ## 32                          1        1                0
    ## 33                          1        1                0
    ## 34                          1        1                0
    ## 35                          1        1                0
    ## 36                          1        1                0
    ##    data_comparison_tool logging file_repository data_quality_create
    ## 1                     1       1               1                   1
    ## 2                     0       0               1                   0
    ## 3                     0       0               1                   0
    ## 4                     0       0               1                   0
    ## 5                     0       0               1                   0
    ## 6                     0       0               1                   0
    ## 7                     0       0               1                   0
    ## 8                     0       0               1                   0
    ## 9                     0       0               1                   0
    ## 10                    0       0               1                   0
    ## 11                    0       0               1                   0
    ## 12                    0       0               1                   0
    ## 13                    0       0               1                   0
    ## 14                    0       0               1                   0
    ## 15                    0       0               1                   0
    ## 16                    0       0               1                   0
    ## 17                    0       0               1                   0
    ## 18                    0       0               1                   0
    ## 19                    0       0               1                   0
    ## 20                    0       0               1                   0
    ## 21                    0       0               1                   0
    ## 22                    0       0               1                   0
    ## 23                    0       0               1                   0
    ## 24                    0       0               1                   0
    ## 25                    0       0               1                   0
    ## 26                    0       0               1                   0
    ## 27                    0       0               1                   0
    ## 28                    0       0               1                   0
    ## 29                    0       0               1                   0
    ## 30                    0       0               1                   0
    ## 31                    0       0               1                   0
    ## 32                    0       0               1                   0
    ## 33                    0       0               1                   0
    ## 34                    0       0               1                   0
    ## 35                    0       0               1                   0
    ## 36                    0       0               1                   0
    ##    data_quality_execute api_export api_import mobile_app
    ## 1                     1          1          1          1
    ## 2                     0          0          0          0
    ## 3                     0          0          0          0
    ## 4                     0          0          0          0
    ## 5                     0          0          0          0
    ## 6                     0          0          0          0
    ## 7                     0          0          0          0
    ## 8                     0          0          0          0
    ## 9                     0          0          0          0
    ## 10                    0          0          0          0
    ## 11                    0          0          0          0
    ## 12                    0          0          0          0
    ## 13                    0          0          0          0
    ## 14                    0          0          0          0
    ## 15                    0          0          0          0
    ## 16                    0          0          0          0
    ## 17                    0          0          0          0
    ## 18                    0          0          0          0
    ## 19                    0          0          0          0
    ## 20                    0          0          0          0
    ## 21                    0          0          0          0
    ## 22                    0          0          0          0
    ## 23                    0          0          0          0
    ## 24                    0          0          0          0
    ## 25                    0          0          0          0
    ## 26                    0          0          0          0
    ## 27                    0          0          0          0
    ## 28                    0          0          0          0
    ## 29                    0          0          0          0
    ## 30                    0          0          0          0
    ## 31                    0          0          0          0
    ## 32                    0          0          0          0
    ## 33                    0          0          0          0
    ## 34                    0          0          0          0
    ## 35                    0          0          0          0
    ## 36                    0          0          0          0
    ##    mobile_app_download_data record_create record_rename record_delete
    ## 1                         1             1             0             0
    ## 2                         0             1             0             0
    ## 3                         0             1             0             0
    ## 4                         0             1             0             0
    ## 5                         0             1             0             0
    ## 6                         0             1             0             0
    ## 7                         0             1             0             0
    ## 8                         0             1             0             0
    ## 9                         0             1             0             0
    ## 10                        0             1             0             0
    ## 11                        0             1             0             0
    ## 12                        0             1             0             0
    ## 13                        0             1             0             0
    ## 14                        0             1             0             0
    ## 15                        0             1             0             0
    ## 16                        0             1             0             0
    ## 17                        0             1             0             0
    ## 18                        0             1             0             0
    ## 19                        0             1             0             0
    ## 20                        0             1             0             0
    ## 21                        0             1             0             0
    ## 22                        0             1             0             0
    ## 23                        0             1             0             0
    ## 24                        0             1             0             0
    ## 25                        0             1             0             0
    ## 26                        0             1             0             0
    ## 27                        0             1             0             0
    ## 28                        0             1             0             0
    ## 29                        0             1             0             0
    ## 30                        0             1             0             0
    ## 31                        0             1             0             0
    ## 32                        0             1             0             0
    ## 33                        0             1             0             0
    ## 34                        0             0             0             0
    ## 35                        0             0             0             0
    ## 36                        0             0             0             0
    ##    lock_records_all_forms lock_records lock_records_customization
    ## 1                       0            0                          0
    ## 2                       0            0                          0
    ## 3                       0            0                          0
    ## 4                       0            0                          0
    ## 5                       0            0                          0
    ## 6                       0            0                          0
    ## 7                       0            0                          0
    ## 8                       0            0                          0
    ## 9                       0            0                          0
    ## 10                      0            0                          0
    ## 11                      0            0                          0
    ## 12                      0            0                          0
    ## 13                      0            0                          0
    ## 14                      0            0                          0
    ## 15                      0            0                          0
    ## 16                      0            0                          0
    ## 17                      0            0                          0
    ## 18                      0            0                          0
    ## 19                      0            0                          0
    ## 20                      0            0                          0
    ## 21                      0            0                          0
    ## 22                      0            0                          0
    ## 23                      0            0                          0
    ## 24                      0            0                          0
    ## 25                      0            0                          0
    ## 26                      0            0                          0
    ## 27                      0            0                          0
    ## 28                      0            0                          0
    ## 29                      0            0                          0
    ## 30                      0            0                          0
    ## 31                      0            0                          0
    ## 32                      0            0                          0
    ## 33                      0            0                          0
    ## 34                      0            0                          0
    ## 35                      0            0                          0
    ## 36                      0            0                          0
    ##             forms
    ## 1  example_data:1
    ## 2  example_data:1
    ## 3  example_data:1
    ## 4  example_data:1
    ## 5  example_data:1
    ## 6  example_data:1
    ## 7  example_data:1
    ## 8  example_data:1
    ## 9  example_data:1
    ## 10 example_data:1
    ## 11 example_data:1
    ## 12 example_data:1
    ## 13 example_data:1
    ## 14 example_data:1
    ## 15 example_data:1
    ## 16 example_data:1
    ## 17 example_data:1
    ## 18 example_data:1
    ## 19 example_data:1
    ## 20 example_data:1
    ## 21 example_data:1
    ## 22 example_data:1
    ## 23 example_data:1
    ## 24 example_data:1
    ## 25 example_data:1
    ## 26 example_data:1
    ## 27 example_data:1
    ## 28 example_data:1
    ## 29 example_data:1
    ## 30 example_data:1
    ## 31 example_data:1
    ## 32 example_data:1
    ## 33 example_data:1
    ## 34 example_data:2
    ## 35 example_data:2
    ## 36 example_data:2

This allows further analyses to be done using roles which are not
currently possible within REDCap (e.g. tables, plots, etc), and can be
used to subsequently automatically upload and allocate user rights (see
[Redcap User Management: 2. Assign User
Rights](https://github.com/kamclean/collaborator/blob/master/vignettes/vignette_user_2_assign.Rmd))

    table(user_roles_full$role)

    ## 
    ## administrator  collaborator     validator 
    ##             1            32             3

`user_validate()`
-----------------

Use `user_validate()` to explore the rights of current users, and
identify significant errors in assignment of user rights. This is a
useful tool whether user rights are allocated manually, or
[automatically](https://github.com/kamclean/collaborator/blob/master/vignettes/vignette_user_2_assign.Rmd).

The output from `user_validate()` is 3 nested dataframes:

    user_validate_out <- user_validate(redcap_project_uri, redcap_project_token,
                  users.df = collaborator::example_df_user, users_exception = c("kmclean"))

### a). `$dag_unallocated`

Unallocated data access groups is a common error during manual
assignment of user rights. **In this case these users will be able to
access all records (within their form rights) in the REDCap project**.

    user_validate_out$dag_unallocated

    ## # A tibble: 5 x 2
    ##   username   data_access_group
    ##   <chr>      <chr>            
    ## 1 c_avila    <NA>             
    ## 2 f_almond   <NA>             
    ## 3 k_ashton   <NA>             
    ## 4 s_ayala    <NA>             
    ## 5 y_andersen <NA>

-   The `$dag_unallocated` output will highlight the individual users
    currently on REDCap with NA recorded for their DAG.

-   However, not all unallocated DAGS are “incorrect” - some users
    (e.g. administrators) may require to view any records on the
    project. It is recommended that in this case these users are
    excluded using `users_exception`.

### b). `$dag_incorrect`

The incorrect allocation of data access groups is a common error during
manual assignment of user rights. **In this case these users will have
access to and be able to upload records within another DAG in the REDCap
project**.

    user_validate_out$dag_incorrect

    ## # A tibble: 4 x 3
    ##   username  DAG_user_new DAG_user_current
    ##   <chr>     <chr>        <chr>           
    ## 1 a_lees    hospital_h   hospital_g      
    ## 2 r_hodge   hospital_i   hospital_f      
    ## 3 s_hardy   hospital_e   hospital_d      
    ## 4 y_cameron hospital_d   hospital_c

-   This uses the `users.df` input (which must contain at least 2
    columns: `username` and `data_access_group`) and compares this to
    the current users on REDCap.

-   The `$dag_incorrect` output will highlight the individual users with
    discrepancies in the DAGs recorded so that these can be corrected.

-   However, not all discrepancies are “incorrect” - some users may be
    participating within multiple DAGs and so will be highlighted. It is
    recommended that in this case these users are either excluded using
    `users_exception` or have separate usernames created for each DAG
    (recommended).

### c). `$forms_na`

Unallocated form rights is a possible error during automatic assignment
of user rights. **In this case these users will have view and edit
rights to all forms (within their DAG) on the REDCap project**.

    user_validate_out$forms_na

    ## # A tibble: 0 x 3
    ## # ... with 3 variables: username <chr>, data_access_group <chr>,
    ## #   forms <chr>

-   The `$forms_na` output will highlight the individual users currently
    on REDCap with NA recorded for their form rights (e.g. ability to
    access data collection instruments).

-   This can occur in the specific circumstance where REDCap user “role
    names” are being used, and the name of a data collection instrument
    is changed **after** the “role name” is created but **without**
    editing and saving the existing user role on REDCap. Once this role
    is confirmed with the changed names of the forms, this error should
    disappear.
