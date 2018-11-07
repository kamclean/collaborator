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

    knitr::kable(user_roles_n_full)

<table>
<thead>
<tr class="header">
<th style="text-align: right;">role</th>
<th style="text-align: left;">username</th>
<th style="text-align: left;">email</th>
<th style="text-align: left;">firstname</th>
<th style="text-align: left;">lastname</th>
<th style="text-align: left;">expiration</th>
<th style="text-align: left;">data_access_group</th>
<th style="text-align: right;">data_access_group_id</th>
<th style="text-align: right;">design</th>
<th style="text-align: right;">user_rights</th>
<th style="text-align: right;">data_access_groups</th>
<th style="text-align: right;">data_export</th>
<th style="text-align: right;">reports</th>
<th style="text-align: right;">stats_and_charts</th>
<th style="text-align: right;">manage_survey_participants</th>
<th style="text-align: right;">calendar</th>
<th style="text-align: right;">data_import_tool</th>
<th style="text-align: right;">data_comparison_tool</th>
<th style="text-align: right;">logging</th>
<th style="text-align: right;">file_repository</th>
<th style="text-align: right;">data_quality_create</th>
<th style="text-align: right;">data_quality_execute</th>
<th style="text-align: right;">api_export</th>
<th style="text-align: right;">api_import</th>
<th style="text-align: right;">mobile_app</th>
<th style="text-align: right;">mobile_app_download_data</th>
<th style="text-align: right;">record_create</th>
<th style="text-align: right;">record_rename</th>
<th style="text-align: right;">record_delete</th>
<th style="text-align: right;">lock_records_all_forms</th>
<th style="text-align: right;">lock_records</th>
<th style="text-align: right;">lock_records_customization</th>
<th style="text-align: left;">forms</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: right;">1</td>
<td style="text-align: left;">a_barker</td>
<td style="text-align: left;"><a href="mailto:a_barker@email.com">a_barker@email.com</a></td>
<td style="text-align: left;">Aleesha</td>
<td style="text-align: left;">Barker</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_a</td>
<td style="text-align: right;">4117</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="even">
<td style="text-align: right;">1</td>
<td style="text-align: left;">a_hicks</td>
<td style="text-align: left;"><a href="mailto:a_hicks@email.com">a_hicks@email.com</a></td>
<td style="text-align: left;">Alyssa</td>
<td style="text-align: left;">Hicks</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_e</td>
<td style="text-align: right;">4121</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="odd">
<td style="text-align: right;">1</td>
<td style="text-align: left;">a_lees</td>
<td style="text-align: left;"><a href="mailto:a_lees@email.com">a_lees@email.com</a></td>
<td style="text-align: left;">Aleesha</td>
<td style="text-align: left;">Lees</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_g</td>
<td style="text-align: right;">4123</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="even">
<td style="text-align: right;">1</td>
<td style="text-align: left;">a_nicholson</td>
<td style="text-align: left;"><a href="mailto:a_nicholson@email.com">a_nicholson@email.com</a></td>
<td style="text-align: left;">Alyssa</td>
<td style="text-align: left;">Nicholson</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_i</td>
<td style="text-align: right;">4125</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="odd">
<td style="text-align: right;">1</td>
<td style="text-align: left;">c_avila</td>
<td style="text-align: left;"><a href="mailto:c_avila@email.com">c_avila@email.com</a></td>
<td style="text-align: left;">Chanice</td>
<td style="text-align: left;">Avila</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: right;">NA</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="even">
<td style="text-align: right;">1</td>
<td style="text-align: left;">c_gould</td>
<td style="text-align: left;"><a href="mailto:c_gould@email.com">c_gould@email.com</a></td>
<td style="text-align: left;">Chanice</td>
<td style="text-align: left;">Gould</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_b</td>
<td style="text-align: right;">4118</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="odd">
<td style="text-align: right;">1</td>
<td style="text-align: left;">c_kent</td>
<td style="text-align: left;"><a href="mailto:c_kent@email.com">c_kent@email.com</a></td>
<td style="text-align: left;">Chanice</td>
<td style="text-align: left;">Kent</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_f</td>
<td style="text-align: right;">4122</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="even">
<td style="text-align: right;">1</td>
<td style="text-align: left;">c_michael</td>
<td style="text-align: left;"><a href="mailto:c_michael@email.com">c_michael@email.com</a></td>
<td style="text-align: left;">Chanice</td>
<td style="text-align: left;">Michael</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_h</td>
<td style="text-align: right;">4124</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="odd">
<td style="text-align: right;">1</td>
<td style="text-align: left;">f_almond</td>
<td style="text-align: left;"><a href="mailto:f_almond@email.com">f_almond@email.com</a></td>
<td style="text-align: left;">Fleur</td>
<td style="text-align: left;">Almond</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: right;">NA</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="even">
<td style="text-align: right;">1</td>
<td style="text-align: left;">f_galindo</td>
<td style="text-align: left;"><a href="mailto:f_galindo@email.com">f_galindo@email.com</a></td>
<td style="text-align: left;">Fleur</td>
<td style="text-align: left;">Galindo</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_a</td>
<td style="text-align: right;">4117</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="odd">
<td style="text-align: right;">1</td>
<td style="text-align: left;">f_livingston</td>
<td style="text-align: left;"><a href="mailto:f_livingston@email.com">f_livingston@email.com</a></td>
<td style="text-align: left;">Fleur</td>
<td style="text-align: left;">Livingston</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_g</td>
<td style="text-align: right;">4123</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="even">
<td style="text-align: right;">1</td>
<td style="text-align: left;">h_herman</td>
<td style="text-align: left;"><a href="mailto:h_herman@email.com">h_herman@email.com</a></td>
<td style="text-align: left;">Hailie</td>
<td style="text-align: left;">Herman</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_d</td>
<td style="text-align: right;">4120</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="odd">
<td style="text-align: right;">1</td>
<td style="text-align: left;">h_mustafa</td>
<td style="text-align: left;"><a href="mailto:h_mustafa@email.com">h_mustafa@email.com</a></td>
<td style="text-align: left;">Hailie</td>
<td style="text-align: left;">Mustafa</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_i</td>
<td style="text-align: right;">4125</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="even">
<td style="text-align: right;">1</td>
<td style="text-align: left;">k_ashton</td>
<td style="text-align: left;"><a href="mailto:k_ashton@email.com">k_ashton@email.com</a></td>
<td style="text-align: left;">Kester</td>
<td style="text-align: left;">Ashton</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: right;">NA</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="odd">
<td style="text-align: right;">1</td>
<td style="text-align: left;">k_gibbons</td>
<td style="text-align: left;"><a href="mailto:k_gibbons@email.com">k_gibbons@email.com</a></td>
<td style="text-align: left;">Kester</td>
<td style="text-align: left;">Gibbons</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_b</td>
<td style="text-align: right;">4118</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="even">
<td style="text-align: right;">1</td>
<td style="text-align: left;">k_marks</td>
<td style="text-align: left;"><a href="mailto:k_marks@email.com">k_marks@email.com</a></td>
<td style="text-align: left;">Kester</td>
<td style="text-align: left;">Marks</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_h</td>
<td style="text-align: right;">4124</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="odd">
<td style="text-align: right;">1</td>
<td style="text-align: left;">l_cervantes</td>
<td style="text-align: left;"><a href="mailto:l_cervantes@email.com">l_cervantes@email.com</a></td>
<td style="text-align: left;">Leroy</td>
<td style="text-align: left;">Cervantes</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_a</td>
<td style="text-align: right;">4117</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="even">
<td style="text-align: right;">1</td>
<td style="text-align: left;">l_jensen</td>
<td style="text-align: left;"><a href="mailto:l_jensen@email.com">l_jensen@email.com</a></td>
<td style="text-align: left;">Leroy</td>
<td style="text-align: left;">Jensen</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_e</td>
<td style="text-align: right;">4121</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="odd">
<td style="text-align: right;">1</td>
<td style="text-align: left;">l_paine</td>
<td style="text-align: left;"><a href="mailto:l_paine@email.com">l_paine@email.com</a></td>
<td style="text-align: left;">Leroy</td>
<td style="text-align: left;">Paine</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_j</td>
<td style="text-align: right;">4126</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="even">
<td style="text-align: right;">1</td>
<td style="text-align: left;">m_owens</td>
<td style="text-align: left;"><a href="mailto:m_owens@email.com">m_owens@email.com</a></td>
<td style="text-align: left;">Martha</td>
<td style="text-align: left;">Owens</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_j</td>
<td style="text-align: right;">4126</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="odd">
<td style="text-align: right;">1</td>
<td style="text-align: left;">r_bradford</td>
<td style="text-align: left;"><a href="mailto:r_bradford@email.com">r_bradford@email.com</a></td>
<td style="text-align: left;">Ralph</td>
<td style="text-align: left;">Bradford</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_c</td>
<td style="text-align: right;">4119</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="even">
<td style="text-align: right;">1</td>
<td style="text-align: left;">r_hodge</td>
<td style="text-align: left;"><a href="mailto:r_hodge@email.com">r_hodge@email.com</a></td>
<td style="text-align: left;">Ralph</td>
<td style="text-align: left;">Hodge</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_f</td>
<td style="text-align: right;">4122</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="odd">
<td style="text-align: right;">1</td>
<td style="text-align: left;">r_ochoa</td>
<td style="text-align: left;"><a href="mailto:r_ochoa@email.com">r_ochoa@email.com</a></td>
<td style="text-align: left;">Ralph</td>
<td style="text-align: left;">Ochoa</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_i</td>
<td style="text-align: right;">4125</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="even">
<td style="text-align: right;">1</td>
<td style="text-align: left;">s_ayala</td>
<td style="text-align: left;"><a href="mailto:s_ayala@email.com">s_ayala@email.com</a></td>
<td style="text-align: left;">Samiha</td>
<td style="text-align: left;">Ayala</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: right;">NA</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="odd">
<td style="text-align: right;">1</td>
<td style="text-align: left;">s_beech</td>
<td style="text-align: left;"><a href="mailto:s_beech@email.com">s_beech@email.com</a></td>
<td style="text-align: left;">Shanelle</td>
<td style="text-align: left;">Beech</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_b</td>
<td style="text-align: right;">4118</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="even">
<td style="text-align: right;">1</td>
<td style="text-align: left;">s_hardy</td>
<td style="text-align: left;"><a href="mailto:s_hardy@email.com">s_hardy@email.com</a></td>
<td style="text-align: left;">Shanelle</td>
<td style="text-align: left;">Hardy</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_d</td>
<td style="text-align: right;">4120</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="odd">
<td style="text-align: right;">1</td>
<td style="text-align: left;">s_moses</td>
<td style="text-align: left;"><a href="mailto:s_moses@email.com">s_moses@email.com</a></td>
<td style="text-align: left;">Shanelle</td>
<td style="text-align: left;">Moses</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_h</td>
<td style="text-align: right;">4124</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="even">
<td style="text-align: right;">1</td>
<td style="text-align: left;">y_andersen</td>
<td style="text-align: left;"><a href="mailto:y_andersen@email.com">y_andersen@email.com</a></td>
<td style="text-align: left;">Yaseen</td>
<td style="text-align: left;">Andersen</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: right;">NA</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="odd">
<td style="text-align: right;">1</td>
<td style="text-align: left;">y_holder</td>
<td style="text-align: left;"><a href="mailto:y_holder@email.com">y_holder@email.com</a></td>
<td style="text-align: left;">Yara</td>
<td style="text-align: left;">Holder</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_e</td>
<td style="text-align: right;">4121</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="even">
<td style="text-align: right;">1</td>
<td style="text-align: left;">y_mackie</td>
<td style="text-align: left;"><a href="mailto:y_mackie@email.com">y_mackie@email.com</a></td>
<td style="text-align: left;">Yaseen</td>
<td style="text-align: left;">Mackie</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_g</td>
<td style="text-align: right;">4123</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="odd">
<td style="text-align: right;">1</td>
<td style="text-align: left;">y_o’doherty</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_j</td>
<td style="text-align: right;">4126</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="even">
<td style="text-align: right;">1</td>
<td style="text-align: left;">y_odoherty</td>
<td style="text-align: left;"><a href="mailto:y_odoherty@email.com">y_odoherty@email.com</a></td>
<td style="text-align: left;">Yara</td>
<td style="text-align: left;">O’Doherty</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_j</td>
<td style="text-align: right;">4126</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="odd">
<td style="text-align: right;">2</td>
<td style="text-align: left;">a_hanna</td>
<td style="text-align: left;"><a href="mailto:a_hanna@email.com">a_hanna@email.com</a></td>
<td style="text-align: left;">Aleesha</td>
<td style="text-align: left;">Hanna</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_d</td>
<td style="text-align: right;">4120</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:2" class="uri">data:2</a></td>
</tr>
<tr class="even">
<td style="text-align: right;">2</td>
<td style="text-align: left;">s_knights</td>
<td style="text-align: left;"><a href="mailto:s_knights@email.com">s_knights@email.com</a></td>
<td style="text-align: left;">Samiha</td>
<td style="text-align: left;">Knights</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_f</td>
<td style="text-align: right;">4122</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:2" class="uri">data:2</a></td>
</tr>
<tr class="odd">
<td style="text-align: right;">2</td>
<td style="text-align: left;">y_cameron</td>
<td style="text-align: left;"><a href="mailto:y_cameron@email.com">y_cameron@email.com</a></td>
<td style="text-align: left;">Yara</td>
<td style="text-align: left;">Cameron</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_c</td>
<td style="text-align: right;">4119</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:2" class="uri">data:2</a></td>
</tr>
<tr class="even">
<td style="text-align: right;">3</td>
<td style="text-align: left;">kmclean</td>
<td style="text-align: left;"><a href="mailto:mcleankaca@gmail.com">mcleankaca@gmail.com</a></td>
<td style="text-align: left;">Kenneth</td>
<td style="text-align: left;">McLean</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: right;">NA</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
</tbody>
</table>

