-- List all departments in a specific building

SELECT "department_number" FROM "departments"
JOIN "buildings" ON "buildings"."id" = "departments"."building_id"
WHERE "name" = 'Belisario Prats';

-- Find a total energy consumption of a specific communal room

SELECT "communal_rooms"."name", SUM("communal_electrical_parameters"."energy_consumption") AS "Total_Energy"
FROM "communal_rooms"
JOIN "communal_divices" ON "communal_divices"."room_id" = "communal_rooms"."id"
JOIN "communal_electrical_parameters" ON "communal_electrical_parameters"."divice_id" = "communal_divices"."id"
WHERE "communal_rooms"."name" = 'Gym'
GROUP BY "communal_rooms"."name";

-- Get owner details for a specific department

SELECT "first_name", "last_name", "email", "phone_number"
FROM "owners"
JOIN "departments" ON "departments"."owner_id" = "owners"."id"
WHERE "departments"."department_number" = '123';


-- Get bills by owner using a created View named "bill_by_owner"

SELECT * FROM "bill_by_owner"
WHERE "owner"."first_name" = 'Bernardo' AND "owner"."last_name" = 'Dávila';