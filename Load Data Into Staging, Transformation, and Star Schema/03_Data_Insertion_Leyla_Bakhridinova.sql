insert into staging.stagingCustomers
select * from northwind.customers;

insert into staging.stagingEmployees
select * from northwind.employees;

insert into staging.stagingCategories
select * from northwind.categories;

insert into staging.stagingShippers
select * from northwind.shippers;

insert into staging.stagingSuppliers
select * from northwind.suppliers;

insert into staging.stagingProducts
select * from northwind.products;

insert into staging.stagingOrders
select * from northwind.orders;

insert into staging.stagingOrderDetails
select * from northwind.order_details;

insert into star.dimCustomer (customerID, companyName, contactName, contactTitle, address, city, region, postalCode, country, phone)
select customerID, companyName, contactName, contactTitle, address, city, region, postalCode, country, phone
from staging.stagingCustomers;

insert into star.dimEmployee (employeeID, lastName, firstName, title, birthDate, hireDate, address, city, region, postalCode, country, homePhone, extension)
select employeeID, lastName, firstName, title, birthDate, hireDate, address, city, region, postalCode, country, homePhone, extension
from staging.stagingEmployees;

insert into star.dimCategory (categoryID, categoryName, description)
select categoryID, categoryName, description
from staging.stagingCategories;

insert into star.dimShipper (shipperID, companyName, phone)
select shipperID, companyName, phone
from staging.stagingShippers;

insert into star.dimSupplier (supplierID, companyName, contactName, contactTitle, address, city, region, postalCode, country, phone)
select supplierID, companyName, contactName, contactTitle, address, city, region, postalCode, country, phone
from staging.stagingSuppliers;

insert into star.dimProduct (productID, productName, supplierID, categoryID, quantityPerUnit, unitPrice, unitsInStock)
select productID, productName, supplierID, categoryID, quantityPerUnit, unitPrice, unitsInStock
from staging.stagingProducts;

DO $$
    declare
        rec RECORD;
    begin
        for rec in
            (select orderDate as date from staging.stagingOrders
             where orderDate is not null)
            LOOP
                IF not exists (select 1 from star.dimDate where date = rec.date) then
                    insert into star.dimDate (date, day, month, year, quarter, weekOfYear)
                    values (
                               rec.date,
                               extract(DAY from rec.date),
                               extract(MONTH from rec.date),
                               extract(YEAR from rec.date),
                               extract(QUARTER from rec.date),
                               extract(WEEK from rec.date)
                           );
                end IF;
            end LOOP;
    end $$;


-- Load data into factSales
insert into star.factSales
(
    salesid, dateID, customerID, productID, employeeID, categoryID, shipperID, supplierID, quantitySold, unitPrice, discount, taxAmount
)
select
    o.orderID,
    d.dateID,
    c.customerID,
    p.productID,
    e.employeeID,
    cat.categoryID,
    s.shipperID,
    sup.supplierID,
    od.quantity,
    od.unitPrice,
    od.discount,
    (od.quantity * od.unitPrice - od.discount) * 0.1 as taxAmount
from staging.stagingOrderDetails od
         join staging.stagingOrders o on od.orderID = o.orderID
         join staging.stagingCustomers c on o.customerID = c.customerID
         join staging.stagingProducts p on od.productID = p.productID
         left join staging.stagingEmployees e on o.employeeID = e.employeeID
         left join staging.stagingCategories cat on p.categoryID = cat.categoryID
         left join staging.stagingShippers s on o.shipVia = s.shipperID
         left join staging.stagingSuppliers sup on p.supplierID = sup.supplierID
         left join star.dimDate d on o.orderDate = d.date;