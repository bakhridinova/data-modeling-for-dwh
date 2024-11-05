drop schema if exists northwind;
create schema northwind;

-- Set the default schema for this session to 'northwind'
set search_path to northwind;

-- Create the tables within the 'northwind' schema
create table northwind.customers
(
    CustomerID   varchar(5) primary key,
    CompanyName  varchar(40),
    ContactName  varchar(30),
    ContactTitle varchar(30),
    Address      varchar(60),
    City         varchar(15),
    Region       varchar(15),
    PostalCode   varchar(10),
    Country      varchar(15),
    Phone        varchar(24),
    Fax          varchar(24)
);


create table northwind.employees
(
    EmployeeID      serial primary key,
    LastName        varchar(20),
    FirstName       varchar(10),
    Title           varchar(30),
    TitleOfCourtesy VARCHAR(25),
    BirthDate       date,
    HireDate        date,
    Address         varchar(60),
    City            varchar(15),
    Region          varchar(15),
    PostalCode      varchar(10),
    Country         varchar(15),
    HomePhone       varchar(24),
    Extension       varchar(4),
    Notes           TEXT,
    ReportsTo       INTEGER
);


create table northwind.shippers
(
    ShipperID   serial primary key,
    CompanyName varchar(40),
    Phone       varchar(24)
);


create table northwind.suppliers
(
    SupplierID   serial primary key,
    CompanyName  varchar(40),
    ContactName  varchar(30),
    ContactTitle varchar(30),
    Address      varchar(60),
    City         varchar(15),
    Region       varchar(15),
    PostalCode   varchar(10),
    Country      varchar(15),
    Phone        varchar(24),
    Fax          varchar(24),
    HomePage     text
);


create table northwind.categories
(
    CategoryID   serial primary key,
    CategoryName varchar(15),
    Description  text
);


create table northwind.products
(
    ProductID       serial primary key,
    ProductName     varchar(40),
    SupplierID      int references northwind.suppliers (SupplierID),
    CategoryID      int references northwind.categories (CategoryID),
    QuantityPerUnit varchar(20),
    UnitPrice       numeric(10, 2),
    UnitsInStock    int,
    UnitsOnOrder    int,
    ReorderLevel    int,
    Discontinued    bool
);


create table northwind.orders
(
    OrderID      serial primary key,
    CustomerID   varchar(5) references northwind.customers (CustomerID),
    EmployeeID   int references northwind.employees (EmployeeID),
    OrderDate    date,
    RequiredDate date,
    ShippedDate  date,
    ShipVia      int references northwind.shippers (ShipperID),
    Freight      numeric(10, 2)
);


create table northwind.order_details
(
    OrderID   int references northwind.orders (OrderID),
    ProductID int references northwind.products (ProductID),
    UnitPrice numeric(10, 2),
    Quantity  int,
    Discount  real,
    primary key (OrderID, ProductID)
);


-- Insert data into the 'northwind' schema

set search_path to northwind;

--CUSTOMERS table
insert into northwind.customers (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, PostalCode, Country,
                                 Phone)
values ('ALFKI', 'Alfreds Futterkiste', 'Maria Anders', 'Sales Representative', 'Obere Str. 57', 'Berlin', '12209',
        'Germany', '+49 30 0074321');
insert into northwind.customers (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, PostalCode, Country,
                                 Phone)
values ('ANATR', 'Ana Trujillo Emparedados y helados', 'Ana Trujillo', 'Owner', 'Avda. de la Constitución 2222',
        'México D.F.', '05021', 'Mexico', '(5) 555-4729');
insert into northwind.customers (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, PostalCode, Country,
                                 Phone)
values ('ANTON', 'Antonio Moreno Taquería', 'Antonio Moreno', 'Owner', 'Mataderos 2312', 'México D.F.', '05023',
        'Mexico', '(5) 555-3932');
insert into northwind.customers (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, PostalCode, Country,
                                 Phone)
values ('AROUT', 'Around the Horn', 'Thomas Hardy', 'Sales Representative', '120 Hanover Sq.', 'London', 'WA1 1DP',
        'UK', '(171) 555-7788');
insert into northwind.customers (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, PostalCode, Country,
                                 Phone)
values ('BERGS', 'Berglunds snabbköp', 'Christina Berglund', 'Order Administrator', 'Berguvsvägen 8', 'Luleå',
        'S-958 22', 'Sweden', '0921-12 34 65');
insert into northwind.customers (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, PostalCode, Country,
                                 Phone)
values ('BLONP', 'Blondesddsl père et fils', 'Frédérique Citeaux', 'Marketing Manager', '24, place Kléber',
        'Strasbourg', '67000', 'France', '88.60.15.31');
