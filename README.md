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
    SELECT "column1", FROM "database" WHERE "column1" = 'value';
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


Lecture 1 - Relating

    One to one.
    One to many.
    Many to many.

    Entity ralationship diagrams (ER Diagrams).
    0         Zero.
    +         One.
    arrow     Many.

    Keys
    Is an identifier that is unique for every item in a table.

    Foreing Keys
    Is a primary key taken from a different table. By referencing the primary key of a different table, it helps relate tha tables by forming a link between them.


    Subqueries
    Is a query inside another query. These are also called nested queries.
    Is usefull for one to one or many to many.

    SELECT "title"
    FROM "books"
    WHERE "publisher_id" = (
        SELECT "id"
        FROM "publishers"
        WHERE "publisher" = 'Fitzcarraldo Editions'
    );

    SELECT "name"
    FROM "authors"
    WHERE "id" = (
        SELECT "author_id"
        FROM "authored"
        WHERE "book_id" = (
            SELECT "id"
            FROM "books"
            WHERE "title" = 'Flights'
            )
    );


    IN keyword
    Is used to check whether the desired value is in a given list or set of values.
    SELECT "title"
    FROM "books"
    WHERE "id" IN (
        SELECT "book_id"
        FROM "authored"
        WHERE "author_id" = (
            SELECT "id"
            FROM "authors"
            WHERE "name" = 'Fernanda Melchor'
        )
    );


    JOIN keyword
    This keyword allows us to combine two or more tables together.
    SELECT * FROM "sea_lions"
    JOIN "migrations" ON "migrations"."id" = "sea_lions"."id";

    Inner JOIN / Outer JOIN

    LEFT JOIN       LEFT OUTER JOIN
    RIGHT JOIN      RIGHT OUTER JOIN
    FULL JOIN       

    NATURAL JOIN
    Allows to omit the part of my previous JOINs (from ON forwards).
    Also assume that the columns with the same name and values want to be join.
    SELECT *
    FROM "sea_lions"
    NATURAL JOIN "migrations";


    Sets
    Sets are tables that results from queries.

    SELECT 'author' AS "profession", "name" FROM "authors"; Important to know. OJO.

    UNION
    SELECT 'author' AS "profession", "name"
    FROM "authors"
    UNION
    SELECT 'translator' AS "profession", "name"
    FROM "translators";

    INTERSET
    SELECT "name" FROM "translators"
    INTERSECT
    SELECT "name" FROM "authors";

    EXCEPT
    SELECT "name" FROM "authors"
    EXCEPT
    SELECT "name" FROM "translators";

    Example of use:
    SELECT "book_id" FROM "translated"
    WHERE "translator_id" = (
    SELECT "id" from "translators"
    WHERE "name" = 'Sophie Hughes'
    )
    INTERSECT
    SELECT "book_id" FROM "translated"
    WHERE "translator_id" = (
    SELECT "id" from "translators"
    WHERE "name" = 'Margaret Jull Costa'
    );

    Groups
    Groups are used to group rows that have the same values in one or more columns.
    GROUP BY
    SELECT "book_id", ROUND(AVG("rating"), 2) AS "average rating"
    FROM "ratings"
    GROUP BY "book_id"
    HAVING "average rating" > 4.0;    Having is like Where but when we are grouping first.

    SELECT "book_id", ROUND(AVG("rating"), 2) AS "average rating"
    FROM "ratings"
    GROUP BY "book_id"
    HAVING "average rating" > 4.0
    ORDER BY "average rating" DESC;

