# postgreSQL commands

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