insert into northwind.customers (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, PostalCode, Country,
                                 Phone)
values ('BOLID', 'Bólido Comidas preparadas', 'Martín Sommer', 'Owner', 'C/ Araquil, 67', 'Madrid', '28023', 'Spain',
        '(91) 555 22 82');
insert into northwind.customers (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, PostalCode, Country,
                                 Phone)
values ('BONAP', 'Bon app''', 'Laurence Lebihan', 'Owner', '12, rue des Bouchers', 'Marseille', '13008', 'France',
        '91.24.45.40');
insert into northwind.customers (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, PostalCode, Country,
                                 Phone)
values ('BOTTM', 'Bottom-Dollar Markets', 'Elizabeth Lincoln', 'Accounting Manager', '23 Tsawassen Blvd.', 'Tsawassen',
        'T2F 8M4', 'Canada', '(604) 555-4729');
insert into northwind.customers (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, PostalCode, Country,
                                 Phone)
values ('BSBEV', 'B''s Beverages', 'Victoria Ashworth', 'Sales Representative', 'Fauntleroy Circus', 'London',
        'EC2 5NT', 'UK', '(171) 555-1212');
insert into northwind.customers (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, PostalCode, Country,
                                 Phone)
values ('CACTU', 'Cactus Comidas para llevar', 'Patricio Simpson', 'Sales Agent', 'Cerrito 333', 'Buenos Aires', '1010',
        'Argentina', '(1) 135-5555');
insert into northwind.customers (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, PostalCode, Country,
                                 Phone)
values ('CENTC', 'Centro comercial Moctezuma', 'Francisco Chang', 'Marketing Manager', 'Sierras de Granada 9993',
        'México D.F.', '05022', 'Mexico', '(5) 555-3392');
insert into northwind.customers (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, PostalCode, Country,
                                 Phone)
values ('CHOPS', 'Chop-suey Chinese', 'Yang Wang', 'Owner', 'Hauptstr. 29', 'Bern', '3012', 'Switzerland',
        '0452-076545');
insert into northwind.customers (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, PostalCode, Country,
                                 Phone)
values ('COMMI', 'Comércio Mineiro', 'Pedro Afonso', 'Sales Associate', 'Av. dos Lusíadas, 23', 'São Paulo',
        '05432-043', 'Brazil', '(11) 555-7647');
insert into northwind.customers (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, PostalCode, Country,
                                 Phone)
values ('CONSH', 'Consolidated Holdings', 'Elizabeth Brown', 'Sales Representative', 'Berkeley Gardens 12 Brewery',
        'London', 'WX1 6LT', 'UK', '(171) 555-2282');
insert into northwind.customers (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, PostalCode, Country,
                                 Phone)
values ('DRACD', 'Drachenblut Delikatessen', 'Sven Ottlieb', 'Order Administrator', 'Walserweg 21', 'Aachen', '52066',
        'Germany', '0241-039123');
insert into northwind.customers (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, PostalCode, Country,
                                 Phone)
values ('DUMON', 'Du monde entier', 'Janine Labrune', 'Owner', '67, rue des Cinquante Otages', 'Nantes', '44000',
        'France', '40.67.88.88');
insert into northwind.customers (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, PostalCode, Country,
                                 Phone)
values ('EASTC', 'Eastern Connection', 'Ann Devon', 'Sales Agent', '35 King George', 'London', 'WX3 6FW', 'UK',
        '(171) 555-0297');
insert into northwind.customers (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, PostalCode, Country,
                                 Phone)
values ('ERNSH', 'Ernst Handel', 'Roland Mendel', 'Sales Manager', 'Kirchgasse 6', 'Graz', '8010', 'Austria',
        '7675-3425');
insert into northwind.customers (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, PostalCode, Country,
                                 Phone)
values ('FOLIG', 'Folies gourmandes', 'Martine Rancé', 'Assistant Sales Agent', '184, chaussée de Tournai', 'Lille',
        '59000', 'France', '20.16.10.16');


--EMPLOYEES table
insert into northwind.employees (EmployeeID, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address,
                                 City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo)
values (1, 'Davolio', 'Nancy', 'Sales Representative', 'Ms.', '1948-12-08', '1992-05-01', '507 - 20th Ave. E. Apt. 2A',
        'Seattle', 'North America', '98122', 'USA', '(206) 555-9857', '5467',
        'Education includes a BA in psychology from Colorado State University in 1970. She also completed "The Art of the Cold Call." Nancy is a member of Toastmasters International.',
        2);
insert into northwind.employees (EmployeeID, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address,
                                 City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo)
