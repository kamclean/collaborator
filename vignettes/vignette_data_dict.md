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

    library(collaborator)

    data <- collaborator::example_data_dict
    knitr::kable(head(data, n=10)) # Please note data is not based on real patients

<table>
<thead>
<tr class="header">
<th style="text-align: left;">id_num</th>
<th style="text-align: right;">age</th>
<th style="text-align: left;">sex</th>
<th style="text-align: left;">ASA_grade</th>
<th style="text-align: left;">cvd_tf</th>
<th style="text-align: left;">cvd_yn</th>
<th style="text-align: left;">adm_date</th>
<th style="text-align: left;">op_date</th>
<th style="text-align: left;">op_urgency</th>
<th style="text-align: left;">op_procedure_code</th>
<th style="text-align: left;">follow_up</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">1</td>
<td style="text-align: right;">45</td>
<td style="text-align: left;">male</td>
<td style="text-align: left;">I</td>
<td style="text-align: left;">TRUE</td>
<td style="text-align: left;">yes</td>
<td style="text-align: left;">2018-07-29</td>
<td style="text-align: left;">2018-08-01</td>
<td style="text-align: left;">elective</td>
<td style="text-align: left;">0D9J00Z</td>
<td style="text-align: left;">yes</td>
</tr>
<tr class="even">
<td style="text-align: left;">2</td>
<td style="text-align: right;">23</td>
<td style="text-align: left;">female</td>
<td style="text-align: left;">II</td>
<td style="text-align: left;">TRUE</td>
<td style="text-align: left;">yes</td>
<td style="text-align: left;">2018-07-30</td>
<td style="text-align: left;">2018-08-02</td>
<td style="text-align: left;">elective</td>
<td style="text-align: left;">0D9J0ZZ</td>
<td style="text-align: left;">no</td>
</tr>
<tr class="odd">
<td style="text-align: left;">3</td>
<td style="text-align: right;">76</td>
<td style="text-align: left;">female</td>
<td style="text-align: left;">II</td>
<td style="text-align: left;">TRUE</td>
<td style="text-align: left;">yes</td>
<td style="text-align: left;">2018-07-30</td>
<td style="text-align: left;">2018-08-02</td>
<td style="text-align: left;">elective</td>
<td style="text-align: left;">0D9J40Z</td>
<td style="text-align: left;">NA</td>
</tr>
<tr class="even">
<td style="text-align: left;">4</td>
<td style="text-align: right;">54</td>
<td style="text-align: left;">female</td>
<td style="text-align: left;">IV</td>
<td style="text-align: left;">TRUE</td>
<td style="text-align: left;">yes</td>
<td style="text-align: left;">2018-07-31</td>
<td style="text-align: left;">2018-08-03</td>
<td style="text-align: left;">emergency</td>
<td style="text-align: left;">0D9J4ZZ</td>
<td style="text-align: left;">NA</td>
</tr>
<tr class="odd">
<td style="text-align: left;">5</td>
<td style="text-align: right;">32</td>
<td style="text-align: left;">female</td>
<td style="text-align: left;">III</td>
<td style="text-align: left;">FALSE</td>
<td style="text-align: left;">no</td>
<td style="text-align: left;">2018-08-01</td>
<td style="text-align: left;">2018-08-04</td>
<td style="text-align: left;">elective</td>
<td style="text-align: left;">0DQJ0ZZ</td>
<td style="text-align: left;">yes</td>
</tr>
<tr class="even">
<td style="text-align: left;">6</td>
<td style="text-align: right;">34</td>
<td style="text-align: left;">female</td>
<td style="text-align: left;">III</td>
<td style="text-align: left;">FALSE</td>
<td style="text-align: left;">no</td>
<td style="text-align: left;">2018-08-01</td>
<td style="text-align: left;">2018-08-04</td>
<td style="text-align: left;">emergency</td>
<td style="text-align: left;">0DQJ4ZZ</td>
<td style="text-align: left;">no</td>
</tr>
<tr class="odd">
<td style="text-align: left;">7</td>
<td style="text-align: right;">56</td>
<td style="text-align: left;">female</td>
<td style="text-align: left;">III</td>
<td style="text-align: left;">TRUE</td>
<td style="text-align: left;">yes</td>
<td style="text-align: left;">2018-08-01</td>
<td style="text-align: left;">2018-08-04</td>
<td style="text-align: left;">emergency</td>
<td style="text-align: left;">0DTJ0ZZ</td>
<td style="text-align: left;">NA</td>
</tr>
<tr class="even">
<td style="text-align: left;">8</td>
<td style="text-align: right;">78</td>
<td style="text-align: left;">female</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">TRUE</td>
<td style="text-align: left;">yes</td>
<td style="text-align: left;">2018-08-02</td>
<td style="text-align: left;">2018-08-05</td>
<td style="text-align: left;">emergency</td>
<td style="text-align: left;">0DTJ4ZZ</td>
<td style="text-align: left;">yes</td>
</tr>
<tr class="odd">
<td style="text-align: left;">9</td>
<td style="text-align: right;">79</td>
<td style="text-align: left;">female</td>
<td style="text-align: left;">I</td>
<td style="text-align: left;">FALSE</td>
<td style="text-align: left;">no</td>
<td style="text-align: left;">2018-08-03</td>
<td style="text-align: left;">2018-08-06</td>
<td style="text-align: left;">emergency</td>
<td style="text-align: left;">0F140D3</td>
<td style="text-align: left;">NA</td>
</tr>
<tr class="even">
<td style="text-align: left;">10</td>
<td style="text-align: right;">65</td>
<td style="text-align: left;">female</td>
<td style="text-align: left;">II</td>
<td style="text-align: left;">TRUE</td>
<td style="text-align: left;">yes</td>
<td style="text-align: left;">2018-08-04</td>
<td style="text-align: left;">2018-08-07</td>
<td style="text-align: left;">emergency</td>
<td style="text-align: left;">0F140D5</td>
<td style="text-align: left;">NA</td>
</tr>
</tbody>
</table>

