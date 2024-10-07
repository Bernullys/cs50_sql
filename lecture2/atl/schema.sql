CREATE TABLE "passenger"(
    "id" INTEGER,
    "first_name" TEXT,
    "last_name" TEXT,
    "age" INTEGER,
    PRIMARY KEY("id")
);

CREATE TABLE "check_in"(
    "checked_in" NUMERIC DEFAULT CURRENT_TIMESTAMP,
    "flight" TEXT,
    "passenger_id" INTEGER,
    FOREIGN KEY("passenger_id") REFERENCES "passenger"("id")
);

CREATE TABLE "airlines"(
    "id" INTEGER,
    "airline_name" TEXT,
    "concourse" TEXT NOT NULL CHECK("concourse" IN ("A", "B", "C", "D", "E", "F", "T")),
    PRIMARY KEY("id")
);

CREATE TABLE "flights"(
    "flight" NUMBER,
    "airline_id" TEXT,
    "departing_from" TEXT,
    "heading_to" TEXT,
    "departure_date" CURRENT_TIMESTAMP,
    "arrival_date" CURRENT_TIMESTAMP,
    FOREIGN KEY("airline_id") REFERENCES "airlines"("id"),
    FOREIGN KEY("flight") REFERENCES "check_in"("flight")
);