values (2, 'Fuller', 'Andrew', 'Vice President, Sales', 'Dr.', '1952-02-19', '1992-08-14', '908 W. Capital Way',
        'Tacoma', 'North America', '98401', 'USA', '(206) 555-9482', '3457',
        'Andrew received his BTS commercial in 1974 and a Ph.D. in international marketing from the University of Dallas in 1981. He is fluent in French and Italian and reads German. He joined the company as a sales representative, was promoted to sales manager in January 1992 and to vice president of sales in March 1993. Andrew is a member of the Sales Management Roundtable, the Seattle Chamber of Commerce, and the Pacific Rim Importers Association.',
        NULL);
insert into northwind.employees (EmployeeID, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address,
                                 City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo)
values (3, 'Leverling', 'Janet', 'Sales Representative', 'Ms.', '1963-08-30', '1992-04-01', '722 Moss Bay Blvd.',
        'Kirkland', 'North America', '98033', 'USA', '(206) 555-3412', '3355',
        'Janet has a BS degree in chemistry from Boston College (1984). She has also completed a certificate program in food retailing management. Janet was hired as a sales associate in 1991 and promoted to sales representative in February 1992.',
        2);
insert into northwind.employees (EmployeeID, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address,
                                 City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo)
values (4, 'Peacock', 'Margaret', 'Sales Representative', 'Mrs.', '1937-09-19', '1993-05-03', '4110 Old Redmond Rd.',
        'Redmond', 'North America', '98052', 'USA', '(206) 555-8122', '5176',
        'Margaret holds a BA in English literature from Concordia College (1958) and an MA from the American Institute of Culinary Arts (1966). She was assigned to the London office temporarily from July through November 1992.',
        2);
insert into northwind.employees (EmployeeID, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address,
                                 City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo)
values (5, 'Buchanan', 'Steven', 'Sales Manager', 'Mr.', '1955-03-04', '1993-10-17', '14 Garrett Hill', 'London',
        'British Isles', 'SW1 8JR', 'UK', '(71) 555-4848', '3453',
        'Steven Buchanan graduated from St. Andrews University, Scotland, with a BSC degree in 1976. Upon joining the company as a sales representative in 1992, he spent 6 months in an orientation program at the Seattle office and then returned to his permanent post in London. He was promoted to sales manager in March 1993. Mr. Buchanan has completed the courses "Successful Telemarketing" and "International Sales Management." He is fluent in French.',
        2);
insert into northwind.employees (EmployeeID, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address,
                                 City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo)
values (6, 'Suyama', 'Michael', 'Sales Representative', 'Mr.', '1963-07-02', '1993-10-17', 'Coventry House Miner Rd.',
        'London', 'British Isles', 'EC2 7JR', 'UK', '(71) 555-7773', '428',
        'Michael is a graduate of Sussex University (MA, economics, 1983) and the University of California at Los Angeles (MBA, marketing, 1986). He has also taken the courses "Multi-Cultural Selling" and "Time Management for the Sales Professional." He is fluent in Japanese and can read and write French, Portuguese, and Spanish.',
        5);
insert into northwind.employees (EmployeeID, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address,
                                 City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo)
values (7, 'King', 'Robert', 'Sales Representative', 'Mr.', '1960-05-29', '1994-01-02', 'Edgeham Hollow Winchester Way',
        'London', 'British Isles', 'RG1 9SP', 'UK', '(71) 555-5598', '465',
        'Robert King served in the Peace Corps and traveled extensively before completing his degree in English at the University of Michigan in 1992, the year he joined the company. After completing a course entitled "Selling in Europe," he was transferred to the London office in March 1993.',
        5);
insert into northwind.employees (EmployeeID, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address,
                                 City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo)
values (8, 'Callahan', 'Laura', 'Inside Sales Coordinator', 'Ms.', '1958-01-09', '1994-03-05', '4726 - 11th Ave. N.E.',
        'Seattle', 'North America', '98105', 'USA', '(206) 555-1189', '2344',
        'Laura received a BA in psychology from the University of Washington. She has also completed a course in business French. She reads and writes French.',
        2);
insert into northwind.employees (EmployeeID, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address,
                                 City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo)
values (9, 'Dodsworth', 'Anne', 'Sales Representative', 'Ms.', '1966-01-27', '1994-11-15', '7 Houndstooth Rd.',
        'London', 'British Isles', 'WG2 7LT', 'UK', '(71) 555-4444', '452',
        'Anne has a BA degree in English from St. Lawrence College. She is fluent in French and German.', 5);
insert into northwind.employees (EmployeeID, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address,
                                 City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo)
values (10, 'Smith', 'John', 'Marketing Manager', 'Mr.', '1976-05-12', '2014-07-20', '100 Market St.', 'San Francisco',
        'North America', '94105', 'USA', '(415) 555-1234', '1010',
        'John has an MBA from Stanford University and a BA from the University of California, Berkeley. He loves marketing and is a member of the American Marketing Association.',
        3);
