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
                - Now I can run in the Terminal: sqlite3 database_name.db and will go to the sqlite enviroment. To exit use the
                command .quit.
                - Then I can type the SQL code.
                - This command: cat file_name.sql | sqlite3 database_name.db > output.txt will run directly in the Terminal the
                SQL code in file_name.sql and put the output in a file called output.txt.

    LIMIT keyword limit the number of rows to output.
    SELECT "column1", FROM "database" 
    LIMIT 5;

    LIMIT can accept two arguments. The first one is from which row starts and the second is the limit.

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

    AS keyword can be ommited. Is implicit.

    SELECT COUNT(*) FROM "longlist"; will output the number of rows of the table.

    DISTINCT keyword returns distincts results.
    SELECT COUNT(DISTINCT "publisher")
    FROM "longlist";


Lecture 1 - Relating

    One to one.
    One to many.
    Many to many.

    Entity ralationship diagrams (ER Diagrams).
    In the project desription is a link where we can design ERD images.

    Keys
    Is an identifier that is unique for every item in a table.

    Foreing Keys
    Is a primary key taken from a different table. By referencing the primary key of a different table,
    it helps relate the tables by forming a link between them.


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

    INNER JOIN return colums that are the same on both tables. 
    
    OUTER JOIN returns all colums of the left or right. It work with this syntax:
    (left is the from table)
    LEFT JOIN    ===   LEFT OUTER JOIN
    RIGHT JOIN   ===   RIGHT OUTER JOIN
    
    FULL JOIN       

    NATURAL JOIN
    Allows to omit the part of my previous JOINs (from ON forwards).
    Also assume that the columns with the same name and values want to be join.
    SELECT *
    FROM "sea_lions"
    NATURAL JOIN "migrations";

    We can join multiple tables together if we have comun colums between them.


    Sets
    Sets are tables that results from queries.

    SELECT 'author' AS "profession", "name" FROM "authors"; Important to know. OJO.

    UNION
    UNION by default is UNION DISTINCT
    But there is also UNION ALL which union everything

    SELECT 'author' AS "profession", "name"
    FROM "authors"
    UNION
    SELECT 'translator' AS "profession", "name"
    FROM "translators";

    SELECT "first_name", "last_name", 'Old' AS "Label"
    FROM "employee_demographics
    WHERE age > 50
    UNION
    SELECT "first_name", "last_name", 'Highly Paid Employee' AS "Label"
    FROM "employee_salary"
    WHERE "salary" > 7000000
    GROUP BY "first_name", "last_name";

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