**ii). $examples:** A dataframe of each role (1:n) and an example
username with those rights (can be used as input for the `user_roles()`
function).

    user_roles_n_eg <- user_roles_n(redcap_project_uri, redcap_project_token)$examples

    ## [1] "There are 3 unique roles in this redcap project"

    knitr::kable(user_roles_n_eg)

<table>
<thead>
<tr class="header">
<th style="text-align: right;">role</th>
<th style="text-align: left;">username</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: right;">1</td>
<td style="text-align: left;">a_barker</td>
</tr>
<tr class="even">
<td style="text-align: right;">2</td>
<td style="text-align: left;">a_hanna</td>
</tr>
<tr class="odd">
<td style="text-align: right;">3</td>
<td style="text-align: left;">kmclean</td>
</tr>
</tbody>
</table>

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

    knitr::kable(user_role_examples)

<table>
<thead>
<tr class="header">
<th style="text-align: left;">role</th>
<th style="text-align: left;">username</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">a_barker</td>
</tr>
<tr class="even">
<td style="text-align: left;">validator</td>
<td style="text-align: left;">a_hanna</td>
</tr>
<tr class="odd">
<td style="text-align: left;">administrator</td>
<td style="text-align: left;">kmclean</td>
</tr>
</tbody>
</table>

### b). Usage of `user_roles()`

