CREATE DATABASE zomato_analysis;
use zomato_analysis;
select * from zom_main;
select * from country;

select * from currency;

# Q1 Find the Numbers of Resturants based on City and Country. #
Create view Restcounts as
SELECT count(RestaurantID), City, CountryName FROM zom_main as a
join country as b on a.CountryID = b.CountryID
GROUP BY City,b.CountryName order by CountryName;
select * from Restcounts;

#Q2) Numbers of Resturants opening based on Year , Quarter , Month#
#Total Resturants Open Year wise#
Create view yearwise as
SELECT DISTINCT(Year(Opening_date)) as year, COUNT(*) as Restrnt_count
FROM zom_main
GROUP BY year order by year desc ;
select * from yearwise;

#Total Resturants Open Year quarter wise#
Create view quarterwise as
SELECT DISTINCT quarter(Opening_date) AS quarter, COUNT(*) as Restrnt_count
FROM zom_main
GROUP BY quarter
ORDER BY quarter;
select * from quarterwise;


# Total Resturants Open Month Wise #
SELECT DISTINCT(month(Opening_date)) AS Montho, COUNT(*)
FROM zom_main
GROUP BY Montho
ORDER BY Montho;

# Total Resturants Open Monthname Wise #
SELECT DISTINCT MONTHNAME(Opening_date) AS Monthname_, COUNT(*)
FROM zom_main
GROUP BY Monthname_
ORDER BY Monthname_;

# Total Resturants Open Weekday number wise #
SELECT DISTINCT weekday((Opening_date)) AS Weekdaynum_, COUNT(*)
FROM zom_main
GROUP BY Weekdaynum_
ORDER BY Weekdaynum_;

# Total Resturants Open Weekday wise #
SELECT DISTINCT dayname((Opening_date)) AS Weekdayname_, COUNT(*)
FROM zom_main
GROUP BY Weekdayname_
ORDER BY Weekdayname_;

# Total Resturants Open financial month wise #
SELECT DISTINCT Financial_month AS fin_month_, COUNT(*)
FROM zom_main
GROUP BY fin_month_
ORDER BY fin_month_;

# Q3)Count of Resturants based on Average Ratings#
Create view avg_rating as
SELECT Rating AS Avg_rating,
COUNT(*) AS ResturantCount
FROM zom_main
WHERE Rating IS NOT NULL
GROUP BY Rating 
ORDER BY rating ASC;
select * from avg_rating;


# Q4)Create buckets based on Average Price of reasonable size and find out how many resturants falls in each buckets
Create view Bucket_list as
SELECT Average_Cost_for_two,
COUNT(*) AS Total_Restrurants
FROM (SELECT CASE
       WHEN Average_Cost_for_two BETWEEN 0 AND 300 THEN "0-300"
	   WHEN Average_Cost_for_two BETWEEN 301 AND 600 THEN "301-600"
       ELSE "other"
      END AS Average_Cost_for_two
      FROM zom_main)
      AS Subquery
      GROUP BY Average_Cost_for_two;
      select * from bucket_list;
      
      
#Q5)Percentage of Resturants based on "Has_Table_booking" #
 Create view Table_bkg as
 SELECT Has_Table_booking,
 COUNT(*) AS Total_Restaurants,
 ROUND((COUNT(*) / (SELECT COUNT(*) FROM zom_main)) * 100,2) AS Percentage
 FROM 
 zom_main
 GROUP BY Has_Table_booking ;
 SELECT * from Table_bkg; 
 
 
 #-- Q6)Percentage of Resturants based on "Has_Online_delivery"
 Create View Online_Del as
 SELECT Has_Online_delivery,
 COUNT(*) AS TotalRestaurants,
 ROUND((COUNT(*) / (SELECT COUNT(*) FROM zom_main)) * 100,2) AS Percentage
 FROM zom_main
 GROUP BY Has_Online_delivery;
 SELECT * from online_Del;



