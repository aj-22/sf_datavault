

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