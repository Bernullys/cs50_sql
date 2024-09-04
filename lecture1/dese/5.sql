SELECT "city", COUNT(*) AS "Amount of public schools" FROM "schools"
WHERE "type" = 'Public School'
GROUP BY "city"
HAVING "Amount of public schools" <= 3
ORDER BY "Amount of public schools" DESC, city;