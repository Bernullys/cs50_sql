
SELECT "city", COUNT(*) AS "Amount of Public Schools" FROM "schools"
WHERE "type" = 'Public School'
GROUP BY "city"
ORDER BY "Amount of Public Schools" DESC, "city"
LIMIT 10;
