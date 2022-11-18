## REDCap Data for R

REDCap is a fantastic database, however the ability to export data is
limited to the “raw” data (e.g. factors stored as numbers) or “labelled”
data (e.g. factors stored as characters). While code is able to be
obtained to convert data into the appropriate format, this the unwieldy
and needs to be refershed if the underlying project design is changed.

The `redcap_data()` function provides a simple way to export, clean, and
format data ready for analysis in R. This utilities data available in
the metadata of the project to ensure numeric data is numeric, factors
are factors in the appropriate order, dates are dates objects, etc. It
remains aligned to the data on REDCap despite any changes in the project
design.

    redcap <- collaborator::redcap_data(redcap_project_uri = Sys.getenv("collaborator_test_uri"),
                              redcap_project_token = Sys.getenv("collaborator_test_token"),
                              include_original = T)

There are 3 potential outputs from this function:

1.  `data`: The cleaned and formatted REDCap dataset:

<!-- -->

    knitr::kable(redcap$data %>% head(5))

<table>
<thead>
<tr>
<th style="text-align:left;">
record\_id
</th>
<th style="text-align:left;">
redcap\_data\_access\_group
</th>
<th style="text-align:left;">
dmy\_hms
</th>
<th style="text-align:left;">
enrol\_tf
</th>
<th style="text-align:left;">
enrol\_signature
</th>
<th style="text-align:right;">
pt\_age
</th>
<th style="text-align:left;">
pt\_sex
</th>
<th style="text-align:left;">
smoking\_status
</th>
<th style="text-align:right;">
body\_mass\_index
</th>
<th style="text-align:left;">
pmh\_\_\_1
</th>
<th style="text-align:left;">
pmh\_\_\_2
</th>
<th style="text-align:left;">
pmh\_\_\_3
</th>
<th style="text-align:left;">
asa\_grade
</th>
<th style="text-align:left;">
pt\_ethnicity
</th>
<th style="text-align:left;">
pt\_ethnicity\_other
</th>
<th style="text-align:left;">
adm\_date
</th>
<th style="text-align:right;">
adm\_vas
</th>
<th style="text-align:right;">
time2op
</th>
<th style="text-align:left;">
op\_urgency
</th>
<th style="text-align:left;">
op\_procedure\_code
</th>
<th style="text-align:left;">
follow\_up
</th>
<th style="text-align:left;">
follow\_up\_readm
</th>
<th style="text-align:left;">
follow\_up\_mort
</th>
<th style="text-align:left;">
file
</th>
<th style="text-align:right;">
redcap\_repeat\_instance
</th>
<th style="text-align:left;">
crp\_yn
</th>
<th style="text-align:right;">
crp\_value
</th>
<th style="text-align:left;">
day
</th>
<th style="text-align:left;">
hb\_value
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
hospital\_a
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
FALSE
</td>
<td style="text-align:right;">
45
</td>
<td style="text-align:left;">
Male
</td>
<td style="text-align:left;">
Current smoker
</td>
<td style="text-align:right;">
22
</td>
<td style="text-align:left;">
Ischaemic Heart Disease (IHD)
</td>
<td style="text-align:left;">
Chronic Obstructive Pulmonary Disease (COPD)
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
V
</td>
<td style="text-align:left;">
White
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
2018-07-29
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
Elective
</td>
<td style="text-align:left;">
0D9J00Z
</td>
<td style="text-align:left;">
Yes
</td>
<td style="text-align:left;">
Yes
</td>
<td style="text-align:left;">
Yes
</td>
<td style="text-align:left;">
TRUE
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
Yes
</td>
<td style="text-align:right;">
120
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
hospital\_a
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
FALSE
</td>
<td style="text-align:right;">
45
</td>
<td style="text-align:left;">
Male
</td>
<td style="text-align:left;">
Current smoker
</td>
<td style="text-align:right;">
22
</td>
<td style="text-align:left;">
Ischaemic Heart Disease (IHD)
</td>
<td style="text-align:left;">
Chronic Obstructive Pulmonary Disease (COPD)
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
V
</td>
<td style="text-align:left;">
White
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
2018-07-29
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
Elective
</td>
<td style="text-align:left;">
0D9J00Z
</td>
<td style="text-align:left;">
Yes
</td>
<td style="text-align:left;">
Yes
</td>
<td style="text-align:left;">
Yes
</td>
<td style="text-align:left;">
TRUE
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:left;">
Yes
</td>
<td style="text-align:right;">
100
</td>
<td style="text-align:left;">
2
</td>
<td style="text-align:left;">
110
</td>
</tr>
<tr>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
hospital\_a
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
FALSE
</td>
<td style="text-align:right;">
45
</td>
<td style="text-align:left;">
Male
</td>
<td style="text-align:left;">
Current smoker
</td>
<td style="text-align:right;">
22
</td>
<td style="text-align:left;">
Ischaemic Heart Disease (IHD)
</td>
<td style="text-align:left;">
Chronic Obstructive Pulmonary Disease (COPD)
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
V
</td>
<td style="text-align:left;">
White
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
2018-07-29
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
Elective
</td>
<td style="text-align:left;">
0D9J00Z
</td>
<td style="text-align:left;">
Yes
</td>
<td style="text-align:left;">
Yes
</td>
<td style="text-align:left;">
Yes
</td>
<td style="text-align:left;">
TRUE
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
3
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
hospital\_a
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
FALSE
</td>
<td style="text-align:right;">
45
</td>
<td style="text-align:left;">
Male
</td>
<td style="text-align:left;">
Current smoker
</td>
<td style="text-align:right;">
22
</td>
<td style="text-align:left;">
Ischaemic Heart Disease (IHD)
</td>
<td style="text-align:left;">
Chronic Obstructive Pulmonary Disease (COPD)
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
V
</td>
<td style="text-align:left;">
White
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
2018-07-29
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
Elective
</td>
<td style="text-align:left;">
0D9J00Z
</td>
<td style="text-align:left;">
Yes
</td>
<td style="text-align:left;">
Yes
</td>
<td style="text-align:left;">
Yes
</td>
<td style="text-align:left;">
TRUE
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
4
</td>
<td style="text-align:left;">
140
</td>
</tr>
<tr>
<td style="text-align:left;">
2
</td>
<td style="text-align:left;">
hospital\_a
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
FALSE
</td>
<td style="text-align:right;">
23
</td>
<td style="text-align:left;">
Female
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
Chronic Obstructive Pulmonary Disease (COPD)
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
V
</td>
<td style="text-align:left;">
Black / African / Caribbean / Black British
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
2018-07-30
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
Emergency
</td>
<td style="text-align:left;">
0D9J0ZZ
</td>
<td style="text-align:left;">
Yes
</td>
<td style="text-align:left;">
Yes
</td>
<td style="text-align:left;">
Yes
</td>
<td style="text-align:left;">
TRUE
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
</tbody>
</table>

