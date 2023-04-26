--explore dataset see how many rows and columns
SELECT *
  FROM [Cape_stone].[dbo].[customer_shopping_data]
-----------------------------------------------

--fix date format 

SELECT  CONVERT(varchar(10),invoice_date, 120) AS formatted_date
  FROM [Cape_stone].[dbo].[customer_shopping_data]

--------------------------------------------------------
--formating the price into turkish currency
SELECT FORMAT(price, 'C', 'tr-TR') AS currency_column
FROM [Cape_stone].[dbo].[customer_shopping_data];

----------------------------------------------------------
-- convert fromk lira to usd 
SELECT price / 8.50 AS usd_column
FROM [Cape_stone].[dbo].[customer_shopping_data];

------------------------------------------------------------------

-- Add a new column for the USD values
ALTER TABLE [Cape_stone].[dbo].[customer_shopping_data]
ADD price_usd DECIMAL(18,2);

-- Update the new column with the converted values
UPDATE [Cape_stone].[dbo].[customer_shopping_data]
SET usd_column = price / 8.50;

---------------------------------------------------------
--calculate total price for each category 
SELECT category, SUM(usd_column) AS total_revenue
FROM [Cape_stone].[dbo].[customer_shopping_data]
GROUP BY category;
-----------------------------------------------------
--summary statistics for price in usd for each product category 

SELECT category, 
       COUNT(*) AS count, 
       SUM(usd_column) AS total, 
       AVG(usd_column) AS average, 
       MIN(usd_column) AS minimum, 
       MAX(usd_column) AS maximum
FROM [Cape_stone].[dbo].[customer_shopping_data]
GROUP BY category;
--------------------------------------------------------
