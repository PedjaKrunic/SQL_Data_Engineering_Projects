-- UNION
-- Unites all rows from tables, but removes duplicates
SELECT UNNEST([1, 1, 1, 2])
UNION
SELECT UNNEST([1, 1, 3]);

-- UNION ALL
-- Unites all rows from tables
SELECT UNNEST([1, 1, 1, 2])
UNION ALL
SELECT UNNEST([1, 1, 3]);


-- INTERSECT
-- Returns rows common to A and B tables, duplicates remove
SELECT UNNEST([1, 1, 1, 2])
INTERSECT
SELECT UNNEST([1, 1, 3]);

-- INTERSECT ALL
-- Returns rows common to A and B tables, duplicates preserved
SELECT UNNEST([1, 1, 1, 2])
INTERSECT ALL
SELECT UNNEST([1, 1, 3]);


-- EXCEPT 
-- Returns rows in A but not in B. Duplicates removed
SELECT UNNEST([1, 1, 1, 2])
EXCEPT
SELECT UNNEST([1, 1, 3]);

-- EXCEPT ALL
-- Returns rows in A but not in B. Duplicates removed one-for-one
SELECT UNNEST([1, 1, 1, 2])
EXCEPT ALL
SELECT UNNEST([1, 1, 3]);



CREATE OR REPLACE TEMP TABLE jobs_2023 AS
SELECT * EXCLUDE (job_id, job_posted_date)
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date) = 2023;

CREATE OR REPLACE TEMP TABLE jobs_2024 AS
SELECT * EXCLUDE (job_id, job_posted_date)
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date) = 2024;

-- Which unique job postings appeared in either 2023 or 2024
SELECT * FROM jobs_2023
UNION
SELECT * FROM jobs_2024;

-- Which job postings appeared across both years, counting duplicates?
SELECT * FROM jobs_2023
UNION ALL
SELECT * FROM jobs_2024;

-- Which job postings appeared in 2023 but not in 2024
SELECT * FROM jobs_2023
EXCEPT
SELECT * FROM jobs_2024;

-- Which job postings from 2023 remain after subtracting matching 2024 postings, one-for-one?
SELECT * FROM jobs_2023
EXCEPT ALL
SELECT * FROM jobs_2024;

-- Which job postings appeared in both 2023 and 2024?
SELECT * FROM jobs_2023
INTERSECT
SELECT * FROM jobs_2024;

-- Which job postings appeared in both years, preserving duplicate counts?
SELECT * FROM jobs_2023
INTERSECT ALL
SELECT * FROM jobs_2024;