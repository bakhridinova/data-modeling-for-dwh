# Designing Data Warehousing Solutions

The purpose of this task is to design and implement DWH solutions by creating staging tables and a star schema and then loading data there and creating scripts for business report queries.

The task will take you about **3 hours**.

Please be aware that the task is **mandatory**.

You can earn a maximum of **36 points** for this task.

**Task Description**

You need to use the same scripts from the NORTHWIND database that you worked with previously.

The task is divided into several steps, which must be completed in order.

_Click the arrows to see more information._

## Design Staging Tables and a Star Schema

The staging tables will be used for loading the initial data, and the star schema will be organized around a fact table and related dimension tables.

1. Create the following staging tables:

- staging_orders
- staging_order_details
- staging_products
- staging_customers
- staging_employees
- staging_categories
- staging_shippers
- staging_suppliers

Designing a star schema design involves creating dimension tables and a fact table.

2. Use the proposed set of dimension tables and their respective columns.

| **DimDate**          | **DimCustomer**          | **DimProduct**          | **DimEmployee**          |
|----------------------|--------------------------|-------------------------|--------------------------|
| DateID (Primary Key) | CustomerID (Primary Key) | ProductID (Primary Key) | EmployeeID (Primary Key) |
| Date                 | CompanyName              | ProductName             | LastName                 |
| Day                  | ContactName              | SupplierID (FK)         | FirstName                |
| Month                | ContactTitle             | CategoryID (FK)         | Title                    |
| Year                 | Address                  | QuantityPerUnit         | BirthDate                |
| Quarter              | City                     | UnitPrice               | HireDate                 |
| WeekOfYear           | Region                   | UnitsInStock            | Address                  |
|                      | PostalCode               |                         | City                     |
|                      | Country                  |                         | Region                   |
|                      | Phone                    |                         | PostalCode               |
|                      |                          |                         | Country                  |
|                      |                          |                         | HomePhone                |
|                      |                          |                         | Extension                |

| **DimCategory**          | **DimShipper**          | **DimSupplier**          |
|--------------------------|-------------------------|--------------------------|
| CategoryID (Primary Key) | ShipperID (Primary Key) | SupplierID (Primary Key) |
| CategoryName             | CompanyName             | CompanyName              |
| Description              | Phone                   | ContactName              |
|                          |                         | ContactTitle             |
|                          |                         | Address                  |
|                          |                         | City                     |
|                          |                         | Region                   |
|                          |                         | PostalCode               |
|                          |                         | Country                  |
|                          |                         | Phone                    |


And the table FactSales with the columns below:

- SalesID (Primary Key)
- DateID (FK to Date Dimension)
- CustomerID (FK to Customer Dimension)
- ProductID (FK to Product Dimension)
- EmployeeID (FK to Employee Dimension)
- CategoryID (FK to Category Dimension)
- ShipperID (FK to Shipper Dimension)
- SupplierID (FK to Supplier Dimension)
- QuantitySold
- UnitPrice
- Discount
- TotalAmount (Calculated as QuantitySold * UnitPrice - Discount)
- TaxAmount

## Load Data Into Staging, Transformation, and Star Schema

1. For each source table in the northwind_pg database, you need to create a corresponding staging table and load data into it. Below is an example for the Customers table.

Assuming staging tables with the same structure as the source tables have already been created, load data into staging_customer from the source Customers table.

```sql 
INSERT INTO staging_customers
SELECT * FROM Customers;
```

2. Repeat this process for each table listed in step 1:

- staging_orders
- staging_order_details
- staging_products
- staging_customers
- staging_employees
- staging_categories
- staging_shippers
- staging_suppliers

3. Transform the data from the staging tables and load it into the respective dimension tables. Here's an example for DimCustomer:

```sql
INSERT INTO DimCustomer (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone)
SELECT CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone
FROM staging_customers;
```

4. Repeat this process for other dimensions (DimProduct, DimEmployee, etc.), transforming the data as necessary.

5. Load it into the fact table, as shown below:

