
EXTERNAL ID:  LK54461_SFCRole=4_JtyENVrvEHzRGTfzgLiWjZldPcA=

USER ARN : arn:aws:iam::974916068036:user/externalstages/cieo8c0000

--------AWS URL----------------
s3://vitech-snowdbt-13/csv/netflix_titles.csv


---Create s3 integration object-------- 

CREATE STORAGE INTEGRATION my_s3_int
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'S3'
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::295191712520:role/vitech-snowdbt-13-role'
  STORAGE_ALLOWED_LOCATIONS = ('s3://vitech-snowdbt-13/csv/', 's3://vitech-snowdbt-13/json/')
  
------DESCRIBE STORAGE INTEGRATION  AND COPY USER ARN AND EXTERNAL_ID AND PASTE IN AWS TRUST RELATIONSHIP-----------
 DESCRIBE INTEGRATION my_s3_int

-----------CREATE STAGE--------------
 CREATE OR REPLACE STAGE MANAGE_DB.EXTERNAL_STAGES.MOVIES_SATGE
 URL = 's3://vitech-snowdbt-13/csv/'
 STORAGE_INTEGRATION = my_s3_int

-------LIST STAGE--------------
 LIST @MANAGE_DB.EXTERNAL_STAGES.MOVIES_SATGE

-------CRAETE TABLE---------------
 // Create table first
CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.movie_titles (
  show_id STRING,
  type STRING,
  title STRING,
  director STRING,
  cast STRING,
  country STRING,
  date_added STRING,
  release_year STRING,
  rating STRING,
  duration STRING,
  listed_in STRING,
  description STRING )

---------CREATE SCHEMA----
CREATE SCHEMA  MANAGE_DB.file_formats  
// Create file format object
CREATE OR REPLACE file format MANAGE_DB.file_formats.csv_fileformat
    type = csv
    field_delimiter = ','
    skip_header = 1
    null_if = ('NULL','null')
    empty_field_as_null = TRUE    
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'       

----------COPY COMMAND------------
COPY INTO  OUR_FIRST_DB.PUBLIC.movie_titles
FROM @MANAGE_DB.EXTERNAL_STAGES.MOVIES_SATGE
FILE_FORMAT = MANAGE_DB.file_formats.csv_fileformat
--FILES = ('netflix_titles.csv')
ON_ERROR = 'SKIP_FILE'


-----------RETRIEVE-------------
SELECT TOP 5 * FROM OUR_FIRST_DB.PUBLIC.movie_titles

-----------RETRIEVE-------------
SELECT COUNT(*)  FROM OUR_FIRST_DB.PUBLIC.movie_titles
