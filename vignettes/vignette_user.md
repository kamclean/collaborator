# Collaborator: Redcap User Management

Management of user rights in REDCap becomes increasingly laborious as
the scale of the research project expands (e.g. with the number of
users, and the number of data access groups). Here are a series of
functions to understand and manage users on a project

For a user to be able to use a REDCap project, there are two
prerequisites they must have:

1.  **User account** - This username allows the user to log onto the
    REDCap instance.

2.  **User rights** - This is required to access a specific REDCap
    project, and determines the capabilities the user has (e.g. to
    access certain forms, to be restricted to a specific data access
    group, to import/export data, etc)

## Create REDCap Accounts

REDCap user accounts cannot be generated via R at present, and need to
be manually uploaded at present (however there is capability to bulk
upload via a csv file). This function can be used to generate the csv
file in the exact format required for direct upload via the control
centre.

It requires a dataframe of at least 4 mandatory columns (corresponding
to: username, first name, last name, and email address) and 4 optional
columns (corresponding to: institution, sponsor, expiration, comments).
All optional columns will be blank unless otherwise specified.

    library(collaborator);library(dplyr)

    # Create example of new users output from user_role()
    collaborator::user_role(redcap_project_uri = Sys.getenv("collaborator_test_uri"),
                            redcap_project_token = Sys.getenv("collaborator_test_token"),
                            remove_id = F)$all %>%
      dplyr::filter(role_name=="collaborator") %>% head(10) %>%
      dplyr::select(username, email, firstname, lastname, data_access_group) %>%
      
      # Format these new users to allow account creation
      collaborator::user_import(username = "username", first_name = "firstname", last_name = "lastname",
                                email = "email", institution = "data_access_group") %>%
      
      knitr::kable()

<table>
<colgroup>
<col style="width: 11%" />
<col style="width: 10%" />
<col style="width: 9%" />
<col style="width: 20%" />
<col style="width: 14%" />
<col style="width: 15%" />
<col style="width: 10%" />
<col style="width: 8%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;">Username</th>
<th style="text-align: left;">First name</th>
<th style="text-align: left;">Last name</th>
<th style="text-align: left;">Email address</th>
<th style="text-align: left;">Institution ID</th>
<th style="text-align: left;">Sponsor username</th>
<th style="text-align: left;">Expiration</th>
<th style="text-align: left;">Comments</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">a_barker</td>
<td style="text-align: left;">Aleesha</td>
<td style="text-align: left;">Barker</td>
<td style="text-align: left;"><a href="mailto:a_barker@email.com"
class="email">a_barker@email.com</a></td>
<td style="text-align: left;">hospital_a</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">a_hanna</td>
<td style="text-align: left;">Aleesha</td>
<td style="text-align: left;">Hanna</td>
<td style="text-align: left;"><a href="mailto:a_hanna@email.com"
class="email">a_hanna@email.com</a></td>
<td style="text-align: left;">hospital_d</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">a_hicks</td>
<td style="text-align: left;">Alyssa</td>
<td style="text-align: left;">Hicks</td>
<td style="text-align: left;"><a href="mailto:a_hicks@email.com"
class="email">a_hicks@email.com</a></td>
<td style="text-align: left;">hospital_e</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">a_lees</td>
<td style="text-align: left;">Aleesha</td>
<td style="text-align: left;">Lees</td>
<td style="text-align: left;"><a href="mailto:a_lees@email.com"
class="email">a_lees@email.com</a></td>
<td style="text-align: left;">hospital_h</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">a_nicholson</td>
<td style="text-align: left;">Alyssa</td>
<td style="text-align: left;">Nicholson</td>
<td style="text-align: left;"><a href="mailto:a_nicholson@email.com"
class="email">a_nicholson@email.com</a></td>
<td style="text-align: left;">hospital_i</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">c_avila</td>
<td style="text-align: left;">Chanice</td>
<td style="text-align: left;">Avila</td>
<td style="text-align: left;"><a href="mailto:c_avila@email.com"
class="email">c_avila@email.com</a></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">c_gould</td>
<td style="text-align: left;">Chanice</td>
<td style="text-align: left;">Gould</td>
<td style="text-align: left;"><a href="mailto:c_gould@email.com"
class="email">c_gould@email.com</a></td>
<td style="text-align: left;">hospital_b</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">c_kent</td>
<td style="text-align: left;">Chanice</td>
<td style="text-align: left;">Kent</td>
<td style="text-align: left;"><a href="mailto:c_kent@email.com"
class="email">c_kent@email.com</a></td>
<td style="text-align: left;">hospital_f</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">c_michael</td>
<td style="text-align: left;">Chanice</td>
<td style="text-align: left;">Michael</td>
<td style="text-align: left;"><a href="mailto:c_michael@email.com"
class="email">c_michael@email.com</a></td>
<td style="text-align: left;">hospital_h</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">f_almond</td>
<td style="text-align: left;">Fleur</td>
<td style="text-align: left;">Almond</td>
<td style="text-align: left;"><a href="mailto:f_almond@email.com"
class="email">f_almond@email.com</a></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
</tbody>
</table>