insert into northwind.employees (EmployeeID, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address,
                                 City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo)
values (11, 'Johnson', 'Harry', 'Accounting Manager', 'Mr.', '1980-03-05', '2015-10-10', '200 Financial Circle',
        'Los Angeles', 'North America', '90010', 'USA', '(213) 555-5678', '1020',
        'Harry is a Certified Public Accountant and has a Master''s degree in Accounting from the University of Southern California. He loves numbers.',
        2);
insert into northwind.employees (EmployeeID, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address,
                                 City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo)
values (12, 'Williams', 'Samantha', 'Human Resources Manager', 'Ms.', '1978-06-15', '2018-07-22', '300 People Pl.',
        'Chicago', 'North America', '60601', 'USA', '(312) 555-3456', '1030',
        'Samantha has a Master''s in Human Resources Management from Northwestern University. She loves helping people and the company culture.',
        1);
insert into northwind.employees (EmployeeID, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address,
                                 City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo)
values (13, 'Jones', 'Robert', 'Sales Representative', 'Mr.', '1982-11-20', '2016-08-15', '400 Sales Dr.', 'Dallas',
        'North America', '75201', 'USA', '(214) 555-7890', '1040',
        'Robert has a degree in Business from the University of Texas at Dallas. He is a very persuasive person and is great at closing deals.',
        5);
insert into northwind.employees (EmployeeID, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address,
                                 City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo)
values (14, 'Brown', 'Angela', 'Cust Service Representative', 'Ms.', '1975-07-30', '2017-12-23', '500 Service Ln.',
        'New York', 'North America', '10001', 'USA', '(212) 555-4321', '1050',
        'Angela is a people person and loves to help customers get their issues resolved. She has a degree in Communication from Boston University.',
        4);
insert into northwind.employees (EmployeeID, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address,
                                 City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo)
values (15, 'Davis', 'Paul', 'Software Engineer', 'Mr.', '1985-09-09', '2019-06-21', '600 Coding St.', 'San Jose',
        'North America', '95101', 'USA', '(408) 555-9876', '1060',
        'Paul is a full-stack engineer who knows multiple programming languages and loves to build web applications. He has a Computer Science degree from Carnegie Mellon University.',
        4);
insert into northwind.employees (EmployeeID, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address,
                                 City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo)
values (16, 'Miller', 'Natalie', 'Product Manager', 'Ms.', '1981-02-20', '2020-10-01', '700 Product Way', 'Austin',
        'North America', '78701', 'USA', '(512) 555-3456', '1070',
        'Natalie has a MBA from the University of Texas at Austin and loves leading teams to launch new products.', 3);
insert into northwind.employees (EmployeeID, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address,
                                 City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo)
values (17, 'Wilson', 'Roger', 'Project Manager', 'Mr.', '1983-04-13', '2020-02-15', '800 Project Ave.', 'Atlanta',
        'North America', '30301', 'USA', '(404) 555-4567', '1080',
        'Roger is a certified PMP and has a Master''s in Project Management from Georgia State University. He loves organizing and leading project teams.',
        2);
insert into northwind.employees (EmployeeID, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address,
                                 City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo)
values (18, 'Moore', 'Jennifer', 'Data Analyst', 'Ms.', '1979-12-01', '2021-07-03', '900 Data Blvd.', 'Seattle',
        'North America', '98101', 'USA', '(206) 555-5678', '1090',
        'Jennifer is great with data and can create reports that provide insights to help make business decisions. She has a degree in Statistics from the University of Washington.',
        4);
insert into northwind.employees (EmployeeID, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address,
                                 City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo)
values (19, 'Taylor', 'Richard', 'Network Administrator', 'Mr.', '1977-10-25', '2020-12-19', '1000 Network St.',
        'Houston', 'North America', '77001', 'USA', '(713) 555-4321', '1100',
        'Richard is CCNA-certified and has a degree in Computer Networking from the University of Houston. He loves to ensure that the company network is running smoothly and securely.',
        4);
insert into northwind.employees (EmployeeID, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address,
                                 City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo)
values (20, 'Adams', 'Sophie', 'Quality Assurance Engineer', 'Ms.', '1987-03-23', '2019-08-03', '100 QA St.',
        'San Francisco', 'North America', '94016', 'USA', '(888) 555-1234', '5050',
        'Sophie holds a computer science degree from San Francisco State University and has several years of experience in software testing. She is critical for ensuring the development of high-quality software.',
        5);


