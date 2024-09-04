SELECT "name", "pupils", "proficient" FROM "schools"
JOIN "staff_evaluations"
WHERE "evaluated" > (
    99
);