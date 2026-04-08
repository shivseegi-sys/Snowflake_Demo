--source --  s3://bucketsnowflakes4

--target -- order tables
-------CREATE DB----------------
CREATE DATABASE MANAGE_DB;

---------CREATE SCHEMA -------------------
CREATE SCHEMA MANAGE_DB.external_stages;

------CREATE STAGE------------------
CREATE OR REPLACE STAGE MANAGE_DB.external_stages.aws_stage_errorex
URL='s3://bucketsnowflakes4'

----LIST STAGE-------------
LIST @MANAGE_DB.external_stages.aws_stage_errorex;

------------CREATE TABLE------------
 // Create example table
 CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.ORDERS_EX (
    ORDER_ID VARCHAR(30),
    AMOUNT INT,
    PROFIT INT,
    QUANTITY INT,
    CATEGORY VARCHAR(30),
    SUBCATEGORY VARCHAR(30));

--------------COPY COMMAND-------------------
    COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX 
	FROM @MANAGE_DB.external_stages.aws_stage_errorex
	FILE_FORMAT = (TYPE='CSV',SKIP_HEADER=1,FIELD_DELIMITER=',')
	--FILES = ('OrderDetails.csv')


----------------------------------------------------------------------------
    
 // Create example table
 CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.ORDERS_EX1 (
    ORDER_ID VARCHAR(30),
    AMOUNT INT,
    PROFIT INT,
    QUANTITY INT,
    CATEGORY VARCHAR(3),
    SUBCATEGORY VARCHAR(30));


    
    COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX1 
	FROM @MANAGE_DB.external_stages.aws_stage_errorex
	FILE_FORMAT = (TYPE='CSV',SKIP_HEADER=1,FIELD_DELIMITER=',')
    ON_ERROR =CONTINUE
    TRUNCATECOLUMNS =TRUE 


     SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX1



    COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX 
	FROM @MANAGE_DB.external_stages.aws_stage_errorex
	FILE_FORMAT = (TYPE='CSV',SKIP_HEADER=1,FIELD_DELIMITER=',')
    ON_ERROR =CONTINUE
    SIZE_LIMIT = 56000



    COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX 
	FROM @MANAGE_DB.external_stages.aws_stage_errorex
	FILE_FORMAT = (TYPE='CSV',SKIP_HEADER=1,FIELD_DELIMITER=',')
    ON_ERROR = 'SKIP_FILE'


    -----------ERROR RECORDS------------
 --------------VALIDATION_MODE----------
      COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX 
	FROM @MANAGE_DB.external_stages.aws_stage_errorex
	FILE_FORMAT = (TYPE='CSV',SKIP_HEADER=1,FIELD_DELIMITER=',')
    VALIDATION_MODE = RETURN_ERRORS 


    COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX 
	FROM @MANAGE_DB.external_stages.aws_stage_errorex
	FILE_FORMAT = (TYPE='CSV',SKIP_HEADER=1,FIELD_DELIMITER=',')
    VALIDATION_MODE = RETURN_2000_ROWS 


    -----------RETURN_FAILED_ONLY--------------
        COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX 
	FROM @MANAGE_DB.external_stages.aws_stage_errorex
	FILE_FORMAT = (TYPE='CSV',SKIP_HEADER=1,FIELD_DELIMITER=',')
    RETURN_FAILED_ONLY = TRUE 
    VALIDATION_MODE = RETURN_ERRORS 

--------------ON_ERROR---------------
    COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX 
	FROM @MANAGE_DB.external_stages.aws_stage_errorex
	FILE_FORMAT = (TYPE='CSV',SKIP_HEADER=1,FIELD_DELIMITER=',')
    ON_ERROR =CONTINUE



    SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX 

--------------FORCE-------------------
        COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX 
	FROM @MANAGE_DB.external_stages.aws_stage_errorex
	FILE_FORMAT = (TYPE='CSV',SKIP_HEADER=1,FIELD_DELIMITER=',')
    ON_ERROR =CONTINUE
    FORCE=TRUE 




    
