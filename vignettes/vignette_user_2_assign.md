Collaborator: Redcap User Management 2. Automatically Assign User Rights
========================================================================

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

Assign new user rights
----------------------

The automatic assignment of user rights and allocation to data access
groups (DAG) has several important advantages over the manual method:

-   Once set-up, it involves a fraction of the time and labour (compared
    to doing so manually), and can be easily repeated using R. This
    enables multicentre research using REDCap to become easily scalable
    irrespective of the number of users and number of data access
    groups.

-   It significantly reduces allocation errors (e.g. users being
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
requiring assigned (ignoring those listed in `users_exception`).

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

    library(collaborator);library(dplyr)

    # Example output from user_roles_n()
    data_user_import <- user_roles_n(redcap_project_uri, redcap_project_token)$full %>%
      select(username, email, firstname, lastname, data_access_group) # please note all names are randomly generated

    ## [1] "There are 3 unique roles in this redcap project"

    user_import(df = data_user_import,
                username = "username", first_name = "firstname", last_name = "lastname",
                email = "email", institution = "data_access_group") %>%
      knitr::kable()

<table>
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
<td style="text-align: left;"><a href="mailto:a_barker@email.com">a_barker@email.com</a></td>
<td style="text-align: left;">hospital_a</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">a_hicks</td>
<td style="text-align: left;">Alyssa</td>
<td style="text-align: left;">Hicks</td>
<td style="text-align: left;"><a href="mailto:a_hicks@email.com">a_hicks@email.com</a></td>
<td style="text-align: left;">hospital_e</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">a_lees</td>
<td style="text-align: left;">Aleesha</td>
<td style="text-align: left;">Lees</td>
<td style="text-align: left;"><a href="mailto:a_lees@email.com">a_lees@email.com</a></td>
<td style="text-align: left;">hospital_g</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">a_nicholson</td>
<td style="text-align: left;">Alyssa</td>
<td style="text-align: left;">Nicholson</td>
<td style="text-align: left;"><a href="mailto:a_nicholson@email.com">a_nicholson@email.com</a></td>
<td style="text-align: left;">hospital_i</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">c_avila</td>
<td style="text-align: left;">Chanice</td>
<td style="text-align: left;">Avila</td>
<td style="text-align: left;"><a href="mailto:c_avila@email.com">c_avila@email.com</a></td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">c_gould</td>
<td style="text-align: left;">Chanice</td>
<td style="text-align: left;">Gould</td>
<td style="text-align: left;"><a href="mailto:c_gould@email.com">c_gould@email.com</a></td>
<td style="text-align: left;">hospital_b</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">c_kent</td>
<td style="text-align: left;">Chanice</td>
<td style="text-align: left;">Kent</td>
<td style="text-align: left;"><a href="mailto:c_kent@email.com">c_kent@email.com</a></td>
<td style="text-align: left;">hospital_f</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">c_michael</td>
<td style="text-align: left;">Chanice</td>
<td style="text-align: left;">Michael</td>
<td style="text-align: left;"><a href="mailto:c_michael@email.com">c_michael@email.com</a></td>
<td style="text-align: left;">hospital_h</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">f_almond</td>
<td style="text-align: left;">Fleur</td>
<td style="text-align: left;">Almond</td>
<td style="text-align: left;"><a href="mailto:f_almond@email.com">f_almond@email.com</a></td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">f_galindo</td>
<td style="text-align: left;">Fleur</td>
<td style="text-align: left;">Galindo</td>
<td style="text-align: left;"><a href="mailto:f_galindo@email.com">f_galindo@email.com</a></td>
<td style="text-align: left;">hospital_a</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">f_livingston</td>
<td style="text-align: left;">Fleur</td>
<td style="text-align: left;">Livingston</td>
<td style="text-align: left;"><a href="mailto:f_livingston@email.com">f_livingston@email.com</a></td>
<td style="text-align: left;">hospital_g</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">h_herman</td>
<td style="text-align: left;">Hailie</td>
<td style="text-align: left;">Herman</td>
<td style="text-align: left;"><a href="mailto:h_herman@email.com">h_herman@email.com</a></td>
<td style="text-align: left;">hospital_d</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">h_mustafa</td>
<td style="text-align: left;">Hailie</td>
<td style="text-align: left;">Mustafa</td>
<td style="text-align: left;"><a href="mailto:h_mustafa@email.com">h_mustafa@email.com</a></td>
<td style="text-align: left;">hospital_i</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">k_ashton</td>
<td style="text-align: left;">Kester</td>
<td style="text-align: left;">Ashton</td>
<td style="text-align: left;"><a href="mailto:k_ashton@email.com">k_ashton@email.com</a></td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">k_gibbons</td>
<td style="text-align: left;">Kester</td>
<td style="text-align: left;">Gibbons</td>
<td style="text-align: left;"><a href="mailto:k_gibbons@email.com">k_gibbons@email.com</a></td>
<td style="text-align: left;">hospital_b</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">k_marks</td>
<td style="text-align: left;">Kester</td>
<td style="text-align: left;">Marks</td>
<td style="text-align: left;"><a href="mailto:k_marks@email.com">k_marks@email.com</a></td>
<td style="text-align: left;">hospital_h</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">l_cervantes</td>
<td style="text-align: left;">Leroy</td>
<td style="text-align: left;">Cervantes</td>
<td style="text-align: left;"><a href="mailto:l_cervantes@email.com">l_cervantes@email.com</a></td>
<td style="text-align: left;">hospital_a</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">l_jensen</td>
<td style="text-align: left;">Leroy</td>
<td style="text-align: left;">Jensen</td>
<td style="text-align: left;"><a href="mailto:l_jensen@email.com">l_jensen@email.com</a></td>
<td style="text-align: left;">hospital_e</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">l_paine</td>
<td style="text-align: left;">Leroy</td>
<td style="text-align: left;">Paine</td>
<td style="text-align: left;"><a href="mailto:l_paine@email.com">l_paine@email.com</a></td>
<td style="text-align: left;">hospital_j</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">m_owens</td>
<td style="text-align: left;">Martha</td>
<td style="text-align: left;">Owens</td>
<td style="text-align: left;"><a href="mailto:m_owens@email.com">m_owens@email.com</a></td>
<td style="text-align: left;">hospital_j</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">r_bradford</td>
<td style="text-align: left;">Ralph</td>
<td style="text-align: left;">Bradford</td>
<td style="text-align: left;"><a href="mailto:r_bradford@email.com">r_bradford@email.com</a></td>
<td style="text-align: left;">hospital_c</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">r_hodge</td>
<td style="text-align: left;">Ralph</td>
<td style="text-align: left;">Hodge</td>
<td style="text-align: left;"><a href="mailto:r_hodge@email.com">r_hodge@email.com</a></td>
<td style="text-align: left;">hospital_f</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">r_ochoa</td>
<td style="text-align: left;">Ralph</td>
<td style="text-align: left;">Ochoa</td>
<td style="text-align: left;"><a href="mailto:r_ochoa@email.com">r_ochoa@email.com</a></td>
<td style="text-align: left;">hospital_i</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">s_ayala</td>
<td style="text-align: left;">Samiha</td>
<td style="text-align: left;">Ayala</td>
<td style="text-align: left;"><a href="mailto:s_ayala@email.com">s_ayala@email.com</a></td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">s_beech</td>
<td style="text-align: left;">Shanelle</td>
<td style="text-align: left;">Beech</td>
<td style="text-align: left;"><a href="mailto:s_beech@email.com">s_beech@email.com</a></td>
<td style="text-align: left;">hospital_b</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">s_hardy</td>
<td style="text-align: left;">Shanelle</td>
<td style="text-align: left;">Hardy</td>
<td style="text-align: left;"><a href="mailto:s_hardy@email.com">s_hardy@email.com</a></td>
<td style="text-align: left;">hospital_d</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">s_moses</td>
<td style="text-align: left;">Shanelle</td>
<td style="text-align: left;">Moses</td>
<td style="text-align: left;"><a href="mailto:s_moses@email.com">s_moses@email.com</a></td>
<td style="text-align: left;">hospital_h</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">y_andersen</td>
<td style="text-align: left;">Yaseen</td>
<td style="text-align: left;">Andersen</td>
<td style="text-align: left;"><a href="mailto:y_andersen@email.com">y_andersen@email.com</a></td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">y_holder</td>
<td style="text-align: left;">Yara</td>
<td style="text-align: left;">Holder</td>
<td style="text-align: left;"><a href="mailto:y_holder@email.com">y_holder@email.com</a></td>
<td style="text-align: left;">hospital_e</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">y_mackie</td>
<td style="text-align: left;">Yaseen</td>
<td style="text-align: left;">Mackie</td>
<td style="text-align: left;"><a href="mailto:y_mackie@email.com">y_mackie@email.com</a></td>
<td style="text-align: left;">hospital_g</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">y_o’doherty</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_j</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">y_odoherty</td>
<td style="text-align: left;">Yara</td>
<td style="text-align: left;">O’Doherty</td>
<td style="text-align: left;"><a href="mailto:y_odoherty@email.com">y_odoherty@email.com</a></td>
<td style="text-align: left;">hospital_j</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">a_hanna</td>
<td style="text-align: left;">Aleesha</td>
<td style="text-align: left;">Hanna</td>
<td style="text-align: left;"><a href="mailto:a_hanna@email.com">a_hanna@email.com</a></td>
<td style="text-align: left;">hospital_d</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">s_knights</td>
<td style="text-align: left;">Samiha</td>
<td style="text-align: left;">Knights</td>
<td style="text-align: left;"><a href="mailto:s_knights@email.com">s_knights@email.com</a></td>
<td style="text-align: left;">hospital_f</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">y_cameron</td>
<td style="text-align: left;">Yara</td>
<td style="text-align: left;">Cameron</td>
<td style="text-align: left;"><a href="mailto:y_cameron@email.com">y_cameron@email.com</a></td>
<td style="text-align: left;">hospital_c</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">kmclean</td>
<td style="text-align: left;">Kenneth</td>
<td style="text-align: left;">McLean</td>
<td style="text-align: left;"><a href="mailto:mcleankaca@gmail.com">mcleankaca@gmail.com</a></td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
</tbody>
</table>

### c). `user_assign()`

This can be achieved via the following steps:

**1. Create example user (with the desired user rights):**

-   This should be done within REDCap - users which act as an example of
    each role in the project (e.g. administrator, collaborator,
    validator) should be manually created as normal.

**2. Create data\_access\_groups:**

-   Data access groups should be added manually as normal.

**3. Apply `user_assign()`:**

-   Use the `user_assign()` function to add a group of users
    (`users.df`) with the same user rights as the example user (input
    username of the example username as `role`).

-   These usernames / user rights are directly pushed into the REDCap
    project (including assignment to the appropriate DAG) on an
    individual , but automatic / rapid basis.

-   It is highly recommended that users are grouped using
    `user_roles_n()` and/or `user_roles()` prior to assignment to
    minimise possible errors, and to use `user_validate()` to identify
    potential issues afterwards (e.g. to ensure form rights have
    uploaded correctly) (see [Redcap User Management: 1. Explore Current
    Users](https://github.com/kamclean/collaborator/blob/master/vignettes/vignette_user_1_explore.Rmd)).

*Note: Users can be assigned to a project without being uploaded via the
control centre (e.g. accounts being issued). This may be useful if a
single user import is preferred over multiple smaller imports, or user
access is desired to be given at a single point in time.*

**4. Troubleshooting common errors using `user_assign()`:**

a). *Users are not being uploaded*:

-   The most likely reason is that the DAG listed for the user is absent
    / incorrect. The DAG being assigned must exactly match a DAG already
    present on REDCap (as per step 2). Note: This does not apply in the
    case of DAGs listed as NA.

b). *Users do not have the appropriate rights*:

-   Check your example user has the correct rights, and that the correct
    example user and correct group are being used within the
    `user_assign()` function. Note: if user rights are required to be
    edited for whatever reason, please see the explaination below.

-   Alternatively use `user_validate()` to check the “forms” access has
    uploaded correctly (see [Redcap User Management: 1. Explore Current
    Users](https://github.com/kamclean/collaborator/blob/master/vignettes/vignette_user_1_explore.Rmd)).

Edit current user rights
------------------------

The downside to automatic user allocation using this method is that
“user roles” cannot be assigned from outwith REDCap. Therefore, should
the user rights of the group need to be edited afterwards it is *highly
recommended* to be done via re-application of this method (otherwise
each individual users would need to be allocated to a role (and then
edited), or their rights would need to manually edited individually).

This can be achieved via the following steps:

**1. Create example user (with the desired user rights):**

-   The easiest method to achieve this is from within REDCap - a new
    user should either be allocated with the desired rights, or an
    existing user should be selected and their user rights amended as
    appropriate.

-   Alternatively, this can be modified once exported to R however this
    requires a clear understanding of how user rights are recorded
    within REDCap.

**2. Apply `user_assign()`:**

-   Use the `user_assign()` function to modify the rights of a group of
    users (`users.df`) to match the existing example user (input
    username as `role`).

*Note: While user rights can be modified to remove all access to forms
on the REDCap project, they cannot be removed from the project using
this method (the only capability to do so is manually / individually via
REDCap).*
