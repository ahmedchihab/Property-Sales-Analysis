create database property;
use property;

CREATE TABLE properties (
    datesold DATE,
    postcode VARCHAR(20),
    price DECIMAL(15,2),
    propertyType VARCHAR(20),
    bedrooms INT
);

SHOW VARIABLES LIKE 'datadir';


TRUNCATE TABLE properties;


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/raw_sales.csv'
INTO TABLE properties
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(datesold, postcode, price, propertyType, @bedrooms)
SET bedrooms = CAST(@bedrooms AS UNSIGNED);


DESCRIBE properties;


SELECT * 
FROM properties
LIMIT 10;


SELECT 
    AVG(price) AS avg_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM properties;



SELECT COUNT(*) AS total_sales
FROM properties;


SELECT AVG(bedrooms) AS avg_bedrooms
FROM properties;


SELECT propertyType, COUNT(*) AS count_sales
FROM properties
GROUP BY propertyType
ORDER BY count_sales DESC;


SELECT postcode, COUNT(*) AS count_sales
FROM properties
GROUP BY postcode
ORDER BY count_sales DESC
LIMIT 10;


SELECT YEAR(datesold) AS year, COUNT(*) AS sales_count
FROM properties
GROUP BY YEAR(datesold)
ORDER BY year;

SELECT MONTH(datesold) AS month, COUNT(*) AS sales_count
FROM properties
GROUP BY MONTH(datesold)
ORDER BY month;

SELECT 
    propertyType, AVG(price) AS avg_price
FROM
    properties
GROUP BY propertyType
ORDER BY avg_price DESC;


SELECT bedrooms, AVG(price) AS avg_price
FROM properties
GROUP BY bedrooms
ORDER BY bedrooms;


