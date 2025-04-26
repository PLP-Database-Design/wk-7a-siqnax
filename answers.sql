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
-- 1: The normalized Orders table: 
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;


-- 2: The normalized OrderItems table:
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;