Use `user_roles()` to apply named roles to all users according to
example users with those rights. E.g. In the example above, everyone
with the same user rights as the example collaborator “a\_barker” will
be assigned the “collaborator” role.

    user_roles_full <- user_roles(redcap_project_uri, redcap_project_token, user_role_examples)

    knitr::kable(user_roles_full)

<table>
<thead>
<tr class="header">
<th style="text-align: left;">role</th>
<th style="text-align: left;">username</th>
<th style="text-align: left;">email</th>
<th style="text-align: left;">firstname</th>
<th style="text-align: left;">lastname</th>
<th style="text-align: left;">expiration</th>
<th style="text-align: left;">data_access_group</th>
<th style="text-align: right;">data_access_group_id</th>
<th style="text-align: right;">design</th>
<th style="text-align: right;">user_rights</th>
<th style="text-align: right;">data_access_groups</th>
<th style="text-align: right;">data_export</th>
<th style="text-align: right;">reports</th>
<th style="text-align: right;">stats_and_charts</th>
<th style="text-align: right;">manage_survey_participants</th>
<th style="text-align: right;">calendar</th>
<th style="text-align: right;">data_import_tool</th>
<th style="text-align: right;">data_comparison_tool</th>
<th style="text-align: right;">logging</th>
<th style="text-align: right;">file_repository</th>
<th style="text-align: right;">data_quality_create</th>
<th style="text-align: right;">data_quality_execute</th>
<th style="text-align: right;">api_export</th>
<th style="text-align: right;">api_import</th>
<th style="text-align: right;">mobile_app</th>
<th style="text-align: right;">mobile_app_download_data</th>
<th style="text-align: right;">record_create</th>
<th style="text-align: right;">record_rename</th>
<th style="text-align: right;">record_delete</th>
<th style="text-align: right;">lock_records_all_forms</th>
<th style="text-align: right;">lock_records</th>
<th style="text-align: right;">lock_records_customization</th>
<th style="text-align: left;">forms</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">administrator</td>
<td style="text-align: left;">kmclean</td>
<td style="text-align: left;"><a href="mailto:mcleankaca@gmail.com">mcleankaca@gmail.com</a></td>
<td style="text-align: left;">Kenneth</td>
<td style="text-align: left;">McLean</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: right;">NA</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">a_barker</td>
<td style="text-align: left;"><a href="mailto:a_barker@email.com">a_barker@email.com</a></td>
<td style="text-align: left;">Aleesha</td>
<td style="text-align: left;">Barker</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_a</td>
<td style="text-align: right;">4117</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">k_ashton</td>
<td style="text-align: left;"><a href="mailto:k_ashton@email.com">k_ashton@email.com</a></td>
<td style="text-align: left;">Kester</td>
<td style="text-align: left;">Ashton</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: right;">NA</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">a_hicks</td>
<td style="text-align: left;"><a href="mailto:a_hicks@email.com">a_hicks@email.com</a></td>
<td style="text-align: left;">Alyssa</td>
<td style="text-align: left;">Hicks</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_e</td>
<td style="text-align: right;">4121</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">a_lees</td>
<td style="text-align: left;"><a href="mailto:a_lees@email.com">a_lees@email.com</a></td>
<td style="text-align: left;">Aleesha</td>
<td style="text-align: left;">Lees</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_g</td>
<td style="text-align: right;">4123</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">a_nicholson</td>
<td style="text-align: left;"><a href="mailto:a_nicholson@email.com">a_nicholson@email.com</a></td>
<td style="text-align: left;">Alyssa</td>
<td style="text-align: left;">Nicholson</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_i</td>
<td style="text-align: right;">4125</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">c_avila</td>
<td style="text-align: left;"><a href="mailto:c_avila@email.com">c_avila@email.com</a></td>
<td style="text-align: left;">Chanice</td>
<td style="text-align: left;">Avila</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: right;">NA</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">c_gould</td>
<td style="text-align: left;"><a href="mailto:c_gould@email.com">c_gould@email.com</a></td>
<td style="text-align: left;">Chanice</td>
<td style="text-align: left;">Gould</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_b</td>
<td style="text-align: right;">4118</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">c_kent</td>
<td style="text-align: left;"><a href="mailto:c_kent@email.com">c_kent@email.com</a></td>
<td style="text-align: left;">Chanice</td>
<td style="text-align: left;">Kent</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_f</td>
<td style="text-align: right;">4122</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">c_michael</td>
<td style="text-align: left;"><a href="mailto:c_michael@email.com">c_michael@email.com</a></td>
<td style="text-align: left;">Chanice</td>
<td style="text-align: left;">Michael</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_h</td>
<td style="text-align: right;">4124</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">f_almond</td>
<td style="text-align: left;"><a href="mailto:f_almond@email.com">f_almond@email.com</a></td>
<td style="text-align: left;">Fleur</td>
<td style="text-align: left;">Almond</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: right;">NA</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">f_galindo</td>
<td style="text-align: left;"><a href="mailto:f_galindo@email.com">f_galindo@email.com</a></td>
<td style="text-align: left;">Fleur</td>
<td style="text-align: left;">Galindo</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_a</td>
<td style="text-align: right;">4117</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">f_livingston</td>
<td style="text-align: left;"><a href="mailto:f_livingston@email.com">f_livingston@email.com</a></td>
<td style="text-align: left;">Fleur</td>
<td style="text-align: left;">Livingston</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_g</td>
<td style="text-align: right;">4123</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">h_herman</td>
<td style="text-align: left;"><a href="mailto:h_herman@email.com">h_herman@email.com</a></td>
<td style="text-align: left;">Hailie</td>
<td style="text-align: left;">Herman</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_d</td>
<td style="text-align: right;">4120</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">h_mustafa</td>
<td style="text-align: left;"><a href="mailto:h_mustafa@email.com">h_mustafa@email.com</a></td>
<td style="text-align: left;">Hailie</td>
<td style="text-align: left;">Mustafa</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_i</td>
<td style="text-align: right;">4125</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">s_hardy</td>
<td style="text-align: left;"><a href="mailto:s_hardy@email.com">s_hardy@email.com</a></td>
<td style="text-align: left;">Shanelle</td>
<td style="text-align: left;">Hardy</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_d</td>
<td style="text-align: right;">4120</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">k_gibbons</td>
<td style="text-align: left;"><a href="mailto:k_gibbons@email.com">k_gibbons@email.com</a></td>
<td style="text-align: left;">Kester</td>
<td style="text-align: left;">Gibbons</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_b</td>
<td style="text-align: right;">4118</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">k_marks</td>
<td style="text-align: left;"><a href="mailto:k_marks@email.com">k_marks@email.com</a></td>
<td style="text-align: left;">Kester</td>
<td style="text-align: left;">Marks</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_h</td>
<td style="text-align: right;">4124</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">y_andersen</td>
<td style="text-align: left;"><a href="mailto:y_andersen@email.com">y_andersen@email.com</a></td>
<td style="text-align: left;">Yaseen</td>
<td style="text-align: left;">Andersen</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: right;">NA</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">l_cervantes</td>
<td style="text-align: left;"><a href="mailto:l_cervantes@email.com">l_cervantes@email.com</a></td>
<td style="text-align: left;">Leroy</td>
<td style="text-align: left;">Cervantes</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_a</td>
<td style="text-align: right;">4117</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">l_jensen</td>
<td style="text-align: left;"><a href="mailto:l_jensen@email.com">l_jensen@email.com</a></td>
<td style="text-align: left;">Leroy</td>
<td style="text-align: left;">Jensen</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_e</td>
<td style="text-align: right;">4121</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">l_paine</td>
<td style="text-align: left;"><a href="mailto:l_paine@email.com">l_paine@email.com</a></td>
<td style="text-align: left;">Leroy</td>
<td style="text-align: left;">Paine</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_j</td>
<td style="text-align: right;">4126</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">m_owens</td>
<td style="text-align: left;"><a href="mailto:m_owens@email.com">m_owens@email.com</a></td>
<td style="text-align: left;">Martha</td>
<td style="text-align: left;">Owens</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_j</td>
<td style="text-align: right;">4126</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">r_bradford</td>
<td style="text-align: left;"><a href="mailto:r_bradford@email.com">r_bradford@email.com</a></td>
<td style="text-align: left;">Ralph</td>
<td style="text-align: left;">Bradford</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_c</td>
<td style="text-align: right;">4119</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">r_hodge</td>
<td style="text-align: left;"><a href="mailto:r_hodge@email.com">r_hodge@email.com</a></td>
<td style="text-align: left;">Ralph</td>
<td style="text-align: left;">Hodge</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_f</td>
<td style="text-align: right;">4122</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">r_ochoa</td>
<td style="text-align: left;"><a href="mailto:r_ochoa@email.com">r_ochoa@email.com</a></td>
<td style="text-align: left;">Ralph</td>
<td style="text-align: left;">Ochoa</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_i</td>
<td style="text-align: right;">4125</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">s_ayala</td>
<td style="text-align: left;"><a href="mailto:s_ayala@email.com">s_ayala@email.com</a></td>
<td style="text-align: left;">Samiha</td>
<td style="text-align: left;">Ayala</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: right;">NA</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">s_beech</td>
<td style="text-align: left;"><a href="mailto:s_beech@email.com">s_beech@email.com</a></td>
<td style="text-align: left;">Shanelle</td>
<td style="text-align: left;">Beech</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_b</td>
<td style="text-align: right;">4118</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">y_odoherty</td>
<td style="text-align: left;"><a href="mailto:y_odoherty@email.com">y_odoherty@email.com</a></td>
<td style="text-align: left;">Yara</td>
<td style="text-align: left;">O’Doherty</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_j</td>
<td style="text-align: right;">4126</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">y_holder</td>
<td style="text-align: left;"><a href="mailto:y_holder@email.com">y_holder@email.com</a></td>
<td style="text-align: left;">Yara</td>
<td style="text-align: left;">Holder</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_e</td>
<td style="text-align: right;">4121</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">s_moses</td>
<td style="text-align: left;"><a href="mailto:s_moses@email.com">s_moses@email.com</a></td>
<td style="text-align: left;">Shanelle</td>
<td style="text-align: left;">Moses</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_h</td>
<td style="text-align: right;">4124</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">y_o’doherty</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_j</td>
<td style="text-align: right;">4126</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">y_mackie</td>
<td style="text-align: left;"><a href="mailto:y_mackie@email.com">y_mackie@email.com</a></td>
<td style="text-align: left;">Yaseen</td>
<td style="text-align: left;">Mackie</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_g</td>
<td style="text-align: right;">4123</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:1" class="uri">data:1</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">validator</td>
<td style="text-align: left;">a_hanna</td>
<td style="text-align: left;"><a href="mailto:a_hanna@email.com">a_hanna@email.com</a></td>
<td style="text-align: left;">Aleesha</td>
<td style="text-align: left;">Hanna</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_d</td>
<td style="text-align: right;">4120</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:2" class="uri">data:2</a></td>
</tr>
<tr class="odd">
<td style="text-align: left;">validator</td>
<td style="text-align: left;">s_knights</td>
<td style="text-align: left;"><a href="mailto:s_knights@email.com">s_knights@email.com</a></td>
<td style="text-align: left;">Samiha</td>
<td style="text-align: left;">Knights</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_f</td>
<td style="text-align: right;">4122</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:2" class="uri">data:2</a></td>
</tr>
<tr class="even">
<td style="text-align: left;">validator</td>
<td style="text-align: left;">y_cameron</td>
<td style="text-align: left;"><a href="mailto:y_cameron@email.com">y_cameron@email.com</a></td>
<td style="text-align: left;">Yara</td>
<td style="text-align: left;">Cameron</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_c</td>
<td style="text-align: right;">4119</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">example_<a href="data:2" class="uri">data:2</a></td>
</tr>
</tbody>
</table>

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

    knitr::kable(user_validate_out$dag_unallocated)