--SHIPPERS table
insert into northwind.shippers (ShipperID, CompanyName, Phone)
values (1, 'Speedy Express', '(503) 555-9831');
insert into northwind.shippers (ShipperID, CompanyName, Phone)
values (2, 'United Package', '(503) 555-3199');
insert into northwind.shippers (ShipperID, CompanyName, Phone)
values (3, 'Federal Shipping', '(503) 555-9931');
insert into northwind.shippers (ShipperID, CompanyName, Phone)
values (4, 'Globex Corporation', '(503) 555-1111');
insert into northwind.shippers (ShipperID, CompanyName, Phone)
values (5, 'Planet Express', '(503) 555-0011');
insert into northwind.shippers (ShipperID, CompanyName, Phone)
values (6, 'AAAAA Transport LLC', '(503) 555-5555');
insert into northwind.shippers (ShipperID, CompanyName, Phone)
values (7, 'SwiftShip', '(503) 555-2222');
insert into northwind.shippers (ShipperID, CompanyName, Phone)
values (8, 'Interstellar Shipping', '(503) 555-3333');
insert into northwind.shippers (ShipperID, CompanyName, Phone)
values (9, 'Zephyr Couriers', '(503) 555-4444');
insert into northwind.shippers (ShipperID, CompanyName, Phone)
values (10, 'Cosmic Delivery Service', '(503) 555-5555');


--SUPPLIERS table
insert into northwind.suppliers (SupplierID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode,
                                 Country, Phone, Fax, HomePage)
values (1, 'Exotic Liquids', 'Charlotte Cooper', 'Purchasing Manager', '49 Gilbert St.', 'London', 'British Isles',
        'EC1 4SD', 'UK', '(171) 555-2222', NULL, 'http://www.exoticliquids.co.uk');
insert into northwind.suppliers (SupplierID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode,
                                 Country, Phone, Fax, HomePage)
values (2, 'New Orleans Cajun Delights', 'Shelley Burke', 'Order Administrator', 'P.O. Box 78934', 'New Orleans',
        'North America', '70117', 'USA', '(100) 555-4822', NULL, 'http://www.neworleansdel.com');
insert into northwind.suppliers (SupplierID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode,
                                 Country, Phone, Fax, HomePage)
values (3, 'Grandma Kelly''s Homestead', 'Regina Murphy', 'Sales Representative', '707 Oxford Rd.', 'Ann Arbor',
        'North America', '48104', 'USA', '(313) 555-5735', '(313) 555-3349', 'http://www.grandmakellyshomestead.com');
insert into northwind.suppliers (SupplierID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode,
                                 Country, Phone, Fax, HomePage)
values (4, 'Tokyo Traders', 'Yoshi Nagase', 'Marketing Manager', '9-8 Sekimai musashino-shi', 'Tokyo', 'Asia', '100',
        'Japan', '(03) 3555-5011', NULL, 'http://www.tokyotraders.com');
insert into northwind.suppliers (SupplierID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode,
                                 Country, Phone, Fax, HomePage)
values (5, 'Cooperativa de Quesos ''Las Cabras''', 'Antonio del Valle Saavedra', 'Export Administrator',
        'Calle del Rosal 4', 'Oviedo', 'Europe', '33007', 'Spain', '(98) 598 76 54', NULL, 'http://www.lascabras.com');
insert into northwind.suppliers (SupplierID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode,
                                 Country, Phone, Fax, HomePage)
values (6, 'Mayumi''s', 'Mayumi Ohno', 'Marketing Representative', '92 Setsuko Chuo-ku', 'Osaka', 'Asia', '545',
        'Japan', '(06) 431-7877', NULL, 'http://www.mayumis.com');
insert into northwind.suppliers (SupplierID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode,
                                 Country, Phone, Fax, HomePage)
values (7, 'Pavlova, Ltd.', 'Ian Devling', 'Marketing Manager', '74 Rose St. Moonie Ponds', 'Melbourne', 'Victoria',
        '3058', 'Australia', '(03) 444-2343', '(03) 444-6588', 'http://www.pavlovaltd.com');
insert into northwind.suppliers (SupplierID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode,
                                 Country, Phone, Fax, HomePage)
values (8, 'Specialty Biscuits, Ltd.', 'Peter Wilson', 'Sales Representative', '29 King''s Way', 'Manchester',
        'British Isles', 'M14 GSD', 'UK', '(161) 555-4448', NULL, 'http://www.specialtybiscuits.co.uk');
insert into northwind.suppliers (SupplierID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode,
                                 Country, Phone, Fax, HomePage)
values (9, 'PB Knäckebröd AB', 'Lars Peterson', 'Sales Agent', 'Kaloadagatan 13', 'Göteborg', 'Scandinavia', 'S-345 67',
        'Sweden', '(031) 123 45 67', '(031) 123 45 89', 'http://www.pbknäckebrödab.se');
