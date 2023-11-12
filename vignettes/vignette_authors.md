# Collaborator: Generating Authorship Lists

## Author name extraction using ORCID

### Validation of ORCID

Generating and formatting authorship lists for multi-centre research
projects can be a challenging data wrangling task. In the case of
collaborative research projects, there can be thousands of collaborators
across hundreds of sites with a variety of
[roles](https://doi.org/10.1016/j.ijsu.2017.12.019).

## ORCID

ORCID provides a persistent digital identifier (an ORCID iD) that each
individual own and control, and that distinguishes them from every other
researcher. This is free to register for and can be used to empower
collaborators to specify how their name should appear in publications.
When working with 1000s collaborators, this provides a simple route to
ensure accuate display of names on an authorship list and can be simply
extracted from the ORCID website using the ORCID.

ORCIDs follow a specific format of 16 characters in the format of
“XXXX-XXXX-XXXX-XXXX” (16 characters in groups of 4 and separated by a
dash). The extraction from the ORCID website will not work if not in
this format. However, we can use the `orcid_valid()` function to
investigate whether the ORCIDs on record are valid or not to use.

    data <- tibble::tibble(n = c(1:7),
                   orcid = c("0000-0001-6482-9086", "0000000250183066", "0000-0002-8738-4902",
                              "00O0-0002-8738-490X", "0000-0002-8738-490X", "0000-0002-8738-490", NA))

    collaborator::orcid_valid(data, orcid = "orcid", reason = T) %>%
      knitr::kable()

    ## Loading required package: tibble

    ## Loading required package: tidyr

    ## Loading required package: stringr

<table style="width:100%;">
<colgroup>
<col style="width: 1%" />
<col style="width: 10%" />
<col style="width: 8%" />
<col style="width: 10%" />
<col style="width: 28%" />
<col style="width: 10%" />
<col style="width: 10%" />
<col style="width: 10%" />
<col style="width: 8%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: right;">n</th>
<th style="text-align: left;">orcid</th>
<th style="text-align: left;">orcid_valid_yn</th>
<th style="text-align: left;">orcid_valid</th>
<th style="text-align: left;">orcid_valid_reason</th>
<th style="text-align: left;">orcid_check_present</th>
<th style="text-align: left;">orcid_check_length</th>
<th style="text-align: left;">orcid_check_format</th>
<th style="text-align: left;">orcid_check_sum</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: right;">1</td>
<td style="text-align: left;">0000-0001-6482-9086</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">0000-0001-6482-9086</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">Yes</td>
</tr>
<tr class="even">
<td style="text-align: right;">2</td>
<td style="text-align: left;">0000000250183066</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">0000-0002-5018-3066</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">Yes</td>
</tr>
<tr class="odd">
<td style="text-align: right;">3</td>
<td style="text-align: left;">0000-0002-8738-4902</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">0000-0002-8738-4902</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">Yes</td>
</tr>
<tr class="even">
<td style="text-align: right;">4</td>
<td style="text-align: left;">00O0-0002-8738-490X</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">Not ORCID format, Failed checksum</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">No</td>
</tr>
<tr class="odd">
<td style="text-align: right;">5</td>
<td style="text-align: left;">0000-0002-8738-490X</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">Failed checksum</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">No</td>
</tr>
<tr class="even">
<td style="text-align: right;">6</td>
<td style="text-align: left;">0000-0002-8738-490</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">Not 16 characters, Not ORCID format,
Failed checksum</td>
<td style="text-align: left;">Yes</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">No</td>
</tr>
<tr class="odd">
<td style="text-align: right;">7</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">Missing ORCID</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">No</td>
<td style="text-align: left;">No</td>
</tr>
</tbody>
</table>

This will output the same dataframe with the “orcid\_valid” column
appended with a correctly formatted orcid (if it is valid to use). All
non-valid orcids will be listed as “NA”. If you want to investigate
further, you can use the argument (“reason==T”) in the function to get
additional columns:

-   “orcid\_check\_present”: A binary value if any value was provided in
    that row or not (e.g. when a “NA” value was supplied)

-   “orcid\_check\_length”: A binary value if the ORCID supplied is 16
    characters or not (e.g. “0000-0002-8738-490” where a character has
    been missed)

-   “orcid\_check\_format”: A binary value if the ORCID supplied fits
    the correct format of either 16 numbers or 15 numbers with an X at
    the end (e.g. “00O0-0002-8738-490X” value supplied)

-   “orcid\_check\_sum”: ORCID uses an internal “checksum” to make sure
    not just any random set of 16 characters can be entered. This is a
    binary value if the ORCID supplied either passes or fails this
    “checksum” (e.g. “0000-0002-8738-490X” is indistinguishable from a
    valid ORCID, except it fails the checksum, so it had to have been
    entered incorrectly)

If any of the values above are “No”, then the ORCID is not valid and so
cannot be used. The final column “orcid\_valid\_reason” summarises all
the reasons why an ORCID is not valid so these can be addressed.

### Extraction of names from ORCID

Now we know what ORCIDs are valid, lets extract the names of just these
using `orcid_name()`. Names on ORCID are recorded in 2 ways:

1.  “Your given and family names” (“orcid\_name\_first” and
    “orcid\_name\_last”).

2.  “Your published name” (orcid\_name\_credit”): This is the full name
    displayed on ORCID, however this is not automatically separated into
    first name / last name.

Given this is recorded in 2 different ways, there can be discrepancies
between the two methods (and why both are returned). It is recommended
that “Your given and family names” is preferentially used since this
avoids any confusion about first/middle vs last names for authorship
lists (since the format required for authorship lists is often that
given names are converted into initials).

    data %>%
      collaborator::orcid_valid(data, orcid = "orcid", reason = F) %>%
      filter(is.na(orcid_valid)==F) %>%
      orcid_name(orcid = "orcid_valid", reason = F) %>%
      knitr::kable()

    ## Loading required package: furrr

    ## Loading required package: future

    ## Loading required package: httr

    ## 
    ## Attaching package: 'magrittr'

    ## The following object is masked from 'package:tidyr':
    ## 
    ##     extract

    ## Warning in if (na.rm == T) {: the condition has length > 1
    ## and only the first element will be used

    ## 
    ## Attaching package: 'purrr'

    ## The following object is masked from 'package:magrittr':
    ## 
    ##     set_names

<table>
<colgroup>
<col style="width: 2%" />
<col style="width: 16%" />
<col style="width: 16%" />
<col style="width: 14%" />
<col style="width: 13%" />
<col style="width: 15%" />
<col style="width: 20%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: right;">n</th>
<th style="text-align: left;">orcid</th>
<th style="text-align: left;">orcid_valid</th>
<th style="text-align: left;">orcid_name_first</th>
<th style="text-align: left;">orcid_name_last</th>
<th style="text-align: left;">orcid_name_credit</th>
<th style="text-align: left;">orcid_name_credit_first</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: right;">1</td>
<td style="text-align: left;">0000-0001-6482-9086</td>
<td style="text-align: left;">0000-0001-6482-9086</td>
<td style="text-align: left;">Kenneth A</td>
<td style="text-align: left;">McLean</td>
<td style="text-align: left;">Kenneth A McLean</td>
<td style="text-align: left;">Kenneth A</td>
</tr>
<tr class="even">
<td style="text-align: right;">2</td>
<td style="text-align: left;">0000000250183066</td>
<td style="text-align: left;">0000-0002-5018-3066</td>
<td style="text-align: left;">Ewen</td>
<td style="text-align: left;">Harrison</td>
<td style="text-align: left;">Ewen Harrison</td>
<td style="text-align: left;">Ewen</td>
</tr>
<tr class="odd">
<td style="text-align: right;">3</td>
<td style="text-align: left;">0000-0002-8738-4902</td>
<td style="text-align: left;">0000-0002-8738-4902</td>
<td style="text-align: left;">Riinu</td>
<td style="text-align: left;">Pius</td>
<td style="text-align: left;">Riinu Pius</td>
<td style="text-align: left;">Riinu</td>
</tr>
</tbody>
</table>

### Formatting of names

If you need to format the names of collaborators as initials, this can
be simply done using `author_name()`. This will convert every name in
the “first\_name” column into initials, which can be placed before or
after the last name. This is shown in the “author\_name” column below.

    data %>%
      collaborator::orcid_valid(data, orcid = "orcid", reason = F) %>%
      collaborator::orcid_name(orcid = "orcid_valid", reason = F) %>%
      collaborator::author_name(first_name = "orcid_name_first", last_name = "orcid_name_last",position = "left", initial_max=3) %>%
      dplyr::select(n:orcid_valid, orcid_name_first:orcid_name_last, author_name)

    ## Loading required package: Hmisc

    ## 
    ## Attaching package: 'Hmisc'

    ## The following objects are masked from 'package:dplyr':
    ## 
    ##     src, summarize

    ## The following objects are masked from 'package:base':
    ## 
    ##     format.pval, units

    ## Warning in if (na.rm == T) {: the condition has length > 1
    ## and only the first element will be used

    ## # A tibble: 3 × 6
    ##       n orcid     orcid_valid orcid_name_first orcid_name_last
    ##   <int> <chr>     <chr>       <chr>            <chr>          
    ## 1     1 0000-000… 0000-0001-… Kenneth A        McLean         
    ## 2     2 00000002… 0000-0002-… Ewen             Harrison       
    ## 3     3 0000-000… 0000-0002-… Riinu            Pius           
    ## # ℹ 1 more variable: author_name <chr>

## Generating the formatted authorship list

Once you have your final list of authors, the `report_auth()` function
aims to simplify the process of generating the fully formatted
authorship list, with inbuilt flexibility in how these are presented.

### Requirements

In order for the `report_auth()` function to operate as intended, we
must first create a dataframe of all authors/collaborators containing at
least 1 column: “name”.

Example dataframe (`data_author`):

    data_author <- collaborator::example_report_author
    knitr::kable(head(data_author, n=10)) # Please note all names have been randomly generated

<table>
<thead>
<tr class="header">
<th style="text-align: left;">name</th>
<th style="text-align: left;">hospital</th>
<th style="text-align: left;">country</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">Almond S</td>
<td style="text-align: left;">hospital N</td>
<td style="text-align: left;">England</td>
</tr>
<tr class="even">
<td style="text-align: left;">Andersen J</td>
<td style="text-align: left;">hospital E</td>
<td style="text-align: left;">Scotland</td>
</tr>
<tr class="odd">
<td style="text-align: left;">Ashton A</td>
<td style="text-align: left;">hospital L</td>
<td style="text-align: left;">England</td>
</tr>
<tr class="even">
<td style="text-align: left;">Avila E</td>
<td style="text-align: left;">hospital C</td>
<td style="text-align: left;">Scotland</td>
</tr>
<tr class="odd">
<td style="text-align: left;">Ayala N</td>
<td style="text-align: left;">hospital Q</td>
<td style="text-align: left;">England</td>
</tr>
<tr class="even">
<td style="text-align: left;">Barker S</td>
<td style="text-align: left;">hospital D</td>
<td style="text-align: left;">Scotland</td>
</tr>
<tr class="odd">
<td style="text-align: left;">Beech J</td>
<td style="text-align: left;">hospital N</td>
<td style="text-align: left;">England</td>
</tr>
<tr class="even">
<td style="text-align: left;">Berry A</td>
<td style="text-align: left;">hospital A</td>
<td style="text-align: left;">Scotland</td>
</tr>
<tr class="odd">
<td style="text-align: left;">Bowen P</td>
<td style="text-align: left;">hospital P</td>
<td style="text-align: left;">England</td>
</tr>
<tr class="even">
<td style="text-align: left;">Bradford J</td>
<td style="text-align: left;">hospital I</td>
<td style="text-align: left;">England</td>
</tr>
</tbody>
</table>

### Main Features

#### (1) Basic Function

At it’s most basic, `report_auth()` can produce a formatted list of a
column of names.

      collaborator::report_auth(data_author) %>% # Please note all names have been randomly generated
      knitr::kable(, col.names= "") 

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<tbody>
<tr class="odd">
<td style="text-align: left;">Almond S, Andersen J, Ashton A, Avila E,
Ayala N, Barker S, Beech J, Berry A, Bowen P, Bradford J, Cameron G,
Cantrell G, Carlson F, Carrillo J, Cervantes S, Chamberlain H, Chan K,
Chung L, Clifford K, Conley M, Cullen F, Dalby D, Dean O, Dodson D,
Downes A, Duffy L, Ellwood M, Erickson K, Fenton U, Ferry A, Finney R,
Flores R, Fox B, Francis F, Frazier U, Fuentes A, Galindo C, Gardiner F,
Gibbons H, Gould C, Halliday S, Hanna L, Hardy E, Herman K, Hicks A,
Hodge M, Holder C, Hollis S, Houston M, Huff J, Jensen L, Kane K, Kearns
U, Keenan L, Kent M, Knights G, Lees S, Lennon J, Livingston F, Mackie
L, Marks H, Michael P, Mooney A, Morin Y, Moses S, Mustafa W, Nicholson
L, Ochoa A, O’Doherty H, Olsen H, O’Neill L, Owens I, Paine R, Patrick
S, Petty O, Phillips A, Pitt A, Plant N, Prosser E, Randolph T, Richmond
S, Riddle C, Riggs M, Rojas E, Rossi P, Rowe P, Saunders R, Skinner I,
Smart F, Stokes P, Villa Z, Wall R, Wardle A, Werner R, Whitfield A,
Whitney M, William C, Woods B, Wynn J, Yang K.</td>
</tr>
</tbody>
</table>

#### (2) Grouping and subdivision of names

These names can be further grouped by another column in the dataframe:

    collaborator::report_auth(data_author, group = "hospital") %>% # Please note all names have been randomly generated
      knitr::kable(col.names= "") 

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<tbody>
<tr class="odd">
<td style="text-align: left;">Berry A, Chan K, Gould C, Jensen L
(hospital A); Clifford K, Kearns U, Livingston F, Rojas E (hospital B);
Avila E, Cullen F, Hanna L, O’Neill L (hospital C); Barker S, Gibbons H,
Kent M (hospital D); Andersen J, Cameron G, Dodson D, Downes A, Erickson
K, Francis F, Lees S, Moses S, Saunders R (hospital E); Dalby D, Houston
M, Morin Y, Stokes P (hospital F); Chamberlain H, Fox B, Keenan L,
Mackie L, Plant N (hospital G); Galindo C, Michael P, Prosser E
(hospital H); Bradford J, Flores R, Mooney A, O’Doherty H, Werner R
(hospital I); Dean O, Fuentes A, Hardy E, Herman K, Ochoa A, Pitt A,
Skinner I, Wynn J (hospital J); Hicks A, Holder C, Phillips A, Richmond
S, Whitfield A (hospital K); Ashton A, William C (hospital L); Carlson F
(hospital M); Almond S, Beech J, Ferry A, Lennon J, Smart F (hospital
N); Halliday S, Riggs M, Rossi P, Wardle A, Whitney M (hospital O);
Bowen P, Carrillo J, Fenton U, Kane K, Knights G, Riddle C (hospital P);
Ayala N, Conley M, Ellwood M, Hollis S, Mustafa W, Olsen H, Wall R
(hospital Q); Finney R, Frazier U, Paine R, Patrick S, Petty O, Villa Z
(hospital R); Cantrell G, Huff J, Rowe P, Woods B, Yang K (hospital S);
Hodge M, Owens I (hospital T); Cervantes S, Marks H, Nicholson L
(hospital U); Chung L, Duffy L, Gardiner F, Randolph T (hospital
V).</td>
</tr>
</tbody>
</table>

Or can be subdivided by another column in the dataframe:

    collaborator::report_auth(data_author, subdivision = "country") %>% # Please note all names have been randomly generated
      knitr::kable(col.names= "")

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<tbody>
<tr class="odd">
<td style="text-align: left;">England: Almond S, Ashton A, Ayala N,
Beech J, Bowen P, Bradford J, Carlson F, Carrillo J, Chamberlain H,
Conley M, Dalby D, Dean O, Ellwood M, Fenton U, Ferry A, Flores R, Fox
B, Fuentes A, Galindo C, Halliday S, Hardy E, Herman K, Hicks A, Holder
C, Hollis S, Houston M, Kane K, Keenan L, Knights G, Lennon J, Mackie L,
Michael P, Mooney A, Morin Y, Mustafa W, Ochoa A, O’Doherty H, Olsen H,
Phillips A, Pitt A, Plant N, Prosser E, Richmond S, Riddle C, Riggs M,
Rossi P, Skinner I, Smart F, Stokes P, Wall R, Wardle A, Werner R,
Whitfield A, Whitney M, William C, Wynn J.</td>
</tr>
<tr class="even">
<td style="text-align: left;">Northern Ireland: Cervantes S, Chung L,
Duffy L, Gardiner F, Hodge M, Marks H, Nicholson L, Owens I, Randolph
T.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">Scotland: Andersen J, Avila E, Barker S,
Berry A, Cameron G, Chan K, Clifford K, Cullen F, Dodson D, Downes A,
Erickson K, Francis F, Gibbons H, Gould C, Hanna L, Jensen L, Kearns U,
Kent M, Lees S, Livingston F, Moses S, O’Neill L, Rojas E, Saunders
R.</td>
</tr>
<tr class="even">
<td style="text-align: left;">Wales: Cantrell G, Finney R, Frazier U,
Huff J, Paine R, Patrick S, Petty O, Rowe P, Villa Z, Woods B, Yang
K.</td>
</tr>
</tbody>
</table>

Or groups can be further subdivided (for example by region/country, or
by role)

    collaborator::report_auth(data_author,
                group = "hospital",
                subdivision = "country") %>% # Please note all names have been randomly generated
      knitr::kable(col.names= "")

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<tbody>
<tr class="odd">
<td style="text-align: left;">England: Dalby D, Houston M, Morin Y,
Stokes P (hospital F); Chamberlain H, Fox B, Keenan L, Mackie L, Plant N
(hospital G); Galindo C, Michael P, Prosser E (hospital H); Bradford J,
Flores R, Mooney A, O’Doherty H, Werner R (hospital I); Dean O, Fuentes
A, Hardy E, Herman K, Ochoa A, Pitt A, Skinner I, Wynn J (hospital J);
Hicks A, Holder C, Phillips A, Richmond S, Whitfield A (hospital K);
Ashton A, William C (hospital L); Carlson F (hospital M); Almond S,
Beech J, Ferry A, Lennon J, Smart F (hospital N); Halliday S, Riggs M,
Rossi P, Wardle A, Whitney M (hospital O); Bowen P, Carrillo J, Fenton
U, Kane K, Knights G, Riddle C (hospital P); Ayala N, Conley M, Ellwood
M, Hollis S, Mustafa W, Olsen H, Wall R (hospital Q).</td>
</tr>
<tr class="even">
<td style="text-align: left;">Northern Ireland: Hodge M, Owens I
(hospital T); Cervantes S, Marks H, Nicholson L (hospital U); Chung L,
Duffy L, Gardiner F, Randolph T (hospital V).</td>
</tr>
<tr class="odd">
<td style="text-align: left;">Scotland: Berry A, Chan K, Gould C, Jensen
L (hospital A); Clifford K, Kearns U, Livingston F, Rojas E (hospital
B); Avila E, Cullen F, Hanna L, O’Neill L (hospital C); Barker S,
Gibbons H, Kent M (hospital D); Andersen J, Cameron G, Dodson D, Downes
A, Erickson K, Francis F, Lees S, Moses S, Saunders R (hospital E).</td>
</tr>
<tr class="even">
<td style="text-align: left;">Wales: Finney R, Frazier U, Paine R,
Patrick S, Petty O, Villa Z (hospital R); Cantrell G, Huff J, Rowe P,
Woods B, Yang K (hospital S).</td>
</tr>
</tbody>
</table>

#### (3) Formatting

Clear and consistent formatting of authorship lists allows the
contributions and affiliations of each collaborator/author to be
represented. Within `report_auth()`, names are usually separated by a
comma (“,”), with groups separated by a semicolon (“;”). Furthermore the
name of groups are separated by round brackets (“()”). However, there is
a degree of inbuilt flexibility to facilitate customisation.

Below if for demonstration of this concept (not intented to reflect how
these should be formatted!)

    collaborator::report_auth(data_author, group="hospital", subdivision = "country",
                name_sep = " +", group_brachet = "[]",group_sep = " --- ") %>% # Please note all names have been randomly generated
      knitr::kable(col.names= "")

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<tbody>
<tr class="odd">
<td style="text-align: left;">England: Dalby D +Houston M +Morin Y
+Stokes P [hospital F] — Chamberlain H +Fox B +Keenan L +Mackie L +Plant
N [hospital G] — Galindo C +Michael P +Prosser E [hospital H] — Bradford
J +Flores R +Mooney A +O’Doherty H +Werner R [hospital I] — Dean O
+Fuentes A +Hardy E +Herman K +Ochoa A +Pitt A +Skinner I +Wynn J
[hospital J] — Hicks A +Holder C +Phillips A +Richmond S +Whitfield A
[hospital K] — Ashton A +William C [hospital L] — Carlson F [hospital M]
— Almond S +Beech J +Ferry A +Lennon J +Smart F [hospital N] — Halliday
S +Riggs M +Rossi P +Wardle A +Whitney M [hospital O] — Bowen P
+Carrillo J +Fenton U +Kane K +Knights G +Riddle C [hospital P] — Ayala
N +Conley M +Ellwood M +Hollis S +Mustafa W +Olsen H +Wall R [hospital
Q].</td>
</tr>
<tr class="even">
<td style="text-align: left;">Northern Ireland: Hodge M +Owens I
[hospital T] — Cervantes S +Marks H +Nicholson L [hospital U] — Chung L
+Duffy L +Gardiner F +Randolph T [hospital V].</td>
</tr>
<tr class="odd">
<td style="text-align: left;">Scotland: Berry A +Chan K +Gould C +Jensen
L [hospital A] — Clifford K +Kearns U +Livingston F +Rojas E [hospital
B] — Avila E +Cullen F +Hanna L +O’Neill L [hospital C] — Barker S
+Gibbons H +Kent M [hospital D] — Andersen J +Cameron G +Dodson D
+Downes A +Erickson K +Francis F +Lees S +Moses S +Saunders R [hospital
E].</td>
</tr>
<tr class="even">
<td style="text-align: left;">Wales: Finney R +Frazier U +Paine R
+Patrick S +Petty O +Villa Z [hospital R] — Cantrell G +Huff J +Rowe P
+Woods B +Yang K [hospital S].</td>
</tr>
</tbody>
</table>
