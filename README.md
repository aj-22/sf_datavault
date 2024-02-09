

# Initial Set Up

Create Worksheet in Snowflake and execute the following.
```sql
use role ACCOUNTADMIN;
set myname = current_user();
create role if not exists DV_ROLE;
grant role DV_ROLE to user identifier($myname);
grant create database on account to role DV_ROLE;
grant EXECUTE TASK, EXECUTE MANAGED TASK on ACCOUNT to role DV_ROLE;
grant IMPORTED PRIVILEGES on DATABASE SNOWFLAKE to role DV_ROLE;
grant IMPORTED PRIVILEGES on DATABASE SNOWFLAKE_SAMPLE_DATA to role DV_ROLE;

create or replace warehouse DV_WH WAREHOUSE_SIZE = XSMALL, AUTO_SUSPEND = 5, AUTO_RESUME= TRUE;
grant all privileges on warehouse DV_WH to role DV_ROLE;

use role DV_ROLE;
create or replace database DV_DB;
grant all privileges on database DV_DB to role DV_ROLE;
```

Create TEST Data
```sql
insert into model.staging__customer values
(100, 'Name1', 'Address1', 22, '98-9876-9876', 100,'AUTOMOBILE','test record',CURRENT_TIMESTAMP(),'MANUAL'),
(200, 'Name2', 'Address2', 15, '98-9876-9876', 110,'AUTOMOBILE','test record',CURRENT_TIMESTAMP(),'MANUAL'),
(300, 'Name3', 'Address3', 22, '98-9876-9876', 190,'AUTOMOBILE','test record',CURRENT_TIMESTAMP(),'MANUAL');


insert into model.staging__orders values
(111, 100, 'F', 8000.00, '1992-01-09','2-HIGH','Clerk007','0','test record',CURRENT_TIMESTAMP(),'MANUAL'),
(112, 100, 'F', 9000.00, '1992-01-10','2-HIGH','Clerk007','0','test record',CURRENT_TIMESTAMP(),'MANUAL'),
(113, 300, 'F', 12000.00, '1992-01-11','2-HIGH','Clerk007','0','test record',CURRENT_TIMESTAMP(),'MANUAL'),
(114, 200, 'F', 8000.00, '1992-01-10','2-HIGH','Clerk007','0','test record',CURRENT_TIMESTAMP(),'MANUAL');

-- Execute dbt run to load the data

update model.staging__customer set C_ACCTBAL = 500 where C_CUSTKEY = 100 and C_SRC = 'MANUAL';
```