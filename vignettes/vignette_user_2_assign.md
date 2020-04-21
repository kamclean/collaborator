# Collaborator: Redcap User Management 2. Automatically Assign User Rights

To be able to use a REDCap project, there are two prerequisites:

1.  **User account** - This username allows the user to log onto the
    REDCap instance.

2.  **User rights** - This is required to access a specific REDCap
    project, and determines the capabilities the user has (e.g. to
    access certain forms, to be restricted to a specific data access
    group, to import/export data, etc)

Management of user rights in REDCap becomes increasingly laborious as
the scale of the research project expands (e.g. with the number of
users, and the number of data access groups). However, at present,
REDCap does not directly support mass-allocation of user rights within a
project.

The aim of the following vignette is to describe a workflow by which
users can be easily automatically assigned within a REDCap project

## Assign new user rights

The automatic assignment of user rights and allocation to data access
groups (DAG) has several important advantages over the manual method:

  - Once set-up, it involves a fraction of the time and labour (compared
    to doing so manually), and can be easily repeated using R. This
    enables multicentre research using REDCap to become easily scalable
    irrespective of the number of users and number of data access
    groups.

  - It significantly reduces allocation errors (e.g. users being
    allocated to incorrect DAGs).

However, the downside using this method is that “user roles” cannot be
assigned from outwith REDCap. Therefore, each user is automatically
allocated their rights on an individual basis. This has implications
that this method must be used throughout the lifespan of the project to
edit current user rights (rather than simply editing those of the “user
role” on REDCap).

The assignment of new user rights can be achieved via the following
steps:

### a). `user_new()`

The `user_new()` function can be used to compare a dataframe of all
users to those currently allocated on REDCap to determine any new users
requiring assigned (ignoring those listed in `user_exclude`).

These new users can then be uploaded to REDCap using `user_import()` and
`user_assign()`.

 

### b). `user_import()`

REDCap user accounts cannot be generated via R at present, and need to
be manually uploaded at present (however there is capability to bulk
upload via a csv file). This function can be used to generate the csv
file in the exact format required for direct upload via the control
centre.

It requires a dataframe of at least 4 mandatory columns (corresponding
to: username, first name, last name, and email address) and 4 optional
columns (corresponding to: institution, sponsor, expiration, comments).
All optional columns will be blank unless otherwise specified.

``` r
library(collaborator);library(dplyr)

# Example output from user_role()
data_user_import <- collaborator::user_role(redcap_project_uri = Sys.getenv("collaborator_test_uri"),
                                            redcap_project_token = Sys.getenv("collaborator_test_token"))$full %>%
  dplyr::select(username, email, firstname, lastname, data_access_group) # please note all names are randomly generated

collaborator::user_import(df = data_user_import,
            username = "username", first_name = "firstname", last_name = "lastname",
            email = "email", institution = "data_access_group") %>%
  head(10) %>%
  knitr::kable()
```

| Username     | First name | Last name | Email address           | Institution ID | Sponsor username | Expiration | Comments |
| :----------- | :--------- | :-------- | :---------------------- | :------------- | :--------------- | :--------- | :------- |
| a\_barker    | Aleesha    | Barker    | <a_barker@email.com>    | hospital\_a    |                  |            |          |
| a\_hanna     | Aleesha    | Hanna     | <a_hanna@email.com>     | hospital\_d    |                  |            |          |
| a\_hicks     | Alyssa     | Hicks     | <a_hicks@email.com>     | hospital\_e    |                  |            |          |
| a\_lees      | Aleesha    | Lees      | <a_lees@email.com>      | hospital\_h    |                  |            |          |
| a\_nicholson | Alyssa     | Nicholson | <a_nicholson@email.com> | hospital\_i    |                  |            |          |
| c\_avila     | Chanice    | Avila     | <c_avila@email.com>     |                |                  |            |          |
| c\_gould     | Chanice    | Gould     | <c_gould@email.com>     | hospital\_b    |                  |            |          |
| c\_kent      | Chanice    | Kent      | <c_kent@email.com>      | hospital\_f    |                  |            |          |
| c\_michael   | Chanice    | Michael   | <c_michael@email.com>   | hospital\_h    |                  |            |          |
| f\_almond    | Fleur      | Almond    | <f_almond@email.com>    |                |                  |            |          |