## View Project Users and Data Access Groups (DAGs)

Use `user_role()` to count the number of unique user “roles” within the
REDCap Project (e.g. the number of unique combinations of user rights).
The users without an allocated data access group or role will be listed
as `NA`. Please note those without an assigned role will have the
minimum user righst by default, but those without an assigned data
access group will have access to ALL data on the project.

The output from `user_role()` is a nested dataframe of:

**1). $all:** A dataframe of all users and their allocated role on the
redcap project.

-   By default the user name and emails are not provided (however this
    can be by changing “remove\_id” to FALSE)

<!-- -->

    # Example output from user_role()
    # please note all names are randomly generated
    user_role <- collaborator::user_role(redcap_project_uri = Sys.getenv("collaborator_test_uri"),
                                         redcap_project_token = Sys.getenv("collaborator_test_token"))

    knitr::kable(user_role$all)

<table>
<colgroup>
<col style="width: 16%" />
<col style="width: 16%" />
<col style="width: 16%" />
<col style="width: 23%" />
<col style="width: 26%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;">role_name</th>
<th style="text-align: left;">role_id</th>
<th style="text-align: left;">username</th>
<th style="text-align: left;">data_access_group</th>
<th style="text-align: right;">data_access_group_id</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">admin</td>
<td style="text-align: left;">U-82337CEWAF</td>
<td style="text-align: left;">kmclean</td>
<td style="text-align: left;">NA</td>
<td style="text-align: right;">NA</td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">a_barker</td>
<td style="text-align: left;">hospital_a</td>
<td style="text-align: right;">4117</td>
</tr>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">a_hanna</td>
<td style="text-align: left;">hospital_d</td>
<td style="text-align: right;">4120</td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">a_hicks</td>
<td style="text-align: left;">hospital_e</td>
<td style="text-align: right;">4121</td>
</tr>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">a_lees</td>
<td style="text-align: left;">hospital_h</td>
<td style="text-align: right;">4124</td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">a_nicholson</td>
<td style="text-align: left;">hospital_i</td>
<td style="text-align: right;">4125</td>
</tr>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">c_avila</td>
<td style="text-align: left;">NA</td>
<td style="text-align: right;">NA</td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">c_gould</td>
<td style="text-align: left;">hospital_b</td>
<td style="text-align: right;">4118</td>
</tr>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">c_kent</td>
<td style="text-align: left;">hospital_f</td>
<td style="text-align: right;">4122</td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">c_michael</td>
<td style="text-align: left;">hospital_h</td>
<td style="text-align: right;">4124</td>
</tr>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">f_almond</td>
<td style="text-align: left;">NA</td>
<td style="text-align: right;">NA</td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">f_galindo</td>
<td style="text-align: left;">hospital_a</td>
<td style="text-align: right;">4117</td>
</tr>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">f_livingston</td>
<td style="text-align: left;">hospital_g</td>
<td style="text-align: right;">4123</td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">h_herman</td>
<td style="text-align: left;">hospital_d</td>
<td style="text-align: right;">4120</td>
</tr>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">h_mustafa</td>
<td style="text-align: left;">hospital_i</td>
<td style="text-align: right;">4125</td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">k_ashton</td>
<td style="text-align: left;">NA</td>
<td style="text-align: right;">NA</td>
</tr>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">k_gibbons</td>
<td style="text-align: left;">hospital_b</td>
<td style="text-align: right;">4118</td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">k_marks</td>
<td style="text-align: left;">hospital_h</td>
<td style="text-align: right;">4124</td>
</tr>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">l_cervantes</td>
<td style="text-align: left;">hospital_a</td>
<td style="text-align: right;">4117</td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">l_jensen</td>
<td style="text-align: left;">hospital_e</td>
<td style="text-align: right;">4121</td>
</tr>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">l_paine</td>
<td style="text-align: left;">hospital_j</td>
<td style="text-align: right;">4126</td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">m_owens</td>
<td style="text-align: left;">hospital_j</td>
<td style="text-align: right;">4126</td>
</tr>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">r_bradford</td>
<td style="text-align: left;">hospital_c</td>
<td style="text-align: right;">4119</td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">r_hodge</td>
<td style="text-align: left;">hospital_i</td>
<td style="text-align: right;">4125</td>
</tr>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">r_ochoa</td>
<td style="text-align: left;">hospital_i</td>
<td style="text-align: right;">4125</td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">s_ayala</td>
<td style="text-align: left;">NA</td>
<td style="text-align: right;">NA</td>
</tr>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">s_beech</td>
<td style="text-align: left;">hospital_b</td>
<td style="text-align: right;">4118</td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">s_hardy</td>
<td style="text-align: left;">hospital_e</td>
<td style="text-align: right;">4121</td>
</tr>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">s_knights</td>
<td style="text-align: left;">hospital_f</td>
<td style="text-align: right;">4122</td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">s_moses</td>
<td style="text-align: left;">hospital_h</td>
<td style="text-align: right;">4124</td>
</tr>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">tdrake</td>
<td style="text-align: left;">hospital_d</td>
<td style="text-align: right;">4120</td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">y_andersen</td>
<td style="text-align: left;">NA</td>
<td style="text-align: right;">NA</td>
</tr>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">y_cameron</td>
<td style="text-align: left;">hospital_d</td>
<td style="text-align: right;">4120</td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">y_holder</td>
<td style="text-align: left;">hospital_e</td>
<td style="text-align: right;">4121</td>
</tr>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">y_mackie</td>
<td style="text-align: left;">hospital_g</td>
<td style="text-align: right;">4123</td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: left;">y_odoherty</td>
<td style="text-align: left;">hospital_j</td>
<td style="text-align: right;">4126</td>
</tr>
<tr class="odd">
<td style="text-align: left;">manager</td>
<td style="text-align: left;">U-591P8EWTJY</td>
<td style="text-align: left;">eharrison</td>
<td style="text-align: left;">hospital_c</td>
<td style="text-align: right;">4119</td>
</tr>
</tbody>
</table>

