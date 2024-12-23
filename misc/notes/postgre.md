# postgreSQL

## detect slow queries

1. slow query log

- postgresql.conf : log min duration statement = 5000
- for one table : postgres=# ALTER DATABASE test SET log_min_duration_statement = 5000;
- create slow query : SELECT pg_sleep(10);

with this log, we can track only singles slow queries, not a huge burst of little queries

2. checking unstable execution plans

- session_preload_libraries = 'auto_explain'

or

```sh
test=# LOAD 'auto_explain';
test=# SET auto_explain.log_analyze TO on;
test=# SET auto_explain.log_min_duration TO 500;
```

“explain analyze” will be sent to the logfile.

3. Checking pg_stat_statements

- shared_preload_libraries = 'pg_stat_statements'

and 

```sh
test=# CREATE EXTENSION pg_stat_statements;
test=# \d pg_stat_statements
```

The view will tell us, which kind of query has been executed how often and tell us about the total runtime of this type of query as well as about the distribution of runtimes for those particular queries.

## postgreSQL commands

Command                                           | action
--------------------------------------------------|-------------------------
createdb                                          | connect to postgre
createuser                                        | connect to postgre
dropdb                                            | list databases
dropuser                                          | drops (removes) a PostgreSQL user
pg_dump bdd_name > file                           | save one database
pg_dumpall > file                                 | save all database
vacuumdb                                          | clean and analyze a PostgreSQL database
psql                                              | postgreSQL interactive terminal
psql -f file postgres                             | restore all database
psql bdd_name < file                              | restore one database

# psql interactive mode

Command                                                            | action
-------------------------------------------------------------------|-------------------------
sudo -u postgres psql                                              | connect to postgre
psql bdd_name user                                                 | connect to postgre
\l                                                                 | list databases
\du                                                                | list user
create database name;                                              | create the database name
create user name;                                                  | create the user name
\password name                                                     | set password
drop database name                                                 | delete database
drop user name                                                     | delete user
\c bdd_name                                                        | connect to database
\dn                                                                | list schema
\dt schema_name.*                                                  | list tables in schema
\d schema_name.table_name                                          | view table
delete from table_name;                                            | clear table
select * from schema_name.AA order by schema_name.AA.id limit 100; | view 100 lines inside AA
select * from schema_name.AA where field='text' limit 100;         | view 100 lines inside AA where field=something
copy (request) to path/file_name;                                  | copy output
select pg_database_size('databaseName');                           | show database size
\\?                                                                 | commands help
\q                                                                 | quit
