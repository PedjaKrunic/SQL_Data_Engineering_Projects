SELECT
    job_id,
    job_title_short,
    name as company_name,
    cd.company_id,
    job_location
FROM job_postings_fact as jpf
LEFT JOIN company_dim as cd
    ON jpf.company_id = cd.company_id;


SELECT
    job_id,
    job_title_short,
    name as company_name,
    cd.company_id,
    job_location
FROM job_postings_fact as jpf
INNER JOIN company_dim as cd
    ON jpf.company_id = cd.company_id;  


SELECT
    job_id,
    job_title_short,
    name as company_name,
    cd.company_id,
    job_location
FROM job_postings_fact as jpf
FULL OUTER JOIN company_dim as cd
    ON jpf.company_id = cd.company_id;   



SELECT *
FROM skills_job_dim
LIMIT 10;

SELECT *
FROM skills_dim
LIMIT 10;



SELECT
    jpf.job_id,
    jpf.job_title_short,
    sjd.skill_id,
    sd.skills
FROM job_postings_fact as jpf
LEFT JOIN skills_job_dim as sjd
    ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim as sd
    ON sjd.skill_id = sd.skill_id;

    

SELECT
    jpf.job_id,
    jpf.job_title_short,
    sjd.skill_id,
    sd.skills
FROM job_postings_fact as jpf
INNER JOIN skills_job_dim as sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim as sd
    ON sjd.skill_id = sd.skill_id;