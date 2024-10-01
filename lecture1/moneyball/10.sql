-- first name, last name, salary, HR, year

SELECT "first_name", "last_name", "salary", "HR", "performances"."year" FROM "players"
JOIN "salaries" ON "salaries"."player_id" = "players"."id"
JOIN "performances" ON "performances"."player_id" = "players"."id"
WHERE "salaries"."year" = "performances"."year"
ORDER BY "players"."id", "performances"."year" DESC, "HR" DESC;