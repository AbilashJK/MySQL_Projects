

🧹 Project Title: Layoff Data Cleaning in MySQL

📌 Overview
Cleaned and standardized layoff data using SQL to ensure accuracy, consistency, and readiness for analysis.

🛠️ Tools
MySQL Workbench
SQL (DDL, DML, CTE, Window Functions)

✅ Key Steps
* Created staging tables to preserve raw data integrity
* Removed duplicates using `ROW_NUMBER()` and CTEs
* Standardized fields: company names, industries, countries, and date formats
* Resolved null and blank values using `JOIN` and conditional `UPDATE`
* Dropped unnecessary columns to finalize the clean dataset
  
🎯 Outcome
A clean and structured dataset (`layoffs_staging2`) ready for exploratory analysis and visualization.











🔍 Project Title: Layoff Data – Exploratory Data Analysis in SQL

📌 Overview
Performed EDA on cleaned layoff data to identify trends, outliers, and business insights over time and across regions.

🛠️ Tools
MySQL Workbench
SQL (Aggregate Functions, GROUP BY, CTEs, Window Functions)**

 🔎 Key Insights Explored
* Top companies and countries by total layoffs
* Layoff trends by industry, location, and funding raised
* Year-over-year and monthly layoff patterns
* Companies with 100% workforce laid off
* Rolling totals using CTEs and window functions

🎯 Outcome
Generated a clear picture of global layoff trends over time, providing business insights for decision-makers and potential visualization in BI tools.


