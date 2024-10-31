CREATE TABLE "glints" (
    "glints_id" INTEGER,
    "first_character" INTEGER,
    "length" INTEGER,
    PRIMARY KEY("glints_id")
);

INSERT INTO "glints" ("glints_id", "first_character", "length")
VALUES
    (14, 98, 4),
    (114, 3, 5),
    (618, 72, 9),
    (630, 7, 3),
    (932, 12, 5),
    (2230, 50, 7),
    (2346, 44, 10),
    (3041, 14, 5)
;

CREATE VIEW "message" AS
SELECT substr("sentence", "first_character", "length") AS "phrase" FROM "sentences"
JOIN "glints" ON "glints"."glints_id" = "sentences"."id";