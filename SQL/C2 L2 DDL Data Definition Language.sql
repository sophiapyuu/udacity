--DDL

--Concepts 3 WRONG
--1.

CREATE TABLE "employee"(
  "id" SERIAL,
  "emp_name" TEXT,
  "manager_id" INTEGER
);

CREATE TABLE "emp_phones"(
  "id_emp" INTEGER,
  "phone_number" TEXT
);


--Concepts 11 WRONG
--1.

CREATE TABLE "reservation"(
  "id" SERIAL,
  "guestID" INTEGER,
  "room" TEXT,
  "checkIn" date,
  "checkOut" date
);

CREATE TABLE "customer"(
  "id" SERIAL,
  "firstName" VARCHAR,
  "lastName" VARCHAR,
  "phoneNumber" VARCHAR
);

CREATE TABLE "cust_email"(
  "id_cust" INTEGER,
  "email" VARCHAR
);

CREATE TABLE "room"(
  "id" SERIAL,
  "floor" SMALLINT,
  "room" SMALLINT,
  "size" SMALLINT--square feet hmm
);


--Concepts 14 WRONG
--1.
ALTER TABLE "students" ALTER COLUMN "email_address" SET DATA TYPE VARCHAR;
--course ratings float ?
ALTER TABLE "courses" ALTER COLUMN "rating" SET DATA TYPE REAL;

ALTER TABLE "registrations" ALTER COLUMN "student_id" SET DATA TYPE INTEGER;
ALTER TABLE "registrations" ALTER COLUMN "course_id" SET DATA TYPE INTEGER;
