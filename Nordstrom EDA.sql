SELECT *
FROM nordstrom_products;

-- 1. PRICING STATERGY
-- finding top 5 discounted products 
SELECT Product_Name, Price_Retail, Price_Current, (Price_Retail - Price_Current) AS Discount_Amount
FROM nordstrom_products
ORDER BY Discount_Amount DESC
LIMIT 5;

--  494/5030 products being sold below retail price 
SELECT count(*)
FROM nordstrom_products
WHERE Price_Current < Price_Retail
LIMIT 5;

-- Avg retail and current price by brand 
SELECT Brand, avg(Price_Retail), avg(Price_Current)
FROM nordstrom_products
GROUP BY Brand;

-- 2. REVIEW AND ENGAGEMENT 
-- Top 5 brands with higher review 
SELECT Product_Name, Review_Count
FROM nordstrom_products
ORDER BY Review_Count DESC
LIMIT 5
;

-- Brands has the highest average review > 4 
SELECT Brand, avg(Review_Rating) AS Avg_Review
FROM nordstrom_products
WHERE Review_Rating > 4
GROUP BY Brand;

-- Are higher-priced products getting better ratings than lower-priced ones
SELECT Product_Name, Price_Current, Review_Rating
FROM  nordstrom_products
WHERE Review_Rating > 0 
ORDER BY Price_Current DESC
;

-- 3. BRAND PERFORMANCE
-- NIKE has the most products listed
SELECT Brand, COUNT(*) AS Product_Count
FROM nordstrom_products
GROUP BY Brand
ORDER BY Product_Count DESC;

-- Kindred Bravely has the highest Average review count
SELECT Brand, AVG(Review_Count) as AVG_Review_Count
FROM nordstrom_products
GROUP BY Brand
ORDER BY AVG_Review_Count DESC;

-- Average price and rating for each brand 
SELECT Brand, AVG(Price_Current) AS AVG_Price_Current, AVG(Review_Rating) AS AVG_Review_Rating
FROM nordstrom_products
GROUP BY Brand
;

-- 3. COLOR AND STYLE INSIGHTS
-- Color Code 001 is the most dominating color in the dataset 
SELECT Color, COUNT(*) AS Count
FROM nordstrom_products
GROUP BY Color
ORDER BY Count DESC
LIMIT 5;

-- Colors with high average rating 
SELECT Color, AVG(Review_Rating) AS Avg_Rating
FROM nordstrom_products
GROUP BY Color
ORDER BY Avg_Rating DESC;


-- 4.Brands that offer the best balance between high product ratings and affordable pricing
SELECT Brand, AVG(Price_Current) AS Avg_Price, AVG(Review_Rating) AS Avg_Rating, 
COUNT(*) AS Product_Count
FROM nordstrom_products
GROUP BY Brand
HAVING AVG(Price_Current) < 200 AND AVG(Review_Rating) >= 4
ORDER BY Avg_Rating DESC, Avg_Price ASC
;

-- 5. Identify undervalued products
-- highly rated but under-reviewed or underpriced
SELECT Product_Name, Brand, Price_Current, Review_Rating, Review_Count
FROM nordstrom_products
WHERE Review_Rating >= 4.5 AND Review_Count < 20 AND Price_Current < 150
ORDER BY Review_Rating DESC, Price_Current ASC
;

-- 6. brands have an average product rating above the overall average rating across the entire dataset
WITH OverallAvgRating AS 
(
 SELECT AVG(Review_Rating) AS Avg_Rating_All
 FROM nordstrom_products
), BrandAvgRating as
(
 SELECT Brand, AVG(Review_Rating) AS Avg_Rating
 FROM nordstrom_products
 GROUP BY Brand
)
SELECT b.Brand, b.Avg_Rating AS Brand_Avg_Rating,o.Avg_Rating_All AS Overall_Avg_Rating
FROM BrandAvgRating b
JOIN OverallAvgRating o
WHERE  b.Avg_Rating > o.Avg_Rating_All
ORDER BY Brand_Avg_Rating DESC;
;

-- Live In High Waist Leggings has the highest review count across the entire dataset

SELECT Product_Name,Brand,Review_Count,Review_Rating
FROM nordstrom_products
WHERE Review_Count = 
(
SELECT MAX(Review_Count) 
FROM nordstrom_products
);










