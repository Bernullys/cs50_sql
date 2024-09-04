SELECT "name", "per_pupil_expenditure", "exemplary" FROM "districts"
JOIN "expenditures" ON "districts"."id" = "expenditures"."district_id"
JOIN "staff_evaluations" ON "staff_evaluations"."district_id" = "districts"."id"
WHERE "per_pupil_expenditure" > (
    SELECT AVG("per_pupil_expenditure") FROM "expenditures"
)
AND
"exemplary" > (
    SELECT AVG("exemplary") FROM "staff_evaluations"
)
AND
"type" = 'Public School District'
ORDER BY "exemplary" DESC, "per_pupil_expenditure" DESC;

-- Other way to the same result:
SELECT "name", "per_pupil_expenditure", "exemplary" FROM "districts"
JOIN "expenditures" ON "districts"."id" = "expenditures"."district_id"
JOIN "staff_evaluations" ON "staff_evaluations"."district_id" = "districts"."id"
WHERE "per_pupil_expenditure" > (
    SELECT AVG("per_pupil_expenditure") FROM "expenditures"
)
INTERSECT
SELECT "name", "per_pupil_expenditure", "exemplary" FROM "districts"
JOIN "expenditures" ON "districts"."id" = "expenditures"."district_id"
JOIN "staff_evaluations" ON "staff_evaluations"."district_id" = "districts"."id"
WHERE "exemplary" > (
    SELECT AVG("exemplary") FROM "staff_evaluations"
)
AND
"type" = 'Public School District'
ORDER BY "exemplary" DESC, "per_pupil_expenditure" DESC;