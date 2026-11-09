CREATE DATABASE zepto_project;
USE zepto_project;


SELECT *
 FROM zepto_v2;
 
 
 DESCRIBE zepto_v2;
 
 
 SELECT COUNT(*) AS total_products FROM zepto_v2;
 
 SELECT category, COUNT(*) AS count_per_category
 FROM zepto_v2
 GROUP BY category
 ORDER BY count_per_category DESC;


SELECT name, availableQuantity, outOfStock
FROM zepto_v2
WHERE outOfStock = 'TRUE';

SELECT name, category, mrp
FROM zepto_v2
ORDER BY mrp DESC
LIMIT 5;

SELECT name, category, mrp, discountPercent
FROM zepto_v2
ORDER BY discountPercent DESC
LIMIT 5;

SELECT category, AVG(mrp) AS avg_mrp, AVG(discountedSellingPrice) AS avg_selling_price
FROM zepto_v2
GROUP BY category;

SELECT name,
category, availableQuantity, discountedSellingPrice, 
(availableQuantity*discountedSellingPrice) AS total_inventory_value
FROM zepto_v2
ORDER BY total_inventory_value DESC
LIMIT 10;

CREATE TABLE category_details ( 
category_name VARCHAR(100),
delivery_hub VARCHAR(50),
manager_name VARCHAR(50) );

SELECT * FROM category_details;

INSERT INTO category_details ( category_name, delivery_hub, manager_name) VALUES
( ' Fruits and Vegetable', 'Hub-A', 'Rahul Singh'),
( 'Dairy and Breakfast', 'Hub-B', 'Priya Singh'),
( 'Munchies', 'Hub-A', 'Rahul Sharma'),
( 'Cold Drinks and Juices', 'Hub-C', 'Amit Verma');


SELECT 
P.name AS product_name,
P.category,
P. discountedSellingPrice,
C.delivery_hub,
C.manager_name
FROM zepto_v2 P
INNER JOIN category_details C
ON P.category = C.category_name
LIMIT 15;

SELECT
P.name AS product_name,
P.category,
coalesce(C.delivery_hub, 'General Hub') AS delivery_hub,
coalesce(C.manager_name, 'Unassigned') AS manager_name
FROM zepto_v2 P 
LEFT JOIN category_details C 
ON P.category = C.category_name
LIMIT 15;

CREATE VIEW v_product_delivery_summary AS 
SELECT
P.name AS product_name,
P.category,
coalesce(C.delivery_hub, 'General Hub') AS delivery_hub,
coalesce(C.manager_name, 'Unassigned') AS manager_name
FROM zepto_v2 P 
LEFT JOIN category_details C 
ON P.category = C.category_name;

SELECT * FROM v_product_delivery_summary
LIMIT 15;

SELECT
coalesce(C.delivery_hub,'General Hub') AS delivery_hub,
COUNT(P.name) AS total_products,
SUM(P.availableQuantity * P.discountedSellingPrice) AS total_hub_inventory_value,
ROUND(AVG(P.discountPercent),2) AS avg_discount_offered
FROM zepto_V2 P 
LEFT JOIN category_details C 
on P.category = C.category_name
GROUP BY delivery_hub
ORDER BY total_hub_inventory_value DESC;

WITH Rankedproducts AS (
SELECT category,
name,
mrp,
discountedSellingPrice,
discountPercent,
DENSE_RANK () OVER ( PARTITION BY category ORDER BY discountPercent DESC) AS discount_rank
FROM zepto_v2)
SELECT category, name, mrp, discountedSellingPrice, discountPercent, discount_rank
FROM Rankedproducts 
WHERE discount_rank <= 2;

DELIMITER //
CREATE PROCEDURE GetProductsByCategory( IN input_category VARCHAR(100))
BEGIN
SELECT name AS product_name,
mrp,
discountedSellingPrice,
availableQuantity
FROM zepto_v2
Where category = input_category;
END//
DELIMITER ;

SELECT DISTINCT category FROM zepto_v2;

CALL GetProductsByCategory('Fruits & Vegetables');

DELIMITER //
CREATE FUNCTION CalculateSavings (mrp DECIMAL(10,2), selling_price DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
DECLARE Savings DECIMAL (10,2);
SET Savings = mrp - selling_price;
RETURN Savings;
END //
DELIMITER ;

SELECT name AS product_name,
mrp,
discountedSellingPrice,
calculateSavings(mrp, discountedSellingPrice) AS total_saved_amount
FROM zepto_v2
LIMIT 10;