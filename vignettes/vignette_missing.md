Collaborator: Generating Missing Data Reports
=============================================

Ensuring high levels of completeness within research projects is an
important task for ensuring the highest quality dataset for subsequent
analyses. However, determining what data is missing within a REDCap
project, particularly accounting for appropriately missing data (such as
in the case of unfulfilled branching logic) can be a challenging and
time-consuming task to produce in real-time.

The `report_miss()` function is designed to easily produce a high
quality and informative report of missing data at a data\_access\_group
and individual record level. This report highlights all missing data
within a REDCap project (delineating between appropriately missing and
true missing data), while removing all other data (so this can be shared
in line with duties of data protection).

Requirements:
-------------

The `report_miss()` function is designed to be simple from the point of
use - the only requirements are a valid URI (Uniform Resource
Identifier) and API (Application Programming Interface) for the REDCap
project.

Any variable can be excluded from the output using the “var\_exclude”
parameter.

Limitations: - This function has not yet been tested on REDCap projects
with multiple events.

Output:
-------

### Record level report

Example of a record level report of missing data. This not only
quantifies the missing data within the record, but also highlights it’s
location within the dataset.

**1. Record level summary**

-   `miss_n` is the number of missing data fields (“M”).
-   `fields_n` is the number of all data fields (excluding appropriately
    missing data).
-   `miss_prop` / `miss_pct` are respective proportions and percentages
    of data that are missing for each record.
-   `miss_5` is a binary variable indicating if the variable has &gt;5%
    missing data (&lt;95% completeness).

**2. Missing data locations (column 8 onwards)**

-   “NA” fields represent appropriately missing data (e.g. secondary to
    unfulfilled branching logic). Therefore, these are excluded from the
    missing data count entirely.

-   “M” fields represent ‘true’ missing data (which may require follow
    up), and so all counts of missing data are based these.

<!-- -->

    report_miss(redcap_project_uri,redcap_project_token)$data_missing_record %>%
      knitr::kable()