Lecture 2 - Disigning

    SQLLite command (not keyword) .schema shows how a data base was created.
    .schema table_name will show only the schema of that table.

    Creating a Database Schema:
    To create a table we have to decide:
        What kinds of tables we will have in our database,
        What columns each of the tables will have, and
        What types of data we should put in each of those columns.

    Normalizing:
    The process of separating our data is called normalizing. When normalizing we put each entity in its own table. Any specific entity, goes into the entity's own table.

    Relating:
    We have to decide how our entities are related.
    We can also use an ER diagram to represesnt this relationship.

    CREATE TABLE
    To create a table I have to type sqlite3 database_name.db. This will create a file called data_base.db. Then we have to read the schema.sql file which contains the commands to create tables.
    Don't work using touch database_name.db.
    And then the command CREATE TABLE... is typed in the command line.

                sqlite> CREATE TABLE "stations" (
        ...>     "id",
        ...>     "name",
        ...>     "line"
        ...> );

    Then we create a table to relate entities. These tables are often called junction tables, associative entities or join tables.

    Data Types and Storage Classes:
    SQLite has five storage classes:
        Null: nothing, or empty value
        Integer: numbers without decimal points
        Real: decimal or floating point numbers
        Text: characters or strings
        Blob: Binary Large Object, for storing objects in binary (useful for images, audio etc.)
        A storage class can hold several data types.
        For example, these are the data types that fall under the umbrella of the Integer storage class:
            INTEGER:
                0-byte integer
                1-byte integer
                2-byte integer
                3-byte integer
                4-byte integer
                6-byte integer
                8-byte integer
    SQLite takes care of storing the input value under the right data type. In other words, we as programmers only need to choose a storage class and SQLite will do the rest!

    A workaround could be to use 0 or 1 integer values to represent booleans.

    Type Affinities:
     It is possible to specify the data type of a column while creating a table.
    However, columns in SQLite don’t always store one particular data type. They are said to have type affinities, meaning that they try to convert an input value into the type they have an affinity for.
    The five type affinities in SQLite are: Text, Numeric (either integer or real values based on what the input value best converts to), Integer, Real and Blob.
    Consider a column with a type affinity for Integers. If we try to insert “25” (the number 25 but stored as text) into this column, it will be converted into an integer data type.
    Similarly, inserting an integer 25 into a column with a type affinity for text will convert the number to its text equivalent, “25”.

    Adding Types to our Tables:
    Command to delete tables: DROP TABLE "table_name";
    (Whatch schema.sql file).

    Table Constraints:
    We can use table constraints to impose restrictions on certain values in our tables.
    For example, a primary key column must have unique values. The table constraint we use for this is PRIMARY KEY.
    Similarly, a constraint on a foreign key value is that it must be found in the primary key column of the related table! This table constraint is called, predictably, FOREIGN KEY.

    Column Constraints:
    A column constraint is a type of constraint that applies to a specified column in the table.
    SQLite has four column constraints:
        CHECK: allows checking for a condition, like all values in the column must be greater than 0
        DEFAULT: uses a default value if none is supplied for a row
        NOT NULL: dictates that a null or empty value cannot be inserted into the column
        UNIQUE: dictates that every value in this column must be unique
    
    Altering Tables:
    Commands to change tables:
        ALTER TABLE "table_name"
        RENAME TO "new_table_name"
        ADD COLUMN "column_name" "data_type"
        RENAME COLUMN "column_name" TO "new_column_name"
        DROP COLUMN "column_name";
    Other wise we can change it by hand in directly in the file.

    Example:

        CREATE TABLE "cards" (
        "id" INTEGER,
        PRIMARY KEY("id")
        );

        CREATE TABLE "stations" (
            "id" INTEGER,
            "name" TEXT NOT NULL UNIQUE,
            "line" TEXT NOT NULL,
            PRIMARY KEY("id")
        );

        CREATE TABLE "swipes" (
            "id" INTEGER,
            "card_id" INTEGER,
            "station_id" INTEGER,
            "type" TEXT NOT NULL CHECK("type" IN ('enter', 'exit', 'deposit')),
            "datetime" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
            "amount" NUMERIC NOT NULL CHECK("amount" != 0),
            PRIMARY KEY("id"),
            FOREIGN KEY("station_id") REFERENCES "stations"("id"),
            FOREIGN KEY("card_id") REFERENCES "cards"("id")
        );

