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
<thead>
<tr>
<th style="text-align:left;">
Username
</th>
<th style="text-align:left;">
First name
</th>
<th style="text-align:left;">
Last name
</th>
<th style="text-align:left;">
Email address
</th>
<th style="text-align:left;">
Institution ID
</th>
<th style="text-align:left;">
Sponsor username
</th>
<th style="text-align:left;">
Expiration
</th>
<th style="text-align:left;">
Comments
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
a\_barker
</td>
<td style="text-align:left;">
Aleesha
</td>
<td style="text-align:left;">
Barker
</td>
<td style="text-align:left;">
<a_barker@email.com>
</td>
<td style="text-align:left;">
hospital\_a
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
a\_hanna
</td>
<td style="text-align:left;">
Aleesha
</td>
<td style="text-align:left;">
Hanna
</td>
<td style="text-align:left;">
<a_hanna@email.com>
</td>
<td style="text-align:left;">
hospital\_d
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
a\_hicks
</td>
<td style="text-align:left;">
Alyssa
</td>
<td style="text-align:left;">
Hicks
</td>
<td style="text-align:left;">
<a_hicks@email.com>
</td>
<td style="text-align:left;">
hospital\_e
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
a\_lees
</td>
<td style="text-align:left;">
Aleesha
</td>
<td style="text-align:left;">
Lees
</td>
<td style="text-align:left;">
<a_lees@email.com>
</td>
<td style="text-align:left;">
hospital\_h
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
a\_nicholson
</td>
<td style="text-align:left;">
Alyssa
</td>
<td style="text-align:left;">
Nicholson
</td>
<td style="text-align:left;">
<a_nicholson@email.com>
</td>
<td style="text-align:left;">
hospital\_i
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
c\_avila
</td>
<td style="text-align:left;">
Chanice
</td>
<td style="text-align:left;">
Avila
</td>
<td style="text-align:left;">
<c_avila@email.com>
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
c\_gould
</td>
<td style="text-align:left;">
Chanice
</td>
<td style="text-align:left;">
Gould
</td>
<td style="text-align:left;">
<c_gould@email.com>
</td>
<td style="text-align:left;">
hospital\_b
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
c\_kent
</td>
<td style="text-align:left;">
Chanice
</td>
<td style="text-align:left;">
Kent
</td>
<td style="text-align:left;">
<c_kent@email.com>
</td>
<td style="text-align:left;">
hospital\_f
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
c\_michael
</td>
<td style="text-align:left;">
Chanice
</td>
<td style="text-align:left;">
Michael
</td>
<td style="text-align:left;">
<c_michael@email.com>
</td>
<td style="text-align:left;">
hospital\_h
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
f\_almond
</td>
<td style="text-align:left;">
Fleur
</td>
<td style="text-align:left;">
Almond
</td>
<td style="text-align:left;">
<f_almond@email.com>
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
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
<thead>
<tr>
<th style="text-align:left;">
role\_name
</th>
<th style="text-align:left;">
role\_id
</th>
<th style="text-align:left;">
username
</th>
<th style="text-align:left;">
data\_access\_group
</th>
<th style="text-align:right;">
data\_access\_group\_id
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
admin
</td>
<td style="text-align:left;">
U-82337CEWAF
</td>
<td style="text-align:left;">
kmclean
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
a\_barker
</td>
<td style="text-align:left;">
hospital\_a
</td>
<td style="text-align:right;">
4117
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
a\_hanna
</td>
<td style="text-align:left;">
hospital\_d
</td>
<td style="text-align:right;">
4120
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
a\_hicks
</td>
<td style="text-align:left;">
hospital\_e
</td>
<td style="text-align:right;">
4121
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
a\_lees
</td>
<td style="text-align:left;">
hospital\_h
</td>
<td style="text-align:right;">
4124
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
a\_nicholson
</td>
<td style="text-align:left;">
hospital\_i
</td>
<td style="text-align:right;">
4125
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
c\_avila
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
c\_gould
</td>
<td style="text-align:left;">
hospital\_b
</td>
<td style="text-align:right;">
4118
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
c\_kent
</td>
<td style="text-align:left;">
hospital\_f
</td>
<td style="text-align:right;">
4122
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
c\_michael
</td>
<td style="text-align:left;">
hospital\_h
</td>
<td style="text-align:right;">
4124
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
f\_almond
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
f\_galindo
</td>
<td style="text-align:left;">
hospital\_a
</td>
<td style="text-align:right;">
4117
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
f\_livingston
</td>
<td style="text-align:left;">
hospital\_g
</td>
<td style="text-align:right;">
4123
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
h\_herman
</td>
<td style="text-align:left;">
hospital\_d
</td>
<td style="text-align:right;">
4120
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
h\_mustafa
</td>
<td style="text-align:left;">
hospital\_i
</td>
<td style="text-align:right;">
4125
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
k\_ashton
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
k\_gibbons
</td>
<td style="text-align:left;">
hospital\_b
</td>
<td style="text-align:right;">
4118
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
k\_marks
</td>
<td style="text-align:left;">
hospital\_h
</td>
<td style="text-align:right;">
4124
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
l\_cervantes
</td>
<td style="text-align:left;">
hospital\_a
</td>
<td style="text-align:right;">
4117
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
l\_jensen
</td>
<td style="text-align:left;">
hospital\_e
</td>
<td style="text-align:right;">
4121
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
l\_paine
</td>
<td style="text-align:left;">
hospital\_j
</td>
<td style="text-align:right;">
4126
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
m\_owens
</td>
<td style="text-align:left;">
hospital\_j
</td>
<td style="text-align:right;">
4126
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
r\_bradford
</td>
<td style="text-align:left;">
hospital\_c
</td>
<td style="text-align:right;">
4119
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
r\_hodge
</td>
<td style="text-align:left;">
hospital\_i
</td>
<td style="text-align:right;">
4125
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
r\_ochoa
</td>
<td style="text-align:left;">
hospital\_i
</td>
<td style="text-align:right;">
4125
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
s\_ayala
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
s\_beech
</td>
<td style="text-align:left;">
hospital\_b
</td>
<td style="text-align:right;">
4118
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
s\_hardy
</td>
<td style="text-align:left;">
hospital\_e
</td>
<td style="text-align:right;">
4121
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
s\_knights
</td>
<td style="text-align:left;">
hospital\_f
</td>
<td style="text-align:right;">
4122
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
s\_moses
</td>
<td style="text-align:left;">
hospital\_h
</td>
<td style="text-align:right;">
4124
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
tdrake
</td>
<td style="text-align:left;">
hospital\_d
</td>
<td style="text-align:right;">
4120
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
y\_andersen
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
y\_cameron
</td>
<td style="text-align:left;">
hospital\_d
</td>
<td style="text-align:right;">
4120
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
y\_holder
</td>
<td style="text-align:left;">
hospital\_e
</td>
<td style="text-align:right;">
4121
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
y\_mackie
</td>
<td style="text-align:left;">
hospital\_g
</td>
<td style="text-align:right;">
4123
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:left;">
y\_odoherty
</td>
<td style="text-align:left;">
hospital\_j
</td>
<td style="text-align:right;">
4126
</td>
</tr>
<tr>
<td style="text-align:left;">
manager
</td>
<td style="text-align:left;">
U-591P8EWTJY
</td>
<td style="text-align:left;">
eharrison
</td>
<td style="text-align:left;">
hospital\_c
</td>
<td style="text-align:right;">
4119
</td>
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
<thead>
<tr>
<th style="text-align:left;">
role\_name
</th>
<th style="text-align:left;">
role\_id
</th>
<th style="text-align:right;">
n
</th>
<th style="text-align:left;">
username
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
admin
</td>
<td style="text-align:left;">
U-82337CEWAF
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
kmclean
</td>
</tr>
<tr>
<td style="text-align:left;">
collaborator
</td>
<td style="text-align:left;">
U-3319YWM9ND
</td>
<td style="text-align:right;">
35
</td>
<td style="text-align:left;">
a\_barker , a\_hanna , a\_hicks , a\_lees , a\_nicholson , c\_avila ,
c\_gould , c\_kent , c\_michael , f\_almond , f\_galindo ,
f\_livingston, h\_herman , h\_mustafa , k\_ashton , k\_gibbons ,
k\_marks , l\_cervantes , l\_jensen , l\_paine , m\_owens , r\_bradford
, r\_hodge , r\_ochoa , s\_ayala , s\_beech , s\_hardy , s\_knights ,
s\_moses , tdrake , y\_andersen , y\_cameron , y\_holder , y\_mackie ,
y\_odoherty
</td>
</tr>
<tr>
<td style="text-align:left;">
manager
</td>
<td style="text-align:left;">
U-591P8EWTJY
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
eharrison
</td>
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

