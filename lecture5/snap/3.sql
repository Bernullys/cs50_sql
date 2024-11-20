EXPLAIN QUERY PLAN
SELECT "to_user_id", COUNT(*) AS "messages_number" FROM "messages"
WHERE "from_user_id" = (
    SELECT "id" FROM "users"
    WHERE "username" = 'creativewisdom377'
)
GROUP BY "to_user_id"
ORDER BY "messages_number" DESC
LIMIT 3;
