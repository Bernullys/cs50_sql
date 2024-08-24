SELECT "first_name", "last_name" FROM "players"
WHERE ("birth_country" = "Venezuela") AND ("debut" > "2020-01-01")
ORDER BY "last_name";