This tibble will be saved as a CSV file (for download to upload to
REDCap) if the `path` parameter is specified (note must end in “.csv”).

 

### c). `user_assign()`

This can be achieved via the following steps:

**1. Create example user (with the desired user rights):**

  - This should be done within REDCap - users which act as an example of
    each role in the project (e.g. administrator, collaborator,
    validator) should be created as outlined in [Redcap User
    Management: 1. Explore Current
    Users](https://github.com/kamclean/collaborator/blob/master/vignettes/vignette_user_1_explore.md))

**2. Create data\_access\_groups:**

  - Data access groups should be added manually to the project as
    normal.

**3. Apply `user_assign()`:**

  - Use the `user_assign()` function to add a group of users (`df_user`)
    with the same user rights as the example user (input username of the
    example username as `role`).

  - These usernames / user rights are directly pushed into the REDCap
    project (including assignment to the appropriate DAG) on an
    individual , but automatic / rapid basis.

  - Usernames should not contain punctuation beyond full stop (“.”),
    dash (“-”), and underscore ("\_").

  - It is highly recommended that users are grouped using `user_role()`
    and/or `user_roles()` prior to assignment to minimise possible
    errors, and to use `user_validate()` to identify potential issues
    afterwards (e.g. to ensure form rights have uploaded correctly) (see
    [Redcap User Management: 1. Explore Current
    Users](https://github.com/kamclean/collaborator/blob/master/vignettes/vignette_user_1_explore.Rmd)).

*Note: Users can be assigned to a project without being uploaded via the
control centre (e.g. accounts being issued). This may be useful if a
single user import is preferred over multiple smaller imports, or user
access is desired to be given at a single point in time.*

**4. Troubleshooting common errors using `user_assign()`:**

a). *Users are not being uploaded*:

  - The most likely reason is that the DAG listed for the user is absent
    / incorrect. The DAG being assigned must exactly match a DAG already
    present on REDCap (as per step 2). Note: This does not apply in the
    case of DAGs listed as NA.

b). *Users do not have the appropriate rights*:

  - Check your example user has the correct rights, and that the correct
    example user and correct group are being used within the
    `user_assign()` function. Note: if user rights are required to be
    edited for whatever reason, please see the explaination below.

  - Alternatively use `user_validate()` to check the “forms” access has
    uploaded correctly (see [Redcap User Management: 1. Explore Current
    Users](https://github.com/kamclean/collaborator/blob/master/vignettes/vignette_user_1_explore.Rmd)).

## Edit current user rights

The downside to automatic user allocation using this method is that
“user roles” cannot be assigned from outwith REDCap. Therefore, should
the user rights of the group need to be edited afterwards it is *highly
recommended* to be done via re-application of this method (otherwise
each individual users would need to be allocated to a role (and then
edited), or their rights would need to manually edited individually).

This can be achieved via the following steps:

**1. Create example user (with the desired user rights):**

  - The easiest method to achieve this is from within REDCap - a new
    user should either be allocated with the desired rights, or an
    existing user should be selected and their user rights amended as
    appropriate.

  - Alternatively, this can be modified once exported to R. However,
    this requires a clear understanding of how user rights are recorded
    within REDCap.

**2. Apply `user_assign()`:**

  - Use the `user_assign()` function to modify the rights of a group of
    users (`df_user`) to match the existing example user (input username
    as `role`).

*Note: While user rights can be modified to remove all access to forms
on the REDCap project, they cannot be removed from the project using
this method (the only capability to do so is manually / individually via
REDCap).*
