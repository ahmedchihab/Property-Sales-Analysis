Use property;
/* =========================================
   -- Check for NULL values
   ========================================= */
/* Goal: Identify columns that have missing values */

SELECT
    SUM(CASE WHEN datesold IS NULL THEN 1 ELSE 0 END) AS null_datesold,
    SUM(CASE WHEN postcode IS NULL THEN 1 ELSE 0 END) AS null_postcode,
    SUM(CASE WHEN price IS NULL THEN 1 ELSE 0 END) AS null_price,
    SUM(CASE WHEN propertyType IS NULL THEN 1 ELSE 0 END) AS null_propertyType,
    SUM(CASE WHEN bedrooms IS NULL THEN 1 ELSE 0 END) AS null_bedrooms
FROM properties;

-- Check for empty strings

SELECT COUNT(*) AS empty_fields
FROM properties
WHERE TRIM(postcode) = '' OR TRIM(propertyType) = '';

-- Detect outliers

SELECT MIN(price) AS min_price, MAX(price) AS max_price, AVG(price) AS avg_price
FROM properties;

-- Check for negative or impossible values

SELECT *
FROM properties
WHERE price <= 0 OR bedrooms <= 0;

-- Detect duplicate rows

SELECT datesold, postcode, price, propertyType, bedrooms, COUNT(*) AS nb
FROM properties
GROUP BY datesold, postcode, price, propertyType, bedrooms
HAVING nb > 1;

-- Ensure dates are in correct format (YYYY-MM-DD)

SELECT *
FROM properties
WHERE datesold IS NULL OR datesold NOT REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$';


-- Detect unusual or invalid categories in propertyType */
SELECT DISTINCT propertyType
FROM properties;

-- Detect unrealistic cases (e.g., 20 bedrooms) 

SELECT *
FROM properties
WHERE bedrooms > 10;