CREATE VIEW "available" AS
SELECT "listings"."id" AS "id", "property_type" AS "property_type", "host_name" AS "host_name", "date" AS "date" FROM "listings"
JOIN "availabilities" ON "availabilities"."listing_id" = "listings"."id"
WHERE "available" = 'TRUE';