**ii). $sum:** A dataframe of each role on REDCap, alongside the total
and list of usernames with those rights. These can be used in later
functions to assign or change user roles.

-   By default the exact rights these roles have are not shown (however
    this can be by changing “show\_rights” to TRUE)

<!-- -->

    knitr::kable(user_role$sum)

<table>
<colgroup>
<col style="width: 2%" />
<col style="width: 2%" />
<col style="width: 0%" />
<col style="width: 94%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;">role_name</th>
<th style="text-align: left;">role_id</th>
<th style="text-align: right;">n</th>
<th style="text-align: left;">username</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">admin</td>
<td style="text-align: left;">U-82337CEWAF</td>
<td style="text-align: right;">1</td>
<td style="text-align: left;">kmclean</td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">U-3319YWM9ND</td>
<td style="text-align: right;">35</td>
<td style="text-align: left;">a_barker , a_hanna , a_hicks , a_lees ,
a_nicholson , c_avila , c_gould , c_kent , c_michael , f_almond ,
f_galindo , f_livingston, h_herman , h_mustafa , k_ashton , k_gibbons ,
k_marks , l_cervantes , l_jensen , l_paine , m_owens , r_bradford ,
r_hodge , r_ochoa , s_ayala , s_beech , s_hardy , s_knights , s_moses ,
tdrake , y_andersen , y_cameron , y_holder , y_mackie , y_odoherty</td>
</tr>
<tr class="odd">
<td style="text-align: left;">manager</td>
<td style="text-align: left;">U-591P8EWTJY</td>
<td style="text-align: right;">1</td>
<td style="text-align: left;">eharrison</td>
</tr>
</tbody>
</table>

## Manage Project Data Access Groups (DAGs) and Project Users

The automatic management of users and data access groups (DAGs) has
several important advantages over the manual method:

-   Once set-up, it involves a fraction of the time and labour (compared
    to doing so manually), and can be easily repeated using R. This
    enables multicentre research using REDCap to become easily scalable
    irrespective of the number of users and number of data access
    groups.

-   It significantly reduces allocation errors (e.g. users being
    allocated to incorrect DAGs).

### `dag_manage()`

Effective management of DAGs is essential to ensure access to data is
restricted to only appropriate users - this can be done using
`dag_manage()`.

If you simply want to view the current DAGs on the project, just enter
the URL and TOKEN. However, if you wish to add or remove DAGs, use the
`import` and `remove` arguments. **It is highly recommended you keep the
DAG name limited to 18 characters, with no special characters or spaces
to avoid issues with duplicate or altered DAG names on the REDCap
project**.

