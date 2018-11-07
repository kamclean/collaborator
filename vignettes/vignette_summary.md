Collaborator: REDCap summary data
=================================

Evaluating data uploaded to a REDCap project in the context of
multi-centre research projects is an important task for ensuring the
highest quality dataset for subsequent analyses, and for sharing
progress (whether internally or externally via social media). However,
summarising this data, particularly at a DAG-level, can be a challenging
and time-consuming task to produce on a regular basis.

The `redcap_sum()` function is designed to easily produce high quality
and informative summary data on a REDCap project (overall and at a
data\_access\_group level). This can be used for the purposes of sharing
progress (including identifying top performing DAGs), and identifying
individual DAGs which have not yet uploaded data or have not completed
data upload.

Requirements
------------

The `redcap_sum()` function is designed to be simple from the point of
use - the only requirements are a valid URI (Uniform Resource
Identifier) and API (Application Programming Interface) for the REDCap
project.

However, this is intended to have a high degree of customisability to
fit the needs of a variety of projects. For example, Being able to
easily:

-   Exclude individual records (`record_exclude`) or whole data access
    groups (`dag_exclude`) from the record count (e.g. records or DAGs
    that were found to be ineligible).

-   Exclude users (`user_exclude`) from the total REDCap user count
    (e.g. administrator user accounts).

-   Define variables that should contribute towards evaluation of data
    completeness. This can be achieved by either excluding
    (`var_exclude`), or specifying certain variables (`var_complete`).

-   Generation of summary data by DAG unless `centre_sum` is specified
    as FALSE (default `centre_sum=T`)

Limitations:

-   This function has not yet been tested on REDCap projects with
    multiple events.

Main Features
-------------

### (1) Basic Function

At it’s most basic, `redcap_sum()` can produce an overall summary of
current data on the REDCap project: - `n_record_all` is the number of
all records currently on the REDCap project (minus any records removed
using `record_exclude` or in DAGs removed using `dag_exclude`).

-   `n_record_com` is the number of all complete records currently on
    the REDCap project (minus any records removed using `record_exclude`
    or in DAGs removed using `dag_exclude`), with no missing data across
    the record (unless certain data fields are either excluded
    (`var_exclude`) or specified (`var_complete`)).

-   `prop_com` /`pct_com` is the respective proportion and percentage of
    complete records in the project.

-   `n_dag` is the number of data access groups (DAGs) for all records
    currently on the REDCap project (minus any records removed using
    `record_exclude` or in DAGs removed using `dag_exclude`).

-   `n_users` is the number of users on the REDCap project (minus any
    users in DAGs removed using `dag_exclude`). Note all users not
    assigned to a DAG will automatically be excluded.

-   `last_update` is the date which the summary data was generated on.

<!-- -->

    redcap_sum(redcap_project_uri, redcap_project_token, centre_sum = F)  %>%
      knitr::kable()

<table>
<thead>
<tr class="header">
<th style="text-align: right;">n_record_all</th>
<th style="text-align: right;">n_record_com</th>
<th style="text-align: right;">prop_com</th>
<th style="text-align: left;">pct_com</th>
<th style="text-align: right;">n_dag</th>
<th style="text-align: right;">n_users</th>
<th style="text-align: left;">last_update</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: right;">50</td>
<td style="text-align: right;">26</td>
<td style="text-align: right;">0.52</td>
<td style="text-align: left;">52.0%</td>
<td style="text-align: right;">8</td>
<td style="text-align: right;">30</td>
<td style="text-align: left;">7-Nov-2018</td>
</tr>
</tbody>
</table>

### (2) Centre summary data

However, more granular summary data on each DAG can also be obtained
using the same function. This centre summary data will automatically be
included within the output from `redcap_sum()` unless `centre_sum` is
specified as FALSE.

#### 1. `$dag_all` Output

This will produce a dataframe of the same summary data as outlined above
**grouped by each DAG instead** (minus any DAGs removed using
`dag_exclude`).

    redcap_sum(redcap_project_uri, redcap_project_token, centre_sum = T)$dag_all %>%
      knitr::kable()

