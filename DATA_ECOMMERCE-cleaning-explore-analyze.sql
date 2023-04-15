--EXPLORING DATA 
SELECT *
  FROM Customer_Data

--------------------------------------
-- change the values of column gender from 1,0 to male and female 
--
ALTER TABLE Customer_Data
ALTER COLUMN Gender varchar(255);

UPDATE Customer_Data
SET gender = 
    CASE 
        WHEN gender = 0 THEN 'Male'
        WHEN gender = 1 THEN 'Female'
    END

-----------------------------------------------
--The number female clients   and avg age  

SELECT COUNT(Gender)female_clints, AVG(Age) Avg_Female_Age
FROM Customer_Data
WHERE Gender = 'female'
---------------------------------------------------------
--NUMBER OF PURCHASES OF FEMALES AND TOTAL REVENUE FROM FEMALES
SELECT  SUM(N_Purchases) N_PURCHASES_FEMALE,SUM(Revenue_Total) TOTAL_REVENUE_FEMALE
  FROM Customer_Data
  WHERE Gender = 'female'
  --------------------------------------------

----The number male clients  

SELECT COUNT(Gender)male_clints, AVG(Age) Avg_male_Age
FROM Customer_Data
WHERE Gender = 'male'

--------------------------------------------------
--NUMBER OF PURCHASES OF MALES AND TOTAL REVENUE FROM MALES
SELECT  SUM(N_Purchases) N_PURCHASES_MALE,SUM(Revenue_Total) TOTAL_REVENUE_MALE
  FROM Customer_Data
  WHERE Gender = 'male'
----------------------------------------------------------------

--- change the browser column from 0,1,2,3 to chrome , safari ,edge , other
ALTER TABLE Customer_Data
ALTER COLUMN Browser varchar(8)


UPDATE Customer_Data
SET Browser = 
              CASE
			      WHEN Browser = 0 THEN 'Digital Wallet'
			      WHEN Browser = 1 THEN 'Safari'
			      WHEN Browser = 2 THEN 'Edge'
			      WHEN Browser = 3 THEN 'Other'
			      ELSE Browser
			  END

 --time spent (in sec) on website i transfered to minutes to be readable 

SELECT CONVERT(varchar(8), DATEADD(second, AVG(Time_Spent), '00:00:00'), 108) AS average_time_spent
FROM Customer_Data
----------------------------------------------------------------------------------------------------
--Which browser do most clients use?
SELECT Browser,COUNT(Browser)
FROM Customer_Data
GROUP BY Browser


--MAX PURCHASE VALUE AND MIN PURCHASE VALUE 
----------------------------------------------------------------------------------------------------------
SELECT MAX(Purchase_VALUE) as max_purchase_value,MIN(Purchase_VALUE) as min_purchase_value
FROM Customer_Data
------------------------------------------------

--MAX Revenue min revenue AVG 
SELECT MAX(Revenue_Total) MAXREVENUE, MIN(Revenue_Total) MINREVENUE,AVG(Revenue_Total) AVGREVENUE
FROM Customer_Data


--HOW MANY CUSTOMERS SUBSCRIBED IN NEWSLETTER 

ALTER TABLE Customer_Data
ALTER COLUMN Newsletter varchar(255);

UPDATE Customer_Data
SET Newsletter = CASE
                     WHEN Newsletter = 0 THEN 'not subscribed,'
					 WHEN Newsletter = 1 THEN 'subscribed'
					 ELSE Newsletter
                 END
                     

SELECT Newsletter,COUNT(Newsletter)
FROM Customer_Data
WHERE Newsletter = 'subscribed'
GROUP BY Newsletter 
------------------------------------------------------------------
--hou many customers used vouchers

ALTER TABLE Customer_Data
ALTER COLUMN Voucher varchar(255)

UPDATE Customer_Data
SET Voucher = 
               CASE
			       WHEN Voucher = 0  THEN 'NO-Voucher'
				   WHEN Voucher = 1  THEN 'Used-Voucher'
				   ELSE Voucher
               END

SELECT Voucher,COUNT(Voucher)
FROM Customer_Data
WHERE Voucher = 'Used-Voucher'
GROUP BY Voucher