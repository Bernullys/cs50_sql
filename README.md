# cs50_sql
CS50 Harvard Curse

SQL Structured Query Language.
Tables are structured database.

Lecture 0. Introduction / Querying

Three reasons to move beyond spreadsheets to databeses are:
    - Scale.
    - Update Capacity.
    - Speed.

A database can perform:
    - create.
    - read.
    - update.
    - delete.

Database management system (DBMS) examples: MySQL, Oracle, PostgreSQLLite, Microsoft Access, MongoDB. How to choice of a DBMS:
    - Cost.
    - Amount of support.
    - Weight.

Getting Started with SQLite:
Is a language used to interact with databases, via which we can create, read, update, and delete data in a database.

SELECT * FROM "database";   Select everything.
SELECT "column1", "column2", "column_n", FROM "database";

        Apart: to work with sqlite3 in my pc I did this:
            - Install sqlite3 in my WSL using sudo apt install sqlite3.
            - In VSC install SQLite.
            - SQLite Viewer (It got installed localy).
            - Now I can run in the Terminal: sqlite3 database_name.db and will go to the sqlite enviroment.
            - Then I can type the SQL code.
            - This command: cat file_name.sql | sqlite3 database_name.db > output.txt will run the SQL code in file_name.sql ant put the output in a file called output.txt.

LIMIT keyword limit the number of rows to output.
SELECT "column1", FROM "database" LIMIT 5;

WHERE keyword is used to select rows based on condition. Conditions could be = , !=, <> (also not equal).
SELECT "column1", FROM "database" WHERE "column1" = "value";
If we are using a string as condition it has to be inside single quotes.

NOT keyword is used with WHERE --> WHERE NOT

Conditionals: AND OR ()
SELECT "title", "format"
FROM "longlist"
WHERE ("year" = 2022 OR "year" = 2023) AND "format" != 'hardcover';

Conditions used with NULL, IS NULL and IS NOT NULL.
SELECT "title", "translator"
FROM "longlist"
WHERE "translator" IS NULL;

LIKE keyword to match some string.
% matches any characters around a given string.
_ matches a single character.
SELECT "title"
FROM "longlist"
WHERE "title" LIKE '%love%';

SELECT "title"
FROM "longlist"
WHERE "title" LIKE 'P_re';


