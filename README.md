# Introduction
Let's to reserch the data job market! Focusing on remote data analyst roles, this project explores top-paying jobs, in-demand skills, and where high demand meets high salary in data analytics. 

- SQL queries. Check them out here: [project_sql folder](/project_sql/)

# Background

Data hails from Luke Barouse course for Data Analyst. It's containsinsights on job titles, salaries, locations, and essential skills.

The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for the top-paying data analyst jobs?
3. What are the most in-demand skills for data analysts?
4. What are the top skills based on salary?
5. What are the most optimal skills to learn?

# Tools I Used

For my project researching the data analyst job market, I used several important tools:

- **SQL**: This was the main tool I used for analyzing the data. It helped me write queries to extract and analyze important information from the database.
- **PostgreSQL**: A reliable and powerful database management system. It was perfect for storing and managing the job posting data efficiently.
- **Visual Studio Code**: A versatile code editor that I used to write and run my SQL queries. With its extensions, it made working with databases more convenient.
- **Git & GitHub**: These were crucial for version control and project management. Git allowed me to track changes in my SQL scripts, while GitHub made it easy to store and share my work with others.
- **Python (Pandas and Matplotlib)**: I used Python for analyzing the query results and visualizing the data. With Pandas for data manipulation and Matplotlib for creating graphs, Python was essential in turning raw data into actionable insights.

These tools helped me organize my project and achieve accurate results in my research.

# The Analysis

### 1. Top paying Data Analyst Jobs

To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
SELECT job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    company_dim.name AS company_name
FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
```

![10 Top Paying Roles](assets\top_ten_titles.png)

*Bar graph visualizing the salary for the top 10 salaries for data analysts for remote jobs; The graph was created using Python and Matplotlib.pyplot, based on the results of an SQL query.*

Here’s an overview of the top remote data analyst jobs in 2023:

- **Wide Salary Range**: The top-paying roles range from $184,000 to $650,000 per year, showing that data analytics offers significant earning potential depending on the job title and responsibilities.
- **Diverse Employers**: Companies like Mantys, Meta, and AT&T are among the employers offering high salaries, highlighting that opportunities span industries such as technology, telecommunications, and healthcare.
- **Variety in Job Titles**: Job titles like "Data Analyst," "Director of Analytics," and "Principal Data Analyst" show a wide range of roles, from entry-level to leadership positions, emphasizing the need for specialization and experience in the field.

### 2. Skills for Top Paying Remote Jobs

To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

```sql
WITH top_paying_jobs AS (
    SELECT job_id,
        job_title,
        salary_year_avg,
        job_posted_date,
        company_dim.name AS company_name
    FROM job_postings_fact
        LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE job_title_short = 'Data Analyst'
        AND job_location = 'Anywhere'
        AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)
SELECT top_paying_jobs.*,
    skills
FROM top_paying_jobs
    INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC
```

![Skill Count for Top 10 Jobs](assets\skill_count.png)

*Bar graph visualizing the count of skills for the top 10 paying remote jobs for data analysts; The graph was created using Python and Matplotlib.pyplot, based on the results of an SQL query.*

Here’s an overview of the most in-demand skills for the top 10 highest-paying remote data analyst jobs in 2023:

- **SQL** is the most required skill, appearing 8 times across the roles.
- **Python** comes next, mentioned 7 times, showing its importance in the field.
- **Tableau** is also highly valued, with 6 mentions, highlighting the need for data visualization expertise. 
- Other skills like **R** (4 mentions), **Snowflake** (3 mentions), **Pandas** (3 mentions), and **Excel** (3 mentions) are also in demand but less frequently required compared to SQL and Python.

### 3. In-Demand Skills for Data Analysts

This query helped identify the most frequently requested skills in job postings in 2023, with a focus on remote jobs in high demand.

```sql
SELECT skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND job_work_from_home = True
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5
```

![Skill Demand in 2023](assets\five_skills.png)

*Bar graph visualizing the demand for top 5 skills for remote jobs for data analysts in 2023; The graph was created using Python and Matplotlib.pyplot, based on the results of an SQL query.*

Here’s the breakdown of the most in-demand skills for data analysts in 2023:

**SQL** and **Excel** are the most requested skills, with demand counts of 7,291 and 4,611 respectively. This highlights the importance of strong foundational skills in data processing and spreadsheet analysis.
**Python**, **Tableau**, and **Power BI** follow, with demand counts of 4,330, 3,745, and 2,609 respectively. These tools are essential for programming, data visualization, and creating reports, emphasizing the growing need for technical skills in data storytelling and supporting business decisions.
The data shows that employers prioritize a mix of fundamental and technical skills. SQL and Excel remain the cornerstones of data analysis, while the demand for Python, Tableau, and Power BI reflects the increasing complexity of data analytics tasks. This suggests that aspiring data analysts should focus on both foundational tools and advanced technologies to remain competitive in the job market.

### 4. Skills Based on Salary

Exploring the average salaries associated with different skills revealed which skills are the highest paying. 

```sql
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
```

#### Skills Grouped by Category and Ordered by Average Salary
**Programming Languages**

- Solidity ($179,000)
- Golang ($155,000)
- Perl ($124,686)
- Scala ($115,480)

**Big Data Technologies**

- Couchbase ($160,515)
- Kafka ($129,999)
- Cassandra ($118,407)

**Machine Learning & AI Tools**

- DataRobot ($155,486)
- Keras ($127,013)
- PyTorch ($125,226)
- Hugging Face ($123,950)
- TensorFlow ($120,647)


**Libraries & Frameworks**

- MXNet ($149,000)
- Dplyr ($147,633)

**Cloud & DevOps Tools**

- VMware ($147,500)
- Terraform ($146,734)
- Ansible ($124,370)
- Airflow ($116,387)

**Collaboration & Development Tools**

- SVN ($400,000)
- GitLab ($134,126)
- Puppet ($129,820)
- Atlassian ($117,966)
- Bitbucket ($116,712)


Breakdown of Results for Top-Paying Skills for Data Analysts

- **High Demand for Big Data and Machine Learning Skills**: Analysts with skills in big data technologies like Couchbase and machine learning tools like DataRobot and Keras earn some of the highest salaries. This shows that data processing and predictive modeling are highly valued in the industry.
- **Proficiency in Software Development and Deployment**: Skills in tools like GitLab, Puppet, and Airflow are highly paid. These tools help automate workflows and manage data pipelines efficiently, reflecting the crossover between data analysis and engineering.
- **Expertise in Cloud Computing**: Knowledge of tools like VMware, Terraform, and Cassandra highlights the growing importance of cloud-based analytics. Familiarity with these tools can significantly boost earning potential.

### 5. Most Optimal Skills to Learn

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and offering a strategic focus for skill development.

```sql
SELECT skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) as avg_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND job_work_from_home = True
    AND salary_year_avg IS NOT NULL
