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

    NOTE: ORDER BY accepts Agregate functions.

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
        ADD COLUMN "column_name" data_type DEFAULT VALUE XXX
        RENAME COLUMN "column_name" TO "new_column_name"
        DROP COLUMN "column_name";
    Other wise we can change it by hand in directly in the file.
    We can add default values as:
        Example:
            ALTER TABLE "table_name"
            ADD COLUMN "column_name" data_type DEFAULT VALUE X;

    Example:

        CREATE TABLE "cards" (
        "id" INTEGER,'cup
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
        
        If we have a data form in a csv without an id column, we can do it in a different way. We will to use a temporary table:
            .import --csv csv_file.csv temporary_table
            This time we won't need to skip line 1 because this way is reconized as the column names.
        Next, we will select the data(without primary keys) from temporary_table and move it to out table_name, which was the goal all along.
        We can do:
            INSERT INTO "table_name" ("column1", ...)
            SELECT "column1", ... FROM "temporary_table";
        In this process, SQLite will automatically add the primary key values in the id column.
        Note: the "id" has to have INTEGER constrains, and also has to be set as PRIMARY KEY
        
        Then we can clean up our database:
            DROP TABLE "temporary_table"; To remove that entire table.

    Deleting Data:

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
            ON DELETE CASCADE: This allows the deletion of IDs that are referenced by a foreign key and also proceeds to cascadingly delete the referencing foreign key rows. 
            For example, if we used this to delete an artist ID, all the artist’s affiliations with the artwork would also be deleted from the table. 
            Example: (This is does when Designing the Tables, is a constrains)
                FOREIGN KEY("artist_id") REFERENCES "artists"("id") ON DELETE CASCADE
                FOREIGN KEY("collection_id") REFERENCES "collections"("id") ON DELETE CASCADE

    Updating Data: (whatch the example of the class. From 1:09 minutes)

        UPDATE table
        SET column1 = value1, column2 = value2, ...
        WHERE condition;

        Example:
            UPDATE "created" SET "artist_id" = (
                SELECT "id" FROM "artists"
                WHERE "name" = 'John'
            )
            WHERE "collections_id" = (
                SELECT "id" FROM "collections"
                WHERE "title" = 'Spring outing'
            );

        To clean up data from tables we can use differents ways and functions like:
            trim("column_1")
            upper("column_1")
            Example:
                UPDATE "table_1" SET "column_1" = trim("column_1);
            Also we can use conditions LIKE, WHERE, %, _, etc...


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
        OLD and NEW will take the value of data which we are deleting or adding to our table.

    Solf deletions:

        Is a tecnique to don't delete data, instead we update data and we add a column where we can keep track of the data we mark as deleted. Then we could select the data deleted or not if we want.

    
    NOTE:   terminal command that is handy when we want to run a sql file which has a command that are not sqlite code (like problem Meteorite Cleaning).
            cat file_name.sql | sqlite3 data_base_name.db
            cat file_name.sql outputs the data in file_name.sql.
            sqlite3 data_base_name.db opens a file called data_base_name.db with the sqlite3 engine, as you’re already familiar with.



Lecture 4 - Viewing

    Views:
        A View is a virtual table defined by a query. This new table can be queried later on.
        View re useful for:
            Simplifying: putting together data fron different tables to be required more simply.
            Aggregating: running aggregate functions, like finding the sum, and storing the results.
            Partitioning: dividing data into logical pieces.
            Securing: hiding columns that should be kept secure.
            There are others types of views...
            Views can not be updated.

        Simplifying:
            This is the format of code:
                CREATE VIEW "view_name" AS
                SELECT ...;
            This will be added to the schema of the database.
            If we want to add a view only for the time we are connected to a database we should use:
                CREATE TEMPORARY VIEW "view_name" AS
                SELECT ...;
            
            Example:
                CREATE VIEW "longlist" AS
                SELECT "name", "title" FROM "authors"
                JOIN "authored" ON "authors"."id" = "authored"."author_id"
                JOIN "books" ON "books"."id" = "authored"."book_id";

                This table will simplify futures querys beacuse we can query anything fron this table.
    
        Aggregating:
            Is basicly the same code but using aggregation functions.

        Common Table Expression (CTE):
            A regular view exists forever in our database. A temporary view exist for the duration of our connection with the database. A CTE is a view that exist for a single query alone.
            A CTE is defined by a query and can be used in a query.
            This is the form:

                WITH "name" AS (
                    SELECT ...
                ), ...
                SELECT ... FROM "name";

            Example:
                WITH "average_book_ratings" AS (
                SELECT "book_id", "title", "year", ROUND(AVG("rating"), 2) AS "rating" FROM "ratings"
                JOIN "books" ON "ratings"."book_id" = "books"."id"
                GROUP BY "book_id"
                )
                SELECT "year" ROUND(AVG("rating"), 2) AS "rating" FROM "average_book_ratings"
                GROUP BY "year";

        Partioning:
            With the same approach has simplifying and aggregating but to our conviniance we can partion tables to be better manipulated.
        
        Securing:
            Some information in tables could be categorized as Personally Identifiable Information (PII) which companies are not allowed to share indiscriminately.
            We can create a view that does not contains this type of information but SQLite3 does not allow access control. This means that someone simply query the original table and see all the information.
            Example:
                CREATE VIEW "analysis" AS
                SELECT "id", "origin", "destination", 'Anonymous' AS "rider"
                FROM "rides";

        Solf Deletions:
            As we saw in previous weeks, a solf deletion involves marking a row as deleted insted of removing it from the table.
            We can create a view that shows only the rows that are not marked as deleted. And had that view which will be showing the rows which aren't mark as deleted in the real table with each solf deletion.
            Example:
                CREATE VIEW "current_collections" AS
                SELECT "id", "title", "accession_number", "acquired"
                FROM "collections"
                WHERE "deleted" = 0;

                This query is the solf deletion:
                UPDATE "collections"
                SET "deleted" = 1
                WHERE "title" = 'Farmers working at dawn';

        Creating triggers on views:
            We can create triggers to insert or delete date from the underlying tables.
            This way to delete:
                CREATE TRIGGER "name"
                INSTED OF DELETE ON "view_name"
                FOR EACH ROW
                BEGIN
                    ...;
                END;

                This way to insert:
                CREATE TRIGGER "name"
                INSTED OF INSERT ON "view_name"
                FOR EACH ROW 
                WHEN condition
                BEGIN
                    ...;
                END;

                (In the lecture are a good example of how to use triggers on insert).


Lecture 5 - Optimizing.

    SqLite has a command .timer on that enable us to time our queries.
    To find the size of a database on the terminal, we can use a Unix command: du -b database_name.db

    Index.
        The same way that textbooks often have an index, databases tables can have an index as well.
        An index is a structure used to speed uo the retrieval of rows from a table.
        Index's comes with trade-offs with space and the time it takes to later insert data into tables.
        To create an index:
            CREATE INDEX "index_name" ON "table_name" ("column_name", ...);

        Index across Multiple Tables.
        To understand what kind of index could help speed this query up, we can run EXPLAIN QUERY PLAB ahead of the query.
            EXPLAIN QUERY PLAN
            SELECT ...; (nested queries).
            When we run explain query plan we can see if the queries and sub queries are done by search or scan. Scan is slower so the idea is to add indexes to the queries which are on scans.
        
        Covering Index: An index in which queried data can be retrived from the index itself.
        A covering index is a special type of index that includes all columns needed for the query. This means the database can fulfill the query directly from the index without having to look up additional data in a table.

        Space Trade-off.
            Indexes seem incredibly helpful, but there are trade-off associated - they occupy additional space in the database, so while we gain query speed, we do lose space.
            An index is stored un a database as a data structure called a B-Tree, or balanced tree.
        TIme Trade-off.
            Similar to the space trade-off, it also takes longer to insert data into a column and then add it ti an index. Each time a value is added to the index, the B-tree needs to be traversed to figure out where the value should be added.
        
    Partial Index.
        This is an index that includes only a subset of rows from a table, allowing us to save some space that a full index would occupy.
        This is especially useful when we know thet users query only a subset of rows fron the table.
        Example:    CREATE INDEX "recents" ON "movies" ("titles")
                    WHERE "year" = 2023;

    Vaccum.
        There are ways to delete unused space in out database. Sqlite allows us to "vacuum" data -  this cleans up previously deleted data (that is actually no deleted, but just marked as space being available for the next INSERT).
        Run:
            VACCUM;
        
    Concurrency.
        Concurrency is the simultaneous handling of multiple queries or interactions by the database. Imagine a database for a website, or a finalcial service, that gets a ot of trafficat the same time. Concurrency is particulary important in these cases.

        Transactions.
            A unit of work in a database.
            A transaction is a sequence of operations that are executed as a single, all-or-nothing unit.
            If any part of the transaction fails, the entire transaction is rolled back and the database is returned to its previous state.
            This is useful for ensuring data consistency and integrity.
            Transactions have some properties, which can be remembered using the acronym ACID:
                Atomicity: can't be broken down into smaller pieces.
                Consistency: should not violate a database constraint.
                Isolation: if multiple users access a database, their transaction cannot interfere with each other.
                Durability: in case of any faliure within the database, all data changed by trasaction will remain.
            To make a transaction:
                BEGIN TRANSACTION;
                    ...
                COMMIT;
            TO revert a transaction we use rollback:
                BEGIN TRANSACTION;
                    ...
                ROLLBACK;
            
            Race Conditions:
                A transaction can help guard against race conditions.
                A race condition occurs when multiple entities simultaneously acces and make decisions based on a shared value, potentially causing inconsistencies in the database.
                To make transactions sequential, SQLite and other database management systems use locks on databases. A table in a database could be in a few different states:
                    UNLOCKED: this is the default state when no user is accessing the database.
                    SHARED: when a transaction is reading data from the database, it obtains shared lock that allows other trasactions to read simultaneously from the database.
                    EXCLUSIVE: if a transaction needs to write or update data, it obtains an exclusive lock on the database that does not allow other transactions to occur at the same time (no even a read).
                    SQLite can lock a database with this command:
                        BEGING EXCLUSIVE TRANSACTION; This way no one could access to the database because is lock.





 
