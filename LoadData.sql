---------------EXTERNAL LOADING-----------------------
CREATE DATABASE OUR_FIRST_DB CREATE
OR REPLACE STAGE OUR_FIRST_DB.PUBLIC.ORDERS_STAGE URL = 's3://bucketsnowflakes3' LIST @OUR_FIRST_DB.PUBLIC.ORDERS_STAGE;
---3 CREATE TABLE
CREATE
OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.ORDERS (
    ORDER_ID VARCHAR(30),
    AMOUNT INT,
    PROFIT INT,
    QUANTITY INT,
    CATEGORY VARCHAR(30),
    SUBCATEGORY VARCHAR(30)
);
COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS
FROM
    @OUR_FIRST_DB.PUBLIC.ORDERS_STAGE FILE_FORMAT = (
        TYPE = 'CSV',
        SKIP_HEADER = 1,
        FIELD_DELIMITER = ','
    ) FILES = ('OrderDetails.csv')
SELECT
    COUNT(*)
FROM
    OUR_FIRST_DB.PUBLIC.ORDERS;
    ----------------------------------------------------------------------
    --------INTERNAL LOADING-----------
    CREATE
    OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.LOAN_PAYMENT_V5 (
        Loan_ID STRING,
        loan_status STRING,
        Principal STRING,
        terms STRING,
        effective_date STRING,
        due_date STRING,
        paid_off_time STRING,
        past_due_days STRING,
        age STRING,
        education STRING,
        Gender STRING
    );
SELECT
    *
FROM
    LOAN_PAYMENT_V5 CREATE
    OR REPLACE STAGE MY_INT_STAGE;
LIST @MY_INT_STAGE;
COPY INTO OUR_FIRST_DB.PUBLIC.LOAN_PAYMENT_V5
FROM
    @OUR_FIRST_DB.PUBLIC.MY_INT_STAGE FILE_FORMAT = (
        TYPE = 'CSV',
        SKIP_HEADER = 1,
        FIELD_DELIMITER = ','
    ) FILES = ('Load_payment-1.csv', 'Loans-data.csv')