-   When importing, the “data\_access\_group\_name” will be the DAG
    imported, and “unique\_group\_name” the automatically generated
    REDCap name.

<!-- -->

    dag_manage(redcap_project_uri = Sys.getenv("collaborator_test_uri"),
               redcap_project_token = Sys.getenv("collaborator_test_token"),
               import = "hospital_n", remove = "hospital_w") %>%
      knitr::kable()

    ## Loading required package: tibble

<table>
<colgroup>
<col style="width: 24%" />
<col style="width: 19%" />
<col style="width: 24%" />
<col style="width: 24%" />
<col style="width: 7%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;">data_access_group_name</th>
<th style="text-align: left;">unique_group_name</th>
<th style="text-align: right;">data_access_group_id.x</th>
<th style="text-align: right;">data_access_group_id.y</th>
<th style="text-align: left;">status</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">hospital m</td>
<td style="text-align: left;">hospital_m</td>
<td style="text-align: right;">4664</td>
<td style="text-align: right;">4664</td>
<td style="text-align: left;">-</td>
</tr>
<tr class="even">
<td style="text-align: left;">hospital_a</td>
<td style="text-align: left;">hospital_a</td>
<td style="text-align: right;">4117</td>
<td style="text-align: right;">4117</td>
<td style="text-align: left;">-</td>
</tr>
<tr class="odd">
<td style="text-align: left;">hospital_b</td>
<td style="text-align: left;">hospital_b</td>
<td style="text-align: right;">4118</td>
<td style="text-align: right;">4118</td>
<td style="text-align: left;">-</td>
</tr>
<tr class="even">
<td style="text-align: left;">hospital_c</td>
<td style="text-align: left;">hospital_c</td>
<td style="text-align: right;">4119</td>
<td style="text-align: right;">4119</td>
<td style="text-align: left;">-</td>
</tr>
<tr class="odd">
<td style="text-align: left;">hospital_d</td>
<td style="text-align: left;">hospital_d</td>
<td style="text-align: right;">4120</td>
<td style="text-align: right;">4120</td>
<td style="text-align: left;">-</td>
</tr>
<tr class="even">
<td style="text-align: left;">hospital_e</td>
<td style="text-align: left;">hospital_e</td>
<td style="text-align: right;">4121</td>
<td style="text-align: right;">4121</td>
<td style="text-align: left;">-</td>
</tr>
<tr class="odd">
<td style="text-align: left;">hospital_f</td>
<td style="text-align: left;">hospital_f</td>
<td style="text-align: right;">4122</td>
<td style="text-align: right;">4122</td>
<td style="text-align: left;">-</td>
</tr>
<tr class="even">
<td style="text-align: left;">hospital_g</td>
<td style="text-align: left;">hospital_g</td>
<td style="text-align: right;">4123</td>
<td style="text-align: right;">4123</td>
<td style="text-align: left;">-</td>
</tr>
<tr class="odd">
<td style="text-align: left;">hospital_h</td>
<td style="text-align: left;">hospital_h</td>
<td style="text-align: right;">4124</td>
<td style="text-align: right;">4124</td>
<td style="text-align: left;">-</td>
</tr>
<tr class="even">
<td style="text-align: left;">hospital_i</td>
<td style="text-align: left;">hospital_i</td>
<td style="text-align: right;">4125</td>
<td style="text-align: right;">4125</td>
<td style="text-align: left;">-</td>
</tr>
<tr class="odd">
<td style="text-align: left;">hospital_j</td>
<td style="text-align: left;">hospital_j</td>
<td style="text-align: right;">4126</td>
<td style="text-align: right;">4126</td>
<td style="text-align: left;">-</td>
</tr>
<tr class="even">
<td style="text-align: left;">hospital_k</td>
<td style="text-align: left;">hospital_k</td>
<td style="text-align: right;">4661</td>
<td style="text-align: right;">4661</td>
<td style="text-align: left;">-</td>
</tr>
<tr class="odd">
<td style="text-align: left;">hospital_l</td>
<td style="text-align: left;">hospital_l</td>
<td style="text-align: right;">4662</td>
<td style="text-align: right;">4662</td>
<td style="text-align: left;">-</td>
</tr>
<tr class="even">
<td style="text-align: left;">hospital_m</td>
<td style="text-align: left;">hospital_mb</td>
<td style="text-align: right;">4663</td>
<td style="text-align: right;">4663</td>
<td style="text-align: left;">-</td>
</tr>
<tr class="odd">
<td style="text-align: left;">hospital_n</td>
<td style="text-align: left;">hospital_n</td>
<td style="text-align: right;">4665</td>
<td style="text-align: right;">4665</td>
<td style="text-align: left;">-</td>
</tr>
</tbody>
</table>

