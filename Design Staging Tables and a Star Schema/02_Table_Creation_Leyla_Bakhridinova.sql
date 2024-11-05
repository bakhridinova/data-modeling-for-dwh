create schema staging;

SET search_path to staging;

-- Staging Tables
create table staging.stagingOrders
(
    orderID      int,
    customerID   varchar(5),
    employeeID   int,
    orderDate    date,
    requiredDate date,
    shippedDate  date,
    shipVia      int,
    freight      numeric(10, 2)
);

create table staging.stagingOrderDetails
(
    orderID   int,
    productID int,
    unitPrice numeric(10, 2),
    quantity  int,
    discount  real
);

create table staging.stagingProducts
(
    productID       int,
    productName     varchar(40),
    supplierID      int,
    categoryID      int,
    quantityPerUnit varchar(20),
    unitPrice       numeric(10, 2),
    unitsInStock    int,
    unitsOnOrder    int,
    reorderLevel    int,
    discontinued    bool
);

create table staging.stagingCustomers
(
    customerID   varchar(5),
    companyName  varchar(40),
    contactName  varchar(30),
    contactTitle varchar(30),
    address      varchar(60),
    city         varchar(15),
    region       varchar(15),
    postalCode   varchar(10),
    country      varchar(15),
    phone        varchar(24),
    fax          varchar(24)
);

create table staging.stagingEmployees
(
    employeeID      int,
    lastName        varchar(20),
    firstName       varchar(10),
    title           varchar(30),
    titleOfCourtesy VARCHAR(25),
    birthDate       date,
    hireDate        date,
    address         varchar(60),
    city            varchar(15),
    region          varchar(15),
    postalCode      varchar(10),
    country         varchar(15),
    homePhone       varchar(24),
    extension       varchar(4),
    notes           TEXT,
    reportsTo       INTEGER
);

create table staging.stagingCategories
(
    categoryID   int,
    categoryName varchar(15),
    description  text
);

create table staging.stagingShippers
(
    shipperID   int,
    companyName varchar(40),
    phone       varchar(24)
);

create table staging.stagingSuppliers
(
    supplierID   int,
    companyName  varchar(40),
    contactName  varchar(30),
    contactTitle varchar(30),
    address      varchar(60),
    city         varchar(15),
    region       varchar(15),
    postalCode   varchar(10),
    country      varchar(15),
    phone        varchar(24),
    fax          varchar(24),
    homePage     text
);

create schema star;

SET search_path to star;

-- Dimension Tables
create table star.dimDate
(
    dateID     serial primary key ,
    date       date,
    day        int,
    month      int,
    year       int,
    quarter    int,
    weekOfYear int
);

create table star.dimCustomer
(
    customerID   varchar(5) primary key ,
    companyName  varchar(40),
    contactName  varchar(30),
    contactTitle varchar(30),
    address      varchar(60),
    city         varchar(15),
    region       varchar(15),
    postalCode   varchar(10),
    country      varchar(15),
    phone        varchar(24)
);



create table star.dimEmployee
(
    employeeID int primary key ,
    lastName   varchar(20),
    firstName  varchar(10),
    title      varchar(30),
    birthDate  date,
    hireDate   date,
    address    varchar(60),
    city       varchar(15),
    region     varchar(15),
    postalCode varchar(10),
    country    varchar(15),
    homePhone  varchar(24),
    extension  varchar(4)
);

create table star.dimCategory
(
    categoryID   int primary key ,
    categoryName varchar(15),
    description  text
);

create table star.dimShipper
(
    shipperID   int primary key ,
    companyName varchar(40),
    phone       varchar(24)
);

create table star.dimSupplier
(
    supplierID   int primary key ,
    companyName  varchar(40),
    contactName  varchar(30),
    contactTitle varchar(30),
    address      varchar(60),
    city         varchar(15),
    region       varchar(15),
    postalCode   varchar(10),
    country      varchar(15),
    phone        varchar(24)
);

create table star.dimProduct
(
    productID       int primary key ,
    productName     varchar(40),
    supplierID      int references star.dimSupplier (supplierID),
    categoryID      int references star.dimCategory (categoryID),
    quantityPerUnit varchar(20),
    unitPrice       numeric(10, 2),
    unitsInStock    int
);


-- Fact Table

create table star.factSales
(
    salesID      serial,
    dateID       int references star.dimDate(dateID),
    customerID   varchar(5) references star.dimCustomer(customerID),
    productID    int references star.dimProduct(productID),
    employeeID   int references star.dimEmployee(employeeID),
    categoryID   int references star.dimCategory(categoryID),
    shipperID    int references star.dimShipper(shipperID),
    supplierID   int references star.dimSupplier(supplierID),
    quantitySold int,
    unitPrice    numeric(10, 2),
    discount     real,
    totalAmount  numeric(10, 2) generated always as (quantitySold * unitPrice - discount) STORED,
    taxAmount    numeric(10, 2),
    primary key (salesID, productID)
);