1.  `metadata`: The metadata used to create `data`.

<!-- -->

    knitr::kable(redcap$metadata %>% head(5))

<table>
<thead>
<tr>
<th style="text-align:left;">
variable\_name
</th>
<th style="text-align:left;">
class
</th>
<th style="text-align:left;">
form\_name
</th>
<th style="text-align:left;">
matrix\_name
</th>
<th style="text-align:left;">
variable\_type
</th>
<th style="text-align:left;">
variable\_validation
</th>
<th style="text-align:right;">
variable\_validation\_min
</th>
<th style="text-align:left;">
variable\_validation\_max
</th>
<th style="text-align:left;">
branch\_logic
</th>
<th style="text-align:left;">
variable\_identifier
</th>
<th style="text-align:left;">
variable\_required
</th>
<th style="text-align:left;">
variable\_label
</th>
<th style="text-align:left;">
select\_choices\_or\_calculations
</th>
<th style="text-align:left;">
factor\_level
</th>
<th style="text-align:left;">
factor\_label
</th>
<th style="text-align:left;">
arm
</th>
<th style="text-align:left;">
redcap\_event\_name
</th>
<th style="text-align:left;">
form\_repeat
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
record\_id
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
example\_data
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
text
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
No
</td>
<td style="text-align:left;">
No
</td>
<td style="text-align:left;">
Record ID
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NULL
</td>
<td style="text-align:left;">
NULL
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
No
</td>
</tr>
<tr>
<td style="text-align:left;">
redcap\_repeat\_instrument
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
redcap\_repeat\_instrument
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NULL
</td>
<td style="text-align:left;">
NULL
</td>
<td style="text-align:left;">
NULL
</td>
<td style="text-align:left;">
NULL
</td>
<td style="text-align:left;">
No
</td>
</tr>
<tr>
<td style="text-align:left;">
redcap\_repeat\_instance
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
redcap\_repeat\_instance
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NULL
</td>
<td style="text-align:left;">
NULL
</td>
<td style="text-align:left;">
NULL
</td>
<td style="text-align:left;">
NULL
</td>
<td style="text-align:left;">
No
</td>
</tr>
<tr>
<td style="text-align:left;">
redcap\_data\_access\_group
</td>
<td style="text-align:left;">
factor
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
REDCap Data Access Group
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NULL
</td>
<td style="text-align:left;">
NULL
</td>
<td style="text-align:left;">
NULL
</td>
<td style="text-align:left;">
NULL
</td>
<td style="text-align:left;">
No
</td>
</tr>
<tr>
<td style="text-align:left;">
dmy\_hms
</td>
<td style="text-align:left;">
datetime
</td>
<td style="text-align:left;">
example\_data
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
text
</td>
<td style="text-align:left;">
datetime\_seconds\_dmy
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
No
</td>
<td style="text-align:left;">
Yes
</td>
<td style="text-align:left;">
Time of entry
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NULL
</td>
<td style="text-align:left;">
NULL
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
No
</td>
</tr>
</tbody>
</table>