Lecture 2 - Designing

    SQLite command (not keyword) .schema shows how a data base was created.
    .schema table_name will show only the schema of that table.

    Creating a Database Schema:
    To create a table we have to decide:
        What kinds of tables we will have in our database,
        What columns each of the tables will have, and
        What types of data we should put in each of those columns.

    Normalizing:
    The process of separating our data is called normalizing. When normalizing we put each entity
    in its own table. Any specific entity, goes into the entity's own table.

    Relating:
    We have to decide how our entities are related.
    We can also use an ER diagram to represesnt this relationship.

    CREATE TABLE
    To create a table I have to type sqlite3 database_name.db. This will create a file called data_base.db.
    Then we have to read the schema.sql file which contains the commands to create tables.
    Don't work using touch database_name.db.
    And then the command CREATE TABLE... is typed in the command line.

                sqlite> CREATE TABLE "stations" (
        ...>     "id",
        ...>     "name",
        ...>     "line"
        ...> );

    Then we create a table to relate entities. These tables are often called junction tables, associative entities
    or join tables.

    Data Types and Storage Classes:
    SQLite has five storage classes:
        Null: nothing, or empty value
        Integer: numbers without decimal points
        Real: decimal or floating point numbers
        Text: characters or strings
        Blob: Binary Large Object, for storing objects in binary (useful for images, audio etc.)
        Any
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
    SQLite takes care of storing the input value under the right data type. In other words, we as programmers
    only need to choose a storage class and SQLite will do the rest!

    A workaround could be to use 0 or 1 integer values to represent booleans.

    Type Affinities:
     It is possible to specify the data type of a column while creating a table.
    However, columns in SQLite don’t always store one particular data type. They are said to have type affinities,
    meaning that they try to convert an input value into the type they have an affinity for.
    The five type affinities in SQLite are: Text, Numeric (either integer or real values based on what the input
    value best converts to), Integer, Real and Blob.
    Consider a column with a type affinity for Integers. If we try to insert “25” (the number 25 but stored as text)
    into this column, it will be converted into an integer data type.
    Similarly, inserting an integer 25 into a column with a type affinity for text will convert the number to its text
    equivalent, “25”.

    Adding Types to our Tables:
    Command to delete tables:
    DROP TABLE "table_name";
    (Whatch schema.sql file).

    Table Constraints:
    We can use table constraints to impose restrictions on certain values in our tables.
    For example, a primary key column must have unique values. The table constraint we use for this is PRIMARY KEY.
    Similarly, a constraint on a foreign key value is that it must be found in the primary key column of the related table!
    This table constraint is called, predictably, FOREIGN KEY.

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
        (),
        (),
        ();
    
        Data could also be stored in a csv format.
        First we have to start from zero, create a database file and import the file we the data:
            .import --csv --skip 1 csv_file.csv table_name
            --skip 1 is to avoid adding the first row of the csv file but this is when we already have the
            table with the column names.
        
        If we have a data form in a csv without an id column, we can do it in a different way. We will use 
        a temporary table:
            .import --csv csv_file.csv temporary_table
            This time we won't need to skip line 1 because this way is reconized as the column names.
        Next, we will select the data(without primary keys) from temporary_table and move it to out table_name,
        which was the goal all along.
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

        There might be cases where deleting some data could impact the integrity of a database. Foreign key 
        constrains are a good example. A foreign key column references the primary key of a different table. If we 
        were to delete the primary key, the foreign key column would have nothing to reference. Traying to delete
        this we get an error. This error notifies us that deleting this data would violate the foring key constraint
        set up in the table.
        One possibility is to delete the corresponding rows from the connections_table and then deleting from the other
        table.

        In another possibility, we can specify the action to be taken when an ID referenced by a foreign key is deleted.
        To do this, we use the keyword ON DELETE followed by the action to be taken.
            ON DELETE RESTRICT: This restricts us from deleting IDs when the foreign key constraint is violated.
            ON DELETE NO ACTION: This allows the deletion of IDs that are referenced by a foreign key and nothing happens.
            ON DELETE SET NULL: This allows the deletion of IDs that are referenced by a foreign key and sets the foreign
            key references to NULL.
            ON DELETE SET DEFAULT: This does the same as the previous, but allows us to set a default value instead of NULL.
            ON DELETE CASCADE: This allows the deletion of IDs that are referenced by a foreign key and also proceeds to
            cascadingly delete the referencing foreign key rows. 
            For example, if we use this to delete an artist ID, all the artist’s affiliations with the artwork would also be
            deleted from the table.

            Example: (This is done when Designing the Tables, is a constrains)
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

        Is a tecnique to don't delete data, instead we update data and we add a column where we can keep track of
        the data we mark as deleted. Then we could select the data deleted or not if we want.

    
    NOTE: terminal command that is handy when we want to run a sql file which has a command that are not sqlite code
    (like problem Meteorite Cleaning).
            cat file_name.sql | sqlite3 data_base_name.db
            cat file_name.sql outputs the data in file_name.sql.
            sqlite3 data_base_name.db opens a file called data_base_name.db with the sqlite3 engine, as we’re already
            familiar with.


