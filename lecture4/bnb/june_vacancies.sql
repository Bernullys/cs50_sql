CREATE VIEW "june_vacancies" AS
SELECT "listings"."id" AS "id", "property_type" AS "property_type", "host_name" AS "host_name", "available" AS "days_vacant" FROM "listings"
JOIN "availabilities" ON "availabilities"."listing_id" = "listings"."id"
WHERE "available" = 'TRUE' AND "date" LIKE '2023-06-__'
GROUP BY "listings"."id";