1.  `original`: An optional output showing the raw dataset extracted
    from REDCap (included if `include_original = T`):

<!-- -->

    knitr::kable(redcap$original %>% head(5))

<table>
<thead>
<tr>
<th style="text-align:right;">
record\_id
</th>
<th style="text-align:left;">
redcap\_repeat\_instrument
</th>
<th style="text-align:right;">
redcap\_repeat\_instance
</th>
<th style="text-align:left;">
redcap\_data\_access\_group
</th>
<th style="text-align:left;">
dmy\_hms
</th>
<th style="text-align:left;">
enrol\_tf
</th>
<th style="text-align:left;">
enrol\_signature
</th>
<th style="text-align:right;">
pt\_age
</th>
<th style="text-align:right;">
pt\_sex
</th>
<th style="text-align:right;">
smoking\_status
</th>
<th style="text-align:right;">
body\_mass\_index
</th>
<th style="text-align:right;">
pmh\_\_\_1
</th>
<th style="text-align:right;">
pmh\_\_\_2
</th>
<th style="text-align:right;">
pmh\_\_\_3
</th>
<th style="text-align:right;">
asa\_grade
</th>
<th style="text-align:right;">
pt\_ethnicity
</th>
<th style="text-align:left;">
pt\_ethnicity\_other
</th>
<th style="text-align:left;">
adm\_date
</th>
<th style="text-align:left;">
adm\_vas
</th>
<th style="text-align:left;">
time2op
</th>
<th style="text-align:right;">
op\_urgency
</th>
<th style="text-align:left;">
op\_procedure\_code
</th>
<th style="text-align:right;">
follow\_up
</th>
<th style="text-align:right;">
follow\_up\_readm
</th>
<th style="text-align:right;">
follow\_up\_mort
</th>
<th style="text-align:right;">
crp\_yn
</th>
<th style="text-align:right;">
crp\_value
</th>
<th style="text-align:right;">
day
</th>
<th style="text-align:right;">
hb\_value
</th>
<th style="text-align:left;">
file
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
hospital\_a
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
45
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
22
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
5
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
2018-07-29
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
0D9J00Z
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
1\_result.csv
</td>
</tr>
<tr>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
crp
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
hospital\_a
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
120
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
crp
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:left;">
hospital\_a
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
100
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
hb
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
hospital\_a
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
100
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
hb
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:left;">
hospital\_a
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:right;">
110
</td>
<td style="text-align:left;">
NA
</td>
</tr>
</tbody>
</table>

## Handling Repeating Instruments

You may note above that the structure of `redcap$data` and
`redcap$original` are different, and that there are multiple rows with
the record ID 1. This is because the project includes repeating
instruments (forms that can be completed repeatedly to facilitate
longitudinal data collection) - this add complexity to how the data is
structured / has to be handled.

The default for both the original and formatted data is to provide the
data in a “long” format - one row per repeating instrument:

-   Data which is not part of a repeating instrument is copied across
    all repeating rows.

-   Data which is part of a repeating instrument is shown to the right
    of the “redcap\_repeat\_instance” column (it indicates which
    instrument each row belongs to).

<!-- -->

    knitr::kable(redcap$data %>% dplyr::select(record_id,pt_age:pt_sex, redcap_repeat_instance:last_col())%>% head(5))

