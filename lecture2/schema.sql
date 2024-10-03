CREATE TABLE "riders" (
    "id" INTEGER,
    "name" TEXT,
    PRIMARY KEY("id")
);

CREATE TABLE "stations"(
    "id" INTEGER,
    "name" TEXT NOT NULL UNIQUE,
    "line" TEXT NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE "visits" (
    "rider_id" INTENGER,
    "station_id" INTEGER,
    FOREING KEY("rider_id") REFERENCES "riders"("id"),
    FOREIGN KEY("station_id") REFERENCES "stations"("id")
);

-- To .read this .schema I have to read the sql file (won't show nothing) and then use the command .schema (will show this schema)

-- In the visits table, there is no primary key. However, SQLite gives every table a primary key by default, known as the row ID. Even though the row ID is implicit, it can be queried!

-- It is also possible to create a primary key composed of two columns. For example, if we wanted to give visits a primary key composed of both the rider and stations IDs, we could use this syntax.
    -- CREATE TABLE visits (
    --  "rider_id" INTEGER,
    --  "station_id" INTEGER,
    --  PRIMARY KEY("rider_id", "station_id")
    -- );