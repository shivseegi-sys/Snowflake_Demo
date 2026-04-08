
// Create example table
 CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.ORDERS_AMAZON (
    ORDER_ID VARCHAR(30),
    AMOUNT INT,
    PROFIT INT,
    QUANTITY INT,
    CATEGORY VARCHAR(30),
    SUBCATEGORY VARCHAR(30));


    SELECT REJECTED_RECORD FROM rejected;



    COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_AMAZON 
	FROM @MANAGE_DB.external_stages.aws_stage_errorex
	FILE_FORMAT = (TYPE='CSV',SKIP_HEADER=1,FIELD_DELIMITER=',')
    VALIDATION_MODE = RETURN_ERRORS 

// Storing rejected /failed results in a table
CREATE OR REPLACE TABLE rejected AS 
select rejected_record from table(result_scan(last_query_id()));

INSERT INTO rejected
select rejected_record from table(result_scan(last_query_id()));

SELECT * FROM rejected;



    CREATE OR REPLACE TABLE rejected_values as
SELECT 
SPLIT_PART(rejected_record,',',1) as ORDER_ID, 
SPLIT_PART(rejected_record,',',2) as AMOUNT, 
SPLIT_PART(rejected_record,',',3) as PROFIT, 
SPLIT_PART(rejected_record,',',4) as QUATNTITY, 
SPLIT_PART(rejected_record,',',5) as CATEGORY, 
SPLIT_PART(rejected_record,',',6) as SUBCATEGORY
FROM rejected; 


SELECT * FROM rejected_values ;

UPDATE rejected_values 
  SET PROFIT = 220 
  WHERE PROFIT = 'two hundred twenty'


         COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_AMAZON 
	FROM @MANAGE_DB.external_stages.aws_stage_errorex
	FILE_FORMAT = (TYPE='CSV',SKIP_HEADER=1,FIELD_DELIMITER=',')
    ON_ERROR=CONTINUE


    285
    1498

INSERT INTO OUR_FIRST_DB.PUBLIC.ORDERS_AMAZON 
    (SELECT * FROM rejected_values)


    SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_AMAZON 



    SELECT OBJECT_CONSTRUCT(*) FROM OUR_FIRST_DB.PUBLIC.ORDERS_AMAZON 
    