Main Features
-------------

### Output

The `data_dict()` function produces a dataframe which identifies the
class, summarised values, and proportion of missing data for each
variable in the original dataframe.

The output can be easily converted to a spreadsheet file (e.g. csv file)
and exported for sharing.

    library(collaborator)
    data_dict(data)
    ##             variable         class
    ## 1             id_num     character
    ## 2                age       numeric
    ## 3                sex        factor
    ## 4          ASA_grade orderedfactor
    ## 5             cvd_tf       logical
    ## 6             cvd_yn        factor
    ## 7           adm_date          Date
    ## 8            op_date          Date
    ## 9         op_urgency        factor
    ## 10 op_procedure_code     character
    ## 11         follow_up        factor
    ##                                                                                                 values
    ## 1                                                             20 Unique: 1, 10, 2, 3, 4, 5, 6, 7, 8, 9
    ## 2                                                          Mean: 50.7 Median: 49.5 Range: 22.0 to 79.0
    ## 3                                                                               2 Levels: female, male
    ## 4                                                                          5 Levels: I, II, III, IV, V
    ## 5                                        TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, TRUE, TRUE, FALSE, TRUE
    ## 6                                                                                    2 Levels: no, yes
    ## 7                                                                     Range:  2018-07-29 to 2018-08-11
    ## 8                                                                     Range:  2018-08-01 to 2018-08-14
    ## 9                                                                        2 Levels: elective, emergency
    ## 10 20 Unique: 0D9J00Z, 0D9J0ZZ, 0D9J40Z, 0D9J4ZZ, 0DQJ0ZZ, 0DQJ4ZZ, 0DTJ0ZZ, 0DTJ4ZZ, 0F140D3, 0F140D5
    ## 11                                                                                   2 Levels: no, yes
    ##    na_pct
    ## 1    0.0%
    ## 2    0.0%
    ## 3    0.0%
    ## 4   15.0%
    ## 5    0.0%
    ## 6    0.0%
    ## 7    0.0%
    ## 8    0.0%
    ## 9    0.0%
    ## 10   0.0%
    ## 11  45.0%

Through summarising the variables, data will not necessarily be linkable
to individual patients (bar in the circumstance where variable(s)
contain a direct patient identifier e.g. Community Health Index (CHI)
Number, hospital numbers, etc).

However, should any variable(s) (such as a direct patient identifier) be
desirable to exclude from the output, this can be achieved using the
“var\_exclude” parameter.

    library(collaborator)
    knitr::kable(data_dict(data, var_exclude = c("id_num","sex")))

<table>
<thead>
<tr class="header">
<th style="text-align: left;">variable</th>
<th style="text-align: left;">class</th>
<th style="text-align: left;">values</th>
<th style="text-align: left;">na_pct</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">age</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Mean: 50.7 Median: 49.5 Range: 22.0 to 79.0</td>
<td style="text-align: left;">0.0%</td>
</tr>
<tr class="even">
<td style="text-align: left;">ASA_grade</td>
<td style="text-align: left;">orderedfactor</td>
<td style="text-align: left;">5 Levels: I, II, III, IV, V</td>
<td style="text-align: left;">15.0%</td>
</tr>
<tr class="odd">
<td style="text-align: left;">cvd_tf</td>
<td style="text-align: left;">logical</td>
<td style="text-align: left;">TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, TRUE, TRUE, FALSE, TRUE</td>
<td style="text-align: left;">0.0%</td>
</tr>
<tr class="even">
<td style="text-align: left;">cvd_yn</td>
<td style="text-align: left;">factor</td>
<td style="text-align: left;">2 Levels: no, yes</td>
<td style="text-align: left;">0.0%</td>
</tr>
<tr class="odd">
<td style="text-align: left;">adm_date</td>
<td style="text-align: left;">Date</td>
<td style="text-align: left;">Range: 2018-07-29 to 2018-08-11</td>
<td style="text-align: left;">0.0%</td>
</tr>
<tr class="even">
<td style="text-align: left;">op_date</td>
<td style="text-align: left;">Date</td>
<td style="text-align: left;">Range: 2018-08-01 to 2018-08-14</td>
<td style="text-align: left;">0.0%</td>
</tr>
<tr class="odd">
<td style="text-align: left;">op_urgency</td>
<td style="text-align: left;">factor</td>
<td style="text-align: left;">2 Levels: elective, emergency</td>
<td style="text-align: left;">0.0%</td>
</tr>
<tr class="even">
<td style="text-align: left;">op_procedure_code</td>
<td style="text-align: left;">character</td>
<td style="text-align: left;">20 Unique: 0D9J00Z, 0D9J0ZZ, 0D9J40Z, 0D9J4ZZ, 0DQJ0ZZ, 0DQJ4ZZ, 0DTJ0ZZ, 0DTJ4ZZ, 0F140D3, 0F140D5</td>
<td style="text-align: left;">0.0%</td>
</tr>
<tr class="odd">
<td style="text-align: left;">follow_up</td>
<td style="text-align: left;">factor</td>
<td style="text-align: left;">2 Levels: no, yes</td>
<td style="text-align: left;">45.0%</td>
</tr>
</tbody>
</table>