<table>
<thead>
<tr class="header">
<th style="text-align: left;">dag</th>
<th style="text-align: right;">record_all</th>
<th style="text-align: right;">record_com</th>
<th style="text-align: right;">prop_com</th>
<th style="text-align: left;">pct_com</th>
<th style="text-align: right;">user_all</th>
<th style="text-align: left;">last_update</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">hospital_a</td>
<td style="text-align: right;">10</td>
<td style="text-align: right;">5</td>
<td style="text-align: right;">0.5000000</td>
<td style="text-align: left;">50.0%</td>
<td style="text-align: right;">3</td>
<td style="text-align: left;">7-Nov-2018</td>
</tr>
<tr class="even">
<td style="text-align: left;">hospital_e</td>
<td style="text-align: right;">9</td>
<td style="text-align: right;">6</td>
<td style="text-align: right;">0.6666667</td>
<td style="text-align: left;">66.7%</td>
<td style="text-align: right;">3</td>
<td style="text-align: left;">7-Nov-2018</td>
</tr>
<tr class="odd">
<td style="text-align: left;">hospital_g</td>
<td style="text-align: right;">7</td>
<td style="text-align: right;">4</td>
<td style="text-align: right;">0.5714286</td>
<td style="text-align: left;">57.1%</td>
<td style="text-align: right;">3</td>
<td style="text-align: left;">7-Nov-2018</td>
</tr>
<tr class="even">
<td style="text-align: left;">hospital_b</td>
<td style="text-align: right;">6</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">0.5000000</td>
<td style="text-align: left;">50.0%</td>
<td style="text-align: right;">3</td>
<td style="text-align: left;">7-Nov-2018</td>
</tr>
<tr class="odd">
<td style="text-align: left;">hospital_f</td>
<td style="text-align: right;">6</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">0.5000000</td>
<td style="text-align: left;">50.0%</td>
<td style="text-align: right;">3</td>
<td style="text-align: left;">7-Nov-2018</td>
</tr>
<tr class="even">
<td style="text-align: left;">hospital_h</td>
<td style="text-align: right;">6</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">0.3333333</td>
<td style="text-align: left;">33.3%</td>
<td style="text-align: right;">3</td>
<td style="text-align: left;">7-Nov-2018</td>
</tr>
<tr class="odd">
<td style="text-align: left;">hospital_d</td>
<td style="text-align: right;">4</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0.2500000</td>
<td style="text-align: left;">25.0%</td>
<td style="text-align: right;">3</td>
<td style="text-align: left;">7-Nov-2018</td>
</tr>
<tr class="even">
<td style="text-align: left;">hospital_c</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">1.0000000</td>
<td style="text-align: left;">100.0%</td>
<td style="text-align: right;">2</td>
<td style="text-align: left;">7-Nov-2018</td>
</tr>
<tr class="odd">
<td style="text-align: left;">hospital_i</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">NA</td>
<td style="text-align: right;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: right;">3</td>
<td style="text-align: left;">7-Nov-2018</td>
</tr>
<tr class="even">
<td style="text-align: left;">hospital_j</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">NA</td>
<td style="text-align: right;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: right;">4</td>
<td style="text-align: left;">7-Nov-2018</td>
</tr>
</tbody>
</table>

#### 2. `$dag_nodata` Output

This will produce a dataframe of all DAG with users assigned on the
REDCap project, but no data uploaded to REDCap. This may be useful for
the purposes of targeting encouragement to upload data, or establishing
authorship on any research output.

    redcap_sum(redcap_project_uri, redcap_project_token, centre_sum = T)$dag_nodata %>%
      knitr::kable()

<table>
<thead>
<tr class="header">
<th style="text-align: left;">dag</th>
<th style="text-align: right;">record_all</th>
<th style="text-align: right;">record_com</th>
<th style="text-align: right;">prop_com</th>
<th style="text-align: left;">pct_com</th>
<th style="text-align: right;">user_all</th>
<th style="text-align: left;">last_update</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">hospital_i</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">NA</td>
<td style="text-align: right;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: right;">3</td>
<td style="text-align: left;">7-Nov-2018</td>
</tr>
<tr class="even">
<td style="text-align: left;">hospital_j</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">NA</td>
<td style="text-align: right;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: right;">4</td>
<td style="text-align: left;">7-Nov-2018</td>
</tr>
</tbody>
</table>

