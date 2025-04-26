 -- Question 1:

WITH ProductSplit AS (
  SELECT
    OrderID,
    CustomerName,
    TRIM(value) AS Product
  FROM ProductDetail,
  JSON_TABLE(
    CONCAT('["', REPLACE(Products, ', ', '","'), '"]'),
    "$[*]" COLUMNS(value VARCHAR(255) PATH "$")
  ) AS jt
)
SELECT * FROM ProductSplit; 


-- Question 2: 
-- 1️⃣ Create the normalized Orders table: 
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;


-- 2️⃣ Create the normalized OrderItems table:


