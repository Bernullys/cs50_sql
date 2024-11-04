CREATE VIEW "frequently_reviewed" AS
SELECT "listings"."id" AS "id", "property_type" AS "property_type", "host_name" AS "host_name", "listing_id" AS "reviews" FROM "listings"
JOIN "reviews" ON "reviews"."listing_id" = "listings"."id"
GROUP BY "reviews"
ORDER BY "reviews" DESC, "property_type", "host_name"
LIMIT 100;