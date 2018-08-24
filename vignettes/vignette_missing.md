Collaborator: Generating Missing Data Reports
=============================================

Ensuring high levels of completeness within research projects is an
important task for ensuring the highest quality dataset for subsequent
analyses. However, determining what data is missing within a REDCap
project, particularly accounting for appropriately missing data (such as
in the case of unfufilled branching logic) can be a challenging and
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

-   “NA” fields represent appropriately missing data (e.g. secondary to
    unfufilled branching logic). Therefore, these are excluded from the
    missing data count entirely.

-   “M” fields represent ‘true’ missing data (which may require follow
    up), and so all counts of missing data are based these.

<!-- -->

    knitr::kable(collaborator::example_data_miss_record)

<table>
<thead>
<tr class="header">
<th style="text-align: right;">record_id</th>
<th style="text-align: left;">redcap_data_access_group</th>
<th style="text-align: right;">miss_n</th>
<th style="text-align: right;">fields_n</th>
<th style="text-align: right;">miss_prop</th>
<th style="text-align: left;">miss_pct</th>
<th style="text-align: left;">miss_95</th>
<th style="text-align: left;">age</th>
<th style="text-align: left;">gender</th>
<th style="text-align: left;">smoking_status</th>
<th style="text-align: left;">body_mass_index</th>
<th style="text-align: left;">asa_grade</th>
<th style="text-align: left;">operation</th>
<th style="text-align: left;">30day_mortality_yn</th>
<th style="text-align: left;">30day_mortality_day</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: right;">1</td>
<td style="text-align: left;">hospital_A</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">7</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">0.00%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">NA</td>
</tr>
<tr class="even">
<td style="text-align: right;">2</td>
<td style="text-align: left;">hospital_A</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">7</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">0.00%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">NA</td>
</tr>
<tr class="odd">
<td style="text-align: right;">3</td>
<td style="text-align: left;">hospital_A</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">7</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">0.00%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">NA</td>
</tr>
<tr class="even">
<td style="text-align: right;">4</td>
<td style="text-align: left;">hospital_A</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">7</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">0.00%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">NA</td>
</tr>
<tr class="odd">
<td style="text-align: right;">5</td>
<td style="text-align: left;">hospital_A</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">7</td>
<td style="text-align: right;">0.2857143</td>
<td style="text-align: left;">28.60%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">NA</td>
</tr>
<tr class="even">
<td style="text-align: right;">6</td>
<td style="text-align: left;">hospital_A</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">7</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">0.00%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">NA</td>
</tr>
<tr class="odd">
<td style="text-align: right;">7</td>
<td style="text-align: left;">hospital_A</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">7</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">0.00%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">NA</td>
</tr>
<tr class="even">
<td style="text-align: right;">8</td>
<td style="text-align: left;">hospital_A</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.1250000</td>
<td style="text-align: left;">12.50%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="odd">
<td style="text-align: right;">9</td>
<td style="text-align: left;">hospital_A</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">0.00%</td>
<td style="text-align: left;">No</td>
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
<td style="text-align: right;">10</td>
<td style="text-align: left;">hospital_A</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">0.00%</td>
<td style="text-align: left;">No</td>
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
<td style="text-align: right;">11</td>
<td style="text-align: left;">hospital_B</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">0.00%</td>
<td style="text-align: left;">No</td>
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
<td style="text-align: right;">12</td>
<td style="text-align: left;">hospital_B</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">0.00%</td>
<td style="text-align: left;">No</td>
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
<td style="text-align: right;">13</td>
<td style="text-align: left;">hospital_B</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.2500000</td>
<td style="text-align: left;">25.00%</td>
<td style="text-align: left;">Yes</td>
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
<td style="text-align: right;">14</td>
<td style="text-align: left;">hospital_B</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.2500000</td>
<td style="text-align: left;">25.00%</td>
<td style="text-align: left;">Yes</td>
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
<td style="text-align: right;">15</td>
<td style="text-align: left;">hospital_B</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.2500000</td>
<td style="text-align: left;">25.00%</td>
<td style="text-align: left;">Yes</td>
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
<td style="text-align: right;">16</td>
<td style="text-align: left;">hospital_B</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.2500000</td>
<td style="text-align: left;">25.00%</td>
<td style="text-align: left;">Yes</td>
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
<td style="text-align: right;">17</td>
<td style="text-align: left;">hospital_C</td>
<td style="text-align: right;">4</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.5000000</td>
<td style="text-align: left;">50.00%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="even">
<td style="text-align: right;">18</td>
<td style="text-align: left;">hospital_C</td>
<td style="text-align: right;">4</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.5000000</td>
<td style="text-align: left;">50.00%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">M</td>
</tr>
<tr class="odd">
<td style="text-align: right;">19</td>
<td style="text-align: left;">hospital_D</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.1250000</td>
<td style="text-align: left;">12.50%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="even">
<td style="text-align: right;">20</td>
<td style="text-align: left;">hospital_D</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">0.00%</td>
<td style="text-align: left;">No</td>
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
<td style="text-align: right;">21</td>
<td style="text-align: left;">hospital_D</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">0.00%</td>
<td style="text-align: left;">No</td>
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
<td style="text-align: right;">22</td>
<td style="text-align: left;">hospital_D</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">7</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">0.00%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">NA</td>
</tr>
<tr class="odd">
<td style="text-align: right;">23</td>
<td style="text-align: left;">hospital_E</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">0.00%</td>
<td style="text-align: left;">No</td>
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
<td style="text-align: right;">24</td>
<td style="text-align: left;">hospital_E</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">0.00%</td>
<td style="text-align: left;">No</td>
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
<td style="text-align: right;">25</td>
<td style="text-align: left;">hospital_E</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.1250000</td>
<td style="text-align: left;">12.50%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="even">
<td style="text-align: right;">26</td>
<td style="text-align: left;">hospital_E</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">0.00%</td>
<td style="text-align: left;">No</td>
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
<td style="text-align: right;">27</td>
<td style="text-align: left;">hospital_E</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">7</td>
<td style="text-align: right;">0.1428571</td>
<td style="text-align: left;">14.30%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">NA</td>
</tr>
<tr class="even">
<td style="text-align: right;">28</td>
<td style="text-align: left;">hospital_E</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">0.00%</td>
<td style="text-align: left;">No</td>
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
<td style="text-align: right;">29</td>
<td style="text-align: left;">hospital_E</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">0.00%</td>
<td style="text-align: left;">No</td>
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
<td style="text-align: right;">30</td>
<td style="text-align: left;">hospital_E</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">0.00%</td>
<td style="text-align: left;">No</td>
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
<td style="text-align: right;">31</td>
<td style="text-align: left;">hospital_E</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">0.00%</td>
<td style="text-align: left;">No</td>
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
<td style="text-align: right;">32</td>
<td style="text-align: left;">hospital_F</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">7</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">0.00%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">NA</td>
</tr>
<tr class="odd">
<td style="text-align: right;">33</td>
<td style="text-align: left;">hospital_F</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">0.00%</td>
<td style="text-align: left;">No</td>
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
<td style="text-align: right;">34</td>
<td style="text-align: left;">hospital_F</td>
<td style="text-align: right;">6</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.7500000</td>
<td style="text-align: left;">75.00%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="odd">
<td style="text-align: right;">35</td>
<td style="text-align: left;">hospital_F</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">0.00%</td>
<td style="text-align: left;">No</td>
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
<td style="text-align: right;">36</td>
<td style="text-align: left;">hospital_F</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">0.00%</td>
<td style="text-align: left;">No</td>
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
<td style="text-align: right;">37</td>
<td style="text-align: left;">hospital_F</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">0.00%</td>
<td style="text-align: left;">No</td>
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
<td style="text-align: right;">38</td>
<td style="text-align: left;">hospital_G</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">0.00%</td>
<td style="text-align: left;">No</td>
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
<td style="text-align: right;">39</td>
<td style="text-align: left;">hospital_G</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.1250000</td>
<td style="text-align: left;">12.50%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="even">
<td style="text-align: right;">40</td>
<td style="text-align: left;">hospital_G</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.1250000</td>
<td style="text-align: left;">12.50%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="odd">
<td style="text-align: right;">41</td>
<td style="text-align: left;">hospital_G</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">7</td>
<td style="text-align: right;">0.1428571</td>
<td style="text-align: left;">14.30%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">NA</td>
</tr>
<tr class="even">
<td style="text-align: right;">42</td>
<td style="text-align: left;">hospital_G</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.1250000</td>
<td style="text-align: left;">12.50%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="odd">
<td style="text-align: right;">43</td>
<td style="text-align: left;">hospital_G</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.1250000</td>
<td style="text-align: left;">12.50%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="even">
<td style="text-align: right;">44</td>
<td style="text-align: left;">hospital_G</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.1250000</td>
<td style="text-align: left;">12.50%</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">M</td>
<td style="text-align: left;">.</td>
</tr>
<tr class="odd">
<td style="text-align: right;">45</td>
<td style="text-align: left;">hospital_H</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">7</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">0.00%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">NA</td>
</tr>
<tr class="even">
<td style="text-align: right;">46</td>
<td style="text-align: left;">hospital_H</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">0.00%</td>
<td style="text-align: left;">No</td>
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
<td style="text-align: right;">47</td>
<td style="text-align: left;">hospital_H</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">12.50%</td>
<td style="text-align: left;">Yes</td>
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
<td style="text-align: right;">48</td>
<td style="text-align: left;">hospital_H</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">0.00%</td>
<td style="text-align: left;">No</td>
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
<td style="text-align: right;">49</td>
<td style="text-align: left;">hospital_H</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">0.00%</td>
<td style="text-align: left;">No</td>
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
<td style="text-align: right;">50</td>
<td style="text-align: left;">hospital_H</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">0.00%</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
<td style="text-align: left;">.</td>
</tr>
</tbody>
</table>

