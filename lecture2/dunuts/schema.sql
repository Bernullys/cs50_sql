CREATE TABLE "ingredients" (
    "id" INTEGER,
    "ingredient" TEXT,
    "ingredient_price" NUMERIC,
    "ingredient_unit" TEXT,
    PRIMARY KEY ("id")
);

CREATE TABLE "dunnuts" (
    "id" INTEGER,
    "name" TEXT,
    "type" TEXT,
    "price" NUMERIC,
    "ingredients" TEXT,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("ingredients") REFERENCES "ingredients"("id")
);

CREATE TABLE "orders" (
    "id" INTEGER,
    "order_dunuts" TEXT,
    "customer_name" TEXT,
    PRIMARY KEY("id")
);

CREATE TABLE "customers" (
    "id" INTEGER,
    "first_name" TEXT,
    "last_name" TEXT,
    "orders_history" TEXT,
    PRIMARY KEY("id"),
    FOREIGN KEY ("orders_history") REFERENCES "orders"("id")
);

