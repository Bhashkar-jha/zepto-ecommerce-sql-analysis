# 🛒 Zepto E-Commerce & Inventory Analytics (SQL Project)

## 📌 Project Overview
This project performs end-to-end data analysis on Zepto's inventory, pricing strategies, product categories, and delivery performance using Microsoft SQL Server / MySQL. It answers key business questions around stock risk, discount optimization, and delivery metrics.

---

## 🛠️ Tech Stack & Key Concepts Used
- *Database Engine:* MySQL / SQL Server
- *Data Hygiene & Modeling:* Relational Modeling, INNER JOIN, LEFT JOIN, COALESCE for NULL handling.
- *Advanced Data Aggregation:* GROUP BY, SUM, AVG, COUNT.
- *Analytical & Window Functions:* Common Table Expressions (CTEs), DENSE_RANK() OVER (PARTITION BY ... ORDER BY ...).
- *Database Programming & Reusability:* 
  - *SQL Views:* v_product_delivery_summary
  - *Stored Procedures:* GetProductsByCategory
  - *User-Defined Functions (UDF):* CalculateSavings

---

## 💡 Key Highlights & Queries Developed

### 1. Advanced Window Function (Top Discounted Products Per Category)
Used DENSE_RANK() with CTEs to rank and filter top discounted products per category without collapsing rows.

### 2. Automated Stored Procedure (GetProductsByCategory)
Developed a custom stored procedure accepting input category parameters to dynamically pull available quantities, pricing, and product names.

### 3. Custom Function (CalculateSavings)
Built a deterministic function to programmatically calculate total customer savings ($MRP - Discounted Price$) inline within queries.

---

## 🎯 Business Impact & Key Insights
- *Inventory Valuation:* Identified top hubs holding maximum stock value to prevent overstocking.
- *Pricing Strategy:* Mapped category-wise discount trends to balance profit margins with volume sales.
-