The `dag_manage()` function output provides a list of all DAGs with a
breakdown of the outcome:

-   The outcome of the DAGs will be displayed (“status”) - either
    unchanged (“-”), “removed” or “added”.

### `user_manage()`

Effective management of users is essential to ensure users have the user
rights and data access appropriate to them - this can be done using
`user_manage()`.

Usernames to manage can be supplied to the `users` argument as a vector
or as a tibble with at least 1 column (“username”). If you simply want
to view the current users on the project, just enter the URL and TOKEN
and you will be shown the output from `user_role()`.

    newuser <- tibble::tibble("username" = "gs2s1005789")

    knitr::kable(newuser)

<table>
<thead>
<tr class="header">
<th style="text-align: left;">username</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">gs2s1005789</td>
</tr>
</tbody>
</table>

There are 2 main ways to manage users:

##### 1. **Add or amend users**:

The role and/or DAG can be specified for ALL users supplied to `users`
(“role” and “dag”), or for individual users by adding a “role” and/or
“dag” column to `users` with the appropriate value for each username. If
present, the information from the columns will take precedence.

-   `role`: This must exactly match either a role name or ID, or a
    username with the appropriate role (see the output from
    `user_role()`)

-   `dag`: This must exactly match the “unique\_group\_name” of an
    existing DAG (see the output from `dag_manage()`)

In order to prevent errors due to users not being assigned to specific
roles and DAGs, there will be an error message if either of these are
listed as `NA`. If you want a user to not have a specific role or DAG,
then these must be explicitly listed as “none”.

    add_outcome <- user_manage(redcap_project_uri = Sys.getenv("collaborator_test_uri"),
                               redcap_project_token = Sys.getenv("collaborator_test_token"),
                               users = newuser %>% mutate("role" = "manager", "dag" = "none"))

This function output provides a breakdown of the outcome for each
username in `users`:

1.  `correct`: Users who have been allocated correctly according to the
    information provided, and provides details on this change.

<!-- -->

    knitr::kable(add_outcome$correct)

<table>
<thead>
<tr class="header">
<th style="text-align: left;">username</th>
<th style="text-align: left;">action</th>
<th style="text-align: left;">role</th>
<th style="text-align: left;">dag</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">gs2s1005789</td>
<td style="text-align: left;">add</td>
<td style="text-align: left;">NA –&gt; manager</td>
<td style="text-align: left;">NA –&gt; none</td>
</tr>
</tbody>
</table>

1.  `error`: Users who have NOT been allocated correctly according to
    the information provided, and provides details on what the current
    status of that user is / what the outcome should have been according
    to the information supplied. This may be an incorrect specification
    of the username, role, or DAG.

<!-- -->

    knitr::kable(add_outcome$error)

<table>
<colgroup>
<col style="width: 13%" />
<col style="width: 10%" />
<col style="width: 23%" />
<col style="width: 7%" />
<col style="width: 20%" />
<col style="width: 5%" />
<col style="width: 19%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;">username</th>
<th style="text-align: left;">action</th>
<th style="text-align: left;">status_intended</th>
<th style="text-align: left;">role</th>
<th style="text-align: left;">role_intended</th>
<th style="text-align: left;">dag</th>
<th style="text-align: left;">dag_intended</th>
</tr>
</thead>
<tbody>
</tbody>
</table>

##### 2. **Remove users**:

This can be specified for ALL users supplied to `users` (“remove==T”) or
for individual users by adding a “remove” column to `users` with the
value `TRUE` for each username wanting to be removed (this allows users
to be added and removed at the same time).

-   If present, the information from the columns will take precedence.

<!-- -->

    remove_outcome <- user_manage(redcap_project_uri = Sys.getenv("collaborator_test_uri"),
                                  redcap_project_token = Sys.getenv("collaborator_test_token"),
                                  users = newuser$username, remove = T)

    knitr::kable(remove_outcome$correct)

<table>
<thead>
<tr class="header">
<th style="text-align: left;">username</th>
<th style="text-align: left;">action</th>
<th style="text-align: left;">role</th>
<th style="text-align: left;">dag</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">gs2s1005789</td>
<td style="text-align: left;">remove</td>
<td style="text-align: left;">manager –&gt; NA</td>
<td style="text-align: left;">none –&gt; NA</td>
</tr>
</tbody>
</table>