<table>
<thead>
<tr class="header">
<th style="text-align: left;">record_id</th>
<th style="text-align: left;">redcap_data_access_group</th>
<th style="text-align: right;">miss_n</th>
<th style="text-align: right;">fields_n</th>
<th style="text-align: right;">miss_prop</th>
<th style="text-align: left;">miss_pct</th>
<th style="text-align: left;">miss_5</th>
<th style="text-align: left;">pt_age</th>
<th style="text-align: left;">pt_sex</th>
<th style="text-align: left;">smoking_status</th>
<th style="text-align: left;">body_mass_index</th>
<th style="text-align: left;">pmh___1</th>
<th style="text-align: left;">pmh___2</th>
<th style="text-align: left;">pmh___3</th>
<th style="text-align: left;">asa_grade</th>
<th style="text-align: left;">pt_ethnicity</th>
<th style="text-align: left;">adm_date</th>
<th style="text-align: left;">op_date</th>
<th style="text-align: left;">op_urgency</th>
<th style="text-align: left;">op_procedure_code</th>
<th style="text-align: left;">follow_up</th>
<th style="text-align: left;">follow_up_readm</th>
<th style="text-align: left;">follow_up_mort</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">1</td>
<td style="text-align: left;">hospital_a</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0000</td>
<td style="text-align: left;">0.0%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="even">
<td style="text-align: left;">2</td>
<td style="text-align: left;">hospital_a</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.1250</td>
<td style="text-align: left;">12.5%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">3</td>
<td style="text-align: left;">hospital_a</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0625</td>
<td style="text-align: left;">6.2%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="even">
<td style="text-align: left;">4</td>
<td style="text-align: left;">hospital_a</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0000</td>
<td style="text-align: left;">0.0%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">5</td>
<td style="text-align: left;">hospital_a</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.1250</td>
<td style="text-align: left;">12.5%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">M</td>
</tr>
<tr class="even">
<td style="text-align: left;">6</td>
<td style="text-align: left;">hospital_a</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.1250</td>
<td style="text-align: left;">12.5%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">M</td>
</tr>
<tr class="odd">
<td style="text-align: left;">7</td>
<td style="text-align: left;">hospital_a</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0000</td>
<td style="text-align: left;">0.0%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="even">
<td style="text-align: left;">8</td>
<td style="text-align: left;">hospital_a</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0000</td>
<td style="text-align: left;">0.0%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">9</td>
<td style="text-align: left;">hospital_a</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.1250</td>
<td style="text-align: left;">12.5%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">M</td>
</tr>
<tr class="even">
<td style="text-align: left;">10</td>
<td style="text-align: left;">hospital_a</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0000</td>
<td style="text-align: left;">0.0%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">11</td>
<td style="text-align: left;">hospital_b</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0000</td>
<td style="text-align: left;">0.0%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="even">
<td style="text-align: left;">12</td>
<td style="text-align: left;">hospital_b</td>
<td style="text-align: right;">4</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.2500</td>
<td style="text-align: left;">25.0%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">M</td>
</tr>
<tr class="odd">
<td style="text-align: left;">13</td>
<td style="text-align: left;">hospital_b</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.1250</td>
<td style="text-align: left;">12.5%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">M</td>
</tr>
<tr class="even">
<td style="text-align: left;">14</td>
<td style="text-align: left;">hospital_b</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0000</td>
<td style="text-align: left;">0.0%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">15</td>
<td style="text-align: left;">hospital_b</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.1875</td>
<td style="text-align: left;">18.8%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">M</td>
</tr>
<tr class="even">
<td style="text-align: left;">16</td>
<td style="text-align: left;">hospital_b</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0000</td>
<td style="text-align: left;">0.0%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">17</td>
<td style="text-align: left;">hospital_c</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0000</td>
<td style="text-align: left;">0.0%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="even">
<td style="text-align: left;">18</td>
<td style="text-align: left;">hospital_c</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0000</td>
<td style="text-align: left;">0.0%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">19</td>
<td style="text-align: left;">hospital_d</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0625</td>
<td style="text-align: left;">6.2%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="even">
<td style="text-align: left;">20</td>
<td style="text-align: left;">hospital_d</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0625</td>
<td style="text-align: left;">6.2%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">21</td>
<td style="text-align: left;">hospital_d</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0625</td>
<td style="text-align: left;">6.2%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="even">
<td style="text-align: left;">22</td>
<td style="text-align: left;">hospital_d</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0000</td>
<td style="text-align: left;">0.0%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">23</td>
<td style="text-align: left;">hospital_e</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0000</td>
<td style="text-align: left;">0.0%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="even">
<td style="text-align: left;">24</td>
<td style="text-align: left;">hospital_e</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0000</td>
<td style="text-align: left;">0.0%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">25</td>
<td style="text-align: left;">hospital_e</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0625</td>
<td style="text-align: left;">6.2%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="even">
<td style="text-align: left;">26</td>
<td style="text-align: left;">hospital_e</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.1875</td>
<td style="text-align: left;">18.8%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">M</td>
</tr>
<tr class="odd">
<td style="text-align: left;">27</td>
<td style="text-align: left;">hospital_e</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.1875</td>
<td style="text-align: left;">18.8%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">M</td>
</tr>
<tr class="even">
<td style="text-align: left;">28</td>
<td style="text-align: left;">hospital_e</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0000</td>
<td style="text-align: left;">0.0%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">29</td>
<td style="text-align: left;">hospital_e</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0000</td>
<td style="text-align: left;">0.0%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="even">
<td style="text-align: left;">30</td>
<td style="text-align: left;">hospital_e</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0000</td>
<td style="text-align: left;">0.0%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">31</td>
<td style="text-align: left;">hospital_e</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0000</td>
<td style="text-align: left;">0.0%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="even">
<td style="text-align: left;">32</td>
<td style="text-align: left;">hospital_f</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0000</td>
<td style="text-align: left;">0.0%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">33</td>
<td style="text-align: left;">hospital_f</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0000</td>
<td style="text-align: left;">0.0%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="even">
<td style="text-align: left;">34</td>
<td style="text-align: left;">hospital_f</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0000</td>
<td style="text-align: left;">0.0%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">35</td>
<td style="text-align: left;">hospital_f</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0000</td>
<td style="text-align: left;">0.0%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="even">
<td style="text-align: left;">36</td>
<td style="text-align: left;">hospital_f</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0625</td>
<td style="text-align: left;">6.2%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">37</td>
<td style="text-align: left;">hospital_f</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0000</td>
<td style="text-align: left;">0.0%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="even">
<td style="text-align: left;">38</td>
<td style="text-align: left;">hospital_g</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0000</td>
<td style="text-align: left;">0.0%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">39</td>
<td style="text-align: left;">hospital_g</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0000</td>
<td style="text-align: left;">0.0%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="even">
<td style="text-align: left;">40</td>
<td style="text-align: left;">hospital_g</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0000</td>
<td style="text-align: left;">0.0%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">41</td>
<td style="text-align: left;">hospital_g</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0625</td>
<td style="text-align: left;">6.2%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="even">
<td style="text-align: left;">42</td>
<td style="text-align: left;">hospital_g</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.1875</td>
<td style="text-align: left;">18.8%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">M</td>
</tr>
<tr class="odd">
<td style="text-align: left;">43</td>
<td style="text-align: left;">hospital_g</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.1875</td>
<td style="text-align: left;">18.8%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">M</td>
</tr>
<tr class="even">
<td style="text-align: left;">44</td>
<td style="text-align: left;">hospital_g</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0000</td>
<td style="text-align: left;">0.0%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">45</td>
<td style="text-align: left;">hospital_h</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0000</td>
<td style="text-align: left;">0.0%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="even">
<td style="text-align: left;">46</td>
<td style="text-align: left;">hospital_h</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0000</td>
<td style="text-align: left;">0.0%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">47</td>
<td style="text-align: left;">hospital_h</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0625</td>
<td style="text-align: left;">6.2%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="even">
<td style="text-align: left;">48</td>
<td style="text-align: left;">hospital_h</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0625</td>
<td style="text-align: left;">6.2%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">49</td>
<td style="text-align: left;">hospital_h</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.0000</td>
<td style="text-align: left;">0.0%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="even">
<td style="text-align: left;">50</td>
<td style="text-align: left;">hospital_h</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.1250</td>
<td style="text-align: left;">12.5%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">M</td>
</tr>
</tbody>
</table>