Lecture 3 - Writing

    Inserting Data:

        INSERT INTO "table_name" ("field1", "field2", ...)
        VALUES ("value1", "value2", ...);

        NOTE: if a table has a PRIMARY KEY, this will be filled automatically.
        NOTE: if a constraint is declare and when adding values we don't respect it, will return an error.
        
    Inserting Multiple Rows:

        INSERT INTO "table_name" (column0, ...)
        VALUES
        ("value1", ...),
        ("value2", ...),
        ...;
    
        Data could also be stored in a csv format.
        First we have to start from zero, create a database file and import the file we the data:
            .import --csv --skip 1 csv_file.csv table_name
            --skip 1 is to avoid adding the first row of the csv file but this is when we already have the table with the column names.
        
        If we have a data from in a csv without an id column, we can do it in a different way. We will to use a temporary table:
            .import --csv csv_file.csv temporary_table
            This time we won't need to skip line 1 because this way is reconized as the column names.
        Next, we will select the data(without primary keys) from temporary_table and move it to out table_name, which was the goal all along.
        We can do:
            INSERT INTO "table_name" ("column1", ...)
            SELECT "column1", ... FROM "temporary_table";
        In this process, SQLite will automatically add the primary key values in the id column.
        Note: the "id" has to have INTEGER constrains.
        Then we can clean up our database:
            DROP TABLE "temporary_table";

    Deleting Data:

        Deleting a table: 
            DROP TABLE "table_name";

        This command will delete all rows in the table:
            DELETE FROM "table_name";
        But we can match specific conditions like:
           DELETE FROM "collections"
            WHERE "title" = 'Spring outing'; 

            DELETE FROM "collections"
            WHERE "acquired" IS NULL;

            DELETE FROM "collections"
            WHERE "acquired" < '1909-01-01';

        There might be cases where deleting some data could impact the integrity of a database. Foreign key constrains are a good example. A foreign key column references the primary key of a different table. If we were to delete the primary key, the foreign key column would have nothing to reference. Traying to delete this we get an error. This error notifies us that deleting this data would violate the foring key constraint set up in the table.
        One possibility is to delete the corresponding rows from the connections_table and then deleting from the other table.

        In another possibility, we can specify the action to be taken when an ID referenced by a foreign key is deleted. To do this, we use the keyword ON DELETE followed by the action to be taken.
            ON DELETE RESTRICT: This restricts us from deleting IDs when the foreign key constraint is violated.
            ON DELETE NO ACTION: This allows the deletion of IDs that are referenced by a foreign key and nothing happens.
            ON DELETE SET NULL: This allows the deletion of IDs that are referenced by a foreign key and sets the foreign key references to NULL.
            ON DELETE SET DEFAULT: This does the same as the previous, but allows us to set a default value instead of NULL.
            ON DELETE CASCADE: This allows the deletion of IDs that are referenced by a foreign key and also proceeds to cascadingly delete the referencing foreign key rows. For example, if we used this to delete an artist ID, all the artist’s affiliations with the artwork would also be deleted from the table. Example:
                FOREIGN KEY("artist_id") REFERENCES "artists"("id") ON DELETE CASCADE
                FOREIGN KEY("collection_id") REFERENCES "collections"("id") ON DELETE CASCADE

    Updating Data: (whatch the example of the class. From 1:09 minutes)

        UPDATE table
        SET column1 = value1, column2 = value2, ...
        WHERE condition;

    Triggers:

        CREATE TRIGGER trigger_name
        BEFORE/AFTER INSERT/UPDATE/DELETE ON table_name
        FOR EACH ROW
        BEGIN
        -- trigger code
        END;
        Example:
        CREATE TRIGGER "update_artist"
        BEFORE UPDATE ON "artists"
        FOR EACH ROW
        BEGIN
            UPDATE "affiliations"
            SET "artist_id" = NEW."id"
            WHERE "artist_id" = OLD."id";
        END;
        This trigger will update the affiliations table whenever an artist is updated in the artists table.

    Solf deletions:

        Is a tecnique to don't delete data, instead we update data and we add a column where we can keep track of the data we mark as deleted. Then we could select the data deleted or not if we want.


 
