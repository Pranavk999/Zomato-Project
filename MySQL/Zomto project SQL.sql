create database Zomato_Analysis;
use Zomato_Analysis;

select*from	zomato;
select*from country;

ALTER TABLE Country RENAME COLUMN ï»¿CountryID TO CountryID;

#Build a country Map Table---1 Query

SELECT countrycode,countryname from zomato z
left join country c on z.countrycode = c.countryid
group by countrycode,countryname;

#Build a Calendar Table using the Column Datekey-----2 Query
SELECT 
    YEAR(openingdate) AS year,                            
    MONTH(openingdate) AS month,                          
    QUARTER(openingdate) AS quarter,                      
    DATE_FORMAT(openingdate, '%M') AS month_name,         
    DATE_FORMAT(openingdate, '%Y-%m') AS yearmonth,      
    DAYOFWEEK(openingdate) AS weekday_number,             
    DAYNAME(openingdate) AS weekday_name,                 
    CASE 
        WHEN MONTH(openingdate) BETWEEN 4 AND 6 THEN 'Q1'
        WHEN MONTH(openingdate) BETWEEN 7 AND 9 THEN 'Q2'
        WHEN MONTH(openingdate) BETWEEN 10 AND 12 THEN 'Q3'
        ELSE 'Q4' 
    END AS financial_month,                               
    CASE 
        WHEN MONTH(openingdate) BETWEEN 4 AND 6 THEN 'Q1'
        WHEN MONTH(openingdate) BETWEEN 7 AND 9 THEN 'Q2'
        WHEN MONTH(openingdate) BETWEEN 10 AND 12 THEN 'Q3'
        ELSE 'Q4' 
    END AS financial_quarter                             
FROM zomato;


#Find the Numbers of Resturants based on City and Country======3 Query

select city,count('restaurantid') as Restaurants from zomato
group by city;
select countryname, count('restaurantid') as Restaurants from zomato z
LEFT JOIN COUNTRY C ON  z.COUNTRYCODE = C.COUNTRYID
GROUP BY COUNTRYNAME;

select c.countryname, z.city, count(z.RestaurantID) as Restaurants
from zomato z
left join country c on z.countrycode = c.countryid
group by
c.countryname, z.city;

#Numbers of Resturants opening based on Year , Quarter , Month-----4 th Query

SELECT 
    distinct YEAR(openingdate) AS year,
	QUARTER(openingdate) AS quarter,
	MONTH(openingdate) AS month,
    COUNT(*) AS num_restaurants
FROM zomato
GROUP BY YEAR(openingdate), QUARTER(openingdate), Month(openingdate)
ORDER BY year, month, quarter;

SELECT 
    distinct YEAR(openingdate) AS year,
    COUNT(*) AS num_restaurants
FROM zomato
GROUP BY YEAR(openingdate)
ORDER BY year;

SELECT 
distinct quarter(openingdate) AS quarter,
COUNT(*) AS num_restaurants
FROM zomato
GROUP BY quarter(openingdate)
ORDER BY quarter;

SELECT 
distinct month(openingdate) AS month,
COUNT(*) AS num_restaurants
FROM zomato
GROUP BY month(openingdate)
ORDER BY month;

#Count of Resturants based on Votes------5 th Query

SELECT Restaurants, count(Votes) as Votes
from zomato
group by Restaurants;


#Create buckets based on Average Price of reasonable size and find out how many resturants falls in each buckets----6 th query

SELECT
Cost_Range,
COUNT(*) AS TotalRestaurants
FROM(
SELECT
CASE
WHEN Average_Cost_for_two BETWEEN 0 AND 300 THEN '0-300'
WHEN Average_Cost_for_two BETWEEN 301 AND 600 THEN '301-600'
WHEN Average_Cost_for_two BETWEEN 601 AND 1000 THEN '601-1000'
WHEN Average_Cost_for_two BETWEEN 1001 AND 80000 THEN '1001-80000'
ELSE 'Other'
END AS Cost_Range
FROM
zomato
) AS Subquery
GROUP BY
Cost_Range;

#Percentage of Resturants based on "Has_Table_booking"---7 th Query

SELECT
Has_Table_booking,
COUNT(*) AS TotalRestaurants,
ROUND((COUNT(*) / (SELECT COUNT(*) FROM zomato)) * 100, 2) AS Percentage
FROM
zomato
GROUP BY
Has_Table_booking;

#Percentage of Resturants based on "Has_Online_Delivery"---8 th Query

SELECT
Has_Online_Delivery,
COUNT(*) AS TotalRestaurants,
ROUND((COUNT(*) / (SELECT COUNT(*) FROM zomato)) * 100, 2) AS Percentage
FROM
zomato
GROUP BY
Has_Online_Delivery;







