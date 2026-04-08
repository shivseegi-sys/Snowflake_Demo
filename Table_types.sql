-------PERMANENT TABLE----------
CREATE   TABLE   EMP (ID INT , NAME STRING)

INSERT INTO EMP VALUES (101,'KARTHIK'),
                       (102,'dAVOOD'),
                       (103,'sREE')

------TRANSIENT TABLE------------
CREATE  TRANSIENT TABLE   EMP_TRANS (ID INT , NAME STRING)


INSERT INTO EMP_TRANS VALUES (101,'KARTHIK'),
                       (102,'dAVOOD'),
                       (103,'sREE')

---------TEMPORARY TABLE----------------
CREATE  TEMPORARY TABLE   EMP_TEMP (ID INT , NAME STRING)


INSERT INTO EMP_TEMP VALUES (101,'KARTHIK'),
                       (102,'dAVOOD'),
                       (103,'sREE')


SHOW TABLES 


SELECT * FROM EMP 


SELECT * FROM EMP_TRANS


SELECT * FROM EMP_TEMP


---can we create same table name as permanent /temporary 

CREATE  TEMPORARY TABLE   EMP (ID INT , NAME STRING)



INSERT INTO EMP VALUES (101,'KARTHIK'),
                       (102,'dAVOOD'),
                       (103,'sREE')


 
INSERT INTO EMP VALUES (111,'RTHIK'),
                       (112,'OOD'),
                       (113,'EE')   



select * from emp 

drop table emp

drop table emp_trans 
----CREATE STAGE----------
CREATE OR REPLACE STAGE MANAGE_DB.EXTERNAL_STAGES.EMPLOYEE_SATGE
 URL = 's3://vitech-snow-dbt-13/csv/'
 STORAGE_INTEGRATION = my_s3_int
----LIST------
list @MANAGE_DB.EXTERNAL_STAGES.EMPLOYEE_SATGE

-------Create the External Table---------
CREATE OR REPLACE EXTERNAL TABLE  our_first_db.public.my_external_table (
  id INT AS (VALUE:c1::INT),
  name STRING AS (VALUE:c2::STRING),
  location STRING AS (VALUE:c5::STRING)
)
LOCATION=@MANAGE_DB.EXTERNAL_STAGES.EMPLOYEE_SATGE
FILE_FORMAT = MANAGE_DB.file_formats.csv_fileformat
PATTERN = '.*employee_data.*\\.csv'
AUTO_REFRESH = TRUE;
--🔹 VALUE:c1, VALUE:c2, etc., refer to columns in the external file.
--🔹 AUTO_REFRESH = TRUE enables automatic metadata refresh when new files are added.

--Query the External Table
SELECT * FROM  our_first_db.public.my_external_table;


show tables ;




select * from orders_ex1 
-----------TIME TRAVEL USING OFFSET-------
create or replace table orders_time as
(select * from orders_ex at (offset => -60 * 5) )

create table  orders_v5 as
(select * from orders_ex )

select * from orders_v5

create or replace table  orders_v6 as
(select order_id,amount,profit,quantity from orders_ex )


select * from orders_v6


---------DYNAMIC TABLE------------
CREATE OR REPLACE DYNAMIC TABLE my_dynamic_table
  TARGET_LAG = '2 minutes'
  WAREHOUSE = compute_wh
  REFRESH_MODE = auto
  INITIALIZE = on_create
  AS
    select order_id,amount,profit,quantity from orders_ex


select * from my_dynamic_table



delete from orders_ex  where profit < 0


create or replace table orders_ex clone orders_ex1 

update orders_ex 
      set profit = 100  