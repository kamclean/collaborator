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

    library(collaborator)

    knitr::kable(data(example_data_miss_record))

<table>
<thead>
<tr class="header">
<th style="text-align: left;">x</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">example_data_miss_record</td>
</tr>
</tbody>
</table>

### Data access group level report

Example of a data access group (DAG) level report of missing data
(summarising missing data for all records within the DAG).

    knitr::kable(data(example_data_miss_dag))

<table>
<thead>
<tr class="header">
<th style="text-align: left;">x</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">example_data_miss_dag</td>
</tr>
</tbody>
</table>