```sql
INSERT INTO FactSales (DateID, CustomerID, ProductID, EmployeeID, CategoryID, ShipperID, SupplierID, QuantitySold, UnitPrice, Discount, TotalAmount, TaxAmount)
SELECT
d.DateID,   
c.CustomerID,  
p.ProductID,  
e.EmployeeID,  
cat.CategoryID,  
s.ShipperID,  
sup.SupplierID,
od.Quantity,
od.UnitPrice,
od.Discount,    
(od.Quantity * od.UnitPrice - od.Discount) AS TotalAmount,
(od.Quantity * od.UnitPrice - od.Discount) * 0.1 AS TaxAmount     
FROM staging_order_details od
JOIN staging_orders o ON od.OrderID = o.OrderID
JOIN staging_customers c ON o.CustomerID = c.CustomerID
JOIN staging_products p ON od.ProductID = p.ProductID  
LEFT JOIN staging_employees e ON o.EmployeeID = e.EmployeeID
LEFT JOIN staging_categories cat ON p.CategoryID = cat.CategoryID
LEFT JOIN staging_shippers s ON o.ShipVia = s.ShipperID  
LEFT JOIN staging_suppliers sup ON p.SupplierID = sup.SupplierID
LEFT JOIN DimDate d ON o.OrderDate = d.Date;
```

6. After loading data into the fact and dimension tables, you should validate the data to ensure it is accurate and complete. This process typically involves:

Checking for data and referential integrity
Verifying that the data in the fact and dimension tables aligns with the source data
Ensuring that all records have been transferred correctly

## Prepare Business Report Queries

Now that you have built the DWH, create scripts (SQLs) to cover the following business requirements:

- Display average sales (total amount, net amount, tax; number of transactions), the rolling average for three months (January–February; January–February–March; February–March–April) per day (specifying the month and date range) across all product categories (selected category, list of categories) in geographical sections (regions, countries, states), in gender sections (men, women), by age group (0–18, 19–28, 28–45, 45–60, 60+), by income (0–20000, 20001–40000, 40001–60000, 60001–80000, 80001-100000). This involves querying the FactSales and DimDate tables.
- Display the top (worst) five products by number of transactions, total sales, and tax (add category section). This involves querying the FactSales table.
- Display the top (worst) five customers by number of transactions and purchase amount (add gender section, region, country, product categories, age group). This involves querying the FactSales table.
- Display a sales chart (with the total amount of sales and the quantity of items sold) for the first week of each month. This involves querying the FactSales and DimDate tables.
- Display a weekly sales report (with monthly totals) by product category (period: one year). This involves querying the FactSales, DimDate, and DimProduct tables.
- Display the median monthly sales value by product category and country. This involves querying the FactSales, DimProduct, and DimCustomer tables and requires a more complex query or a custom function to calculate the median.
- Display sales rankings by product category (with the best-selling categories at the top). This involves querying the FactSales and DimProduct tables.

## How the Task Will Be Evaluated

| Criteria/Points | 0 points | 2 points | 3 points | 4 points | 5 points | 6 points |
|-----------------|-----------|----------|----------|----------|----------|----------|
| **Completeness** | No attempt or incomplete response to task requirements | Task is partially completed and does not meet all specified requirements | Task is completed and meets all specified requirements | Task is completed and meets all specified requirements but contains syntax errors | Task is completed and meets all specified requirements but contains logical errors | Task is completed with no errors and meets all specified requirements |
| **Syntax Errors** | Code does not work | Major syntax errors prevent code from being executed | Code contains minor syntax errors |  | Code has minimal syntax errors | Code is free of syntax errors |
| **Logical Errors** | Code returns unexpected results | Major logical errors significantly affect the program's logic | Code contains minor logical errors | Code contains a few logical errors | Code has minimal logical errors | Code is free of logical errors |
| **Minor Issues** | Task is completed with a significant number of minor issues (typos, formatting, readability, excessive complexity, etc.) | Task is completed with a noticeable number of minor issues | Task is completed with minor issues | Task is completed with some minor issues | Task is completed with minimal minor issues | Task is completed with no issues |
| **Description** | Inadequate or missing description | Adequate description | Good description | Very good description | Excellent description | Outstanding description |
| **Creativity** | Little to no creativity | Some creativity in using different language constructs | Good creativity in using different language constructs | Very good creativity in using different language constructs | Excellent creativity in using different language constructs | Outstanding creativity; uses innovative, original constructs |

## Result

This task will be checked by the instructor. Submit the result as several `.sql` files and place them in your Git repository. Provide a link in the field below. Also, please note the following requirements:

- Include comments in the SQL scripts to explain their purpose and functionality.
- The names of files should be clear—e.g., `01_Table_Creation_Name_Surname.sql`, `02_Data_Insertion_Name_Surname.sql`, etc.