insert into northwind.suppliers (SupplierID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode,
                                 Country, Phone, Fax, HomePage)
values (10, 'Refrescos Americanas LTDA', 'Carlos Diaz', 'Sales Representative', 'Av. das Americanas 12.890',
        'Sao Paulo', 'South America', '5442', 'Brazil', '(11) 555 4640', NULL, 'http://www.refrescosamericanas.com.br');


--CATEGORIES table
insert into northwind.categories (CategoryID, CategoryName, Description)
values (1, 'Beverages', 'Soft drinks, coffees, teas, beers, and ales');
insert into northwind.categories (CategoryID, CategoryName, Description)
values (2, 'Condiments', 'Sweet and savory sauces, relishes, spreads, and seasonings');
insert into northwind.categories (CategoryID, CategoryName, Description)
values (3, 'Confections', 'Desserts, candies, and sweet breads');
insert into northwind.categories (CategoryID, CategoryName, Description)
values (4, 'Dairy Products', 'Cheeses');
insert into northwind.categories (CategoryID, CategoryName, Description)
values (5, 'Grains/Cereals', 'Breads, crackers, pasta, and cereal');
insert into northwind.categories (CategoryID, CategoryName, Description)
values (6, 'Meat/Poultry', 'Prepared meats');
insert into northwind.categories (CategoryID, CategoryName, Description)
values (7, 'Produce', 'Dried fruit and bean curd');
insert into northwind.categories (CategoryID, CategoryName, Description)
values (8, 'Seafood', 'Seaweed and fish');
insert into northwind.categories (CategoryID, CategoryName, Description)
values (9, 'Snacks', 'Potato Chips and other salty snacks');
insert into northwind.categories (CategoryID, CategoryName, Description)
values (10, 'Bakery', 'Breads and related products');


--PRODUCTS table
insert into northwind.products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice,
                                UnitsInStock, UnitsOnOrder, ReorderLevel)
values (1, 'Chai', 1, 1, '10 boxes x 20 bags', 18, 39, 0, 10);
insert into northwind.products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice,
                                UnitsInStock, UnitsOnOrder, ReorderLevel)
values (2, 'Chang', 1, 1, '24 - 12 oz bottles', 19, 17, 40, 25);
insert into northwind.products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice,
                                UnitsInStock, UnitsOnOrder, ReorderLevel)
values (3, 'Aniseed Syrup', 1, 2, '12 - 550 ml bottles', 10, 13, 70, 25);
insert into northwind.products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice,
                                UnitsInStock, UnitsOnOrder, ReorderLevel)
values (4, 'Chef Anton''s Cajun Seasoning', 2, 2, '48 - 6 oz jars', 22, 53, 0, 0);
insert into northwind.products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice,
                                UnitsInStock, UnitsOnOrder, ReorderLevel)
values (5, 'Chef Anton''s Gumbo Mix', 2, 2, '36 boxes', 21.35, 0, 0, 0);
insert into northwind.products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice,
                                UnitsInStock, UnitsOnOrder, ReorderLevel)
values (6, 'Grandma''s Boysenberry Spread', 3, 2, '12 - 8 oz jars', 25, 120, 0, 25);
insert into northwind.products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice,
                                UnitsInStock, UnitsOnOrder, ReorderLevel)
values (7, 'Uncle Bob''s Organic Dried Pears', 3, 7, '12 - 1 lb pkgs.', 30, 15, 0, 10);
insert into northwind.products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice,
                                UnitsInStock, UnitsOnOrder, ReorderLevel)
values (8, 'Northwoods Cranberry Sauce', 3, 2, '12 - 12 oz jars', 40, 6, 0, 0);
insert into northwind.products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice,
                                UnitsInStock, UnitsOnOrder, ReorderLevel)
values (9, 'Mishi Kobe Niku', 4, 6, '18 - 500 g pkgs.', 97, 29, 0, 0);
insert into northwind.products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice,
                                UnitsInStock, UnitsOnOrder, ReorderLevel)
values (10, 'Ikura', 4, 8, '12 - 200 ml jars', 31, 31, 0, 0);
insert into northwind.products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice,
                                UnitsInStock, UnitsOnOrder, ReorderLevel)
values (11, 'Queso Cabrales', 5, 4, '1 kg pkg.', 21, 22, 30, 30);
insert into northwind.products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice,
                                UnitsInStock, UnitsOnOrder, ReorderLevel)
values (12, 'Queso Manchego La Pastora', 5, 4, '10 - 500 g pkgs.', 38, 86, 0, 0);
insert into northwind.products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice,
                                UnitsInStock, UnitsOnOrder, ReorderLevel)