<table>
<thead>
<tr>
<th style="text-align:left;">
record\_id
</th>
<th style="text-align:right;">
pt\_age
</th>
<th style="text-align:left;">
pt\_sex
</th>
<th style="text-align:right;">
redcap\_repeat\_instance
</th>
<th style="text-align:left;">
crp\_yn
</th>
<th style="text-align:right;">
crp\_value
</th>
<th style="text-align:left;">
day
</th>
<th style="text-align:left;">
hb\_value
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
1
</td>
<td style="text-align:right;">
45
</td>
<td style="text-align:left;">
Male
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
Yes
</td>
<td style="text-align:right;">
120
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
1
</td>
<td style="text-align:right;">
45
</td>
<td style="text-align:left;">
Male
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:left;">
Yes
</td>
<td style="text-align:right;">
100
</td>
<td style="text-align:left;">
2
</td>
<td style="text-align:left;">
110
</td>
</tr>
<tr>
<td style="text-align:left;">
1
</td>
<td style="text-align:right;">
45
</td>
<td style="text-align:left;">
Male
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
3
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
1
</td>
<td style="text-align:right;">
45
</td>
<td style="text-align:left;">
Male
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
4
</td>
<td style="text-align:left;">
140
</td>
</tr>
<tr>
<td style="text-align:left;">
2
</td>
<td style="text-align:right;">
23
</td>
<td style="text-align:left;">
Female
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
</tbody>
</table>

However if you require 1 record per row for analysis (the majority of
cases), but wish to keep data from ALL repeating instruments you can
easily change the data structure by applying `redcap_format_repeat()` to
`redcap_data()$data` or specify in `redcap_data()`upfront using the
`format` argument. This has 2 options instead of “long” format:

1.  `wide`: The repeating instruments are all transposed and numbered
    accordingly. The consistent naming scheme allows re-conversion to a
    long format using `tidyr::pivot_longer()`.

<!-- -->

    redcap$data %>%
      redcap_format_repeat(format = "wide") %>%
      dplyr::select(record_id, contains("instance")) %>%
      knitr::kable()

<table>
<thead>
<tr>
<th style="text-align:left;">
record\_id
</th>
<th style="text-align:left;">
crp\_yn\_instance1
</th>
<th style="text-align:left;">
crp\_yn\_instance2
</th>
<th style="text-align:left;">
crp\_yn\_instance3
</th>
<th style="text-align:left;">
crp\_yn\_instance4
</th>
<th style="text-align:right;">
crp\_value\_instance1
</th>
<th style="text-align:right;">
crp\_value\_instance2
</th>
<th style="text-align:right;">
crp\_value\_instance3
</th>
<th style="text-align:right;">
crp\_value\_instance4
</th>
<th style="text-align:left;">
day\_instance1
</th>
<th style="text-align:left;">
day\_instance2
</th>
<th style="text-align:left;">
day\_instance3
</th>
<th style="text-align:left;">
day\_instance4
</th>
<th style="text-align:left;">
hb\_value\_instance1
</th>
<th style="text-align:left;">
hb\_value\_instance2
</th>
<th style="text-align:left;">
hb\_value\_instance3
</th>
<th style="text-align:left;">
hb\_value\_instance4
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
Yes
</td>
<td style="text-align:left;">
Yes
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
120
</td>
<td style="text-align:right;">
100
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
2
</td>
<td style="text-align:left;">
3
</td>
<td style="text-align:left;">
4
</td>
<td style="text-align:left;">
100
</td>
<td style="text-align:left;">
110
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
140
</td>
</tr>
<tr>
<td style="text-align:left;">
2
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
3
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
3
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
110
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
120
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
4
</td>
<td style="text-align:left;">
Yes
</td>
<td style="text-align:left;">
No
</td>
<td style="text-align:left;">
Yes
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
120
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
5
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
6
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
7
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
8
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
9
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
10
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
11
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
12
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
13
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
14
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
15
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
16
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
17
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
18
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
19
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
20
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
21
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
22
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
23
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
24
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
25
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
26
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
27
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
28
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
29
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
30
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
31
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
32
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
33
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
34
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
35
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
36
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
37
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
38
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
39
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
40
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
41
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
42
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
43
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
44
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
45
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
46
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
47
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
48
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
49
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
50
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
</tbody>
</table>

