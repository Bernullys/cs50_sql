CREATE VIEW "rural" AS
SELECT "locality" FROM "census"
WHERE "locality" LIKE '%rural%';