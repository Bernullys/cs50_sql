CREATE TABLE "users"(
    "id" INTEGER,
    "first_name" TEXT,
    "last_name" TEXT,
    "password" NUMERIC,
    PRIMARY KEY("id")
);

CREATE TABLE "schools"(
    "id" INTEGER,
    "name" TEXT,
    "type" TEXT NOT NULL CHECK("type" IN ("Elementary School", "Middle School", "High School", "Lower School", "Upper School", "College", "University", "Other")),
    "address" TEXT,
    "founded_year" INTEGER,
    "alumni_id" INTEGER,
    PRIMARY KEY("id")
);

CREATE TABLE "schools_connections"(
    "id" INTEGER,
    "school_id" INTEGER,
    "alumni_id" INTEGER,
    "alumni_affiliation",
    "alumni_degree" TEXT CHECK("alumni_degree" IN ("BA", "MA", "PhD", "Other")),
    PRIMARY KEY("id"),
    FOREIGN KEY("school_id") REFERENCES "schools"("id"),
    FOREIGN KEY("alumni_id") REFERENCES "users"("id")
);

CREATE TABLE "companies"(
    "id" INTEGER,
    "name" TEXT,
    "type" TEXT NOT NULL CHECK("type" IN ("Education","Technology","Finance","Other")),
    "address" TEXT,
    PRIMARY KEY("id")
);

CREATE TABLE "companies_connections"(
    "id" INTEGER,
    "company_id" INTEGER,
    "employ_id" INTEGER,
    "employ_start_date" TIMESTAMP,
    "employ_end_date" TIMESTAMP,
    "employ_title" TEXT,
    PRIMARY KEY("id"),
    FOREIGN KEY("company_id") REFERENCES "companies"("id"),
    FOREIGN KEY("employ_id") REFERENCES "users"("id")
);