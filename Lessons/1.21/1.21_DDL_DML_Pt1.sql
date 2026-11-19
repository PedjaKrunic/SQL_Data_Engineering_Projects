CREATE DATABASE IF NOT EXISTS job_mart;

SHOW DATABASES;

-- DROP DATABASE IF EXISTS job_mart;

SELECT *
FROM information_schema.schemata;

USE job_mart;

CREATE SCHEMA IF NOT EXISTS staging;

-- DROP SCHEMA staging;

CREATE TABLE IF NOT EXISTS staging.preferred_roles(
    role_id INTEGER PRIMARY KEY, -- if we don't specify primary key, we could create duplicates
    role_name VARCHAR
);

SELECT *
FROM information_schema.tables
WHERE table_catalog = 'job_mart';


-- INSERT
INSERT INTO staging.preferred_roles (role_id, role_name)
VALUES
    (1, 'Data Engineer'),
    (2, 'Senior Data Engineer'),
    (3, 'Software Engineer');

SELECT *
FROM staging.preferred_roles;


-- ALTER TABLE - ADD/DROP COLUMN
ALTER TABLE staging.preferred_roles
ADD COLUMN preferred_role BOOLEAN;

-- ALTER TABLE staging.preferred_roles
-- DROP COLUMN preferred_role;


-- UPDATE
UPDATE staging.preferred_roles
SET preferred_role = TRUE
WHERE role_id = 1 OR role_id = 2;

UPDATE staging.preferred_roles
SET preferred_role = FALSE
WHERE role_id = 3;


-- ALTER TABLE - RENAME TABLE/COLUMN, ALTER COLUMN
-- Changing table name
ALTER TABLE staging.preferred_roles
RENAME TO priority_roles;

SELECT *
FROM staging.priority_roles;

-- Changing column name
ALTER TABLE staging.priority_roles
RENAME COLUMN preferred_role TO priority_lvl;

-- Changing specified column type
ALTER TABLE staging.priority_roles
ALTER COLUMN priority_lvl TYPE INTEGER;

UPDATE staging.priority_roles
SET priority_lvl = 3
WHERE role_id = 3;

SELECT *
FROM staging.priority_roles;