Lecture 4 - Viewing

    Views:
        A View is a virtual table defined by a query. This new table can be queried later on.
        Views are useful for:
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

        CTEs - Common Table Expression:
            A regular view exists forever in our database. A temporary view exist for the duration of our connection
            with the database. A CTE is a view that exist for a single query alone.
            A CTE is defined by a query and can be used in a query.
            This is the form:

                WITH "cte_name" AS (
                    SELECT ...
                ), ...
                SELECT ... FROM "cte_name";

            The idea is to make a table created with keyword WITH ... and then make a query:
            
            Example:
                WITH "average_book_ratings" AS (
                SELECT "book_id", "title", "year", ROUND(AVG("rating"), 2) AS "rating" FROM "ratings"
                JOIN "books" ON "ratings"."book_id" = "books"."id"
                GROUP BY "book_id"
                )
                SELECT "year" ROUND(AVG("rating"), 2) AS "rating" FROM "average_book_ratings"
                GROUP BY "year";

            We can use CTE for readiability. It's a better way for Subqueries.
            We can create more than 1 CTE like:

                WITH "cte_name1" AS (
                    all the queries
                ),
                "cte_name2" AS (
                    all the others queries
                )
                SELECT *
                FROM "cte_name1"
                JOIN "cte_name2" ON "cte_name1"."some_id" = "cte_name2"."some_id";

            Another thing we can do is set the alias of the CTE columns between parenthisis after the CTE name:

                WITH "cte_example" ("Gender", "Salary") AS (
                    SELECT COUNT("gender"), AVG("salary)
                    ...
                )
                ...

                This will named the colums of the output.


        Partioning:
            With the same approach as simplifying and aggregating but to our conviniance we can partion tables
            to be better manipulated.
        
        Securing:
            Some information in tables could be categorized as Personally Identifiable Information (PII) which
            companies are not allowed to share indiscriminately.
            We can create a view that does not contains this type of information but SQLite3 does not allow access
            control. This means that someone simply query the original table and see all the information.
            
            Example:
                CREATE VIEW "analysis" AS
                SELECT "id", "origin", "destination", 'Anonymous' AS "rider"
                FROM "rides";

        Solf Deletions:
            As we saw in previous weeks, a solf deletion involves marking a row as deleted insted of removing it
            from the table.
            We can create a view that shows only the rows that are not marked as deleted. And had that view which
            will be showing the rows which aren't mark as deleted in the real table with each solf deletion.
            
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

    SqLite has a command .timer which enable us to time our queries.
    To find the size of a database on the terminal, we can use a Unix command: du -b database_name.db

    Index.
        The same way that textbooks often have an index, databases tables can have an index as well.
        An index is a structure used to speed up the retrieval of rows from a table.
        Index's comes with trade-offs with space and the time it takes to later insert data into tables.
        To create an index:
            CREATE INDEX "index_name" ON "table_name" ("column_name", ...);

        Index across Multiple Tables.
        To understand what kind of index could help speed this query up, we can run EXPLAIN QUERY PLAB
        ahead of the query.
            EXPLAIN QUERY PLAN
            SELECT ...; (nested queries).
            When we run explain query plan we can see if the queries and sub queries are done by search
            or scan. Scan is slower so the idea is to add indexes to the queries which are on scans.
        
        Covering Index: An index in which queried data can be retrived from the index itself.
        A covering index is a special type of index that includes all columns needed for the query. This
        means the database can fulfill the query directly from the index without having to look up additional
        data in a table.

        Space Trade-off.
            Indexes seem incredibly helpful, but there are trade-off associated - they occupy additional space
            in the database, so while we gain query speed, we do lose space.
            An index is stored in a database as a data structure called a B-Tree, or balanced tree.
        TIme Trade-off.
            Similar to the space trade-off, it also takes longer to insert data into a column and then add it to
            an index. Each time a value is added to the index, the B-tree needs to be traversed to figure out where
            the value should be added.
        
    Partial Index.
        This is an index that includes only a subset of rows from a table, allowing us to save some space that a
        full index would occupy.
        This is especially useful when we know the users query only a subset of rows fron the table.
        Example:    CREATE INDEX "recents" ON "movies" ("titles")
                    WHERE "year" = 2023;

    Vaccum.
        There are ways to delete unused space in out database. Sqlite allows us to "vacuum" data -  this cleans up
        previously deleted data (that is actually no deleted, but just marked as space being available for the next
        INSERT).
        Run:
            VACCUM;
        
    Concurrency.
        Concurrency is the simultaneous handling of multiple queries or interactions by the database. Imagine a database
        for a website, or a finalcial service, that gets a lot of traffic at the same time. Concurrency is particulary
        important in these cases.

        Transactions.
            A unit of work in a database.
            A transaction is a sequence of operations that are executed as a single, all-or-nothing unit.
            If any part of the transaction fails, the entire transaction is rolled back and the database is returned
            to its previous state.
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
            To revert a transaction we use rollback:
                BEGIN TRANSACTION;
                    ...
                ROLLBACK;
            
            Race Conditions:
                A transaction can help guard against race conditions.
                A race condition occurs when multiple entities simultaneously acces and make decisions based on a
                shared value, potentially causing inconsistencies in the database.
                To make transactions sequential, SQLite and other database management systems use locks on databases.
                A table in a database could be in a few different states:
                    UNLOCKED: this is the default state when no user is accessing the database.
                    SHARED: when a transaction is reading data from the database, it obtains shared lock that allows
                    other trasactions to read simultaneously from the database.
                    EXCLUSIVE: if a transaction needs to write or update data, it obtains an exclusive lock on the
                    database that does not allow other transactions to occur at the same time (no even a read).
                    SQLite can lock a database with this command:
                        BEGING EXCLUSIVE TRANSACTION; This way no one could access to the database because is lock.

Lecture 6 - Scaling.

    Scalability is the ability to increase or decrease the capacity of an application or database to meet demand.

    MySQL.
        I have to install it with: sudo apt install mysql-server.
        I can go into mysql enviroment using: sudo mysql.
        Also I can do: 
        cat /etc/mysql/debian.cnf
        and find the debian password and go in with that using: mysql -u debian-sys-maint -p.

        Commands: 
            SHOW DATABASES; There will be default databases in the server.
            USE database_name;
            SHOW TABLES;
            DESCRIBE `table_name`;
            CREATE USER 'user_name' IDENTIFIED BY 'password';

        Type in the terminal:
            mysql -u root -h 127.0.0.1 -P 3306 -p (I set a password to enter this way).
                -u indicates the user. We provide the user we want to connect to the database as — root 
                (synonymous with database admin, in this case).
                
                127.0.0.1 is the address of local host on the internet (our own computer).
                
                3306 is the port we want to connect to, and this is the default port where MySQL is
                hosted. Think of the combination of host and port as the address of the database we are trying
                to connect to!
                
                -p at the end of the command indicates that we want to be prompted for a password when connecting.
        
        MySQL does have data types, like INT and VARCHAR but unlike SQLite, it will not allow us to enter data of
        a different type and try to convert it.

        Integer data types:
        Size and Range of numbers we can store in each of the integer types:
            Data Type   Size(in Bytes)  Minimum Value (signed)  Maximum Value (signed)
            TYNYINT     1               -128                    127
            SMALLINT    2               -32768                  32767
            MEDIUMINT   3               -8388608                8388607
            INT         4               -2147483648             2147483647
            BIGINT      8               -2^63                   2^63 -1

        We can explicity make a data type an unsigned integer by adding the keyword UNSIGNED while creating
        the integer.

        Strings data types:
            CHAR(M)
            VARCHAR(M)
        
        Text data types:
            TEXT (for large text):
                TYNYTEXT, TEXT, MEDIUMTEXT, LONGTEXT.

        Others data types:
            BLOB
            ENUM
            SET
        
        Data types for storing dates and times:
            DATE 
            YEAR 
            TIME(fsp)           fsp = fractional seconds precision
            DATETIME(fsp)
            TIMESTAMP(fsp)
        
        Real Numbers        Size(in Bytes)
        FLOAT               4
        DOUBLE PRECISION    8
        
        Fixed precision type: With this, we would specify the number of digits in the number to be represented, and
        the number of digits after the decimal point.
            Example: DECIMAL(6,3)


        CREATE DATABASE `database_name`;
        Creating tables:
            Example:
                CREATE TABLE `cards` (
                    `id` INT AUTO_INCREMENT,
                    PRIMARY KEY(`id`)
                );
            Example:
                CREATE TABLE `stations` (
                    `id` INT AUTO_INCREMENT,
                    `name` VARCHAR(32) NOT NULL UNIQUE,
                    `line` ENUM('blue', 'green', 'orange', 'red') NOT NULL,
                    PRIMARY KEY(`id`)
                );
            Example:
                CREATE TABLE `swipes` (
                    `id` INT AUTO_INCREMENT,
                    `card_id` INT,
                    `station_id` INT,
                    `type` ENUM('enter', 'exit', 'deposit') NOT NULL,
                    `datetime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                    `amount` DECIMAL(5,2) NOT NULL CHECK(`amount` != 0),
                    PRIMARY KEY(`id`),
                    FOREIGN KEY(`station_id`) REFERENCES `stations`(`id`),
                    FOREIGN KEY(`card_id`) REFERENCES `cards`(`id`)
                );
        
        Altering Tables:
            ALTER TABLE `table_name`
            MODIFY ...;

            Example:
                ALTER TABLE `stations` 
                MODIFY `line` ENUM('blue', 'green', 'orange', 'red', 'silver') NOT NULL;
            
        Store Procedures:
            Store procedures are a way to automate SQL statements and run them repeatedly.
            See the hole example and explination at the lecture, to understand better.
            CREATE PROCEDURE `procedure_name`()
            BEGIN
            ...
            END;

        Stored Procedures with Parameters:
            Same here, see the lecture to understand.
            CREATE PROCEDURE `porcedure_name`(parameters)
            BEGIN
            ...
            END;
            We can use here:
                IF; ELSEIF; ELSE
                LOOP
                REPEAT
                WHILE
                ...

    PostgreSQL:

        Some commands:
            (Look out how to install and log).
            \l      to view all the databases.
            \c "database_name" to connect to a specific database.
            \dt to list out all the tables in a database.
            \d "table_name" to describe a table.

        Integer data types:
        Data Type       Size(Bytes)     Minimum Value(signed)       Maximum Value (signed)
        SMALLINT        2               -32768                      32767
        INT             4               -2147483648                 2147483647
        BIGINT          8               -2^63                       2^63 -1

        Serial data types: Serials are also integers, but they are serial numbers, usually used for primary keys.
        SMALLSERIAL
        SERIAL
        BIGSERIAL

        Look out for others data types: some are very similar to MySql.
            VARCHAR(M)
            ENUM(...,...)
            TIMESTAMP(p)        p = precision
            DATE
            TIME(p)
            INTERVAL(p)
            MONEY
            NUMERIC(precision, scale)

        To create a database:
            CREATE DATABASE "database_name";
        
        To create tables:
            CREATE TABLE "table_name" (
                "colum_name" Constraints,
                ...
            );
    
    Scaling.
        Vertical Scaling:
            Increasing capacity by increasing a server's computing power.
        Horizontal Scaling:
            Increasing capacity by distributing load across multiple servers. When we scale horizontally, we
            keep copies of our database on multiple servers (replication).
        Replication:
            Keeping copies of a database on multiple servers.
            There are several models of replication, but these three are the main ones:
                Single-leader.
                Multi-leader.
                Leaderless.
            
            Read Replica:
                A copy of a database from which data may only be read. This is used on single-leader model of
                replication.
            
            Synchronous replication:
                Once the leader processes a write request, it could wait for the followers to replicate changes
                before doing anything else.
                While this ensures the database is always consistent, it may be too slow in responding to queries.
                In applications like finance or healthcare, where data consistency is extremely important, we might
                choose this kind of communication despite the disadvantages.
            Asynchronous replication:
                The leader communicates with follower databases asynchronously to ensure chaanges are replicated. This
                method could be used in social media applications, where speed of response is extremely important.
        
        Sharding:
            This involves splitting the database into shards across multiple database servers. A word of caution
            with sharding: we want to avoid having a database hotspot, or a database server that becomes more
            frequently accessed than others. This could create an overload on that server. Also sharding without
            replication, if one of the servers goes down, we will have an incomplete database. This creates a single
            point of failure: if one system goes down, or entire system is not usable.

    
    Access Control: (MySQL)
        CREATE USER 'user_name' IDENTIFIED BY 'password';
        GRANT privilege ON `database_name`.`table_name` TO 'user_name'; 
        REVOKE privilege ON `database_name`.`table_name` FROM 'user_name'; 

        privilege can be: ALL, CREATE, INSERT, SELECT, UPDATE, DELETE ...
    
    SQL Injection Attacks:
        This involves a malicious user injecting some SQL phrases to complete an existing query within our
        application in an undesirable way.

    Prepared Statements:
        Is a statement in SQL that we can later insert values into.
        PREPARE `statement_name` FROM 'statement';

        Example:
            PREPARE `balance_check` FROM 'SELECT * FROM `accounts` WHERE `id` = ?';
            The question mark in the prepared statement acts as a safeguard against the unintended execution
            of SQL code.

        SET @id = 1;
        EXECUTE `balance_check` USING @id;

        In the above code, imagine the SET statement to be procuring the user's ID through the application!
        The @ is a canvention for variables in MySQL.

MySQL Workbench Notes from Bro Code.

    CREATE DATABASE database_name;

    DROP DATABASE database_name; Is the same to drop a table and to a column to.

    To read only a database:
    ALTER DATABASE database_name READ ONLY = 1;

    To change read only:
    ALTER DATABASE database_name READ ONLY = 0;

    To crate tables on a specific DB I have to right click the DB and set
    as default schema.

    Rename table:
    RENAME TABLE table_name TO new_table_name;

    ALTER TABLE table_name
    ADD column DataType;

    To rename a column:
    ALTER TABLE table_name
    RENAME column_name TO new_name;

    To modify a datatype:
    ALTER TABLE table_name
    MODIFY COLUMN column_name new_data_type;

    Change the position of a column:
    ALTER TABLE table_name
    MODIFY column_n data_type
    AFTER column_m;
    If we want tha column to be first we can type directly FIRST.

    AUTOCOMMIT / COMMIT / ROLLBACK
    By default autocommit is ON so every operation get save right away, but we can set autocommit off:
    SET AUTOCOMMIT = OFF;
    Then operations to be saved have to be commited manually:
    COMMIT;
    So if we want to go back to undo some operation, we can use:
    ROLLBACK;


MySQL notes from Alex The Analyst:

    String functions:
        LENGTH('string_data')
        Example:
        SELECT first_name, LENGTH(first_name)
        FROM table_name;

        UPPER('sky') will return the string all captital
        LOWER('SKY')
        TRIM('     sky ')
        LTRIM('sky      ')
        RTRIM('   sky')

        LEFT(first_name, n) where n is the number of characters at left.
        RIGHT(first_name, n) where n is the number of characters at right.

        SUBSTRING(first_name,p,n) where p is position and n is the number of characters to select.

        SELECT first_name, REPLACE(first_name, 'a', 'b') replaces the character a with the b.

        SELECT LOCATE('e', 'Bernardo') will return the index where is located
        SELECT first_name, LOCATE('er', first_name) will return the number of er has the first_name

        CONCAT returns the data of two columns in only one column.
        SELECT first_name, last_name,
        CONCAT(first_name, ' ' ,last_name)
        FROM table_name;
    
    CASE Statements allow us to use logic

        Examples:
        SELECT first_name, last_name, age,
        CASE
            WHEN age <= 40 THEN 'Young'
            WHEN age BETWEEN 41 and 70 THEN 'Old'
            WHEN age >= 70 THEN 'Dont work'
        END AS Age_Bracket
        FROM employee_demographics;


        SELECT first_name, last_name, salary, department_name,
        CASE
            WHEN salary <= 50000 THEN salary * 1.05
            WHEN  salary > 50000 THEN salary * 1.07
        END AS New_Salaries,
        CASE
            WHEN  department_name = 'Finance' THEN salary * 1.1
        END AS Bonus
        FROM employee_salary
        JOIN parks_departments ON parks_departments.department_id = employee_salary.dept_id;

    Window functions:
        It's some like GROUP BY but don't return only a row but multiple

        OVER()

        Example: This will return the average over everything
            SELECT gender, AVG(salary) OVER()
            FROM employee_demographics dem
            JOIN employee_salary salary ON dem.employee_id = sal.employee_id;

            This will return the average by gender
            SELECT gender, AVG(salary) OVER(PARTITION BY gender)
            FROM employee_demographics dem
            JOIN employee_salary salary ON dem.employee_id = sal.employee_id
            GROUP BY gender;

            This is useful when using other data and had the agregate value on each row.

            SELECT dem.first_name, dem.last_name, gender,
            SUM(salary) OVER(PARTITION BY gender)
            FROM employee_demographics dem
            JOIN employee_salary salary ON dem.employee_id = sal.employee_id;

            rolling total application:

            SELECT dem.first_name, dem.last_name, gender,
            SUM(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id) AS Rolling_total
            FROM employee_demographics dem
            JOIN employee_salary salary ON dem.employee_id = sal.employee_id;

        ROW_NUMBER()

            SELECT dem.employee_id, dem.first_name, dem.last_name, gender, salary,
            ROW_NUMBER() OVER()   -- This is a column counting from one (similar to id)
            FROM employee_demographics dem
            JOIN employee_salary salary ON dem.employee_id = sal.employee_id;

            SELECT dem.employee_id, dem.first_name, dem.last_name, gender, salary,
            ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC)
            FROM employee_demographics dem
            JOIN employee_salary salary ON dem.employee_id = sal.employee_id;

        RANK() and DENSE_RANK

            SELECT dem.employee_id, dem.first_name, dem.last_name, gender, salary,
            ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num, -- dont repeat
            RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_num,      -- repeat equals and leave space
            DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS dense_rank_num, -- repeat equals and dont leave space
            FROM employee_demographics dem
            JOIN employee_salary salary ON dem.employee_id = sal.employee_id;

    Temporary tables:
        We can use these tables while we have a session open.

        This way if we are inserting data:

        CREATE TEMPORARY TABLE table_name (
            f_n VARCHAR(30),
            l_n VARCHAR(30),
            ...
        )

        But we can select part of data from another table:

        CREATE TEMPORARY TABLE table_name
        SELECT column1
        FROM  existing_table
        Where something_happen;

    Stored Procedures: are way to save our SQL code and use it over and over again. It's like functions on other languages.

        DELIMITER $$
        CREATE PROCEDURE procedure_name()
        BEGIN
            SELECT ...
            ... ;
            SELECT ...
            ... ;
        END $$
        DELIMITER ;

        Then we can call the procedure:

        CALL procedure_name();

        We can create stored procedures in Workbench in that section.
        Procedures like function can have parameters. The same way.

    Triggers:

        DELIMITER $$
        CREATE TRIGGER trigger_name
            AFTER/BEFORE INSERT/DELETE/UPDATE ON table_name
            FOR EACH ROW
        BEGIN
            ... code of what we want to happen ...;
        END $$
        DELIMITER ;

    Events:
        Triggers happen when an event take place but an event take place when schedule.

        Example: 

        DELIMITER $$
        CREATE EVENT event_name
        ON SCHEDULE EVERY 30 SECOND
        DO
        BEGIN
            DELETE
            FROM table_name
            WHERE column_n >= 100;
        END $$
        DELIMITER ;

        To ensure the event is working:
        SHOW VARIABLES LIKE 'event%';
        And to ensure we have permission to delete or something in the Workbench we can check on Workbench Preferences.

    Project Cleanind_data (All notes in data_cleaning.sql)
    Project Exploratory Data Analysis.
            