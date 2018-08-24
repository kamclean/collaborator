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
the REDcap Project (e.g. the number of unique combinations of user
rights).

There are 3 outputs from `user_roles_n()`:

**a). A string stating “There are n unique roles in this redcap
project”.**

**b). A nested dataframe of:**

**i). $full:** A dataframe of all user rights of the redcap project
(with an additional column called “role” which numbers users 1:n
according to their unique role).

    # Example output from user_roles_n()
    user_roles_n_full <- collaborator::example_user_roles_n_full # please note all names are randomly generated

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
<td style="text-align: left;">f_almond</td>
<td style="text-align: left;"><a href="mailto:f_almond@email.com">f_almond@email.com</a></td>
<td style="text-align: left;">Fleur</td>
<td style="text-align: left;">Almond</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: right;">NA</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">2</td>
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
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">patient_demographics:1,admission_details:1,follow_up:1,validation:1</td>
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
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">2</td>
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
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">patient_demographics:1,admission_details:1,follow_up:1,validation:1</td>
</tr>
<tr class="odd">
<td style="text-align: right;">2</td>
<td style="text-align: left;">k_ashton</td>
<td style="text-align: left;"><a href="mailto:k_ashton@email.com">k_ashton@email.com</a></td>
<td style="text-align: left;">Kester</td>
<td style="text-align: left;">Ashton</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: right;">NA</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
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
<td style="text-align: left;">patient_demographics:1,admission_details:1,follow_up:1,validation:1</td>
</tr>
<tr class="even">
<td style="text-align: right;">2</td>
<td style="text-align: left;">c_avila</td>
<td style="text-align: left;"><a href="mailto:c_avila@email.com">c_avila@email.com</a></td>
<td style="text-align: left;">Chanice</td>
<td style="text-align: left;">Avila</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: right;">NA</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
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
<td style="text-align: left;">patient_demographics:1,admission_details:1,follow_up:1,validation:1</td>
</tr>
<tr class="odd">
<td style="text-align: right;">2</td>
<td style="text-align: left;">s_ayala</td>
<td style="text-align: left;"><a href="mailto:s_ayala@email.com">s_ayala@email.com</a></td>
<td style="text-align: left;">Samiha</td>
<td style="text-align: left;">Ayala</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: right;">NA</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
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
<td style="text-align: left;">patient_demographics:1,admission_details:1,follow_up:1,validation:1</td>
</tr>
<tr class="even">
<td style="text-align: right;">3</td>
<td style="text-align: left;">a_barker</td>
<td style="text-align: left;"><a href="mailto:a_barker@email.com">a_barker@email.com</a></td>
<td style="text-align: left;">Aleesha</td>
<td style="text-align: left;">Barker</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_A</td>
<td style="text-align: right;">1001</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
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
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">patient_demographics:1,admission_details:1,follow_up:1,validation:0</td>
</tr>
<tr class="odd">
<td style="text-align: right;">3</td>
<td style="text-align: left;">s_beech</td>
<td style="text-align: left;"><a href="mailto:s_beech@email.com">s_beech@email.com</a></td>
<td style="text-align: left;">Shanelle</td>
<td style="text-align: left;">Beech</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_B</td>
<td style="text-align: right;">1002</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
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
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">patient_demographics:1,admission_details:1,follow_up:1,validation:0</td>
</tr>
<tr class="even">
<td style="text-align: right;">3</td>
<td style="text-align: left;">h_berry</td>
<td style="text-align: left;"><a href="mailto:h_berry@email.com">h_berry@email.com</a></td>
<td style="text-align: left;">Hailie</td>
<td style="text-align: left;">Berry</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_B</td>
<td style="text-align: right;">1002</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
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
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">patient_demographics:1,admission_details:1,follow_up:1,validation:0</td>
</tr>
<tr class="odd">
<td style="text-align: right;">3</td>
<td style="text-align: left;">a_bowen</td>
<td style="text-align: left;"><a href="mailto:a_bowen@email.com">a_bowen@email.com</a></td>
<td style="text-align: left;">Alyssa</td>
<td style="text-align: left;">Bowen</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_C</td>
<td style="text-align: right;">1003</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
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
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">patient_demographics:1,admission_details:1,follow_up:1,validation:0</td>
</tr>
<tr class="even">
<td style="text-align: right;">3</td>
<td style="text-align: left;">r_bradford</td>
<td style="text-align: left;"><a href="mailto:r_bradford@email.com">r_bradford@email.com</a></td>
<td style="text-align: left;">Ralph</td>
<td style="text-align: left;">Bradford</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_C</td>
<td style="text-align: right;">1003</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
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
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">patient_demographics:1,admission_details:1,follow_up:1,validation:0</td>
</tr>
<tr class="odd">
<td style="text-align: right;">3</td>
<td style="text-align: left;">y_cameron</td>
<td style="text-align: left;"><a href="mailto:y_cameron@email.com">y_cameron@email.com</a></td>
<td style="text-align: left;">Yara</td>
<td style="text-align: left;">Cameron</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_D</td>
<td style="text-align: right;">1004</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
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
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">patient_demographics:1,admission_details:1,follow_up:1,validation:0</td>
</tr>
<tr class="even">
<td style="text-align: right;">3</td>
<td style="text-align: left;">m_cantrell</td>
<td style="text-align: left;"><a href="mailto:m_cantrell@email.com">m_cantrell@email.com</a></td>
<td style="text-align: left;">Meg</td>
<td style="text-align: left;">Cantrell</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_D</td>
<td style="text-align: right;">1004</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
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
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: left;">patient_demographics:1,admission_details:1,follow_up:1,validation:0</td>
</tr>
<tr class="odd">
<td style="text-align: right;">4</td>
<td style="text-align: left;">a_carlson</td>
<td style="text-align: left;"><a href="mailto:a_carlson@email.com">a_carlson@email.com</a></td>
<td style="text-align: left;">Ayomide</td>
<td style="text-align: left;">Carlson</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_A</td>
<td style="text-align: right;">1001</td>
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
<td style="text-align: left;">patient_demographics:0,admission_details:0,follow_up:0,validation:1</td>
</tr>
<tr class="even">
<td style="text-align: right;">4</td>
<td style="text-align: left;">m_carrillo</td>
<td style="text-align: left;"><a href="mailto:m_carrillo@email.com">m_carrillo@email.com</a></td>
<td style="text-align: left;">Martha</td>
<td style="text-align: left;">Carrillo</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_B</td>
<td style="text-align: right;">1002</td>
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
<td style="text-align: left;">patient_demographics:0,admission_details:0,follow_up:0,validation:1</td>
</tr>
<tr class="odd">
<td style="text-align: right;">4</td>
<td style="text-align: left;">l_cervantes</td>
<td style="text-align: left;"><a href="mailto:l_cervantes@email.com">l_cervantes@email.com</a></td>
<td style="text-align: left;">Leroy</td>
<td style="text-align: left;">Cervantes</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">hospital_D</td>
<td style="text-align: right;">1004</td>
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
<td style="text-align: left;">patient_demographics:0,admission_details:0,follow_up:0,validation:1</td>
</tr>
</tbody>
</table>