### Data access group level report

Example of a data access group (DAG) level report of missing data
(summarising missing data for all records within the DAG).

    knitr::kable(collaborator::example_data_miss_dag)

<table>
<thead>
<tr class="header">
<th style="text-align: left;">redcap_data_access_group</th>
<th style="text-align: right;">n_pt</th>
<th style="text-align: right;">n_pt95</th>
<th style="text-align: right;">cen_miss_n</th>
<th style="text-align: right;">cen_field_n</th>
<th style="text-align: right;">cen_miss_prop</th>
<th style="text-align: left;">cen_miss_pct</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">hospital_A</td>
<td style="text-align: right;">10</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">73</td>
<td style="text-align: right;">0.0410959</td>
<td style="text-align: left;">4.1%</td>
</tr>
<tr class="even">
<td style="text-align: left;">hospital_B</td>
<td style="text-align: right;">6</td>
<td style="text-align: right;">4</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">48</td>
<td style="text-align: right;">0.1666667</td>
<td style="text-align: left;">16.7%</td>
</tr>
<tr class="odd">
<td style="text-align: left;">hospital_D</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">0.5000000</td>
<td style="text-align: left;">50.0%</td>
</tr>
<tr class="even">
<td style="text-align: left;">hospital_D</td>
<td style="text-align: right;">4</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">31</td>
<td style="text-align: right;">0.0322581</td>
<td style="text-align: left;">3.2%</td>
</tr>
<tr class="odd">
<td style="text-align: left;">hospital_E</td>
<td style="text-align: right;">9</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">71</td>
<td style="text-align: right;">0.0281690</td>
<td style="text-align: left;">2.8%</td>
</tr>
<tr class="even">
<td style="text-align: left;">hospital_F</td>
<td style="text-align: right;">6</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">6</td>
<td style="text-align: right;">47</td>
<td style="text-align: right;">0.1276596</td>
<td style="text-align: left;">12.8%</td>
</tr>
<tr class="odd">
<td style="text-align: left;">hospital_G</td>
<td style="text-align: right;">7</td>
<td style="text-align: right;">6</td>
<td style="text-align: right;">6</td>
<td style="text-align: right;">55</td>
<td style="text-align: right;">0.1090909</td>
<td style="text-align: left;">10.9%</td>
</tr>
<tr class="even">
<td style="text-align: left;">hospital_H</td>
<td style="text-align: right;">6</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">47</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">0.0%</td>
</tr>
</tbody>
</table>