1.  `list`: The repeating instruments are all stored as a nested list
    for each record (more efficent storage of data). This can be
    unnested at a later point using `tidyr::unnest()`.

<!-- -->

    redcap$data %>%
      redcap_format_repeat(format = "list") %>%
      dplyr::select(record_id, redcap_repeat_instance:last_col()) %>%
      knitr::kable()

<table>
<thead>
<tr>
<th style="text-align:left;">
record\_id
</th>
<th style="text-align:left;">
redcap\_repeat\_instance
</th>
<th style="text-align:left;">
crp\_yn
</th>
<th style="text-align:left;">
crp\_value
</th>
<th style="text-align:left;">
day
</th>
<th style="text-align:left;">
hb\_value
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
1, 2, 3, 4
</td>
<td style="text-align:left;">
2, 2, NA, NA
</td>
<td style="text-align:left;">
120, 100, NA, NA
</td>
<td style="text-align:left;">
1, 2, 3, 4
</td>
<td style="text-align:left;">
100, 110, NA , 140
</td>
</tr>
<tr>
<td style="text-align:left;">
2
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
3
</td>
<td style="text-align:left;">
1, 2, 3
</td>
<td style="text-align:left;">
NA, NA, NA
</td>
<td style="text-align:left;">
NA, NA, NA
</td>
<td style="text-align:left;">
1 , NA, 3
</td>
<td style="text-align:left;">
110, NA , 120
</td>
</tr>
<tr>
<td style="text-align:left;">
4
</td>
<td style="text-align:left;">
1, 2, 3
</td>
<td style="text-align:left;">
2, 1, 2
</td>
<td style="text-align:left;">
NA, NA, 120
</td>
<td style="text-align:left;">
NA, NA, NA
</td>
<td style="text-align:left;">
NA, NA, NA
</td>
</tr>
<tr>
<td style="text-align:left;">
5
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
6
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
7
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
8
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
9
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
10
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
11
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
12
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
13
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
14
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
15
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
16
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
17
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
18
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
19
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
20
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
21
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
22
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
23
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
24
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
25
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
26
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
27
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
28
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
29
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
30
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
31
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
32
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
33
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
34
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
35
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
36
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
37
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
38
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
39
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
40
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
41
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
42
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
43
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
44
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
45
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
46
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
47
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
48
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
49
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
50
</td>
<td style="text-align:left;">
1
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
</tbody>
</table>

## Generating a Simple, Easily-Shareable Data Dictionary

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

### Requirements

The `data_dict()` function can be applied to any dataframe object. At
present, it supports the following classes (other classes will be shown
as “Class not supported” in the values column):

-   Numeric, integer.
-   Logical.
-   Date.
-   Character, String.
-   Factor, orderedfactor.

### Output

The `data_dict()` function produces a dataframe which identifies the
class, summarised values, and proportion of missing data for each
variable in the original dataframe.

The output can be easily converted to a spreadsheet file (e.g. csv file)
and exported for sharing. Let’s use the data extracted above.

    data <- redcap$data %>% redcap_format_repeat(format = "wide")

    data_dict(data) %>%
      knitr::kable()

