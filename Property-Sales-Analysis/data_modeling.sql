
ALTER TABLE properties
ADD COLUMN propertyID INT AUTO_INCREMENT PRIMARY KEY FIRST;

DESCRIBE properties;

SELECT * FROM properties
limit 10;


CREATE TABLE Sale (
    saleID INT AUTO_INCREMENT PRIMARY KEY,
    propertyID INT NOT NULL,
    datesold DATE NOT NULL,
    price DECIMAL(15,2) NOT NULL,
    FOREIGN KEY (propertyID) REFERENCES properties(propertyID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

SELECT * FROM sale 
limit 10;

INSERT INTO Sale (propertyID, datesold, price)
SELECT propertyID, datesold, price
FROM properties;

