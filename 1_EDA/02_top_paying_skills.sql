/*
Question: What are the highest paying skills for data engineers?
- Calculate the median salary for each skill required in data engineer positions
- Focus on remote positions with specified salaries
- Include skill frequency to identify both, salary and demand
- Why? It reveals how different skills impact salary levels for Data Engineers 
    and helps identify the most financially rewarding skills to acquire or improve
*/


SELECT
    sd.skills,
    COUNT(sjd.skill_id) as demand_count,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary
FROM job_postings_fact as jpf
INNER JOIN skills_job_dim as sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim as sd
    ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title_short = 'Data Engineer' AND
    jpf.job_work_from_home = TRUE AND
    jpf.salary_year_avg IS NOT NULL
GROUP BY sd.skills
HAVING demand_count > 100
ORDER BY median_salary DESC
LIMIT 25;

/*
Key Insights:

- Terraform has the highest median salary at $184,000, despite appearing in only 193 job postings.
- Cloud and infrastructure skills such as Terraform, Kubernetes, and AWS are associated with some of the highest median salaries.
- Airflow ($150,000) and Spark ($140,000) offer a strong combination of high median salaries and substantial job demand.
- AWS has the highest demand among the top 10 skills, appearing in 783 job postings, with a median salary of $137,320.
- Python and SQL have the highest overall demand, with 1,133 and 1,128 job postings, respectively, despite having lower median salaries than the highest-paying specialized skills.
- Specialized technologies tend to have higher median salaries, while foundational skills such as Python and SQL offer broader job opportunities.

┌────────────┬──────────────┬───────────────┐
│   skills   │ demand_count │ median_salary │
│  varchar   │    int64     │    double     │
├────────────┼──────────────┼───────────────┤
│ terraform  │          193 │      184000.0 │
│ kubernetes │          147 │      150500.0 │
│ airflow    │          386 │      150000.0 │
│ kafka      │          292 │      145000.0 │
│ spark      │          503 │      140000.0 │
│ pyspark    │          152 │      140000.0 │
│ git        │          208 │      140000.0 │
│ go         │          113 │      140000.0 │
│ aws        │          783 │      137320.0 │
│ scala      │          247 │      137290.0 │
│ gcp        │          196 │      136000.0 │
│ mongodb    │          136 │      135750.0 │
│ snowflake  │          438 │      135500.0 │
│ github     │          127 │      135000.0 │
│ bigquery   │          123 │      135000.0 │
│ docker     │          144 │      135000.0 │
│ hadoop     │          198 │      135000.0 │
│ python     │         1133 │      135000.0 │
│ java       │          303 │      135000.0 │
│ r          │          133 │      134775.0 │
│ nosql      │          193 │      134415.0 │
│ databricks │          266 │      132750.0 │
│ mysql      │          101 │      130500.0 │
│ redshift   │          274 │      130000.0 │
│ sql        │         1128 │      130000.0 │
└────────────┴──────────────┴───────────────┘
*/