**ii). $examples:** A dataframe of each role (1:n) and an example
username with those rights (can be used as input for the `user_roles()`
function).

    user_roles_n_eg <- collaborator::example_user_roles_n_eg

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
<td style="text-align: left;">f_almond</td>
</tr>
<tr class="even">
<td style="text-align: right;">2</td>
<td style="text-align: left;">k_ashton</td>
</tr>
<tr class="odd">
<td style="text-align: right;">3</td>
<td style="text-align: left;">a_barker</td>
</tr>
<tr class="even">
<td style="text-align: right;">4</td>
<td style="text-align: left;">a_carlson</td>
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
    user_roles_n_eg <- collaborator::example_user_roles_n_eg

    user_roles_n_eg %>%
      dplyr::mutate(role = factor(role,
                           levels=c(1:nrow(user_roles_n_eg)),
                           labels=c("administrator", "committee", "collaborator", "validator"))) %>%
      dplyr::mutate(role = as.character(role)) %>%
      knitr::kable()

<table>
<thead>
<tr class="header">
<th style="text-align: left;">role</th>
<th style="text-align: left;">username</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">administrator</td>
<td style="text-align: left;">f_almond</td>
</tr>
<tr class="even">
<td style="text-align: left;">committee</td>
<td style="text-align: left;">k_ashton</td>
</tr>
<tr class="odd">
<td style="text-align: left;">collaborator</td>
<td style="text-align: left;">a_barker</td>
</tr>
<tr class="even">
<td style="text-align: left;">validator</td>
<td style="text-align: left;">a_carlson</td>
</tr>
</tbody>
</table>

