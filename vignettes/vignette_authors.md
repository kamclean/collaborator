Collaborator: Generating Authorship Lists
========================================

Generating and formatting authorship lists for multi-centre research
projects can be a challenging data wrangling task. In the case of
collaborative research projects, there can be thousands of collaborators
across hundreds of sites with a variety of
[roles](https://doi.org/10.1016/j.ijsu.2017.12.019).

The `report_auth()` function aims to simplify this process by providing
an easy method to complile a fully formatted authorship list with
inbuilt flexibility in how these are presented.

Requirements
------------

In order for the `report_auth()` function to operate as intended, we
must first create a dataframe of all authors/collaborators containing at
least 1 column: “name”.

Example dataframe (`data_author`):

    library(collaborator)

    data_author <- collaborator::example_report_author
    head(data_author, n=6) # Please note all names have been randomly generated

    ##         name   hospital  country
    ## 1   Almond S hospital N  England
    ## 2 Andersen J hospital E Scotland
    ## 3   Ashton A hospital L  England
    ## 4    Avila E hospital C Scotland
    ## 5    Ayala N hospital Q  England
    ## 6   Barker S hospital D Scotland

Main Features
-------------

### (1) Basic Function

At it’s most basic, `report_auth()` can produce a formatted list of a
column of names.

    report_auth(data_author) # Please note all names have been randomly generated

    ## Almond S, Andersen J, Ashton A, Avila E, Ayala N, Barker S, Beech J, Berry A, Bowen P, Bradford J, Cameron G, Cantrell G, Carlson F, Carrillo J, Cervantes S, Chamberlain H, Chan K, Chung L, Clifford K, Conley M, Cullen F, Dalby D, Dean O, Dodson D, Downes A, Duffy L, Ellwood M, Erickson K, Fenton U, Ferry A, Finney R, Flores R, Fox B, Francis F, Frazier U, Fuentes A, Galindo C, Gardiner F, Gibbons H, Gould C, Halliday S, Hanna L, Hardy E, Herman K, Hicks A, Hodge M, Holder C, Hollis S, Houston M, Huff J, Jensen L, Kane K, Kearns U, Keenan L, Kent M, Knights G, Lees S, Lennon J, Livingston F, Mackie L, Marks H, Michael P, Mooney A, Morin Y, Moses S, Mustafa W, Nicholson L, Ochoa A, O'Doherty H, Olsen H, O'Neill L, Owens I, Paine R, Patrick S, Petty O, Phillips A, Pitt A, Plant N, Prosser E, Randolph T, Richmond S, Riddle C, Riggs M, Rojas E, Rossi P, Rowe P, Saunders R, Skinner I, Smart F, Stokes P, Villa Z, Wall R, Wardle A, Werner R, Whitfield A, Whitney M, William C, Woods B, Wynn J, Yang K.

### (2) Grouping and subdivision of names

These names can be further grouped by another column in the dataframe:

    report_auth(data_author, group = "hospital")

    ## Berry A, Chan K, Gould C, Jensen L (hospital A);  Clifford K, Kearns U, Livingston F, Rojas E (hospital B);  Avila E, Cullen F, Hanna L, O'Neill L (hospital C);  Barker S, Gibbons H, Kent M (hospital D);  Andersen J, Cameron G, Dodson D, Downes A, Erickson K, Francis F, Lees S, Moses S, Saunders R (hospital E);  Dalby D, Houston M, Morin Y, Stokes P (hospital F);  Chamberlain H, Fox B, Keenan L, Mackie L, Plant N (hospital G);  Galindo C, Michael P, Prosser E (hospital H);  Bradford J, Flores R, Mooney A, O'Doherty H, Werner R (hospital I);  Dean O, Fuentes A, Hardy E, Herman K, Ochoa A, Pitt A, Skinner I, Wynn J (hospital J);  Hicks A, Holder C, Phillips A, Richmond S, Whitfield A (hospital K);  Ashton A, William C (hospital L);  Carlson F (hospital M);  Almond S, Beech J, Ferry A, Lennon J, Smart F (hospital N);  Halliday S, Riggs M, Rossi P, Wardle A, Whitney M (hospital O);  Bowen P, Carrillo J, Fenton U, Kane K, Knights G, Riddle C (hospital P);  Ayala N, Conley M, Ellwood M, Hollis S, Mustafa W, Olsen H, Wall R (hospital Q);  Finney R, Frazier U, Paine R, Patrick S, Petty O, Villa Z (hospital R);  Cantrell G, Huff J, Rowe P, Woods B, Yang K (hospital S);  Hodge M, Owens I (hospital T);  Cervantes S, Marks H, Nicholson L (hospital U);  Chung L, Duffy L, Gardiner F, Randolph T (hospital V).

Or can be subdivided by another column in the dataframe:

    report_auth(data_author, subdivision = "country")

    ## England: Almond S, Ashton A, Ayala N, Beech J, Bowen P, Bradford J, Carlson F, Carrillo J, Chamberlain H, Conley M, Dalby D, Dean O, Ellwood M, Fenton U, Ferry A, Flores R, Fox B, Fuentes A, Galindo C, Halliday S, Hardy E, Herman K, Hicks A, Holder C, Hollis S, Houston M, Kane K, Keenan L, Knights G, Lennon J, Mackie L, Michael P, Mooney A, Morin Y, Mustafa W, Ochoa A, O'Doherty H, Olsen H, Phillips A, Pitt A, Plant N, Prosser E, Richmond S, Riddle C, Riggs M, Rossi P, Skinner I, Smart F, Stokes P, Wall R, Wardle A, Werner R, Whitfield A, Whitney M, William C, Wynn J.
    ## 
    ## Northern Ireland: Cervantes S, Chung L, Duffy L, Gardiner F, Hodge M, Marks H, Nicholson L, Owens I, Randolph T.
    ## 
    ## Scotland: Andersen J, Avila E, Barker S, Berry A, Cameron G, Chan K, Clifford K, Cullen F, Dodson D, Downes A, Erickson K, Francis F, Gibbons H, Gould C, Hanna L, Jensen L, Kearns U, Kent M, Lees S, Livingston F, Moses S, O'Neill L, Rojas E, Saunders R.
    ## 
    ## Wales: Cantrell G, Finney R, Frazier U, Huff J, Paine R, Patrick S, Petty O, Rowe P, Villa Z, Woods B, Yang K.

Or groups can be further subdivided (for example by region/country, or
by role)

    report_auth(data_author, group="hospital", subdivision = "country")

    ## England: Dalby D, Houston M, Morin Y, Stokes P (hospital F);  Chamberlain H, Fox B, Keenan L, Mackie L, Plant N (hospital G);  Galindo C, Michael P, Prosser E (hospital H);  Bradford J, Flores R, Mooney A, O'Doherty H, Werner R (hospital I);  Dean O, Fuentes A, Hardy E, Herman K, Ochoa A, Pitt A, Skinner I, Wynn J (hospital J);  Hicks A, Holder C, Phillips A, Richmond S, Whitfield A (hospital K);  Ashton A, William C (hospital L);  Carlson F (hospital M);  Almond S, Beech J, Ferry A, Lennon J, Smart F (hospital N);  Halliday S, Riggs M, Rossi P, Wardle A, Whitney M (hospital O);  Bowen P, Carrillo J, Fenton U, Kane K, Knights G, Riddle C (hospital P);  Ayala N, Conley M, Ellwood M, Hollis S, Mustafa W, Olsen H, Wall R (hospital Q).
    ## 
    ## Northern Ireland: Hodge M, Owens I (hospital T);  Cervantes S, Marks H, Nicholson L (hospital U);  Chung L, Duffy L, Gardiner F, Randolph T (hospital V).
    ## 
    ## Scotland: Berry A, Chan K, Gould C, Jensen L (hospital A);  Clifford K, Kearns U, Livingston F, Rojas E (hospital B);  Avila E, Cullen F, Hanna L, O'Neill L (hospital C);  Barker S, Gibbons H, Kent M (hospital D);  Andersen J, Cameron G, Dodson D, Downes A, Erickson K, Francis F, Lees S, Moses S, Saunders R (hospital E).
    ## 
    ## Wales: Finney R, Frazier U, Paine R, Patrick S, Petty O, Villa Z (hospital R);  Cantrell G, Huff J, Rowe P, Woods B, Yang K (hospital S).

### (3) Formatting

Clear and consistant formatting of authorship lists allows the
contributions and afficilations of each collaborator/author to be
represented. Within `report_auth()`, names are usually separated by a
comma (“,”), with groups separated by a semicolon (“;”). Furthermore the
name of groups are separated by round brackets (“()”). However, there is
a degree of inbuilt flexibility to facilitate customisation.

    report_auth(data_author, group="hospital", subdivision = "country",
                name_sep = " +", group_brachet = "[}",group_sep = " -")

    ## England: Dalby D + Houston M + Morin Y + Stokes P [hospital F} -  Chamberlain H + Fox B + Keenan L + Mackie L + Plant N [hospital G} -  Galindo C + Michael P + Prosser E [hospital H} -  Bradford J + Flores R + Mooney A + O'Doherty H + Werner R [hospital I} -  Dean O + Fuentes A + Hardy E + Herman K + Ochoa A + Pitt A + Skinner I + Wynn J [hospital J} -  Hicks A + Holder C + Phillips A + Richmond S + Whitfield A [hospital K} -  Ashton A + William C [hospital L} -  Carlson F [hospital M} -  Almond S + Beech J + Ferry A + Lennon J + Smart F [hospital N} -  Halliday S + Riggs M + Rossi P + Wardle A + Whitney M [hospital O} -  Bowen P + Carrillo J + Fenton U + Kane K + Knights G + Riddle C [hospital P} -  Ayala N + Conley M + Ellwood M + Hollis S + Mustafa W + Olsen H + Wall R [hospital Q}.
    ## 
    ## Northern Ireland: Hodge M + Owens I [hospital T} -  Cervantes S + Marks H + Nicholson L [hospital U} -  Chung L + Duffy L + Gardiner F + Randolph T [hospital V}.
    ## 
    ## Scotland: Berry A + Chan K + Gould C + Jensen L [hospital A} -  Clifford K + Kearns U + Livingston F + Rojas E [hospital B} -  Avila E + Cullen F + Hanna L + O'Neill L [hospital C} -  Barker S + Gibbons H + Kent M [hospital D} -  Andersen J + Cameron G + Dodson D + Downes A + Erickson K + Francis F + Lees S + Moses S + Saunders R [hospital E}.
    ## 
    ## Wales: Finney R + Frazier U + Paine R + Patrick S + Petty O + Villa Z [hospital R} -  Cantrell G + Huff J + Rowe P + Woods B + Yang K [hospital S}.