<table>
<thead>
<tr>
<th style="text-align:left;">
variable
</th>
<th style="text-align:left;">
class
</th>
<th style="text-align:left;">
value
</th>
<th style="text-align:left;">
na\_pct
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
record\_id
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
50 Unique: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
</td>
<td style="text-align:left;">
0.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
redcap\_data\_access\_group
</td>
<td style="text-align:left;">
factor
</td>
<td style="text-align:left;">
8 Levels: hospital\_a, hospital\_b, hospital\_c, hospital\_d,
hospital\_e, hospital\_f, hospital\_g, hospital\_h
</td>
<td style="text-align:left;">
0.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
enrol\_tf
</td>
<td style="text-align:left;">
logical
</td>
<td style="text-align:left;">
NA, NA, NA, NA, NA, NA, NA, NA, NA, NA
</td>
<td style="text-align:left;">
100.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
enrol\_signature
</td>
<td style="text-align:left;">
logical
</td>
<td style="text-align:left;">
FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE
</td>
<td style="text-align:left;">
0.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
pt\_age
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean: 46; Median: 44.5; Range: 15 to 79
</td>
<td style="text-align:left;">
0.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
pt\_sex
</td>
<td style="text-align:left;">
factor
</td>
<td style="text-align:left;">
2 Levels: Male, Female
</td>
<td style="text-align:left;">
4.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
smoking\_status
</td>
<td style="text-align:left;">
factor
</td>
<td style="text-align:left;">
3 Levels: Current smoker, Ex-smoker, Non-smoker
</td>
<td style="text-align:left;">
4.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
body\_mass\_index
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean: 30.3; Median: 30; Range: 21 to 47
</td>
<td style="text-align:left;">
22.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
pmh\_\_\_1
</td>
<td style="text-align:left;">
factor
</td>
<td style="text-align:left;">
1 Levels: Ischaemic Heart Disease (IHD)
</td>
<td style="text-align:left;">
48.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
pmh\_\_\_2
</td>
<td style="text-align:left;">
factor
</td>
<td style="text-align:left;">
1 Levels: Chronic Obstructive Pulmonary Disease (COPD)
</td>
<td style="text-align:left;">
62.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
pmh\_\_\_3
</td>
<td style="text-align:left;">
factor
</td>
<td style="text-align:left;">
1 Levels: Diabetes Mellitus
</td>
<td style="text-align:left;">
56.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
asa\_grade
</td>
<td style="text-align:left;">
factor
</td>
<td style="text-align:left;">
5 Levels: I, II, III, IV, V
</td>
<td style="text-align:left;">
6.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
pt\_ethnicity
</td>
<td style="text-align:left;">
factor
</td>
<td style="text-align:left;">
5 Levels: Asian / Asian British, Black / African / Caribbean / Black
British, Mixed / Multiple ethnic groups, White, Other ethnic group
</td>
<td style="text-align:left;">
0.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
pt\_ethnicity\_other
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
1 Unique: NA
</td>
<td style="text-align:left;">
100.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
adm\_date
</td>
<td style="text-align:left;">
Date
</td>
<td style="text-align:left;">
Range: 2018-07-29 to 2018-08-11
</td>
<td style="text-align:left;">
0.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
adm\_vas
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean: NaN; Median: NA; Range: Inf to -Inf
</td>
<td style="text-align:left;">
100.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
time2op
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean: NaN; Median: NA; Range: Inf to -Inf
</td>
<td style="text-align:left;">
100.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
op\_urgency
</td>
<td style="text-align:left;">
factor
</td>
<td style="text-align:left;">
2 Levels: Elective, Emergency
</td>
<td style="text-align:left;">
0.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
op\_procedure\_code
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
20 Unique: 0D9J00Z, 0D9J0ZZ, 0D9J40Z, 0D9J4ZZ, 0DQJ0ZZ, 0DQJ4ZZ,
0DTJ0ZZ, 0DTJ4ZZ, 0F140D3, 0F140D5
</td>
<td style="text-align:left;">
0.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
follow\_up
</td>
<td style="text-align:left;">
factor
</td>
<td style="text-align:left;">
2 Levels: No, Yes
</td>
<td style="text-align:left;">
0.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
follow\_up\_readm
</td>
<td style="text-align:left;">
factor
</td>
<td style="text-align:left;">
2 Levels: No, Yes
</td>
<td style="text-align:left;">
30.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
follow\_up\_mort
</td>
<td style="text-align:left;">
factor
</td>
<td style="text-align:left;">
2 Levels: No, Yes
</td>
<td style="text-align:left;">
32.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
file
</td>
<td style="text-align:left;">
logical
</td>
<td style="text-align:left;">
TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE
</td>
<td style="text-align:left;">
0.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
crp\_yn\_instance1
</td>
<td style="text-align:left;">
factor
</td>
<td style="text-align:left;">
2 Levels: No, Yes
</td>
<td style="text-align:left;">
96.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
crp\_yn\_instance2
</td>
<td style="text-align:left;">
factor
</td>
<td style="text-align:left;">
2 Levels: No, Yes
</td>
<td style="text-align:left;">
96.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
crp\_yn\_instance3
</td>
<td style="text-align:left;">
factor
</td>
<td style="text-align:left;">
2 Levels: No, Yes
</td>
<td style="text-align:left;">
98.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
crp\_yn\_instance4
</td>
<td style="text-align:left;">
factor
</td>
<td style="text-align:left;">
2 Levels: No, Yes
</td>
<td style="text-align:left;">
100.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
crp\_value\_instance1
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean: 120; Median: 120; Range: 120 to 120
</td>
<td style="text-align:left;">
98.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
crp\_value\_instance2
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean: 100; Median: 100; Range: 100 to 100
</td>
<td style="text-align:left;">
98.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
crp\_value\_instance3
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean: 120; Median: 120; Range: 120 to 120
</td>
<td style="text-align:left;">
98.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
crp\_value\_instance4
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean: NaN; Median: NA; Range: Inf to -Inf
</td>
<td style="text-align:left;">
100.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
day\_instance1
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2 Unique: 1, NA
</td>
<td style="text-align:left;">
96.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
day\_instance2
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2 Unique: 2, NA
</td>
<td style="text-align:left;">
98.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
day\_instance3
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2 Unique: 3, NA
</td>
<td style="text-align:left;">
96.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
day\_instance4
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2 Unique: 4, NA
</td>
<td style="text-align:left;">
98.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
hb\_value\_instance1
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
3 Unique: 100, NA, 110
</td>
<td style="text-align:left;">
96.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
hb\_value\_instance2
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2 Unique: 110, NA
</td>
<td style="text-align:left;">
98.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
hb\_value\_instance3
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2 Unique: NA, 120
</td>
<td style="text-align:left;">
98.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
hb\_value\_instance4
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2 Unique: 140, NA
</td>
<td style="text-align:left;">
98.0%
</td>
</tr>
</tbody>
</table>