### b). Usage of `user_roles()`

Use `user_roles()` to apply named roles to all users according to
example users with those rights. E.g. In the example above, everyone
with the same user rights as the example collaborator “a\_barker” will
be assigned the “collaborator” role.

This allows further analyses to be done using roles which are not
currently possible within REDCap (e.g. tables, plots, etc), and can be
used to subsequently automatically upload and allocate user rights (see
[Redcap User Management: 2. Assign User
Rights](https://github.com/kamclean/collaborator/blob/master/vignettes/vignette_user_2_assign.Rmd))

    user_roles_full <- collaborator::example_user_roles_full

    table(user_roles_full$role) %>%
      knitr::kable()

<table>
<thead>
<tr class="header">
<th style="text-align: left;">Var1</th>
<th style="text-align: right;">Freq</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">administrator</td>
<td style="text-align: right;">2</td>
</tr>
<tr class="even">
<td style="text-align: left;">collaborator</td>
<td style="text-align: right;">7</td>
</tr>
<tr class="odd">
<td style="text-align: left;">committee</td>
<td style="text-align: right;">3</td>
</tr>
<tr class="even">
<td style="text-align: left;">validator</td>
<td style="text-align: right;">3</td>
</tr>
</tbody>
</table>

`user_validate()`
-----------------

Use `user_validate()` to explore the rights of current users, and
identify signficant errors in assignment of user rights. This is a
useful tool whether user rights are allocated manually, or
[automatically](https://github.com/kamclean/collaborator/blob/master/vignettes/vignette_user_2_assign.Rmd).

The output from `user_validate()` is 3 nested dataframes:

### a). `$forms_na`

The unallocation of form rights is a possible error during automatic
assignment of user rights. **In this case these users will have view and
edit rights to all forms (within their DAG) on the REDCap project**.

-   The `$forms_na` output will highlight the individual users currently
    on REDCap with NA recorded for their form rights (e.g. ability to
    access data collection instruments).

-   This can occur in the specific circumstance where REDCap user “role
    names” are being used, and the name of a data collection instrument
    is changed **after** the “role name” is created but **without**
    editing and saving the existing user role on REDCap. Once this role
    is comfirmed with the changed names of the forms, this error should
    disappear.

### b). `$dag_unallocated`

The unallocation of data access groups is a common error during manual
assignment of user rights. **In this case these users will be able to
access all records (within their form rights) in the REDCap project**.

-   The `$dag_unallocated` output will highlight the individual users
    currently on REDCap with NA recorded for their DAG.

-   However, not all unallocated DAGS are “incorrect” - some users
    (e.g. administrators) may require to view any records on the
    project. It is recommended that in this case these users are
    excluded using `users_exception`.

### c). `$dag_incorrect`

The incorrect allocation of data access groups is a common error during
manual assignment of user rights. **In this case these users will have
access to and be able to upload records within another DAG in the REDCap
project**.

-   This uses the `users.df` input (which must contain at least 2
    columns: `username` and `data_access_group`) and compares this to
    the current users on REDCap.

-   The `$dag_incorrect` output will highlight the individual users with
    discrepancies in the DAGs recorded so that these can be corrected.

-   However, not all discrepancies are “incorrect” - some users may be
    particpating within multiple DAGs and so will be highlighted. It is
    recommended that in this case these users are either excluded using
    `users_exception` or have separate usernames created for each DAG
    (recommended).
