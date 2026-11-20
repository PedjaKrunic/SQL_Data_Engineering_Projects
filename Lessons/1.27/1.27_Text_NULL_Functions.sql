SELECT LENGTH('SQL');

-- case conversions
SELECT LOWER('SQL');
SELECT UPPER('SQl');

-- substring/extraction
SELECT LEFT('SQL', 2);
SELECT RIGHT('SQL', 1);
SELECT SUBSTRING('SQL',1,2);


-- Concatenation
SELECT CONCAT('SQL', '-', 'Fucntions');
SELECT 'SQL' || '-' || 'Funcstions';

-- Trimming
SELECT TRIM(' SQL  ');

-- Replacement
SELECT REPLACE('SQL', 'Q', 't');
SELECT REGEXP_REPLACE('SQL'); -- Use AI chatbot models for this


WITH job_title_lower AS (
    SELECT
        job_title,
        LOWER(TRIM(job_title)) AS job_title_clean
    FROM job_postings_fact
)
SELECT
    job_title,
    CASE
        WHEN job_title_clean LIKE '%data%' AND job_title_clean LIKE '%analyst%' THEN 'Data Analyst'
        WHEN job_title_clean LIKE '%data%' AND job_title_clean LIKE '%engineer%' THEN 'Data Engineer'
        WHEN job_title_clean LIKE '%data%' AND job_title_clean LIKE '%scientist%' THEN 'Data Scientist'
        ELSE 'Other'
    END AS job_title_category

FROM job_title_lower
ORDER BY RANDOM()
LIMIT 30;


----- NULL -------
-- NULLIF - Returns NULL if values are equal
SELECT NULLIF(10, 11);

-- COALESCE - Returns first non-NULL value

SELECT
    job_title_short,
    salary_hour_avg,
    salary_year_avg,
    COALESCE(salary_year_avg, salary_hour_avg * 2080) AS standardized_salary,
    CASE
        WHEN COALESCE(salary_year_avg, salary_hour_avg * 2080) IS NULL THEN 'Missing'
        WHEN COALESCE(salary_year_avg, salary_hour_avg * 2080) < 75000 then 'LOW'
        WHEN COALESCE(salary_year_avg, salary_hour_avg * 2080) < 150000 then 'MEDIUM'
        ELSE 'HIGH'
    END AS salary_bucket
FROM job_postings_fact
ORDER BY standardized_salary DESC;