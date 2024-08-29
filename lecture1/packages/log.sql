
-- *** The Lost Letter ***

-- SELECT "id" FROM "addresses"
-- WHERE "address" = '900 Somerville Avenue';
-- I have this id = 432

-- SELECT "id" FROM "packages"
-- WHERE "from_address_id" = '2 Finnegan Street';
-- This id was not found (it was grown typed at first).

-- SELECT "id", "contents" FROM "packages"
-- WHERE "contents" LIKE '%congratulatory%';
-- I have this keyword "congratulatory" to search something and I find only one answer.
-- Now I have the id of the package = 384.

-- SELECT "address_id" FROM "scans"
-- WHERE "action" = 'Drop' AND "package_id" = 384;
-- Now I have the id of the address so I can find the answers.

SELECT "address", "type" FROM "addresses"
WHERE "id" = (
    SELECT "address_id" FROM "scans"
    WHERE "action" = 'Drop' AND "package_id" = (
        SELECT "id" FROM "packages"
        WHERE "contents" LIKE '%congratulatory%'
    )
);



-- *** The Devious Delivery ***

SELECT "type" FROM "addresses"
WHERE "id" = (
    SELECT "address_id" FROM "scans"
    WHERE "action" = 'Drop' AND "package_id" = (
        SELECT "id" FROM "packages"
        WHERE "from_address_id" IS NULL
    )
)
UNION
SELECT "contents" FROM "packages"
WHERE "from_address_id" IS NULL;


-- *** The Forgotten Gift ***

SELECT "name" FROM "drivers"
WHERE "id" = (
    SELECT "driver_id" FROM "scans"
    WHERE "package_id" = (
        SELECT "id" FROM "packages"
        WHERE "from_address_id" = (
            SELECT "id" FROM "addresses"
            WHERE "address" = '109 Tileston Street'
        )
    ) AND "action" = 'Pick'
    ORDER BY "timestamp" DESC
    LIMIT 1
);