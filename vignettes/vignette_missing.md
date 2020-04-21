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

There is a high degree of customisability, with the following able to be
specified to focus on a subset of the dataset:

-   Variables (columns): Modified using the “var\_include” and
    “var\_exclude” parameters.

-   Records / DAGs (rows): Modified using the
    “record\_include”/“dag\_include” and
    “record\_exclude”/“dag\_exclude”.

Limitations:

-   This function has not yet been tested on REDCap projects with
    multiple events.

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

-   `miss_threshold` is a yes/no variable indicating if the variable has
    **over** the specified missing data threshold (default = 5%).

**2. Missing data locations (column 8 onwards)**

-   “NA” fields represent appropriately missing data (e.g. secondary to
    unfulfilled branching logic). Therefore, these are excluded from the
    missing data count entirely.

-   “M” fields represent ‘true’ missing data (which may require follow
    up), and so all counts of missing data are based these.

``` r
collaborator::report_miss(redcap_project_uri = Sys.getenv("collaborator_test_uri"),
                          redcap_project_token = Sys.getenv("collaborator_test_token"))$record %>%
  head(15) %>% # first 15 records
  knitr::kable()
```

| record\_id | redcap\_data\_access\_group |  miss\_n|  fields\_n|  miss\_prop| miss\_pct | miss\_threshold | dmy\_hms | enrol\_tf | enrol\_signature | pt\_age | pt\_sex | smoking\_status | body\_mass\_index | pmh\_\_\_1 | pmh\_\_\_2 | pmh\_\_\_3 | asa\_grade | pt\_ethnicity | pt\_ethnicity\_other | adm\_date | adm\_vas | op\_date | time2op | op\_urgency | op\_procedure\_code | follow\_up | follow\_up\_readm | follow\_up\_mort | file |
|:-----------|:----------------------------|--------:|----------:|-----------:|:----------|:----------------|:---------|:----------|:-----------------|:--------|:--------|:----------------|:------------------|:-----------|:-----------|:-----------|:-----------|:--------------|:---------------------|:----------|:---------|:---------|:--------|:------------|:--------------------|:-----------|:------------------|:-----------------|:-----|
| 1          | hospital\_a                 |        4|         21|   0.1904762| 19%       | Yes             | M        | M         | NA               | .       | .       | .               | .                 | .          | .          | .          | .          | .             | NA                   | .         | M        | .        | M       | .           | .                   | .          | .                 | .                | .    |
| 2          | hospital\_a                 |        6|         21|   0.2857143| 29%       | Yes             | M        | M         | NA               | .       | .       | M               | M                 | .          | .          | .          | .          | .             | NA                   | .         | M        | .        | M       | .           | .                   | .          | .                 | .                | .    |
| 3          | hospital\_a                 |        5|         21|   0.2380952| 24%       | Yes             | M        | M         | NA               | .       | .       | .               | M                 | .          | .          | .          | .          | .             | NA                   | .         | M        | .        | M       | .           | .                   | .          | .                 | .                | .    |
| 4          | hospital\_a                 |        4|         21|   0.1904762| 19%       | Yes             | M        | M         | NA               | .       | .       | .               | .                 | .          | .          | .          | .          | .             | NA                   | .         | M        | .        | M       | .           | .                   | .          | .                 | .                | .    |
| 5          | hospital\_a                 |        4|         19|   0.2105263| 21%       | Yes             | M        | M         | NA               | .       | .       | .               | .                 | .          | .          | .          | .          | .             | NA                   | .         | M        | .        | M       | .           | .                   | .          | NA                | NA               | .    |
| 6          | hospital\_a                 |        4|         19|   0.2105263| 21%       | Yes             | M        | M         | NA               | .       | .       | .               | .                 | .          | .          | .          | .          | .             | NA                   | .         | M        | .        | M       | .           | .                   | .          | NA                | NA               | .    |
| 7          | hospital\_a                 |        4|         21|   0.1904762| 19%       | Yes             | M        | M         | NA               | .       | .       | .               | .                 | .          | .          | .          | .          | .             | NA                   | .         | M        | .        | M       | .           | .                   | .          | .                 | .                | .    |
| 8          | hospital\_a                 |        4|         21|   0.1904762| 19%       | Yes             | M        | M         | NA               | .       | .       | .               | .                 | .          | .          | .          | .          | .             | NA                   | .         | M        | .        | M       | .           | .                   | .          | .                 | .                | .    |
| 9          | hospital\_a                 |        4|         19|   0.2105263| 21%       | Yes             | M        | M         | NA               | .       | .       | .               | .                 | .          | .          | .          | .          | .             | NA                   | .         | M        | .        | M       | .           | .                   | .          | NA                | NA               | .    |
| 10         | hospital\_a                 |        4|         21|   0.1904762| 19%       | Yes             | M        | M         | NA               | .       | .       | .               | .                 | .          | .          | .          | .          | .             | NA                   | .         | M        | .        | M       | .           | .                   | .          | .                 | .                | .    |
| 11         | hospital\_b                 |        4|         21|   0.1904762| 19%       | Yes             | M        | M         | NA               | .       | .       | .               | .                 | .          | .          | .          | .          | .             | NA                   | .         | M        | .        | M       | .           | .                   | .          | .                 | .                | .    |
| 12         | hospital\_b                 |        6|         19|   0.3157895| 32%       | Yes             | M        | M         | NA               | .       | M       | .               | M                 | .          | .          | .          | .          | .             | NA                   | .         | M        | .        | M       | .           | .                   | .          | NA                | NA               | .    |
| 13         | hospital\_b                 |        4|         19|   0.2105263| 21%       | Yes             | M        | M         | NA               | .       | .       | .               | .                 | .          | .          | .          | .          | .             | NA                   | .         | M        | .        | M       | .           | .                   | .          | NA                | NA               | .    |
| 14         | hospital\_b                 |        4|         21|   0.1904762| 19%       | Yes             | M        | M         | NA               | .       | .       | .               | .                 | .          | .          | .          | .          | .             | NA                   | .         | M        | .        | M       | .           | .                   | .          | .                 | .                | .    |
| 15         | hospital\_b                 |        5|         19|   0.2631579| 26%       | Yes             | M        | M         | NA               | .       | .       | .               | .                 | .          | .          | .          | M          | .             | NA                   | .         | M        | .        | M       | .           | .                   | .          | NA                | NA               | .    |

