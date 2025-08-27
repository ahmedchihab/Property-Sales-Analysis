# Property Sales Data Analysis & Data Modeling

![Project Badge](https://img.shields.io/badge/Project-Property%20Sales%20Data-blue)
![SQL Badge](https://img.shields.io/badge/Skills-SQL-green)
![EDA Badge](https://img.shields.io/badge/Skills-EDA-yellow)
![Database Badge](https://img.shields.io/badge/Database-Design-orange)

**Author:** Ahmed Chihab  
**Dataset:** 29,580 property sales records (2007–2019)  
**Skills Demonstrated:** SQL, Data Cleaning, Data Modeling, Exploratory Data Analysis (EDA), Database Design

---

## 📌 Project Overview

This project involves analyzing property sales data, cleaning and structuring it, and creating a relational database to support insightful analysis.  

**Key Goals:**

- Ensure high-quality, clean data  
- Build a relational database for property sales  
- Extract insights on prices, trends, and property types  

---

## 🗂 Dataset Description

| Column        | Data Type | Description                       |
|---------------|-----------|-----------------------------------|
| `datesold`    | date      | Date when the property was sold    |
| `postcode`    | varchar   | Property postcode                  |
| `price`       | decimal   | Sale price of the property         |
| `propertyType`| varchar   | Type of property (e.g., house)    |
| `bedrooms`    | int       | Number of bedrooms                 |

---

## 🔧 Key Steps

<details>
<summary>1️⃣ Data Cleaning</summary>

- Checked for **NULL values** and duplicates  
- Corrected **date formats**  
- Ensured consistency in `propertyType` and `postcode`  

```sql
-- Check for NULLs
SELECT COUNT(*) AS null_datesold
FROM sales
WHERE datesold IS NULL;

-- Remove duplicate sales
DELETE FROM sales
WHERE id NOT IN (
    SELECT MIN(id)
    FROM sales
    GROUP BY datesold, postcode, price, propertyType, bedrooms
);
````

</details>

<details>
<summary>2️⃣ Data Modeling</summary>

* Created **Property** and **Sale** tables
* Defined **Primary Keys** and **Foreign Keys**
* One-to-many relationship: one property can have multiple sales

**Tables:**

| Table      | Columns & Types                                                                          |
| ---------- | ---------------------------------------------------------------------------------------- |
| `Property` | `propertyID` (PK, INT), `postcode` (VARCHAR), `propertyType` (VARCHAR), `bedrooms` (INT) |
| `Sale`     | `saleID` (PK, INT), `propertyID` (FK, INT), `datesold` (DATE), `price` (DECIMAL)         |

**ERD (Entity-Relationship Diagram)**

![ERD Placeholder](./images/ERD.png)

```sql
CREATE TABLE Property (
    propertyID INT PRIMARY KEY AUTO_INCREMENT,
    postcode VARCHAR(20),
    propertyType VARCHAR(20),
    bedrooms INT
);

CREATE TABLE Sale (
    saleID INT PRIMARY KEY AUTO_INCREMENT,
    propertyID INT,
    datesold DATE,
    price DECIMAL(15,2),
    FOREIGN KEY (propertyID) REFERENCES Property(propertyID)
);
```

</details>

<details>
<summary>3️⃣ Data Population</summary>

```sql
-- Insert unique properties
INSERT INTO Property (postcode, propertyType, bedrooms)
SELECT DISTINCT postcode, propertyType, bedrooms
FROM raw_sales;

-- Map sales to propertyID
INSERT INTO Sale (propertyID, datesold, price)
SELECT p.propertyID, r.datesold, r.price
FROM raw_sales r
JOIN Property p
ON r.postcode = p.postcode
AND r.propertyType = p.propertyType
AND r.bedrooms = p.bedrooms;
```

</details>

<details>
<summary>4️⃣ Exploratory Data Analysis (EDA)</summary>

**SQL Queries for Insights:**

```sql
-- Average price per property type
SELECT propertyType, AVG(price) AS avg_price
FROM Sale s
JOIN Property p ON s.propertyID = p.propertyID
GROUP BY propertyType;

-- Sales count per year
SELECT YEAR(datesold) AS year, COUNT(*) AS sales_count
FROM Sale
GROUP BY YEAR(datesold)
ORDER BY year;
```

**Sample Insights:**

| Insight                            | Observation    |
| ---------------------------------- | -------------- |
| Highest avg price by property type | Houses > Flats |
| Peak sales year                    | 2016           |
| Month with highest sales           | May            |
| Most common property type          | House          |

</details>

---

## 💡 Key Takeaways

* Prices vary by property type and location
* Sales show seasonal trends, peaking in spring
* Houses dominate both in volume and price
* Clean, structured data enables efficient querying and analysis

---

## ⚙️ Skills Highlighted

![SQL](https://img.shields.io/badge/SQL-Blue)
![Data Cleaning](https://img.shields.io/badge/Data%20Cleaning-Purple)
![Data Modeling](https://img.shields.io/badge/Data%20Modeling-Orange)
![EDA](https://img.shields.io/badge/EDA-Green)
![Database Design](https://img.shields.io/badge/Database%20Design-Red)

---

## 🔗 Next Steps / Improvements

* Add more property attributes (e.g., size, parking, garden)
* Predictive analysis for prices or trends
* Build interactive dashboards (Power BI, Tableau)

---

## 📁 Project Structure

```
Property_Sales_Project/
│
├─ data/                   # Raw and cleaned CSVs
├─ sql/                    # SQL scripts for tables and queries
├─ notebooks/              # EDA and analysis notebooks
└─ README.md               # Project documentation
```

---

## 📬 Contact

**Ahmed Chihab**

* GitHub: [github.com/ahmedchihab](https://github.com/ahmedchihab)
* LinkedIn: [linkedin.com/in/ahmed-chihab](https://www.linkedin.com/in/ahmed-chihab)
* Email: [ahmed.chihab@uit.ac.ma](mailto:ahmed.chihab@uit.ac.ma)


