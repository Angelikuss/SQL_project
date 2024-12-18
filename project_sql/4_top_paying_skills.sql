/*
 Answer: What are the top skills based on salary?
 - Look at the average salary associated with each skill for Data Analyst positions
 - Focuses on roles with specified salaries, regardless of location
 - Why? It reveals how different skills impact salary levels for Data Analyst and 
 helps identify the most financially rewarding skills to acquire or improve
 */
SELECT skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 25
    /*
     1. Emerging Technologies
     Skills like Solidity (related to blockchain and smart contracts) 
     and Golang are commanding high salaries, indicating the growing 
     importance of blockchain and scalable, efficient programming languages 
     in data analytics roles.
     
     2. Specialized Tools
     Tools like Couchbase (a NoSQL database) and DataRobot (AI/ML automation 
     platform) are among the top-paying skills, suggesting that specialized 
     software expertise is highly valued.
     
     3. Cross-Industry Demand
     
     Many of the listed skills (e.g., SVN, Couchbase) are applicable 
     across industries, which increases their demand and results in 
     higher salaries.
     
     4. Combination of New and Established Skills
     
     Some older technologies like SVN (Subversion for version control) 
     remain valuable in certain domains, alongside newer skills like 
     Solidity and Golang.
     
     "svn","400000"
     "solidity","179000"
     "couchbase","160515"
     "datarobot","155486"
     "golang","155000"
     "mxnet","149000"
     "dplyr","147633"
     "vmware","147500"
     "terraform","146734"
     "twilio","138500"
     "gitlab","134126"
     "kafka","129999"
     "puppet","129820"
     "keras","127013"
     "pytorch","125226"
     "perl","124686"
     "ansible","124370"
     "hugging face","123950"
     "tensorflow","120647"
     "cassandra","118407"
     "notion","118092"
     "atlassian","117966"
     "bitbucket","116712"
     "airflow","116387"
     "scala","115480"
     */