<table>
<thead>
<tr class="header">
<th style="text-align: left;">username</th>
<th style="text-align: left;">data_access_group</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">c_avila</td>
<td style="text-align: left;">NA</td>
</tr>
<tr class="even">
<td style="text-align: left;">f_almond</td>
<td style="text-align: left;">NA</td>
</tr>
<tr class="odd">
<td style="text-align: left;">k_ashton</td>
<td style="text-align: left;">NA</td>
</tr>
<tr class="even">
<td style="text-align: left;">s_ayala</td>
<td style="text-align: left;">NA</td>
</tr>
<tr class="odd">
<td style="text-align: left;">y_andersen</td>
<td style="text-align: left;">NA</td>
</tr>
</tbody>
</table>

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

    knitr::kable(user_validate_out$dag_incorrect)

<table>
<thead>
<tr class="header">
<th style="text-align: left;">username</th>
<th style="text-align: left;">DAG_user_new</th>
<th style="text-align: left;">DAG_user_current</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">a_lees</td>
<td style="text-align: left;">hospital_h</td>
<td style="text-align: left;">hospital_g</td>
</tr>
<tr class="even">
<td style="text-align: left;">r_hodge</td>
<td style="text-align: left;">hospital_i</td>
<td style="text-align: left;">hospital_f</td>
</tr>
<tr class="odd">
<td style="text-align: left;">s_hardy</td>
<td style="text-align: left;">hospital_e</td>
<td style="text-align: left;">hospital_d</td>
</tr>
<tr class="even">
<td style="text-align: left;">y_cameron</td>
<td style="text-align: left;">hospital_d</td>
<td style="text-align: left;">hospital_c</td>
</tr>
</tbody>
</table>

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

    knitr::kable(user_validate_out$forms_na)

username data\_access\_group forms ——— —————— ——

-   The `$forms_na` output will highlight the individual users currently
    on REDCap with NA recorded for their form rights (e.g. ability to
    access data collection instruments).

-   This can occur in the specific circumstance where REDCap user “role
    names” are being used, and the name of a data collection instrument
    is changed **after** the “role name” is created but **without**
    editing and saving the existing user role on REDCap. Once this role
    is confirmed with the changed names of the forms, this error should
    disappear.
