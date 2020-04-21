Collaborator: Generating a Simple, Easily-Shareable Data Dictionary
===================================================================

The function `data_dict()` can be used to generate an easily sharable
and informative data dictionary for an R dataframe. Unlike the `str()`
function typically used to display the internal structure of dataframes
in R, this produces a dataframe alongside summarising information
relevant to the class of variable, and the proportion of missing data
(NA) within each variable.

This can be useful in quickly understanding how data is structured
within the dataset, and in assessing data quality (e.g. outlying and
incorrect or quantity of missing values). This can be easily exported
from R and shared as a spreadsheet.

Requirements
------------

The `data_dict()` function can be applied to any dataframe object. At
present, it supports the following classes (other classes will be shown
as “Class not supported” in the values column):

-   Numeric, integer.
-   Logical.
-   Date.
-   Character, String.
-   Factor, orderedfactor.

Example dataframe (`example_data_dict`):

``` r

data <- collaborator::example_data_dict
knitr::kable(head(data, n=10)) # Please note data is not based on real patients
```

| id\_num |  age| sex    | ASA\_grade | cvd\_tf | cvd\_yn | adm\_date  | op\_date   | op\_urgency | op\_procedure\_code | follow\_up |
|:--------|----:|:-------|:-----------|:--------|:--------|:-----------|:-----------|:------------|:--------------------|:-----------|
| 1       |   45| male   | I          | TRUE    | yes     | 2018-07-29 | 2018-08-01 | elective    | 0D9J00Z             | yes        |
| 2       |   23| female | II         | TRUE    | yes     | 2018-07-30 | 2018-08-02 | elective    | 0D9J0ZZ             | no         |
| 3       |   76| female | II         | TRUE    | yes     | 2018-07-30 | 2018-08-02 | elective    | 0D9J40Z             | NA         |
| 4       |   54| female | IV         | TRUE    | yes     | 2018-07-31 | 2018-08-03 | emergency   | 0D9J4ZZ             | NA         |
| 5       |   32| female | III        | FALSE   | no      | 2018-08-01 | 2018-08-04 | elective    | 0DQJ0ZZ             | yes        |
| 6       |   34| female | III        | FALSE   | no      | 2018-08-01 | 2018-08-04 | emergency   | 0DQJ4ZZ             | no         |
| 7       |   56| female | III        | TRUE    | yes     | 2018-08-01 | 2018-08-04 | emergency   | 0DTJ0ZZ             | NA         |
| 8       |   78| female | NA         | TRUE    | yes     | 2018-08-02 | 2018-08-05 | emergency   | 0DTJ4ZZ             | yes        |
| 9       |   79| female | I          | FALSE   | no      | 2018-08-03 | 2018-08-06 | emergency   | 0F140D3             | NA         |
| 10      |   65| female | II         | TRUE    | yes     | 2018-08-04 | 2018-08-07 | emergency   | 0F140D5             | NA         |

Main Features
-------------

### Output

The `data_dict()` function produces a dataframe which identifies the
class, summarised values, and proportion of missing data for each
variable in the original dataframe.

The output can be easily converted to a spreadsheet file (e.g. csv file)
and exported for sharing.

``` r

data_dict(data) %>%
  knitr::kable()
```

| variable            | class         | value                                                                                               | na\_pct |
|:--------------------|:--------------|:----------------------------------------------------------------------------------------------------|:--------|
| id\_num             | character     | 20 Unique: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10                                                            | 0.0%    |
| age                 | numeric       | Mean: 50.7; Median: 49.5; Range: 22 to 79                                                           | 0.0%    |
| sex                 | factor        | 2 Levels: female, male                                                                              | 0.0%    |
| ASA\_grade          | orderedfactor | 5 Levels: I, II, III, IV, V                                                                         | 15.0%   |
| cvd\_tf             | logical       | TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, TRUE, TRUE, FALSE, TRUE                                       | 0.0%    |
| cvd\_yn             | factor        | 2 Levels: no, yes                                                                                   | 0.0%    |
| adm\_date           | Date          | Range: 2018-07-29 to 2018-08-11                                                                     | 0.0%    |
| op\_date            | Date          | Range: 2018-08-01 to 2018-08-14                                                                     | 0.0%    |
| op\_urgency         | factor        | 2 Levels: elective, emergency                                                                       | 0.0%    |
| op\_procedure\_code | character     | 20 Unique: 0D9J00Z, 0D9J0ZZ, 0D9J40Z, 0D9J4ZZ, 0DQJ0ZZ, 0DQJ4ZZ, 0DTJ0ZZ, 0DTJ4ZZ, 0F140D3, 0F140D5 | 0.0%    |
| follow\_up          | factor        | 2 Levels: no, yes                                                                                   | 45.0%   |

Through summarising the variables, data will not necessarily be linkable
to individual patients (bar in the circumstance where variable(s)
contain a direct patient identifier e.g. Community Health Index (CHI)
Number, hospital numbers, etc).

However, should any variable(s) (such as a direct patient identifier) be
desirable to exclude from the output, this can be achieved using the
“var\_exclude” parameter.

``` r
knitr::kable(collaborator::data_dict(data, var_exclude = c("id_num","sex")))
```

| variable            | class         | value                                                                                               | na\_pct |
|:--------------------|:--------------|:----------------------------------------------------------------------------------------------------|:--------|
| age                 | numeric       | Mean: 50.7; Median: 49.5; Range: 22 to 79                                                           | 0.0%    |
| ASA\_grade          | orderedfactor | 5 Levels: I, II, III, IV, V                                                                         | 15.0%   |
| cvd\_tf             | logical       | TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, TRUE, TRUE, FALSE, TRUE                                       | 0.0%    |
| cvd\_yn             | factor        | 2 Levels: no, yes                                                                                   | 0.0%    |
| adm\_date           | Date          | Range: 2018-07-29 to 2018-08-11                                                                     | 0.0%    |
| op\_date            | Date          | Range: 2018-08-01 to 2018-08-14                                                                     | 0.0%    |
| op\_urgency         | factor        | 2 Levels: elective, emergency                                                                       | 0.0%    |
| op\_procedure\_code | character     | 20 Unique: 0D9J00Z, 0D9J0ZZ, 0D9J40Z, 0D9J4ZZ, 0DQJ0ZZ, 0DQJ4ZZ, 0DTJ0ZZ, 0DTJ4ZZ, 0F140D3, 0F140D5 | 0.0%    |
| follow\_up          | factor        | 2 Levels: no, yes                                                                                   | 45.0%   |
