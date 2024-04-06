

```bash

mysql -u awf -p

# Create a new database advendure_works_db
create database advendure_works_db;
create database advendure_works;

# Use the database
USE advendure_works;

# Create adress table
-- DROP SCHEMA IF EXISTS SalesLT;

CREATE SCHEMA IF NOT EXISTS SalesLT;

-- SalesLT.Address definition

-- Drop table

-- DROP TABLE IF EXISTS SalesLT.Address;
CREATE TABLE IF NOT EXISTS SalesLT.Address (
    AddressID INT AUTO_INCREMENT PRIMARY KEY,
    AddressLine1 VARCHAR(60) NOT NULL,
    AddressLine2 VARCHAR(60),
    City VARCHAR(30) NOT NULL,
    StateProvinceName VARCHAR(100) NOT NULL,
    CountryRegionName VARCHAR(100) NOT NULL,
    PostalCode VARCHAR(15) NOT NULL,
    rowguid CHAR(36) NOT NULL,
    ModifiedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY (rowguid),
    INDEX IX_Address_AddressLine1 (AddressLine1),
    INDEX IX_Address_StateProvince (StateProvinceName)
);

# view the table
-- DESCRIBE SalesLT.Address;


# Create Customer table
CREATE TABLE SalesLT.Customer (
    CustomerID INT AUTO_INCREMENT NOT NULL,
    NameStyle INT DEFAULT 0 NOT NULL,
    Title VARCHAR(8) COLLATE utf8_general_ci NULL,
    FirstName VARCHAR(50) COLLATE utf8_general_ci NOT NULL,
    MiddleName VARCHAR(50) COLLATE utf8_general_ci NULL,
    LastName VARCHAR(50) COLLATE utf8_general_ci NOT NULL,
    Suffix VARCHAR(10) COLLATE utf8_general_ci NULL,
    CompanyName VARCHAR(128) COLLATE utf8_general_ci NULL,
    SalesPerson VARCHAR(256) COLLATE utf8_general_ci NULL,
    EmailAddress VARCHAR(50) COLLATE utf8_general_ci NULL,
    Phone VARCHAR(20) COLLATE utf8_general_ci NULL,
    PasswordHash VARCHAR(128) COLLATE utf8_general_ci NOT NULL,
    PasswordSalt VARCHAR(10) COLLATE utf8_general_ci NOT NULL,
    rowguid CHAR(36) NOT NULL,
    ModifiedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (CustomerID),
    UNIQUE KEY `AK_Customer_rowguid` (`rowguid`)
);





create database advendure_works;

# Use the database
USE advendure_works;

# Create adress table Address 
CREATE TABLE IF NOT EXISTS Address (
    AddressID INT AUTO_INCREMENT PRIMARY KEY,
    AddressLine1 VARCHAR(60) NOT NULL,
    AddressLine2 VARCHAR(60),
    City VARCHAR(30) NOT NULL,
    StateProvinceName VARCHAR(100) NOT NULL,
    CountryRegionName VARCHAR(100) NOT NULL,
    PostalCode VARCHAR(15) NOT NULL,
    rowguid CHAR(36) NOT NULL,
    ModifiedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY (rowguid),
    INDEX IX_Address_AddressLine1 (AddressLine1),
    INDEX IX_Address_StateProvince (StateProvinceName)
);



# Create Customer table
CREATE TABLE Customer (
    CustomerID INT AUTO_INCREMENT NOT NULL,
    NameStyle INT DEFAULT 0 NOT NULL,
    Title VARCHAR(8) COLLATE utf8_general_ci NULL,
    FirstName VARCHAR(50) COLLATE utf8_general_ci NOT NULL,
    MiddleName VARCHAR(50) COLLATE utf8_general_ci NULL,
    LastName VARCHAR(50) COLLATE utf8_general_ci NOT NULL,
    Suffix VARCHAR(10) COLLATE utf8_general_ci NULL,
    CompanyName VARCHAR(128) COLLATE utf8_general_ci NULL,
    SalesPerson VARCHAR(256) COLLATE utf8_general_ci NULL,
    EmailAddress VARCHAR(50) COLLATE utf8_general_ci NULL,
    Phone VARCHAR(20) COLLATE utf8_general_ci NULL,
    PasswordHash VARCHAR(128) COLLATE utf8_general_ci NOT NULL,
    PasswordSalt VARCHAR(10) COLLATE utf8_general_ci NOT NULL,
    rowguid CHAR(36) NOT NULL,
    ModifiedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (CustomerID),
    UNIQUE KEY `AK_Customer_rowguid` (`rowguid`)
);


CREATE TABLE ProductDescription (
    ProductDescriptionID INT AUTO_INCREMENT NOT NULL,
    Description NVARCHAR(400) COLLATE utf8_general_ci NOT NULL,
    rowguid CHAR(36) DEFAULT UUID() NOT NULL,
    ModifiedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (ProductDescriptionID),
    UNIQUE KEY AK_ProductDescription_rowguid (rowguid)
);


CREATE TABLE ProductModel (
	ProductModelID int IDENTITY(1,1) NOT NULL,
	Name Name COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CatalogDescription xml NULL,
	rowguid uniqueidentifier DEFAULT newid() NOT NULL,
	ModifiedDate datetime DEFAULT getdate() NOT NULL,
	CONSTRAINT AK_ProductModel_Name UNIQUE (Name),
	CONSTRAINT AK_ProductModel_rowguid UNIQUE (rowguid),
	CONSTRAINT PK_ProductModel_ProductModelID PRIMARY KEY (ProductModelID)
);



CREATE TABLE CustomerAddress (
    CustomerID INT NOT NULL,
    AddressID INT NOT NULL,
    AddressType VARCHAR(255) COLLATE utf8_general_ci NOT NULL,
    rowguid CHAR(36) NOT NULL DEFAULT (UUID()),
    ModifiedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT AK_CustomerAddress_rowguid UNIQUE (rowguid),
    CONSTRAINT PK_CustomerAddress_CustomerID_AddressID PRIMARY KEY (CustomerID, AddressID),
    CONSTRAINT FK_CustomerAddress_Address_AddressID FOREIGN KEY (AddressID) REFERENCES Address(AddressID),
    CONSTRAINT FK_CustomerAddress_Customer_CustomerID FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);


CREATE TABLE ProductCategory (
    ProductCategoryID INT AUTO_INCREMENT NOT NULL,
    ParentProductCategoryID INT NULL,
    Name VARCHAR(255) COLLATE utf8_general_ci NOT NULL,
    rowguid CHAR(36) DEFAULT (UUID()) NOT NULL,
    ModifiedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT AK_ProductCategory_Name UNIQUE (Name),
    CONSTRAINT AK_ProductCategory_rowguid UNIQUE (rowguid),
    CONSTRAINT PK_ProductCategory_ProductCategoryID PRIMARY KEY (ProductCategoryID),
    CONSTRAINT FK_ProductCategory_ProductCategory_ParentProductCategoryID FOREIGN KEY (ParentProductCategoryID) REFERENCES ProductCategory(ProductCategoryID)
);


CREATE TABLE ProductModelProductDescription (
    ProductModelID INT NOT NULL,
    ProductDescriptionID INT NOT NULL,
    Culture CHAR(6) COLLATE utf8_general_ci NOT NULL,
    rowguid CHAR(36) DEFAULT 'UUID()' NOT NULL,
    ModifiedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT AK_ProductModelProductDescription_rowguid UNIQUE (rowguid),
    CONSTRAINT PK_PMPD_ProductModelID_ProductDescriptionID_Culture PRIMARY KEY (ProductModelID, ProductDescriptionID, Culture),
    CONSTRAINT FK_PMPD_ProductDescriptionID FOREIGN KEY (ProductDescriptionID) REFERENCES ProductDescription(ProductDescriptionID),
    CONSTRAINT FK_PMPD_ProductModelID FOREIGN KEY (ProductModelID) REFERENCES ProductModel(ProductModelID)
);


CREATE TABLE SalesOrderHeader (
    SalesOrderID INT AUTO_INCREMENT NOT NULL,
    RevisionNumber TINYINT DEFAULT 0 NOT NULL,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    DueDate DATETIME NOT NULL,
    ShipDate DATETIME NULL,
    Status TINYINT DEFAULT 1 NOT NULL,
    OnlineOrderFlag ENUM('0', '1') DEFAULT '1' NOT NULL,
    SalesOrderNumber VARCHAR(23) NOT NULL,
    PurchaseOrderNumber VARCHAR(25) COLLATE utf8_general_ci NULL,
    AccountNumber VARCHAR(25) COLLATE utf8_general_ci NULL,
    CustomerID INT NOT NULL,
    ShipToAddressID INT NULL,
    BillToAddressID INT NULL,
    ShipMethod VARCHAR(50) COLLATE utf8_general_ci NOT NULL,
    CreditCardApprovalCode VARCHAR(15) COLLATE utf8_general_ci NULL,
    SubTotal DECIMAL(19, 4) DEFAULT 0.00 NOT NULL,
    TaxAmt DECIMAL(19, 4) DEFAULT 0.00 NOT NULL,
    Freight DECIMAL(19, 4) DEFAULT 0.00 NOT NULL,
    TotalDue DECIMAL(19, 4) AS (COALESCE((SubTotal + TaxAmt + Freight), 0.00)) STORED NOT NULL,
    Comment TEXT COLLATE utf8_general_ci NULL,
    rowguid CHAR(36) NOT NULL,
    ModifiedDate DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT AK_SalesOrderHeader_SalesOrderNumber UNIQUE (SalesOrderNumber),
    CONSTRAINT AK_SalesOrderHeader_rowguid UNIQUE (rowguid),
    CONSTRAINT PK_SalesOrderHeader_SalesOrderID PRIMARY KEY (SalesOrderID),
    CONSTRAINT FK_SalesOrderHeader_Address_BillTo_AddressID FOREIGN KEY (BillToAddressID) REFERENCES Address(AddressID), 
    CONSTRAINT FK_SalesOrderHeader_Address_ShipTo_AddressID FOREIGN KEY (ShipToAddressID) REFERENCES Address(AddressID), 
    CONSTRAINT FK_SalesOrderHeader_Customer_CustomerID FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);


CREATE TABLE SalesOrderDetail (
    SalesOrderID INT NOT NULL,
    SalesOrderDetailID INT AUTO_INCREMENT,
    OrderQty SMALLINT NOT NULL,
    ProductID INT NOT NULL,
    UnitPrice DECIMAL(19, 4) NOT NULL,
    UnitPriceDiscount DECIMAL(19, 4) DEFAULT 0.0 NOT NULL,
    LineTotal DECIMAL(19, 4) NOT NULL,
    rowguid CHAR(36) NOT NULL,
    ModifiedDate DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (SalesOrderDetailID), -- Make SalesOrderDetailID the primary key
    CONSTRAINT AK_SalesOrderDetail_rowguid UNIQUE (rowguid),
    CONSTRAINT FK_SalesOrderDetail_Product_ProductID FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    CONSTRAINT FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID FOREIGN KEY (SalesOrderID) REFERENCES SalesOrderHeader(SalesOrderID) ON DELETE CASCADE
);


CREATE TABLE SalesOrderDetail (
    SalesOrderID INT NOT NULL,
    SalesOrderDetailID INT,
    OrderQty SMALLINT NOT NULL,
    ProductID INT NOT NULL,
    UnitPrice DECIMAL(19, 4) NOT NULL,
    UnitPriceDiscount DECIMAL(19, 4) DEFAULT 0.0 NOT NULL,
    LineTotal DECIMAL(19, 4) NOT NULL,
    rowguid CHAR(36) NOT NULL,
    ModifiedDate DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT AK_SalesOrderDetail_rowguid UNIQUE (rowguid),
    CONSTRAINT FK_SalesOrderDetail_Product_ProductID FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    CONSTRAINT FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID FOREIGN KEY (SalesOrderID) REFERENCES SalesOrderHeader(SalesOrderID) ON DELETE CASCADE
);



# show tables

# show SalesOrderDetail table
DESCRIBE SalesOrderDetail;