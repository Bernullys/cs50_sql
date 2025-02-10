CREATE TABLE "molds_table" (
    "mold_id" INTEGER PRIMARY KEY,
    "mold_type" TEXT NOT NULL,
    "mold_description" TEXT NOT NULL,
    "principal_cable_section" TEXT NOT NULL,
    "principal_cable_code" TEXT NOT NULL,
    "secondary_cable_section" TEXT NOT NULL,
    "secondary_cable_code" TEXT NOT NULL,
    "charge" TEXT NOT NULL,
    "disc" TEXT NOT NULL
);

INSERT INTO molds_table (mold_type, mold_description, principal_cable_section, principal_cable_code, secondary_cable_section, secondary_cable_code, charge, disc) VALUES ('CC-L', 'Unión Cable-Cable TEE Horizontal', '4', 'B', '4', 'B', 'C32', 'D14');