GROUP BY skills_dim.skill_id
HAVING COUNT(skills_job_dim.job_id) > 10
ORDER BY avg_salary DESC,
    demand_count DESC
LIMIT 25
```

![Most optimal Skills](assets\salary_demand_count.png)

*Scatter Plot of the most optimal skills for data analyst sorted by salary; The graph was created using Python and Matplotlib.pyplot, based on the results of an SQL query.*

**1. High-Demand Programming Languages**:

- **Python** and **R** are among the most sought-after programming languages, with demand counts of 236 and 148, respectively.
- Their average salaries are $101,397 for Python and $100,499 for R. These numbers show that while these languages are in high demand, they are also widely available in the job market, which balances their salary levels.
- Proficiency in these languages remains essential for data analysts, especially for tasks like statistical analysis and machine learning.

**2. Cloud Tools and Big Data Technologies**:

- Skills in cloud platforms like **Snowflake**, **Azure**, **AWS**, and **BigQuery** are in demand, with salaries ranging between $108,317 and $112,948.
- This reflects the growing importance of cloud-based data storage and processing in data analysis. Companies are increasingly relying on scalable cloud technologies to manage and analyze large datasets efficiently.

**3. Business Intelligence and Visualization Tools**:

- Tools like **Tableau** and **Looker** are crucial for creating visualizations and business insights. Tableau has a demand count of 230 with an average salary of $99,288, while Looker has a smaller demand count of 49 but a higher average salary of $103,795.
- This highlights the value of skills in BI tools, as they are critical for transforming raw data into actionable insights for decision-making.

**4. Database Technologies**:

- Traditional databases like **Oracle** and **SQL Server**, along with NoSQL databases like **NoSQL**, have strong demand. Salaries for these skills range from $97,786 to $104,534.
- These tools remain fundamental for storing, retrieving, and managing data, showing their enduring importance in data analytics workflows.


# What I Learned

SQL Skills Gained During the Project:

- **Advanced Query Development**: Proficient in writing complex SQL queries, including table joins and using WITH clauses to create temporary tables for efficient data analysis.
- **Data Aggregation**: Skilled in leveraging GROUP BY and aggregate functions like COUNT() and AVG() to summarize and analyze datasets effectively.
- **Analytical Problem-Solving**: Gained hands-on experience in translating real-world business questions into actionable insights through well-crafted SQL queries.

# Conclusions

### Insights
From the analysis, several general insights emerged:

1. **Top-Paying Data Analysts Jobs**: The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $ 650,000.
2. **Skills for Top-Paying Jobs**: High paying data analyst jobs require advanced knowledge of SQL, Python, Tableau, R, which means that these are important and essential skills for earning a high salary.
3. **Most In-Demand Skills**: SQL, Python and Tableau are also the most demanded skills in the data analyst job market, thus making them essential for job seekers.
4. **Skills with Higher Salaries**: Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value**: A well-rounded skill set that combines programming, cloud expertise, BI tools, and database management can significantly enhance career prospects in data analytics.

### Closing Thoughts

This project helped me improve my SQL skills and gave me useful information about the data analyst job market. The analysis shows which skills to focus on and how to plan job searches. People who want to become data analysts can do better in the job market by learning high-demand and high-salary skills. This project also shows how important it is to keep learning and stay updated with new trends in data analytics.