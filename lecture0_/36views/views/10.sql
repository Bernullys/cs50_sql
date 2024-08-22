SELECT "id", "artist", "entropy", "english_title" AS "More entropy Pictures" FROM "views"
WHERE "entropy" > 7.6
ORDER BY "entropy" DESC;