### Data access group level report

Example of a data access group (DAG) level report of missing data
(summarising missing data for all records within the DAG).

-   `n_pt` is the number of patients within the data\_access\_group.
-   `n_pt5` is the number of patients with &gt;5% missing data (&lt;95%
    completeness).
-   `cen_miss_n` is the number of missing data fields (“M”) within the
    data\_access\_group.
-   `fields_n` is the number of all data fields within the
    data\_access\_group (excluding appropriately missing data).
-   `cen_miss_prop` / `cen_miss_pct` are respective proportions and
    percentages of data that are missing for each data\_access\_group.

<!-- -->

    report_miss(redcap_project_uri,redcap_project_token)$data_missing_dag %>%
      knitr::kable()

<table>
<thead>
<tr class="header">
<th style="text-align: left;">redcap_data_access_group</th>
<th style="text-align: right;">n_pt</th>
<th style="text-align: right;">n_pt5</th>
<th style="text-align: right;">cen_miss_n</th>
<th style="text-align: right;">cen_field_n</th>
<th style="text-align: right;">cen_miss_prop</th>
<th style="text-align: left;">cen_miss_pct</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">hospital_a</td>
<td style="text-align: right;">10</td>
<td style="text-align: right;">5</td>
<td style="text-align: right;">9</td>
<td style="text-align: right;">160</td>
<td style="text-align: right;">0.0562500</td>
<td style="text-align: left;">5.6%</td>
</tr>
<tr class="even">
<td style="text-align: left;">hospital_b</td>
<td style="text-align: right;">6</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">9</td>
<td style="text-align: right;">96</td>
<td style="text-align: right;">0.0937500</td>
<td style="text-align: left;">9.4%</td>
</tr>
<tr class="odd">
<td style="text-align: left;">hospital_c</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">32</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">0.0%</td>
</tr>
<tr class="even">
<td style="text-align: left;">hospital_d</td>
<td style="text-align: right;">4</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">64</td>
<td style="text-align: right;">0.0468750</td>
<td style="text-align: left;">4.7%</td>
</tr>
<tr class="odd">
<td style="text-align: left;">hospital_e</td>
<td style="text-align: right;">9</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">7</td>
<td style="text-align: right;">144</td>
<td style="text-align: right;">0.0486111</td>
<td style="text-align: left;">4.9%</td>
</tr>
<tr class="even">
<td style="text-align: left;">hospital_f</td>
<td style="text-align: right;">6</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">96</td>
<td style="text-align: right;">0.0104167</td>
<td style="text-align: left;">1.0%</td>
</tr>
<tr class="odd">
<td style="text-align: left;">hospital_g</td>
<td style="text-align: right;">7</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">7</td>
<td style="text-align: right;">112</td>
<td style="text-align: right;">0.0625000</td>
<td style="text-align: left;">6.2%</td>
</tr>
<tr class="even">
<td style="text-align: left;">hospital_h</td>
<td style="text-align: right;">6</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">4</td>
<td style="text-align: right;">96</td>
<td style="text-align: right;">0.0416667</td>
<td style="text-align: left;">4.2%</td>
</tr>
</tbody>
</table>