values (13, 'Konbu', 6, 8, '2 kg box', 6, 24, 0, 5);
insert into northwind.products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice,
                                UnitsInStock, UnitsOnOrder, ReorderLevel)
values (14, 'Tofu', 6, 7, '40 - 100 g pkgs.', 23.25, 35, 0, 5);
insert into northwind.products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice,
                                UnitsInStock, UnitsOnOrder, ReorderLevel)
values (15, 'Genen Shouyu', 6, 2, '24 - 250 ml bottles', 15.5, 39, 0, 5);
insert into northwind.products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice,
                                UnitsInStock, UnitsOnOrder, ReorderLevel)
values (16, 'Pavlova', 7, 3, '32 - 500 g boxes', 17.45, 29, 0, 10);
insert into northwind.products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice,
                                UnitsInStock, UnitsOnOrder, ReorderLevel)
values (17, 'Alice Mutton', 7, 6, '20 - 1 kg tins', 39, 0, 0, 0);
insert into northwind.products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice,
                                UnitsInStock, UnitsOnOrder, ReorderLevel)
values (18, 'Carnarvon Tigers', 7, 8, '16 kg pkg.', 62.5, 42, 0, 0);
insert into northwind.products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice,
                                UnitsInStock, UnitsOnOrder, ReorderLevel)
values (19, 'Teatime Chocolate Biscuits', 8, 3, '10 boxes x 12 pieces', 9.2, 25, 0, 5);
insert into northwind.products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice,
                                UnitsInStock, UnitsOnOrder, ReorderLevel)
values (20, 'Sir Rodney''s Marmalade', 8, 3, '30 gift boxes', 81, 40, 0, 0);


--ORDERS table
insert into northwind.orders (OrderID, CustomerID, EmployeeID, OrderDate, ShippedDate, ShipVia, Freight)
values (1, 'ALFKI', 5, '2012-07-04', '2012-07-16', 3, 32.38);
insert into northwind.orders (OrderID, CustomerID, EmployeeID, OrderDate, ShippedDate, ShipVia, Freight)
values (2, 'ANATR', 6, '2012-08-01', '2012-08-02', 1, 11.61);
insert into northwind.orders (OrderID, CustomerID, EmployeeID, OrderDate, ShippedDate, ShipVia, Freight)
values (3, 'ANTON', 4, '2012-08-02', '2012-08-12', 2, 65.83);
insert into northwind.orders (OrderID, CustomerID, EmployeeID, OrderDate, ShippedDate, ShipVia, Freight)
values (4, 'AROUT', 3, '2012-08-04', '2012-08-07', 2, 41.34);
insert into northwind.orders (OrderID, CustomerID, EmployeeID, OrderDate, ShippedDate, ShipVia, Freight)
values (5, 'BERGS', 2, '2012-08-05', '2012-08-10', 3, 51.30);
insert into northwind.orders (OrderID, CustomerID, EmployeeID, OrderDate, ShippedDate, ShipVia, Freight)
values (6, 'BLONP', 1, '2012-08-07', '2012-08-12', 1, 58.17);
insert into northwind.orders (OrderID, CustomerID, EmployeeID, OrderDate, ShippedDate, ShipVia, Freight)
values (7, 'BOLID', 4, '2012-08-09', '2012-08-18', 2, 29.61);
insert into northwind.orders (OrderID, CustomerID, EmployeeID, OrderDate, ShippedDate, ShipVia, Freight)
values (8, 'BONAP', 3, '2012-08-10', '2012-08-16', 1, 13.97);
insert into northwind.orders (OrderID, CustomerID, EmployeeID, OrderDate, ShippedDate, ShipVia, Freight)
values (9, 'BOTTM', 1, '2012-08-12', '2012-08-20', 3, 81.91);
insert into northwind.orders (OrderID, CustomerID, EmployeeID, OrderDate, ShippedDate, ShipVia, Freight)
values (10, 'BSBEV', 2, '2012-08-15', '2012-08-21', 2, 140.51);
insert into northwind.orders (OrderID, CustomerID, EmployeeID, OrderDate, ShippedDate, ShipVia, Freight)
values (11, 'CACTU', 3, '2012-09-01', '2012-09-10', 2, 20.12);
insert into northwind.orders (OrderID, CustomerID, EmployeeID, OrderDate, ShippedDate, ShipVia, Freight)
values (12, 'CENTC', 4, '2012-09-04', '2012-09-09', 1, 75.89);
insert into northwind.orders (OrderID, CustomerID, EmployeeID, OrderDate, ShippedDate, ShipVia, Freight)
values (13, 'CHOPS', 5, '2012-09-07', '2012-09-16', 3, 37.09);
insert into northwind.orders (OrderID, CustomerID, EmployeeID, OrderDate, ShippedDate, ShipVia, Freight)
values (14, 'COMMI', 6, '2012-09-09', '2012-09-14', 2, 45.97);
insert into northwind.orders (OrderID, CustomerID, EmployeeID, OrderDate, ShippedDate, ShipVia, Freight)
values (15, 'CONSH', 1, '2012-09-12', '2012-09-19', 1, 70.29);
insert into northwind.orders (OrderID, CustomerID, EmployeeID, OrderDate, ShippedDate, ShipVia, Freight)
values (16, 'DRACD', 2, '2012-09-14', '2012-09-23', 3, 27.93);
insert into northwind.orders (OrderID, CustomerID, EmployeeID, OrderDate, ShippedDate, ShipVia, Freight)
values (17, 'DUMON', 3, '2012-09-15', '2012-09-24', 2, 31.14);
insert into northwind.orders (OrderID, CustomerID, EmployeeID, OrderDate, ShippedDate, ShipVia, Freight)
values (18, 'EASTC', 4, '2012-09-19', '2012-09-29', 1, 24.59);
insert into northwind.orders (OrderID, CustomerID, EmployeeID, OrderDate, ShippedDate, ShipVia, Freight)
values (19, 'ERNSH', 5, '2012-09-23', '2012-10-01', 3, 74.83);
insert into northwind.orders (OrderID, CustomerID, EmployeeID, OrderDate, ShippedDate, ShipVia, Freight)
values (20, 'FOLIG', 1, '2012-09-25', '2012-10-03', 2, 58.33);


