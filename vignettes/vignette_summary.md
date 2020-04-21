# Collaborator: REDCap summary data

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

## Requirements

The `redcap_sum()` function is designed to be simple from the point of
use - the only requirements are a valid URI (Uniform Resource
Identifier) and API (Application Programming Interface) for the REDCap
project.

However, this is intended to have a high degree of customisability to
fit the needs of a variety of projects. For example, being able to
easily:

  - Select variables (using `var_include` or `var_exclude`) to be
    included in the assessment of completeness. For example, to focus on
    only essential variables to determine level of completeness.

  - Select individual records (using `record_exclude` or
    `record_include`) or whole data access groups (using `dag_exclude`
    or `dag_include`) to be assessed. For example to remove records or
    DAGs that were found to be ineligible.

  - Select individual users (using `user_exclude` or `user_include`) or
    whole data access groups (using `dag_exclude` or `dag_include`) to
    be assessed. For example to remove users (e.g. administrator user
    accounts) or DAGs that were found to be ineligible from the total
    REDCap user count.

  - Generation of summary data by DAG unless `centre_sum` is specified
    as FALSE (default `centre_sum=T`)

Limitations:

  - This function has not yet been tested on REDCap projects with
    multiple events.

## Main Features

### (1) Basic Function

At it’s most basic, `redcap_sum()` can produce an overall summary of
current data on the REDCap project: - `n_record_all` is the number of
all records currently on the REDCap project (minus any records removed
using `record_exclude` or in DAGs removed using `dag_exclude`).

  - `n_record_com` is the number of all complete records currently on
    the REDCap project (minus any records removed using `record_exclude`
    or in DAGs removed using `dag_exclude`), with no missing data across
    the record (unless certain data fields are either excluded
    (`var_exclude`) or specified (`var_complete`)).

  - `prop_com` /`pct_com` is the respective proportion and percentage of
    complete records in the project.

  - `n_dag` is the number of data access groups (DAGs) for all records
    currently on the REDCap project (minus any records removed using
    `record_exclude` or in DAGs removed using `dag_exclude`).

  - `n_users` is the number of users on the REDCap project (minus any
    users in DAGs removed using `dag_exclude`). Note all users not
    assigned to a DAG will automatically be excluded.

  - `last_update` is the date which the summary data was generated
on.

<!-- end list -->

``` r
collaborator::redcap_sum(redcap_project_uri = Sys.getenv("collaborator_test_uri"),
                         redcap_project_token = Sys.getenv("collaborator_test_token"),
                         centre_sum = F)  %>%
  knitr::kable()
```

| n\_record\_all | n\_record\_com | prop\_com | pct\_com | n\_dag | n\_users | last\_update |
| -------------: | -------------: | --------: | :------- | -----: | -------: | :----------- |
|             50 |              0 |         0 | 0%       |      8 |       30 | 21-Apr-2020  |

### (2) Centre summary data

However, more granular summary data on each DAG can also be obtained
using the same function. This centre summary data will automatically be
included within the output from `redcap_sum()` unless `centre_sum` is
specified as FALSE.

#### 1\. `$dag_all` Output

This will produce a dataframe of the same summary data as outlined above
**grouped by each DAG instead** (minus any DAGs removed using
`dag_exclude`).

``` r
output <- collaborator::redcap_sum(redcap_project_uri = Sys.getenv("collaborator_test_uri"),
                                   redcap_project_token = Sys.getenv("collaborator_test_token"),
                                   centre_sum = T)

  knitr::kable(output$dag_all)
```

| redcap\_data\_access\_group | record\_all | record\_com | prop\_com | pct\_com | user\_all | last\_update |
| :-------------------------- | ----------: | ----------: | --------: | :------- | --------: | :----------- |
| hospital\_a                 |          10 |           0 |         0 | 0%       |         3 | 21-Apr-2020  |
| hospital\_e                 |           9 |           0 |         0 | 0%       |         4 | 21-Apr-2020  |
| hospital\_g                 |           7 |           0 |         0 | 0%       |         2 | 21-Apr-2020  |
| hospital\_b                 |           6 |           0 |         0 | 0%       |         3 | 21-Apr-2020  |
| hospital\_f                 |           6 |           0 |         0 | 0%       |         2 | 21-Apr-2020  |
| hospital\_h                 |           6 |           0 |         0 | 0%       |         4 | 21-Apr-2020  |
| hospital\_d                 |           4 |           0 |         0 | 0%       |         3 | 21-Apr-2020  |
| hospital\_c                 |           2 |           0 |         0 | 0%       |         1 | 21-Apr-2020  |
| hospital\_i                 |           0 |          NA |        NA | NA       |         4 | 21-Apr-2020  |
| hospital\_j                 |           0 |          NA |        NA | NA       |         4 | 21-Apr-2020  |

#### 2\. `$dag_nodata` Output

This will produce a dataframe of all DAG with users assigned on the
REDCap project, but no data uploaded to REDCap. This may be useful for
the purposes of targeting encouragement to upload data, or establishing
authorship on any research
output.

``` r
knitr::kable(output$dag_nodata)
```

| redcap\_data\_access\_group | record\_all | record\_com | prop\_com | pct\_com | user\_all | last\_update |
| :-------------------------- | ----------: | ----------: | --------: | :------- | --------: | :----------- |
| hospital\_i                 |           0 |          NA |        NA | NA       |         4 | 21-Apr-2020  |
| hospital\_j                 |           0 |          NA |        NA | NA       |         4 | 21-Apr-2020  |

#### 3\. `$dag_incom` Output

This will produce a dataframe of all DAG with incomplete records (the
definition of completeness customisable as discussed above). This may be
useful for the purposes of follow up regarding (essential) missing data
at each of these
DAGs.

``` r
knitr::kable(output$dag_incom)
```

| redcap\_data\_access\_group | record\_all | record\_com | prop\_com | pct\_com | user\_all | last\_update |
| :-------------------------- | ----------: | ----------: | --------: | :------- | --------: | :----------- |
| hospital\_a                 |          10 |           0 |         0 | 0%       |         3 | 21-Apr-2020  |
| hospital\_e                 |           9 |           0 |         0 | 0%       |         4 | 21-Apr-2020  |
| hospital\_g                 |           7 |           0 |         0 | 0%       |         2 | 21-Apr-2020  |
| hospital\_b                 |           6 |           0 |         0 | 0%       |         3 | 21-Apr-2020  |
| hospital\_f                 |           6 |           0 |         0 | 0%       |         2 | 21-Apr-2020  |
| hospital\_h                 |           6 |           0 |         0 | 0%       |         4 | 21-Apr-2020  |
| hospital\_d                 |           4 |           0 |         0 | 0%       |         3 | 21-Apr-2020  |
| hospital\_c                 |           2 |           0 |         0 | 0%       |         1 | 21-Apr-2020  |

#### 4\. `$dag_top_n` Output

This will produce a dataframe of the DAGs with the most records uploaded
overall (the number of DAGs listed is defined by `top` with top 10 DAG
being default). This may be useful for the purposes of publicity
surrounding the
project.

``` r
collaborator::redcap_sum(redcap_project_uri = Sys.getenv("collaborator_test_uri"),
                                   redcap_project_token = Sys.getenv("collaborator_test_token"),
                                   centre_sum = T, top = 5)$dag_top %>% 
  knitr::kable()
```

| redcap\_data\_access\_group | record\_all |
| :-------------------------- | ----------: |
| hospital\_a                 |          10 |
| hospital\_e                 |           9 |
| hospital\_g                 |           7 |
| hospital\_b                 |           6 |
| hospital\_f                 |           6 |
