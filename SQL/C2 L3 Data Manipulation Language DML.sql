--DML

--Concepts 2

INSERT INTO "books" ("book_title") VALUES
("Bourne Identity"),
("Matrix"),
("Twilight")

--Concepts 5

1. create table
2. insert into table

CREATE TABLE "people" (
  "person_id" SERIAL,
  "first_name"  VARCHAR,
  "last_name" VARCHAR
);

INSERT INTO "people" ("first_name", "last_name")
  SELECT "first_name", "last_name" FROM "denormalized_people";


--Concepts

--1
UPDATE "people" SET "last_name" = 'INITCAP(last_name)';


--2