### Data access group level report

Example of a data access group (DAG) level report of missing data
(summarising missing data for all records within the DAG).

-   `n_pt` is the number of patients within the data\_access\_group.
-   `n_threshold` is the number of patients **over** the specified
    missing data threshold (default = 5%).
-   `cen_miss_n` is the number of missing data fields (“M”) within the
    data\_access\_group.
-   `fields_n` is the number of all data fields within the
    data\_access\_group (excluding appropriately missing data).
-   `cen_miss_prop` / `cen_miss_pct` are respective proportions and
    percentages of data that are missing for each data\_access\_group.

``` r
report_miss(redcap_project_uri = Sys.getenv("collaborator_test_uri"),
            redcap_project_token = Sys.getenv("collaborator_test_token"), missing_threshold = 0.2)$group %>%
  knitr::kable()
```

| redcap\_data\_access\_group |  n\_pt|  n\_threshold|  cen\_miss\_n|  cen\_field\_n|  cen\_miss\_prop| cen\_miss\_pct |
|:----------------------------|------:|-------------:|-------------:|--------------:|----------------:|:---------------|
| hospital\_a                 |     10|             5|            43|            204|        0.2107843| 21.0784%       |
| hospital\_b                 |      6|             3|            27|            120|        0.2250000| 22.5000%       |
| hospital\_c                 |      2|             0|             8|             42|        0.1904762| 19.0476%       |
| hospital\_d                 |      4|             3|            19|             84|        0.2261905| 22.6190%       |
| hospital\_e                 |      9|             3|            39|            185|        0.2108108| 21.0811%       |
| hospital\_f                 |      6|             3|            29|            126|        0.2301587| 23.0159%       |
| hospital\_g                 |      7|             3|            34|            144|        0.2361111| 23.6111%       |
| hospital\_h                 |      6|             4|            30|            125|        0.2400000| 24.0000%       |
