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
            - Now I can run in the Terminal: sqlite3 database_name.db and will go to the sqlite enviroment. To exit use the command .quit.
            - Then I can type the SQL code.
            - This command: cat file_name.sql | sqlite3 database_name.db > output.txt will run directly in the Terminal the SQL code in file_name.sql and put the output in a file called output.txt.

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

LIKE keyword to match some string. LIKE is case insentitive.
% matches any characters around a given string.
_ matches a single character.
SELECT "title"
FROM "longlist"
WHERE "title" LIKE '%love%';

SELECT "title"
FROM "longlist"
WHERE "title" LIKE 'P_re';

Ranges can be used with < > <=  >=
SELECT "title", "author"
FROM "longlist"
WHERE "year" >= 2019 AND "year" <= 2022;

BETWEEN keyword:
SELECT "title", "author"
FROM "longlist"
WHERE "year" BETWEEN 2019 AND 2022; 
You might find it helpful to know you can use BETWEEN with dates, such as BETWEEN '2000-01-01' AND '2000-12-31'.

ORDER BY keywords, works with DESC ASC. Default oreder by ascending and alphabetic.
SELECT "title", "rating", "votes"
FROM "longlist"
ORDER BY "rating" DESC, "votes" DESC
LIMIT 10;

Agregate functions:
COUNT AVG MIN MAX SUM, works with ROUND
SELECT AVG("rating")
FROM "longlist";

SELECT ROUND(AVG("rating"), 2)
FROM "longlist";

AS keyword to define a name for a query.
SELECT ROUND(AVG("rating"), 2) AS "average rating"
FROM "longlist";

SELECT COUNT(*) FROM "longlist"; will output the number of rows of the table.

DISTINCT keyword returns distincts results.
SELECT COUNT(DISTINCT "publisher")
FROM "longlist";