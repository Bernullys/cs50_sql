-- SELECT "id" FROM "addresses"
-- WHERE "address" = '900 Somerville Avenue';
-- I have this id = 432

-- SELECT "id" FROM "packages"
-- WHERE "from_address_id" = '2 Finnegan Street';
-- This id was not found (it was grown typed at first).

-- SELECT "id", "contents" FROM "packages"
-- WHERE "contents" LIKE '%congratulatory%';
-- I have this keyword to search something and I find only one answer.
-- Now I have the id of the package = 384.

-- SELECT "address_id" FROM "scans"
-- WHERE "action" = 'Drop' AND "package_id" = 384;
-- Now I have the id of the address so I can find the answers.


-------------------------------------------------------------------------------------
-- package id = 5098 and contents = Duck debugger
-- SELECT "id", "contents" FROM "packages"
-- WHERE "from_address_id" IS NULL;

-- address of drop id = 348
-- SELECT "address_id" FROM "scans"
-- WHERE "action" = 'Drop' AND "package_id" = 5098;

-- type of address where the package was drop = Police Station
-- SELECT "type" FROM "addresses"
-- WHERE "id" = 348;


---------------------------------------------------------------------------------------
--I have this id = 4983
-- SELECT "id" FROM "addresses"
-- WHERE "address" = '728 Maple Place'
-- UNION
-- SELECT "id" FROM "addresses"
-- WHERE "address" = '109 Tileston Street';
--I have this id = 9873


-- I know what is the contents, and the id of the package.

-- SELECT "driver_id" FROM "scans"
-- WHERE "package_id" = 9523 AND "action" = 'Pick'
-- ORDER BY "timestamp" DESC
-- LIMIT 1;
-- Now I have the id of the driver who was the last one on picking the package.


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