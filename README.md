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






Nordstrom Product EDA (MySQL Workbench)
🛍️ Project Title: Exploratory Data Analysis on Nordstrom Products

📌 Overview
This project explores pricing, reviews, brand performance, and product features in Nordstrom's product catalog using SQL. The objective is to derive actionable business insights around customer behavior, brand trends, and value optimization.

🛠️ Tools
MySQL Workbench
SQL (Aggregations, CTEs, Filtering, Sorting, Grouping)

🔍 Key Analysis Areas
1. Pricing Strategy
* Identified top 5 discounted products
* Found 494+ items sold below retail
* Analyzed average retail vs current prices by brand

2. Review & Engagement
* Listed products with the highest review counts
* Brands with average ratings > 4
* Compared pricing vs product rating to study value perception

3. Brand Performance
* Ranked brands by product volume and review counts
* Evaluated average price and rating by brand

4. Color & Style Insights
* Top 5 dominant colors by count
* Colors with highest average ratings

5. Value Identification
* Highlighted brands offering high ratings and affordable prices
* Flagged undervalued products (high rating, low reviews, low price)

6. Advanced Comparison
* Used CTEs to compare brand ratings against overall average
* Identified best-reviewed individual product

🎯 Outcome
A set of targeted business insights to assist Nordstrom in product positioning, pricing decisions, inventory strategy, and brand optimization.
