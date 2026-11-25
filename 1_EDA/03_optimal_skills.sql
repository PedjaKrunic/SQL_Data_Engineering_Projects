/*
Question: What are the most optimal skills for data engineers - balancing both demand and salary?
- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Concentrate on remote Data Engineer positions with specified annual salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salary),
    offering strategic insights for career development in data analysis
*/


SELECT
    sd.skills,
    COUNT(sjd.skill_id) as demand_count,
    ROUND(LN(COUNT(sjd.skill_id)), 1) AS ln_demand_count,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    ROUND((LN(COUNT(sjd.skill_id)) * MEDIAN(jpf.salary_year_avg))/1000000, 2) AS optimal_score
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
ORDER BY optimal_score DESC
LIMIT 25;


/*
Here is a breakdown of the most optimal skills for Data Engineers, based on both high demand and high salaries:
To identify skills that offer a balance between market demand and salary potential, I created a custom `optimal_score` 
using logarithmic demand and median salary:

optimal_score = (LN(demand_count) * median_salary) / 1,000,000

- Why use LN()? - A natural logarithm reduces the influence of very high demand counts while preserving their relative 
  ranking. This prevents highly demanded skills, such as Python and SQL, from dominating the score simply because they 
  appear in significantly more job postings.

- What if we used raw demand counts? - Multiplying raw demand by median salary would give demand a much greater 
  influence on the final score. Consequently, skills like Python and SQL would dominate the ranking, potentially 
  overshadowing specialized skills with higher salary potential, such as Terraform.

- Why combine demand and salary? - The goal is to identify skills that offer both strong market demand and attractive 
  earning potential, rather than evaluating either factor independently.

Key Insights:

- Terraform ranks first with an optimal score of 0.97, combining the highest median salary ($184,000) with 
  relatively moderate demand (193 job postings).
- Python and SQL rank second and fourth, demonstrating that foundational skills remain highly valuable due to their 
  exceptionally high demand (over 1,100 job postings each).
- AWS offers a strong balance between demand and salary, appearing in 783 job postings with a median salary of $137,320.
- Airflow and Spark are among the most attractive Data Engineering technologies, combining substantial demand 
  (386 and 503 postings) with median salaries of $150,000 and $140,000, respectively.
- While demand for Kafka and Kubernetes i slower than for more common technologies, specialiying in them can lead to very 
  high salaries.
- Cloud platforms and data processing technologies (AWS, Azure, Snowflake, Spark, and Databricks) feature prominently, 
  highlighting the importance of cloud infrastructure and distributed data processing in Data Engineering.
- Overall, the results suggest that specialized skills can offer higher salary potential, while foundational skills provide 
  broader job opportunities. Combining both categories may be an effective career strategy.


┌────────────┬──────────────┬─────────────────┬───────────────┬───────────────┐
│   skills   │ demand_count │ ln_demand_count │ median_salary │ optimal_score │
│  varchar   │    int64     │     double      │    double     │    double     │
├────────────┼──────────────┼─────────────────┼───────────────┼───────────────┤
│ terraform  │          193 │             5.3 │      184000.0 │          0.97 │
│ python     │         1133 │             7.0 │      135000.0 │          0.95 │
│ aws        │          783 │             6.7 │      137320.0 │          0.91 │
│ sql        │         1128 │             7.0 │      130000.0 │          0.91 │
│ airflow    │          386 │             6.0 │      150000.0 │          0.89 │
│ spark      │          503 │             6.2 │      140000.0 │          0.87 │
│ kafka      │          292 │             5.7 │      145000.0 │          0.82 │
│ snowflake  │          438 │             6.1 │      135500.0 │          0.82 │
│ azure      │          475 │             6.2 │      128000.0 │          0.79 │
│ java       │          303 │             5.7 │      135000.0 │          0.77 │
│ scala      │          247 │             5.5 │      137290.0 │          0.76 │
│ git        │          208 │             5.3 │      140000.0 │          0.75 │
│ kubernetes │          147 │             5.0 │      150500.0 │          0.75 │
│ databricks │          266 │             5.6 │      132750.0 │          0.74 │
│ redshift   │          274 │             5.6 │      130000.0 │          0.73 │
│ gcp        │          196 │             5.3 │      136000.0 │          0.72 │
│ hadoop     │          198 │             5.3 │      135000.0 │          0.71 │
│ nosql      │          193 │             5.3 │      134415.0 │          0.71 │
│ pyspark    │          152 │             5.0 │      140000.0 │           0.7 │
│ mongodb    │          136 │             4.9 │      135750.0 │          0.67 │
│ docker     │          144 │             5.0 │      135000.0 │          0.67 │
│ go         │          113 │             4.7 │      140000.0 │          0.66 │
│ r          │          133 │             4.9 │      134775.0 │          0.66 │
│ bigquery   │          123 │             4.8 │      135000.0 │          0.65 │
│ github     │          127 │             4.8 │      135000.0 │          0.65 │
└────────────┴──────────────┴─────────────────┴───────────────┴───────────────┘
*/