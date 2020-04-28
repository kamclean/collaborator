# CollaboratoR: Group-specific emails (mailmerge in R)

In large-scale multicentre reseach, communication with data collectors
in a meaningful way can be challenging. Often, group-specific emails
(with group-specific attachments) can be desired (for example reports of
missing data for a particular site). Yet there is a limited number of
non-proprietary softwares that allow this to be automated at scale, and
often this is required to be done on a manual basis.

CollaboratoR has several functions that have been designed to work
together to faciliate the process of sending group-specific emails
(including attachments). This has been developed with interoperability
with REDCap in mind, but the “email\_” functions do not require REDCap
to work.

**Why would you choose to do this over mailmerge or other equivalent
software?**

  - The main advantage of this method is the capability to attach
    group-specific attachments and to reproducibility email regular
    updates.

   

# 1\. Build email dataset

The first step is to define the groups of people that will be emailed.

#### a). REDCap user export

For projects on REDCap, all users with access rights to each data access
group (DAG) can be accessed via the API.

This can be done via the `user_role()` CollaboratoR function (see
[Redcap User Management: 1. Explore Current
Users](https://github.com/kamclean/collaborator/blob/master/vignettes/vignette_user_1_explore.Rmd)
for more details), alongside several other functions from other packages
(
[redcapAPI](https://cran.r-project.org/web/packages/REDCapR/index.html)
/
[REDCapAPI](https://cran.r-project.org/web/packages/redcapAPI/index.html)
/ [RCurl](https://cran.r-project.org/web/packages/RCurl/index.html)
).

``` r
df_user_all <- collaborator::user_role(redcap_project_uri = Sys.getenv("collaborator_test_uri"),
                                       redcap_project_token = Sys.getenv("collaborator_test_token"))$full

knitr::kable(head(df_user_all, n=10)) # Please note all names / emails have been randomly generated
```

| role | username     | email                   | firstname | lastname  | expiration | data\_access\_group | data\_access\_group\_id | design | user\_rights | data\_access\_groups | data\_export | reports | stats\_and\_charts | manage\_survey\_participants | calendar | data\_import\_tool | data\_comparison\_tool | logging | file\_repository | data\_quality\_create | data\_quality\_execute | api\_export | api\_import | mobile\_app | mobile\_app\_download\_data | record\_create | record\_rename | record\_delete | lock\_records\_all\_forms | lock\_records | lock\_records\_customization | forms                           |
| ---: | :----------- | :---------------------- | :-------- | :-------- | :--------- | :------------------ | ----------------------: | -----: | -----------: | -------------------: | -----------: | ------: | -----------------: | ---------------------------: | -------: | -----------------: | ---------------------: | ------: | ---------------: | --------------------: | ---------------------: | ----------: | ----------: | ----------: | --------------------------: | -------------: | -------------: | -------------: | ------------------------: | ------------: | ---------------------------: | :------------------------------ |
|    1 | a\_barker    | <a_barker@email.com>    | Aleesha   | Barker    | NA         | hospital\_a         |                    4117 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | a\_hanna     | <a_hanna@email.com>     | Aleesha   | Hanna     | NA         | hospital\_d         |                    4120 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | a\_hicks     | <a_hicks@email.com>     | Alyssa    | Hicks     | NA         | hospital\_e         |                    4121 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | a\_lees      | <a_lees@email.com>      | Aleesha   | Lees      | NA         | hospital\_h         |                    4124 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | a\_nicholson | <a_nicholson@email.com> | Alyssa    | Nicholson | NA         | hospital\_i         |                    4125 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | c\_avila     | <c_avila@email.com>     | Chanice   | Avila     | NA         | NA                  |                      NA |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | c\_gould     | <c_gould@email.com>     | Chanice   | Gould     | NA         | hospital\_b         |                    4118 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | c\_kent      | <c_kent@email.com>      | Chanice   | Kent      | NA         | hospital\_f         |                    4122 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | c\_michael   | <c_michael@email.com>   | Chanice   | Michael   | NA         | hospital\_h         |                    4124 |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |
|    1 | f\_almond    | <f_almond@email.com>    | Fleur     | Almond    | NA         | NA                  |                      NA |      0 |            0 |                    0 |            2 |       1 |                  1 |                            1 |        1 |                  0 |                      0 |       0 |                1 |                     0 |                      0 |           0 |           0 |           0 |                           0 |              1 |              0 |              0 |                         0 |             0 |                            0 | example\_<data:1,file_upload:1> |

However, these do not produce the correct data format as the data
(email) must be summarised by group (data\_access\_group). This can be
done directly via the `user_summarise()` function. This produces data in
the exact format required by the subsequent “email\_” functions
(alongside some additional summarised data which may be of interest).
This is the recommended option for handing REDCap user data for this
purpose.

``` r
df_user <- collaborator::user_summarise(redcap_project_uri = Sys.getenv("collaborator_test_uri"),
                                        redcap_project_token = Sys.getenv("collaborator_test_token"),
                                        user_exclude = "y_o’doherty")

knitr::kable(df_user) # Please note all names have been randomly generated
```

| data\_access\_group | user\_n | user\_usernames                              | user\_fullnames                                             | user\_email                                                                              |
| :------------------ | ------: | :------------------------------------------- | :---------------------------------------------------------- | :--------------------------------------------------------------------------------------- |
| hospital\_a         |       3 | a\_barker; f\_galindo; l\_cervantes          | Aleesha Barker; Fleur Galindo; Leroy Cervantes              | <a_barker@email.com>; <f_galindo@email.com>; <l_cervantes@email.com>                     |
| hospital\_b         |       3 | c\_gould; k\_gibbons; s\_beech               | Chanice Gould; Kester Gibbons; Shanelle Beech               | <c_gould@email.com>; <k_gibbons@email.com>; <s_beech@email.com>                          |
| hospital\_c         |       1 | r\_bradford                                  | Ralph Bradford                                              | <r_bradford@email.com>                                                                   |
| hospital\_d         |       3 | a\_hanna; h\_herman; y\_cameron              | Aleesha Hanna; Hailie Herman; Yara Cameron                  | <a_hanna@email.com>; <h_herman@email.com>; <y_cameron@email.com>                         |
| hospital\_e         |       4 | a\_hicks; l\_jensen; s\_hardy; y\_holder     | Alyssa Hicks; Leroy Jensen; Shanelle Hardy; Yara Holder     | <a_hicks@email.com>; <l_jensen@email.com>; <s_hardy@email.com>; <y_holder@email.com>     |
| hospital\_f         |       2 | c\_kent; s\_knights                          | Chanice Kent; Samiha Knights                                | <c_kent@email.com>; <s_knights@email.com>                                                |
| hospital\_g         |       2 | f\_livingston; y\_mackie                     | Fleur Livingston; Yaseen Mackie                             | <f_livingston@email.com>; <y_mackie@email.com>                                           |
| hospital\_h         |       4 | a\_lees; c\_michael; k\_marks; s\_moses      | Aleesha Lees; Chanice Michael; Kester Marks; Shanelle Moses | <a_lees@email.com>; <c_michael@email.com>; <k_marks@email.com>; <s_moses@email.com>      |
| hospital\_i         |       4 | a\_nicholson; h\_mustafa; r\_hodge; r\_ochoa | Alyssa Nicholson; Hailie Mustafa; Ralph Hodge; Ralph Ochoa  | <a_nicholson@email.com>; <h_mustafa@email.com>; <r_hodge@email.com>; <r_ochoa@email.com> |
| hospital\_j         |       3 | l\_paine; m\_owens; y\_odoherty              | Leroy Paine; Martha Owens; Yara O’Doherty                   | <l_paine@email.com>; <m_owens@email.com>; <y_odoherty@email.com>                         |

 

#### b). Other sources

While these email functions were developed for the intent of integration
with REDCap, the subsequent “email\_” functions are build to not require
REDCap to work. However, the same minimum input format is required:

  - One unique group per row (listed within a single column).

  - A string of group-specific email addresses, separated by a semicolon
    (listed within a single column).

For example (using the data above to illustrate):

``` r
df_user_other <- df_user %>%
  dplyr::select("group" = data_access_group, "group_specific_emails_recipients" = user_email)

  knitr::kable(df_user_other)
```

| group       | group\_specific\_emails\_recipients                                                      |
| :---------- | :--------------------------------------------------------------------------------------- |
| hospital\_a | <a_barker@email.com>; <f_galindo@email.com>; <l_cervantes@email.com>                     |
| hospital\_b | <c_gould@email.com>; <k_gibbons@email.com>; <s_beech@email.com>                          |
| hospital\_c | <r_bradford@email.com>                                                                   |
| hospital\_d | <a_hanna@email.com>; <h_herman@email.com>; <y_cameron@email.com>                         |
| hospital\_e | <a_hicks@email.com>; <l_jensen@email.com>; <s_hardy@email.com>; <y_holder@email.com>     |
| hospital\_f | <c_kent@email.com>; <s_knights@email.com>                                                |
| hospital\_g | <f_livingston@email.com>; <y_mackie@email.com>                                           |
| hospital\_h | <a_lees@email.com>; <c_michael@email.com>; <k_marks@email.com>; <s_moses@email.com>      |
| hospital\_i | <a_nicholson@email.com>; <h_mustafa@email.com>; <r_hodge@email.com>; <r_ochoa@email.com> |
| hospital\_j | <l_paine@email.com>; <m_owens@email.com>; <y_odoherty@email.com>                         |

There may be any number of additional columns present that can be used
to “mail-merge” within the email subject or body.

   

# 2\. Build group-specific emails

At this stage, we have a dataframe of the grouped recipents of the
emails. Now we can begin to build the group-specific components of the
emails.

#### a). Generate email fields

The `email_field()` function wrangles the dataframe of grouped recipents
(e.g. `df_user` above) into the format required by `email_send()`. There
are two aspects of email fields that can be customised:

  - Recipients: We define who will recieve the email. Different columns
    of emails can be specified as the main recipents (`recipient_main`),
    cc’d (`recipient_cc`), or bcc’d (`recipient_bcc`). For example, you
    may want to specify the primary investigator for a site as the
    `recipient_main` and others involved at that site as `recipient_cc`.

  - Subject: We define what the name of the email will be. This can be
    the same for all emails, or the subject can be made *group-specific*
    by incorporting column names within the string. These names must be
    within square brackets e.g. `"[colname]"`.

<!-- end list -->

``` r
df_email <- collaborator::email_field(df_email = df_user,
                                      group = "data_access_group",
                                      recipient_main = NULL,
                                      recipient_cc = NULL,
                                      recipient_bcc = "user_email", # we want all the recipients to be "BCC". 
                                      subject = "Hello to [user_n] collaborators at [data_access_group]")

knitr::kable(df_email)
```

| group       | recipient\_main | recipient\_cc | recipient\_bcc                                                                           | subject                                 | user\_n | user\_usernames                              | user\_fullnames                                             |
| :---------- | :-------------- | :------------ | :--------------------------------------------------------------------------------------- | :-------------------------------------- | ------: | :------------------------------------------- | :---------------------------------------------------------- |
| hospital\_a |                 |               | <a_barker@email.com>; <f_galindo@email.com>; <l_cervantes@email.com>                     | Hello to 3 collaborators at hospital\_a |       3 | a\_barker; f\_galindo; l\_cervantes          | Aleesha Barker; Fleur Galindo; Leroy Cervantes              |
| hospital\_b |                 |               | <c_gould@email.com>; <k_gibbons@email.com>; <s_beech@email.com>                          | Hello to 3 collaborators at hospital\_b |       3 | c\_gould; k\_gibbons; s\_beech               | Chanice Gould; Kester Gibbons; Shanelle Beech               |
| hospital\_c |                 |               | <r_bradford@email.com>                                                                   | Hello to 1 collaborators at hospital\_c |       1 | r\_bradford                                  | Ralph Bradford                                              |
| hospital\_d |                 |               | <a_hanna@email.com>; <h_herman@email.com>; <y_cameron@email.com>                         | Hello to 3 collaborators at hospital\_d |       3 | a\_hanna; h\_herman; y\_cameron              | Aleesha Hanna; Hailie Herman; Yara Cameron                  |
| hospital\_e |                 |               | <a_hicks@email.com>; <l_jensen@email.com>; <s_hardy@email.com>; <y_holder@email.com>     | Hello to 4 collaborators at hospital\_e |       4 | a\_hicks; l\_jensen; s\_hardy; y\_holder     | Alyssa Hicks; Leroy Jensen; Shanelle Hardy; Yara Holder     |
| hospital\_f |                 |               | <c_kent@email.com>; <s_knights@email.com>                                                | Hello to 2 collaborators at hospital\_f |       2 | c\_kent; s\_knights                          | Chanice Kent; Samiha Knights                                |
| hospital\_g |                 |               | <f_livingston@email.com>; <y_mackie@email.com>                                           | Hello to 2 collaborators at hospital\_g |       2 | f\_livingston; y\_mackie                     | Fleur Livingston; Yaseen Mackie                             |
| hospital\_h |                 |               | <a_lees@email.com>; <c_michael@email.com>; <k_marks@email.com>; <s_moses@email.com>      | Hello to 4 collaborators at hospital\_h |       4 | a\_lees; c\_michael; k\_marks; s\_moses      | Aleesha Lees; Chanice Michael; Kester Marks; Shanelle Moses |
| hospital\_i |                 |               | <a_nicholson@email.com>; <h_mustafa@email.com>; <r_hodge@email.com>; <r_ochoa@email.com> | Hello to 4 collaborators at hospital\_i |       4 | a\_nicholson; h\_mustafa; r\_hodge; r\_ochoa | Alyssa Nicholson; Hailie Mustafa; Ralph Hodge; Ralph Ochoa  |
| hospital\_j |                 |               | <l_paine@email.com>; <m_owens@email.com>; <y_odoherty@email.com>                         | Hello to 3 collaborators at hospital\_j |       3 | l\_paine; m\_owens; y\_odoherty              | Leroy Paine; Martha Owens; Yara O’Doherty                   |

 

#### b). Add email body

The `email_body()` function will perform a mailmerge using a specified
rmarkdown file (e.g. “vignette\_email\_body.Rmd”) and the output from
`email_field()`. This will form the email body to be sent via
`email_send()`.

  - The rmarkdown file must have the YAML specified as “output:
    html\_document” and fields to be mailmerged must be specified as
    “x$colname” (see “vignettes/vignette\_email\_body.Rmd”). The text
    format / spacing/ etc can be edited as usual for html rmarkdown
    documents.

  - The output from `email_body()` is a tibble with the “group” and
    based on the options selected in the `html_output` parameter can
    include:
    
      - “file” - The path for group-specific html file produced (can be
        viewed to verify the rendered Rmd document displays as desired).
        These will only be saved if `html_output` includes “file”.
        *Note: All files will be placed in a subfolder specified by
        `subfolder` (default = “folder\_html” within current working
        directory), and will be named according to the group name (this
        can be customised using `file_prefix` and `file_suffix`)*.
    
      - “code” - The html code for the mailmerged html document
        produced. *Note: at present, GmailR does not allow allow html
        files to be directly attached as the email body. Therefore,
        html\_output should always include “code” and this should be
        used as the email body in `email_send()`*.

<!-- end list -->

``` r
body <- collaborator::email_body(df_email, group = "group",
                                 html_output = "code", 
                                 rmd_file = here::here("vignettes/vignette_email_body.Rmd"))

tibble::as_tibble(body)
```

    ## # A tibble: 10 x 2
    ##    group      code                                                              
    ##    <chr>      <chr>                                                             
    ##  1 hospital_a <h4><strong>Dear Aleesha Barker; Fleur Galindo; Leroy Cervantes</…
    ##  2 hospital_b <h4><strong>Dear Chanice Gould; Kester Gibbons; Shanelle Beech</s…
    ##  3 hospital_c <h4><strong>Dear Ralph Bradford</strong>,</h4><p>Thank you for yo…
    ##  4 hospital_d <h4><strong>Dear Aleesha Hanna; Hailie Herman; Yara Cameron</stro…
    ##  5 hospital_e <h4><strong>Dear Alyssa Hicks; Leroy Jensen; Shanelle Hardy; Yara…
    ##  6 hospital_f <h4><strong>Dear Chanice Kent; Samiha Knights</strong>,</h4><p>Th…
    ##  7 hospital_g <h4><strong>Dear Fleur Livingston; Yaseen Mackie</strong>,</h4><p…
    ##  8 hospital_h <h4><strong>Dear Aleesha Lees; Chanice Michael; Kester Marks; Sha…
    ##  9 hospital_i <h4><strong>Dear Alyssa Nicholson; Hailie Mustafa; Ralph Hodge; R…
    ## 10 hospital_j <h4><strong>Dear Leroy Paine; Martha Owens; Yara O’Doherty</stron…

The output from `email_body()` must be appended to the output from
`email_field()` as an additional column.

``` r
df_email <- df_email %>%
  dplyr::left_join(body, group=c("group"))
```

 

#### c). Add email attachments

The `group2csv()` function will split a tibble/dataframe by “group”
variable, then save grouped data in a subfolder as individual CSV files.
This can be used as a group-specific attachment to be sent via
`email_send()`.

  - The groups in the tibble/dataframe supplied (`data`) must
    **exactly** match the groups within the `email_field()` function
    output.

  - The output from `email_body()` is a tibble with the “group”:
    
      - “file” - The path for group-specific CSV files produced (not any
        data not in a group will be discarded). *Note: All files will be
        placed in a subfolder specified by `subfolder` (default =
        “folder\_csv” within current working directory), and will be
        named according to the group name (this can be customised using
        `file_prefix` and `file_suffix`)*.

<!-- end list -->

``` r
# Generate patient-level / anonomysed missing data report
report <- collaborator::report_miss(redcap_project_uri = Sys.getenv("collaborator_test_uri"),
                                    redcap_project_token = Sys.getenv("collaborator_test_token"))$record


attach <- collaborator::group2csv(data = report,
                                  group = "redcap_data_access_group",
                                  subfolder = here::here("vignettes/folder_csv"), file_prefix = "missing_data_")

knitr::kable(attach)
```

| group       | file                                                                            |
| :---------- | :------------------------------------------------------------------------------ |
| hospital\_a | /home/kmclean/collaborator/vignettes/folder\_csv/missing\_data\_hospital\_a.csv |
| hospital\_b | /home/kmclean/collaborator/vignettes/folder\_csv/missing\_data\_hospital\_b.csv |
| hospital\_c | /home/kmclean/collaborator/vignettes/folder\_csv/missing\_data\_hospital\_c.csv |
| hospital\_d | /home/kmclean/collaborator/vignettes/folder\_csv/missing\_data\_hospital\_d.csv |
| hospital\_e | /home/kmclean/collaborator/vignettes/folder\_csv/missing\_data\_hospital\_e.csv |
| hospital\_f | /home/kmclean/collaborator/vignettes/folder\_csv/missing\_data\_hospital\_f.csv |
| hospital\_g | /home/kmclean/collaborator/vignettes/folder\_csv/missing\_data\_hospital\_g.csv |
| hospital\_h | /home/kmclean/collaborator/vignettes/folder\_csv/missing\_data\_hospital\_h.csv |

The output from `group2csv()` and any other attachments must be appended
to the output from `email_field()` as additional columns.

  - Files that are intended to be sent to all groups can be appended
    here in addition (any file type).

<!-- end list -->

``` r
df_email <- df_email %>%
  dplyr::left_join(attach, group=c("redcap_data_access_group" = "group")) %>%
  
  dplyr::mutate(file2 = here::here("man/figures/collaborator_logo.png"))
```

Note: Only `group2csv()` will be supported as a function for creating
group-specific files en mass (e.g. rather than pdf, word, etc) as these
are too heterogeneous and specific in their purpose. However, once
created via rmarkdown, their pathways can be joined to the correct group
and will be attached if included in the `email_send()` function.

   

# 3\. Send group-specific emails

We now have created our four components to the group-specific email:

  - **Group** (Essential): Column created via `email_field()` (“group”).

  - **Email fields** (Essential): Columns created via `email_field()`
    (“recipient\_main”, “recipient\_cc”, “recipient\_bcc”, “subject”)
    .

  - **Email body** (Essential): Column created via `email_body()`
    (“code”).

  - **Attachments** (Optional): Column created via `group2csv()` (e.g.
    “file”) or added manually (e.g. “file2”).

 

#### a). Gmail connection set-up

The `email_send()` function is currently built for use with gmail via
the [gmailr package](https://github.com/r-lib/gmailr). To function, a
connection to the Gmail API must be established in advance (find step by
step process [here](https://github.com/jennybc/send-email-with-r)).

  - *Note: Rstudio hosted on virtual machines have difficulty in
    connecting to gmail. For sending emails, an Rstudio installed on a
    physical computer is needed at present*.

<!-- end list -->

``` r
gmailr::gm_auth_configure(path = "gmail.json")
```

 

#### b). Sending

The `email_send()` will allow automated sending of the prepared
group-specific emails and their attachments. The following parameters
can be specified:

  - `sender`: The email account from which the emails will be sent (must
    be a gmail account and match the )

  - `body`: The column containing the html code produced by the
    `email_body()` function for each group.

  - `attach`: An (optional) list of columns containing the paths of all
    files to be attached (including those which are group-specific). If
    zip = TRUE (default = FALSE), then these files will be compressed
    into a zip folder.

  - `draft`: To prevent premature sending of emails, the default setting
    is to send emails to the gmail draft folder (draft = FALSE). When
    ready to send emails automatically this should be changed to draft =
    TRUE. *Note: gmail allows a maximum of 500 emails to be sent per day
    - if you plan to exceed this number then split the dataset and send
    on different days.*

<!-- end list -->

``` r
collaborator::email_send(df_email = df_email,
                         sender = "email@gmail.com", 
                         email_body = "code", 
                         attach = c("file", "file2"), zip = T,
                         draft = FALSE)
```

The `email_send()` function will print the number + group of emails as
they are sent. This facilitates troubleshooting in the event of errors.