<table>
<thead>
<tr>
<th style="text-align:left;">
data\_access\_group\_name
</th>
<th style="text-align:left;">
unique\_group\_name
</th>
<th style="text-align:left;">
status
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
hospital m
</td>
<td style="text-align:left;">
hospital\_m
</td>
<td style="text-align:left;">

-   </td>
    </tr>
    <tr>
    <td style="text-align:left;">
    hospital\_a
    </td>
    <td style="text-align:left;">
    hospital\_a
    </td>
    <td style="text-align:left;">

    -   </td>
        </tr>
        <tr>
        <td style="text-align:left;">
        hospital\_b
        </td>
        <td style="text-align:left;">
        hospital\_b
        </td>
        <td style="text-align:left;">

        -   </td>
            </tr>
            <tr>
            <td style="text-align:left;">
            hospital\_c
            </td>
            <td style="text-align:left;">
            hospital\_c
            </td>
            <td style="text-align:left;">

            -   </td>
                </tr>
                <tr>
                <td style="text-align:left;">
                hospital\_d
                </td>
                <td style="text-align:left;">
                hospital\_d
                </td>
                <td style="text-align:left;">

                -   </td>
                    </tr>
                    <tr>
                    <td style="text-align:left;">
                    hospital\_e
                    </td>
                    <td style="text-align:left;">
                    hospital\_e
                    </td>
                    <td style="text-align:left;">

                    -   </td>
                        </tr>
                        <tr>
                        <td style="text-align:left;">
                        hospital\_f
                        </td>
                        <td style="text-align:left;">
                        hospital\_f
                        </td>
                        <td style="text-align:left;">

                        -   </td>
                            </tr>
                            <tr>
                            <td style="text-align:left;">
                            hospital\_g
                            </td>
                            <td style="text-align:left;">
                            hospital\_g
                            </td>
                            <td style="text-align:left;">

                            -   </td>
                                </tr>
                                <tr>
                                <td style="text-align:left;">
                                hospital\_h
                                </td>
                                <td style="text-align:left;">
                                hospital\_h
                                </td>
                                <td style="text-align:left;">

                                -   </td>
                                    </tr>
                                    <tr>
                                    <td style="text-align:left;">
                                    hospital\_i
                                    </td>
                                    <td style="text-align:left;">
                                    hospital\_i
                                    </td>
                                    <td style="text-align:left;">

                                    -   </td>
                                        </tr>
                                        <tr>
                                        <td style="text-align:left;">
                                        hospital\_j
                                        </td>
                                        <td style="text-align:left;">
                                        hospital\_j
                                        </td>
                                        <td style="text-align:left;">

                                        -   </td>
                                            </tr>
                                            <tr>
                                            <td style="text-align:left;">
                                            hospital\_k
                                            </td>
                                            <td style="text-align:left;">
                                            hospital\_k
                                            </td>
                                            <td style="text-align:left;">

                                            -   </td>
                                                </tr>
                                                <tr>
                                                <td style="text-align:left;">
                                                hospital\_l
                                                </td>
                                                <td style="text-align:left;">
                                                hospital\_l
                                                </td>
                                                <td style="text-align:left;">

                                                -   </td>
                                                    </tr>
                                                    <tr>
                                                    <td style="text-align:left;">
                                                    hospital\_m
                                                    </td>
                                                    <td style="text-align:left;">
                                                    hospital\_mb
                                                    </td>
                                                    <td style="text-align:left;">

                                                    -   </td>
                                                        </tr>
                                                        <tr>
                                                        <td style="text-align:left;">
                                                        hospital\_n
                                                        </td>
                                                        <td style="text-align:left;">
                                                        hospital\_n
                                                        </td>
                                                        <td style="text-align:left;">

                                                        -   </td>
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
<tr>
<th style="text-align:left;">
username
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
gs2s1005789
</td>
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
<tr>
<th style="text-align:left;">
username
</th>
<th style="text-align:left;">
action
</th>
<th style="text-align:left;">
role
</th>
<th style="text-align:left;">
dag
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
gs2s1005789
</td>
<td style="text-align:left;">
add
</td>
<td style="text-align:left;">
NA –&gt; manager
</td>
<td style="text-align:left;">
NA –&gt; none
</td>
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
<thead>
<tr>
<th style="text-align:left;">
username
</th>
<th style="text-align:left;">
action
</th>
<th style="text-align:left;">
status\_intended
</th>
<th style="text-align:left;">
role
</th>
<th style="text-align:left;">
role\_intended
</th>
<th style="text-align:left;">
dag
</th>
<th style="text-align:left;">
dag\_intended
</th>
</tr>
</thead>
<tbody>
<tr>
</tr>
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
<tr>
<th style="text-align:left;">
username
</th>
<th style="text-align:left;">
action
</th>
<th style="text-align:left;">
role
</th>
<th style="text-align:left;">
dag
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
gs2s1005789
</td>
<td style="text-align:left;">
remove
</td>
<td style="text-align:left;">
manager –&gt; NA
</td>
<td style="text-align:left;">
none –&gt; NA
</td>
</tr>
</tbody>
</table>
