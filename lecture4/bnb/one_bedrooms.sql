CREATE VIEW "one_bedrooms" AS
SELECT "id" AS "id", "property_type" AS "property_type", "host_name" AS "host_name", "accommodates" AS "accommodates" FROM "listings"
WHERE "bedrooms" = 1;