--ORDER_DETAILS table
insert into northwind.order_details (OrderID, ProductID, UnitPrice, Quantity, Discount)
values (1, 1, 18.00, 12, 0.05);
insert into northwind.order_details (OrderID, ProductID, UnitPrice, Quantity, Discount)
values (1, 2, 19.00, 25, 0.00);
insert into northwind.order_details (OrderID, ProductID, UnitPrice, Quantity, Discount)
values (2, 3, 10.00, 20, 0.05);
insert into northwind.order_details (OrderID, ProductID, UnitPrice, Quantity, Discount)
values (2, 4, 22.00, 30, 0.00);
insert into northwind.order_details (OrderID, ProductID, UnitPrice, Quantity, Discount)
values (3, 5, 21.35, 15, 0.00);
insert into northwind.order_details (OrderID, ProductID, UnitPrice, Quantity, Discount)
values (3, 6, 25.00, 20, 0.05);
insert into northwind.order_details (OrderID, ProductID, UnitPrice, Quantity, Discount)
values (4, 7, 30.00, 10, 0.00);
insert into northwind.order_details (OrderID, ProductID, UnitPrice, Quantity, Discount)
values (4, 8, 40.00, 10, 0.05);
insert into northwind.order_details (OrderID, ProductID, UnitPrice, Quantity, Discount)
values (5, 9, 97.00, 5, 0.00);
insert into northwind.order_details (OrderID, ProductID, UnitPrice, Quantity, Discount)
values (5, 10, 31.00, 5, 0.10);
insert into northwind.order_details (OrderID, ProductID, UnitPrice, Quantity, Discount)
values (6, 11, 21.00, 35, 0.05);
insert into northwind.order_details (OrderID, ProductID, UnitPrice, Quantity, Discount)
values (6, 12, 38.00, 15, 0.00);
insert into northwind.order_details (OrderID, ProductID, UnitPrice, Quantity, Discount)
values (7, 13, 6.00, 25, 0.05);
insert into northwind.order_details (OrderID, ProductID, UnitPrice, Quantity, Discount)
values (7, 14, 23.25, 30, 0.00);
insert into northwind.order_details (OrderID, ProductID, UnitPrice, Quantity, Discount)
values (8, 15, 15.50, 20, 0.05);
insert into northwind.order_details (OrderID, ProductID, UnitPrice, Quantity, Discount)
values (8, 16, 17.45, 25, 0.00);
insert into northwind.order_details (OrderID, ProductID, UnitPrice, Quantity, Discount)
values (9, 17, 39.00, 15, 0.10);
insert into northwind.order_details (OrderID, ProductID, UnitPrice, Quantity, Discount)
values (9, 18, 62.50, 40, 0.00);
insert into northwind.order_details (OrderID, ProductID, UnitPrice, Quantity, Discount)
values (10, 19, 9.20, 50, 0.00);
insert into northwind.order_details (OrderID, ProductID, UnitPrice, Quantity, Discount)
values (10, 20, 81.00, 35, 0.05);
