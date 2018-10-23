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

    report_miss(redcap_project_uri,redcap_project_token)$data_missing_record

    ## # A tibble: 50 x 23
    ##    record_id redcap_data_access… miss_n fields_n miss_prop miss_pct miss_5
    ##    <chr>     <chr>                <dbl>    <dbl>     <dbl> <chr>    <chr> 
    ##  1 1         hospital_a               0       16    0      " 0.0%"  No    
    ##  2 2         hospital_a               2       16    0.125  12.5%    Yes   
    ##  3 3         hospital_a               1       16    0.0625 " 6.2%"  Yes   
    ##  4 4         hospital_a               0       16    0      " 0.0%"  No    
    ##  5 5         hospital_a               2       16    0.125  12.5%    Yes   
    ##  6 6         hospital_a               2       16    0.125  12.5%    Yes   
    ##  7 7         hospital_a               0       16    0      " 0.0%"  No    
    ##  8 8         hospital_a               0       16    0      " 0.0%"  No    
    ##  9 9         hospital_a               2       16    0.125  12.5%    Yes   
    ## 10 10        hospital_a               0       16    0      " 0.0%"  No    
    ## # ... with 40 more rows, and 16 more variables: pt_age <chr>,
    ## #   pt_sex <chr>, smoking_status <chr>, body_mass_index <chr>,
    ## #   pmh___1 <chr>, pmh___2 <chr>, pmh___3 <chr>, asa_grade <chr>,
    ## #   pt_ethnicity <chr>, adm_date <chr>, op_date <chr>, op_urgency <chr>,
    ## #   op_procedure_code <chr>, follow_up <chr>, follow_up_readm <chr>,
    ## #   follow_up_mort <chr>

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

    report_miss(redcap_project_uri,redcap_project_token)$data_missing_dag

    ## # A tibble: 8 x 7
    ##   redcap_data_access_gro…  n_pt n_pt5 cen_miss_n cen_field_n cen_miss_prop
    ##   <chr>                   <int> <int>      <dbl>       <dbl>         <dbl>
    ## 1 hospital_a                 10     5          9         160        0.0562
    ## 2 hospital_b                  6     3          9          96        0.0938
    ## 3 hospital_c                  2     0          0          32        0     
    ## 4 hospital_d                  4     3          3          64        0.0469
    ## 5 hospital_e                  9     3          7         144        0.0486
    ## 6 hospital_f                  6     1          1          96        0.0104
    ## 7 hospital_g                  7     3          7         112        0.0625
    ## 8 hospital_h                  6     3          4          96        0.0417
    ## # ... with 1 more variable: cen_miss_pct <chr>
