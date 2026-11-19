/*
NUMERIC - za brojeve
- INT
- FLOAT - za manju preciznost od `double`
- DOUBLE - za analitiku ili racunanje nekih kalkulacija
- DECIMAL
- NUMERIC

------------------------------------------------------------

CHARACTER - za text ili string
- CHAR(n) - za mali broj karaktera (2 ili 3 fazon)
- VARCHAR(n) 
- TEXT - dugacak tekst, nema limit

------------------------------------------------------------

BOOLEAN - true/false

------------------------------------------------------------

DATE/TIME 
- DATE - 2025-11-02
- TIME - 15:40:00
- TIMESTAMP - 2025-11-02 15:40:00
- TIMESTAMPTZ - 2025-11-02 15:40:00+00

------------------------------------------------------------

OTHER TYPES
- ARRAY
- JSON
- UUID
- BINARY
*/

-- How to check data types of columns in a table
SELECT 
    table_name,
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'job_postings_fact';


DESCRIBE job_postings_fact;


-- Data type conversion
SELECT CAST('123' AS INTEGER);

SELECT
    CAST(job_id AS VARCHAR) || '-' || CAST(company_id AS VARCHAR), -- "more" unique identifier
    CAST(job_work_from_home AS INT) AS job_work_from_home, -- from boolean to numeric value
    CAST(job_posted_date AS DATE) AS job_posted_date, -- from timestamp to date only
    CAST(salary_year_avg AS DECIMAL(10, 0)) as salary_year_avg -- from double to no decimal places
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
LIMIT 10;