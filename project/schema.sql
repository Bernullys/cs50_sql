-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it

-- Contains each building with the consuption system installed
CREATE TABLE "buildings" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "address" TEXT NOT NULL UNIQUE,
    "administrated_by" TEXT NOT NULL,
    "communal_rooms_amount" INTEGER NOT NULL,
    "departments_amount" INTEGER NOT NULL,
    PRIMARY KEY("id")
);

-- Contains every communal rooms and areas of the building where the electrical consuption is mesured individually
CREATE TABLE "communal_rooms" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "building_id" INTEGER NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("building_id") REFERENCES "buildings"("id")
);

-- Contains the people who owns a department(s)
CREATE TABLE "owners" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "email" TEXT NOT NULL UNIQUE,
    "phone_number" TEXT NOT NULL UNIQUE,
    PRIMARY KEY("id")
);

-- Constains every department in the building
CREATE TABLE "departments" (
    "id" INTEGER,
    "department_number" TEXT NOT NULL,
    "owner_id" INTEGER NOT NULL,
    "building_id" INTEGER NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("owner_id") REFERENCES "owners"."id",
    FOREIGN KEY("building_id") REFERENCES "buildings"."id"
);

-- Contains the devices which takes register of electrical consumtions of communal rooms
CREATE TABLE "communal_divices" (
    "id" INTEGER,
    "type" TEXT NOT NULL CHECK("single_phase", "direct_triphasic", "indirect_triphasic"),
    "serial_number" INTEGER NOT NULL UNIQUE,
    "room_id" INTEGER NOT NULL,
    "building_id" INTEGER NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("room_id") REFERENCES "communal_rooms"."id",
    FOREIGN KEY("building_id") REFERENCES "buildings"."id"
);

-- Contains the devices which takes register of electrical consumtions of departments
CREATE TABLE "departments_divices" (
    "id" INTEGER,
    "type" TEXT NOT NULL CHECK("single_phase", "direct_triphasic", "indirect_triphasic"),
    "serial_number" INTEGER NOT NULL UNIQUE,
    "department_id" INTEGER NOT NULL,
    "building_id" INTEGER NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("department_id") REFERENCES "departments"."id",
    FOREIGN KEY("building_id") REFERENCES "buildings"."id"
);

-- Contains the electrical parameters which the divices takes
CREATE TABLE "communal_electrical_parameters" (
    "id" INTEGER,
    "divice_id" INTEGER NOT NULL,
    "energy_consuption" REAL NOT NULL,
    "voltage" REAL NOT NULL,
    "current" REAL NOT NULL,
    "frecuency" REAL NOT NULL,
    "power" REAL NOT NULL,
    "timestamp" TEXT NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("divice_id") REFERENCES "communal_divices"."id" 
);

-- Contains the electrical parameters which the divices takes
CREATE TABLE "departments_electrical_parameters" (
    "id" INTEGER,
    "divice_id" INTEGER NOT NULL,
    "energy_consuption" REAL NOT NULL,
    "voltage" REAL NOT NULL,
    "current" REAL NOT NULL,
    "frecuency" REAL NOT NULL,
    "power" REAL NOT NULL,
    "timestamp" TEXT NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("divice_id") REFERENCES "departments_divices"."id" 
);
-- Contains the bills for the energy consuption of all communal rooms
CREATE TABLE "communal_bills" (
    "id" INTEGER,
    "month" TEXT NOT NULL,
    "year" TEXT NOT NULL,
    "month_energy_consumption" REAL NOT NULL,
    "total_energy_consumption" REAL NOT NULL,
    "communal_room_divece_id" INTEGER NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("communal_room_device_id") REFERENCES "communal_electrical_parameters"."divice_id"
);

-- Contains the bills for the energy consuption of all departments
CREATE TABLE "departments_bills" (
    "id" INTEGER,
    "month" TEXT NOT NULL,
    "year" TEXT NOT NULL,
    "month_energy_consumption" REAL NOT NULL,
    "total_energy_consumption" REAL NOT NULL,
    "department_divece_id" INTEGER NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("department_device_id") REFERENCES "departments_electrical_parameters"."divice_id"
);