Through summarising the variables, data will not necessarily be linkable
to individual patients (bar in the circumstance where variable(s)
contain a direct patient identifier e.g. Community Health Index (CHI)
Number, hospital numbers, etc).

However, should any variable(s) (such as a direct patient identifier) be
desirable to exclude from the output, this can be achieved using the
“var\_exclude” parameter.

    knitr::kable(collaborator::data_dict(data, var_exclude = c("id_num","sex")))

<table>
<thead>
<tr>
<th style="text-align:left;">
variable
</th>
<th style="text-align:left;">
class
</th>
<th style="text-align:left;">
value
</th>
<th style="text-align:left;">
na\_pct
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
record\_id
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
50 Unique: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
</td>
<td style="text-align:left;">
0.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
redcap\_data\_access\_group
</td>
<td style="text-align:left;">
factor
</td>
<td style="text-align:left;">
8 Levels: hospital\_a, hospital\_b, hospital\_c, hospital\_d,
hospital\_e, hospital\_f, hospital\_g, hospital\_h
</td>
<td style="text-align:left;">
0.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
enrol\_tf
</td>
<td style="text-align:left;">
logical
</td>
<td style="text-align:left;">
NA, NA, NA, NA, NA, NA, NA, NA, NA, NA
</td>
<td style="text-align:left;">
100.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
enrol\_signature
</td>
<td style="text-align:left;">
logical
</td>
<td style="text-align:left;">
FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE
</td>
<td style="text-align:left;">
0.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
pt\_age
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean: 46; Median: 44.5; Range: 15 to 79
</td>
<td style="text-align:left;">
0.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
pt\_sex
</td>
<td style="text-align:left;">
factor
</td>
<td style="text-align:left;">
2 Levels: Male, Female
</td>
<td style="text-align:left;">
4.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
smoking\_status
</td>
<td style="text-align:left;">
factor
</td>
<td style="text-align:left;">
3 Levels: Current smoker, Ex-smoker, Non-smoker
</td>
<td style="text-align:left;">
4.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
body\_mass\_index
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean: 30.3; Median: 30; Range: 21 to 47
</td>
<td style="text-align:left;">
22.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
pmh\_\_\_1
</td>
<td style="text-align:left;">
factor
</td>
<td style="text-align:left;">
1 Levels: Ischaemic Heart Disease (IHD)
</td>
<td style="text-align:left;">
48.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
pmh\_\_\_2
</td>
<td style="text-align:left;">
factor
</td>
<td style="text-align:left;">
1 Levels: Chronic Obstructive Pulmonary Disease (COPD)
</td>
<td style="text-align:left;">
62.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
pmh\_\_\_3
</td>
<td style="text-align:left;">
factor
</td>
<td style="text-align:left;">
1 Levels: Diabetes Mellitus
</td>
<td style="text-align:left;">
56.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
asa\_grade
</td>
<td style="text-align:left;">
factor
</td>
<td style="text-align:left;">
5 Levels: I, II, III, IV, V
</td>
<td style="text-align:left;">
6.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
pt\_ethnicity
</td>
<td style="text-align:left;">
factor
</td>
<td style="text-align:left;">
5 Levels: Asian / Asian British, Black / African / Caribbean / Black
British, Mixed / Multiple ethnic groups, White, Other ethnic group
</td>
<td style="text-align:left;">
0.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
pt\_ethnicity\_other
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
1 Unique: NA
</td>
<td style="text-align:left;">
100.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
adm\_date
</td>
<td style="text-align:left;">
Date
</td>
<td style="text-align:left;">
Range: 2018-07-29 to 2018-08-11
</td>
<td style="text-align:left;">
0.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
adm\_vas
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean: NaN; Median: NA; Range: Inf to -Inf
</td>
<td style="text-align:left;">
100.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
time2op
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean: NaN; Median: NA; Range: Inf to -Inf
</td>
<td style="text-align:left;">
100.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
op\_urgency
</td>
<td style="text-align:left;">
factor
</td>
<td style="text-align:left;">
2 Levels: Elective, Emergency
</td>
<td style="text-align:left;">
0.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
op\_procedure\_code
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
20 Unique: 0D9J00Z, 0D9J0ZZ, 0D9J40Z, 0D9J4ZZ, 0DQJ0ZZ, 0DQJ4ZZ,
0DTJ0ZZ, 0DTJ4ZZ, 0F140D3, 0F140D5
</td>
<td style="text-align:left;">
0.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
follow\_up
</td>
<td style="text-align:left;">
factor
</td>
<td style="text-align:left;">
2 Levels: No, Yes
</td>
<td style="text-align:left;">
0.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
follow\_up\_readm
</td>
<td style="text-align:left;">
factor
</td>
<td style="text-align:left;">
2 Levels: No, Yes
</td>
<td style="text-align:left;">
30.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
follow\_up\_mort
</td>
<td style="text-align:left;">
factor
</td>
<td style="text-align:left;">
2 Levels: No, Yes
</td>
<td style="text-align:left;">
32.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
file
</td>
<td style="text-align:left;">
logical
</td>
<td style="text-align:left;">
TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE
</td>
<td style="text-align:left;">
0.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
crp\_yn\_instance1
</td>
<td style="text-align:left;">
factor
</td>
<td style="text-align:left;">
2 Levels: No, Yes
</td>
<td style="text-align:left;">
96.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
crp\_yn\_instance2
</td>
<td style="text-align:left;">
factor
</td>
<td style="text-align:left;">
2 Levels: No, Yes
</td>
<td style="text-align:left;">
96.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
crp\_yn\_instance3
</td>
<td style="text-align:left;">
factor
</td>
<td style="text-align:left;">
2 Levels: No, Yes
</td>
<td style="text-align:left;">
98.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
crp\_yn\_instance4
</td>
<td style="text-align:left;">
factor
</td>
<td style="text-align:left;">
2 Levels: No, Yes
</td>
<td style="text-align:left;">
100.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
crp\_value\_instance1
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean: 120; Median: 120; Range: 120 to 120
</td>
<td style="text-align:left;">
98.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
crp\_value\_instance2
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean: 100; Median: 100; Range: 100 to 100
</td>
<td style="text-align:left;">
98.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
crp\_value\_instance3
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean: 120; Median: 120; Range: 120 to 120
</td>
<td style="text-align:left;">
98.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
crp\_value\_instance4
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean: NaN; Median: NA; Range: Inf to -Inf
</td>
<td style="text-align:left;">
100.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
day\_instance1
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2 Unique: 1, NA
</td>
<td style="text-align:left;">
96.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
day\_instance2
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2 Unique: 2, NA
</td>
<td style="text-align:left;">
98.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
day\_instance3
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2 Unique: 3, NA
</td>
<td style="text-align:left;">
96.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
day\_instance4
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2 Unique: 4, NA
</td>
<td style="text-align:left;">
98.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
hb\_value\_instance1
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
3 Unique: 100, NA, 110
</td>
<td style="text-align:left;">
96.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
hb\_value\_instance2
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2 Unique: 110, NA
</td>
<td style="text-align:left;">
98.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
hb\_value\_instance3
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2 Unique: NA, 120
</td>
<td style="text-align:left;">
98.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
hb\_value\_instance4
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2 Unique: 140, NA
</td>
<td style="text-align:left;">
98.0%
</td>
</tr>
</tbody>
</table>
