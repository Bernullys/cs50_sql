CREATE TABLE "users" (
    "id" INTEGER PRIMARY KEY,
    "name" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    "email" TEXT NOT NULL UNIQUE
);