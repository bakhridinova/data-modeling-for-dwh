-- Top 5 Products by Transactions Count
select fs.productID,
       dp.productName,
       COUNT(fs.salesID) as transactionsCount
from star.factSales fs
         join
     star.dimProduct dp on fs.productID = dp.productID
group by fs.productID, dp.productName
order by transactionsCount desc
LIMIT 5;

-- Worst 5 Products by Transactions Count
select fs.productID,
       dp.productName,
       COUNT(fs.salesID) as transactionsCount
from star.factSales fs
         join
     star.dimProduct dp on fs.productID = dp.productID
group by fs.productID, dp.productName
order by transactionsCount
LIMIT 5;

-- Top 5 Products by Total Sales
select p.productName,
       sum(f.totalAmount) as totalSales
from star.factSales f
         join star.dimProduct p on f.productID = p.productID
group by p.productName
order by totalSales desc
LIMIT 5;

-- Worst 5 Products by Total Sales
select p.productName,
       sum(f.totalAmount) as totalSales
from star.factSales f
         join star.dimProduct p on f.productID = p.productID
group by p.productName
order by totalSales
LIMIT 5;

-- Top 5 Products by Tax
select p.productName,
       sum(f.taxAmount) as totalTax
from star.factSales f
         join star.dimProduct p on f.productID = p.productID
group by p.productName
order by totalTax desc
LIMIT 5;

-- Worst 5 Products by Tax
select p.productName,
       sum(f.taxAmount) as totalTax
from star.factSales f
         join star.dimProduct p on f.productID = p.productID
group by p.productName
order by totalTax
LIMIT 5;

-- 3)Display the top (worst) five customers by number of transactions and purchase amount (add gender section, region, country, product categories, age group).
--  This involves querying the FactSales table.

-- Top 5 Customers by Number of Transactions
WITH FilteredCustomers as (select c.contactname,
                                  c.region,
                                  c.country,
                                  p.categoryID,
                                  COUNT(f.salesID)   as numTransactions,
                                  sum(f.totalAmount) as totalPurchaseAmount
                           from star.factSales f
                                    join star.dimCustomer c on f.customerID = c.customerID
                                    join star.dimProduct p on f.productID = p.productID
                           where c.region is null       -- Change for region filter (Well since all customers region are null, we will get 0 results. That's why I will use IS NULL)
                             and c.country = 'UK'       -- Change for country filter
                             and p.categoryID in (2, 3) -- Change for category filter
                           group by c.customerID, c.contactname, c.region, c.country, p.categoryID)
select contactname,
       totalPurchaseAmount,
       numTransactions
from FilteredCustomers
order by totalPurchaseAmount desc, numTransactions desc
LIMIT 5;

-- Worst 5 Customers by Number of Transactions
WITH FilteredCustomers as (select c.contactname,
                                  c.region,
                                  c.country,
                                  p.categoryID,
                                  COUNT(f.salesID)   as numTransactions,
                                  sum(f.totalAmount) as totalPurchaseAmount
                           from star.factSales f
                                    join star.dimCustomer c on f.customerID = c.customerID
                                    join star.dimProduct p on f.productID = p.productID
                           where c.region IS NULL       -- Change for region filter (Well since all customers region are null, we will get 0 results. That's why I will use IS NULL)
                             and c.country = 'UK'       -- Change for country filter
                             and p.categoryID in (2, 3) -- Change for category filter
                           group by c.customerID, c.contactname, c.region, c.country, p.categoryID)
select contactname,
       totalPurchaseAmount,
       numTransactions
from FilteredCustomers
order by totalPurchaseAmount, numTransactions
LIMIT 5;

-- 4) Display a sales chart (with the total amount of sales and the quantity of items sold) for the first week of each month.
--      This involves querying the FactSales and DimDate tables.

select d.month,
       d.year,
       sum(f.totalAmount)  as totalSales,
       sum(f.quantitySold) as totalQuantitySold
from star.factSales f
         join star.dimDate d on f.dateID = d.dateID
where d.day <= 7
group by d.month, d.year
order by d.month;

-- 5) Display a weekly sales report (with monthly totals) by product category (period: one year).
--    This involves querying the FactSales, DimDate, and DimProduct tables.

select p.categoryID,
       d.year,
       d.month,
       d.weekOfYear,
       sum(f.totalAmount)  as totalSales,
       sum(f.quantitySold) as totalQuantitySold
from star.factSales f
         join star.dimDate d on f.dateID = d.dateID
         join star.dimProduct p on f.productID = p.productID
where d.year = 2012-- or specify the desired year
group by p.categoryID,
         d.year,
         d.month,
         d.weekOfYear
order by p.categoryID,
         d.year,
         d.month,
         d.weekOfYear;

-- 6) Display the median monthly sales value by product category and country.
--      This involves querying the FactSales, DimProduct, and DimCustomer tables and requires a more complex query or a custom function to calculate the median.
WITH MonthlySales as (select p.categoryID,
                             c.country,
                             d.year,
                             d.month,
                             sum(f.totalAmount) as totalSales
                      from star.factSales f
                               join star.dimDate d on f.dateID = d.dateID
                               join star.dimProduct p on f.productID = p.productID
                               join star.dimCustomer c on f.customerID = c.customerID
                      group by p.categoryID,
                               c.country,
                               d.year,
                               d.month),
     rankedSales as (select categoryID,
                            country,
                            year,
                            month,
                            totalSales,
                            ROW_NUMBER()
                            OVER (partition by categoryID, country, year, month order by totalSales) AS row_num,
                            COUNT(*) OVER (partition by categoryID, country, year, month)            AS total_count
                     from MonthlySales)
select categoryID,
       country,
       year,
       month,
       avg(totalSales) as median_sales
from rankedSales
where row_num in (FLOOR((total_count + 1) / 2.0), CEIL((total_count + 1) / 2.0))
group by categoryID,
         country,
         year,
         month
order by categoryID,
         country,
         year,
         month;

-- 7) Display sales rankings by product category (with the best-selling categories at the top).
-- This involves querying the FactSales and DimProduct tables.
select
    f.categoryid,
    sum(f.totalAmount) as totalSales,
    rank() OVER (order by sum(f.totalAmount) desc) as salesrank
from
    star.factSales f
        join star.dimProduct p on f.productID = p.productID
group by
    f.categoryID
order by
    salesrank;
