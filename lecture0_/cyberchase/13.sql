SELECT "title", "topic", "air_date" FROM "episodes"
WHERE "air_date" LIKE "%-12-31" OR "%-12-25";