#### 3. `$dag_incom` Output

This will produce a dataframe of all DAG with incomplete records (the
definition of completeness customisable as discussed above). This may be
useful for the purposes of follow up regarding (essential) missing data
at each of these DAGs.

    redcap_sum(redcap_project_uri, redcap_project_token, centre_sum = T)$dag_incom %>%
      knitr::kable()

<table>
<thead>
<tr class="header">
<th style="text-align: left;">dag</th>
<th style="text-align: right;">record_all</th>
<th style="text-align: right;">record_com</th>
<th style="text-align: right;">prop_com</th>
<th style="text-align: left;">pct_com</th>
<th style="text-align: right;">user_all</th>
<th style="text-align: left;">last_update</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">hospital_a</td>
<td style="text-align: right;">10</td>
<td style="text-align: right;">5</td>
<td style="text-align: right;">0.5000000</td>
<td style="text-align: left;">50.0%</td>
<td style="text-align: right;">3</td>
<td style="text-align: left;">7-Nov-2018</td>
</tr>
<tr class="even">
<td style="text-align: left;">hospital_e</td>
<td style="text-align: right;">9</td>
<td style="text-align: right;">6</td>
<td style="text-align: right;">0.6666667</td>
<td style="text-align: left;">66.7%</td>
<td style="text-align: right;">3</td>
<td style="text-align: left;">7-Nov-2018</td>
</tr>
<tr class="odd">
<td style="text-align: left;">hospital_g</td>
<td style="text-align: right;">7</td>
<td style="text-align: right;">4</td>
<td style="text-align: right;">0.5714286</td>
<td style="text-align: left;">57.1%</td>
<td style="text-align: right;">3</td>
<td style="text-align: left;">7-Nov-2018</td>
</tr>
<tr class="even">
<td style="text-align: left;">hospital_b</td>
<td style="text-align: right;">6</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">0.5000000</td>
<td style="text-align: left;">50.0%</td>
<td style="text-align: right;">3</td>
<td style="text-align: left;">7-Nov-2018</td>
</tr>
<tr class="odd">
<td style="text-align: left;">hospital_f</td>
<td style="text-align: right;">6</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">0.5000000</td>
<td style="text-align: left;">50.0%</td>
<td style="text-align: right;">3</td>
<td style="text-align: left;">7-Nov-2018</td>
</tr>
<tr class="even">
<td style="text-align: left;">hospital_h</td>
<td style="text-align: right;">6</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">0.3333333</td>
<td style="text-align: left;">33.3%</td>
<td style="text-align: right;">3</td>
<td style="text-align: left;">7-Nov-2018</td>
</tr>
<tr class="odd">
<td style="text-align: left;">hospital_d</td>
<td style="text-align: right;">4</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0.2500000</td>
<td style="text-align: left;">25.0%</td>
<td style="text-align: right;">3</td>
<td style="text-align: left;">7-Nov-2018</td>
</tr>
</tbody>
</table>

#### 4. `$dag_top_n` Output

This will produce a dataframe of the DAGs with the most records uploaded
overall (the number of DAGs listed is defined by `n_top_dag` with top 10
DAG being default). This may be useful for the purposes of publicity
surrounding the project.

    redcap_sum(redcap_project_uri, redcap_project_token, centre_sum = T, n_top_dag = 5)$dag_top_n %>%
      knitr::kable()

<table>
<thead>
<tr class="header">
<th style="text-align: left;">top_n_dag</th>
<th style="text-align: right;">record_all</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">hospital_a</td>
<td style="text-align: right;">10</td>
</tr>
<tr class="even">
<td style="text-align: left;">hospital_e</td>
<td style="text-align: right;">9</td>
</tr>
<tr class="odd">
<td style="text-align: left;">hospital_g</td>
<td style="text-align: right;">7</td>
</tr>
<tr class="even">
<td style="text-align: left;">hospital_b</td>
<td style="text-align: right;">6</td>
</tr>
<tr class="odd">
<td style="text-align: left;">hospital_f</td>
<td style="text-align: right;">6</td>
</tr>
</tbody>
</table>
