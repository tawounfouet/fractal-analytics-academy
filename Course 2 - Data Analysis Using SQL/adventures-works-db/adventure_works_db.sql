-- DROP SCHEMA SalesLT;

CREATE SCHEMA SalesLT;
-- [adventure-works-db].SalesLT.Address definition

-- Drop table

-- DROP TABLE [adventure-works-db].SalesLT.Address;

CREATE TABLE [adventure-works-db].SalesLT.Address (
	AddressID int IDENTITY(1,1) NOT NULL,
	AddressLine1 nvarchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	AddressLine2 nvarchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	City nvarchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	StateProvince Name COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CountryRegion Name COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	PostalCode nvarchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	rowguid uniqueidentifier DEFAULT newid() NOT NULL,
	ModifiedDate datetime DEFAULT getdate() NOT NULL,
	CONSTRAINT AK_Address_rowguid UNIQUE (rowguid),
	CONSTRAINT PK_Address_AddressID PRIMARY KEY (AddressID)
);
 CREATE NONCLUSTERED INDEX IX_Address_AddressLine1_AddressLine2_City_StateProvince_PostalCode_CountryRegion ON SalesLT.Address (  AddressLine1 ASC  , AddressLine2 ASC  , City ASC  , StateProvince ASC  , PostalCode ASC  , CountryRegion ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Address_StateProvince ON SalesLT.Address (  StateProvince ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- [adventure-works-db].SalesLT.Customer definition

-- Drop table

-- DROP TABLE [adventure-works-db].SalesLT.Customer;

CREATE TABLE [adventure-works-db].SalesLT.Customer (
	CustomerID int IDENTITY(1,1) NOT NULL,
	NameStyle NameStyle DEFAULT 0 NOT NULL,
	Title nvarchar(8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	FirstName Name COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	MiddleName Name COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	LastName Name COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Suffix nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CompanyName nvarchar(128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SalesPerson nvarchar(256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	EmailAddress nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Phone Phone COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PasswordHash varchar(128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	PasswordSalt varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	rowguid uniqueidentifier DEFAULT newid() NOT NULL,
	ModifiedDate datetime DEFAULT getdate() NOT NULL,
	CONSTRAINT AK_Customer_rowguid UNIQUE (rowguid),
	CONSTRAINT PK_Customer_CustomerID PRIMARY KEY (CustomerID)
);
 CREATE NONCLUSTERED INDEX IX_Customer_EmailAddress ON SalesLT.Customer (  EmailAddress ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- [adventure-works-db].SalesLT.ProductDescription definition

-- Drop table

-- DROP TABLE [adventure-works-db].SalesLT.ProductDescription;

CREATE TABLE [adventure-works-db].SalesLT.ProductDescription (
	ProductDescriptionID int IDENTITY(1,1) NOT NULL,
	Description nvarchar(400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	rowguid uniqueidentifier DEFAULT newid() NOT NULL,
	ModifiedDate datetime DEFAULT getdate() NOT NULL,
	CONSTRAINT AK_ProductDescription_rowguid UNIQUE (rowguid),
	CONSTRAINT PK_ProductDescription_ProductDescriptionID PRIMARY KEY (ProductDescriptionID)
);


-- [adventure-works-db].SalesLT.ProductModel definition

-- Drop table

-- DROP TABLE [adventure-works-db].SalesLT.ProductModel;

CREATE TABLE [adventure-works-db].SalesLT.ProductModel (
	ProductModelID int IDENTITY(1,1) NOT NULL,
	Name Name COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CatalogDescription xml NULL,
	rowguid uniqueidentifier DEFAULT newid() NOT NULL,
	ModifiedDate datetime DEFAULT getdate() NOT NULL,
	CONSTRAINT AK_ProductModel_Name UNIQUE (Name),
	CONSTRAINT AK_ProductModel_rowguid UNIQUE (rowguid),
	CONSTRAINT PK_ProductModel_ProductModelID PRIMARY KEY (ProductModelID)
);


-- [adventure-works-db].SalesLT.CustomerAddress definition

-- Drop table

-- DROP TABLE [adventure-works-db].SalesLT.CustomerAddress;

CREATE TABLE [adventure-works-db].SalesLT.CustomerAddress (
	CustomerID int NOT NULL,
	AddressID int NOT NULL,
	AddressType Name COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	rowguid uniqueidentifier DEFAULT newid() NOT NULL,
	ModifiedDate datetime DEFAULT getdate() NOT NULL,
	CONSTRAINT AK_CustomerAddress_rowguid UNIQUE (rowguid),
	CONSTRAINT PK_CustomerAddress_CustomerID_AddressID PRIMARY KEY (CustomerID,AddressID),
	CONSTRAINT FK_CustomerAddress_Address_AddressID FOREIGN KEY (AddressID) REFERENCES [adventure-works-db].SalesLT.Address(AddressID),
	CONSTRAINT FK_CustomerAddress_Customer_CustomerID FOREIGN KEY (CustomerID) REFERENCES [adventure-works-db].SalesLT.Customer(CustomerID)
);


-- [adventure-works-db].SalesLT.ProductCategory definition

-- Drop table

-- DROP TABLE [adventure-works-db].SalesLT.ProductCategory;

CREATE TABLE [adventure-works-db].SalesLT.ProductCategory (
	ProductCategoryID int IDENTITY(1,1) NOT NULL,
	ParentProductCategoryID int NULL,
	Name Name COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	rowguid uniqueidentifier DEFAULT newid() NOT NULL,
	ModifiedDate datetime DEFAULT getdate() NOT NULL,
	CONSTRAINT AK_ProductCategory_Name UNIQUE (Name),
	CONSTRAINT AK_ProductCategory_rowguid UNIQUE (rowguid),
	CONSTRAINT PK_ProductCategory_ProductCategoryID PRIMARY KEY (ProductCategoryID),
	CONSTRAINT FK_ProductCategory_ProductCategory_ParentProductCategoryID_ProductCategoryID FOREIGN KEY (ParentProductCategoryID) REFERENCES [adventure-works-db].SalesLT.ProductCategory(ProductCategoryID)
);


-- [adventure-works-db].SalesLT.ProductModelProductDescription definition

-- Drop table

-- DROP TABLE [adventure-works-db].SalesLT.ProductModelProductDescription;

CREATE TABLE [adventure-works-db].SalesLT.ProductModelProductDescription (
	ProductModelID int NOT NULL,
	ProductDescriptionID int NOT NULL,
	Culture nchar(6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	rowguid uniqueidentifier DEFAULT newid() NOT NULL,
	ModifiedDate datetime DEFAULT getdate() NOT NULL,
	CONSTRAINT AK_ProductModelProductDescription_rowguid UNIQUE (rowguid),
	CONSTRAINT PK_ProductModelProductDescription_ProductModelID_ProductDescriptionID_Culture PRIMARY KEY (ProductModelID,ProductDescriptionID,Culture),
	CONSTRAINT FK_ProductModelProductDescription_ProductDescription_ProductDescriptionID FOREIGN KEY (ProductDescriptionID) REFERENCES [adventure-works-db].SalesLT.ProductDescription(ProductDescriptionID),
	CONSTRAINT FK_ProductModelProductDescription_ProductModel_ProductModelID FOREIGN KEY (ProductModelID) REFERENCES [adventure-works-db].SalesLT.ProductModel(ProductModelID)
);


-- [adventure-works-db].SalesLT.SalesOrderHeader definition

-- Drop table

-- DROP TABLE [adventure-works-db].SalesLT.SalesOrderHeader;

CREATE TABLE [adventure-works-db].SalesLT.SalesOrderHeader (
	SalesOrderID int DEFAULT NEXT VALUE FOR [SalesLT].[SalesOrderNumber] NOT NULL,
	RevisionNumber tinyint DEFAULT 0 NOT NULL,
	OrderDate datetime DEFAULT getdate() NOT NULL,
	DueDate datetime NOT NULL,
	ShipDate datetime NULL,
	Status tinyint DEFAULT 1 NOT NULL,
	OnlineOrderFlag Flag DEFAULT 1 NOT NULL,
	SalesOrderNumber AS (isnull(N'SO'+CONVERT([nvarchar](23),[SalesOrderID],(0)),N'*** ERROR ***')) NOT NULL,
	PurchaseOrderNumber OrderNumber COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	AccountNumber AccountNumber COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CustomerID int NOT NULL,
	ShipToAddressID int NULL,
	BillToAddressID int NULL,
	ShipMethod nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CreditCardApprovalCode varchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SubTotal money DEFAULT 0.00 NOT NULL,
	TaxAmt money DEFAULT 0.00 NOT NULL,
	Freight money DEFAULT 0.00 NOT NULL,
	TotalDue AS (isnull(([SubTotal]+[TaxAmt])+[Freight],(0))) NOT NULL,
	Comment nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	rowguid uniqueidentifier DEFAULT newid() NOT NULL,
	ModifiedDate datetime DEFAULT getdate() NOT NULL,
	CONSTRAINT AK_SalesOrderHeader_SalesOrderNumber UNIQUE (SalesOrderNumber),
	CONSTRAINT AK_SalesOrderHeader_rowguid UNIQUE (rowguid),
	CONSTRAINT PK_SalesOrderHeader_SalesOrderID PRIMARY KEY (SalesOrderID),
	CONSTRAINT FK_SalesOrderHeader_Address_BillTo_AddressID FOREIGN KEY (BillToAddressID) REFERENCES [adventure-works-db].SalesLT.Address(AddressID),
	CONSTRAINT FK_SalesOrderHeader_Address_ShipTo_AddressID FOREIGN KEY (ShipToAddressID) REFERENCES [adventure-works-db].SalesLT.Address(AddressID),
	CONSTRAINT FK_SalesOrderHeader_Customer_CustomerID FOREIGN KEY (CustomerID) REFERENCES [adventure-works-db].SalesLT.Customer(CustomerID)
);
 CREATE NONCLUSTERED INDEX IX_SalesOrderHeader_CustomerID ON SalesLT.SalesOrderHeader (  CustomerID ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
ALTER TABLE [adventure-works-db].SalesLT.SalesOrderHeader WITH NOCHECK ADD CONSTRAINT CK_SalesOrderHeader_DueDate CHECK ([DueDate]>=[OrderDate]);
ALTER TABLE [adventure-works-db].SalesLT.SalesOrderHeader WITH NOCHECK ADD CONSTRAINT CK_SalesOrderHeader_Freight CHECK ([Freight]>=(0.00));
ALTER TABLE [adventure-works-db].SalesLT.SalesOrderHeader WITH NOCHECK ADD CONSTRAINT CK_SalesOrderHeader_ShipDate CHECK ([ShipDate]>=[OrderDate] OR [ShipDate] IS NULL);
ALTER TABLE [adventure-works-db].SalesLT.SalesOrderHeader WITH NOCHECK ADD CONSTRAINT CK_SalesOrderHeader_Status CHECK ([Status]>=(0) AND [Status]<=(8));
ALTER TABLE [adventure-works-db].SalesLT.SalesOrderHeader WITH NOCHECK ADD CONSTRAINT CK_SalesOrderHeader_SubTotal CHECK ([SubTotal]>=(0.00));
ALTER TABLE [adventure-works-db].SalesLT.SalesOrderHeader WITH NOCHECK ADD CONSTRAINT CK_SalesOrderHeader_TaxAmt CHECK ([TaxAmt]>=(0.00));


-- [adventure-works-db].SalesLT.Product definition

-- Drop table

-- DROP TABLE [adventure-works-db].SalesLT.Product;

CREATE TABLE [adventure-works-db].SalesLT.Product (
	ProductID int IDENTITY(1,1) NOT NULL,
	Name Name COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	ProductNumber nvarchar(25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Color nvarchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	StandardCost money NOT NULL,
	ListPrice money NOT NULL,
	[Size] nvarchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Weight decimal(8,2) NULL,
	ProductCategoryID int NULL,
	ProductModelID int NULL,
	SellStartDate datetime NOT NULL,
	SellEndDate datetime NULL,
	DiscontinuedDate datetime NULL,
	ThumbNailPhoto varbinary(MAX) NULL,
	ThumbnailPhotoFileName nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	rowguid uniqueidentifier DEFAULT newid() NOT NULL,
	ModifiedDate datetime DEFAULT getdate() NOT NULL,
	CONSTRAINT AK_Product_Name UNIQUE (Name),
	CONSTRAINT AK_Product_ProductNumber UNIQUE (ProductNumber),
	CONSTRAINT AK_Product_rowguid UNIQUE (rowguid),
	CONSTRAINT PK_Product_ProductID PRIMARY KEY (ProductID),
	CONSTRAINT FK_Product_ProductCategory_ProductCategoryID FOREIGN KEY (ProductCategoryID) REFERENCES [adventure-works-db].SalesLT.ProductCategory(ProductCategoryID),
	CONSTRAINT FK_Product_ProductModel_ProductModelID FOREIGN KEY (ProductModelID) REFERENCES [adventure-works-db].SalesLT.ProductModel(ProductModelID)
);
ALTER TABLE [adventure-works-db].SalesLT.Product WITH NOCHECK ADD CONSTRAINT CK_Product_ListPrice CHECK ([ListPrice]>=(0.00));
ALTER TABLE [adventure-works-db].SalesLT.Product WITH NOCHECK ADD CONSTRAINT CK_Product_SellEndDate CHECK ([SellEndDate]>=[SellStartDate] OR [SellEndDate] IS NULL);
ALTER TABLE [adventure-works-db].SalesLT.Product WITH NOCHECK ADD CONSTRAINT CK_Product_StandardCost CHECK ([StandardCost]>=(0.00));
ALTER TABLE [adventure-works-db].SalesLT.Product WITH NOCHECK ADD CONSTRAINT CK_Product_Weight CHECK ([Weight]>(0.00));


-- [adventure-works-db].SalesLT.SalesOrderDetail definition

-- Drop table

-- DROP TABLE [adventure-works-db].SalesLT.SalesOrderDetail;

CREATE TABLE [adventure-works-db].SalesLT.SalesOrderDetail (
	SalesOrderID int NOT NULL,
	SalesOrderDetailID int IDENTITY(1,1) NOT NULL,
	OrderQty smallint NOT NULL,
	ProductID int NOT NULL,
	UnitPrice money NOT NULL,
	UnitPriceDiscount money DEFAULT 0.0 NOT NULL,
	LineTotal AS (isnull(([UnitPrice]*((1.0)-[UnitPriceDiscount]))*[OrderQty],(0.0))) NOT NULL,
	rowguid uniqueidentifier DEFAULT newid() NOT NULL,
	ModifiedDate datetime DEFAULT getdate() NOT NULL,
	CONSTRAINT AK_SalesOrderDetail_rowguid UNIQUE (rowguid),
	CONSTRAINT PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID PRIMARY KEY (SalesOrderID,SalesOrderDetailID),
	CONSTRAINT FK_SalesOrderDetail_Product_ProductID FOREIGN KEY (ProductID) REFERENCES [adventure-works-db].SalesLT.Product(ProductID),
	CONSTRAINT FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID FOREIGN KEY (SalesOrderID) REFERENCES [adventure-works-db].SalesLT.SalesOrderHeader(SalesOrderID) ON DELETE CASCADE
);
 CREATE NONCLUSTERED INDEX IX_SalesOrderDetail_ProductID ON SalesLT.SalesOrderDetail (  ProductID ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
ALTER TABLE [adventure-works-db].SalesLT.SalesOrderDetail WITH NOCHECK ADD CONSTRAINT CK_SalesOrderDetail_OrderQty CHECK ([OrderQty]>(0));
ALTER TABLE [adventure-works-db].SalesLT.SalesOrderDetail WITH NOCHECK ADD CONSTRAINT CK_SalesOrderDetail_UnitPrice CHECK ([UnitPrice]>=(0.00));
ALTER TABLE [adventure-works-db].SalesLT.SalesOrderDetail WITH NOCHECK ADD CONSTRAINT CK_SalesOrderDetail_UnitPriceDiscount CHECK ([UnitPriceDiscount]>=(0.00));


-- SalesLT.vGetAllCategories source

CREATE VIEW [SalesLT].[vGetAllCategories]
WITH SCHEMABINDING
AS
-- Returns the CustomerID, first name, and last name for the specified customer.
WITH CategoryCTE([ParentProductCategoryID], [ProductCategoryID], [Name]) AS
(
    SELECT [ParentProductCategoryID], [ProductCategoryID], [Name]
    FROM SalesLT.ProductCategory
    WHERE ParentProductCategoryID IS NULL

UNION ALL

    SELECT C.[ParentProductCategoryID], C.[ProductCategoryID], C.[Name]
    FROM SalesLT.ProductCategory AS C
    INNER JOIN CategoryCTE AS BC ON BC.ProductCategoryID = C.ParentProductCategoryID
)

SELECT PC.[Name] AS [ParentProductCategoryName], CCTE.[Name] as [ProductCategoryName], CCTE.[ProductCategoryID]
FROM CategoryCTE AS CCTE
JOIN SalesLT.ProductCategory AS PC
ON PC.[ProductCategoryID] = CCTE.[ParentProductCategoryID];


-- SalesLT.vProductAndDescription source

CREATE VIEW [SalesLT].[vProductAndDescription]
WITH SCHEMABINDING
AS
-- View (indexed or standard) to display products and product descriptions by language.
SELECT
    p.[ProductID]
    ,p.[Name]
    ,pm.[Name] AS [ProductModel]
    ,pmx.[Culture]
    ,pd.[Description]
FROM [SalesLT].[Product] p
    INNER JOIN [SalesLT].[ProductModel] pm
    ON p.[ProductModelID] = pm.[ProductModelID]
    INNER JOIN [SalesLT].[ProductModelProductDescription] pmx
    ON pm.[ProductModelID] = pmx.[ProductModelID]
    INNER JOIN [SalesLT].[ProductDescription] pd
    ON pmx.[ProductDescriptionID] = pd.[ProductDescriptionID];


-- SalesLT.vProductModelCatalogDescription source

CREATE VIEW [SalesLT].[vProductModelCatalogDescription]
AS
SELECT
    [ProductModelID]
    ,[Name]
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
        declare namespace html="http://www.w3.org/1999/xhtml";
        (/p1:ProductDescription/p1:Summary/html:p)[1]', 'nvarchar(max)') AS [Summary]
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
        (/p1:ProductDescription/p1:Manufacturer/p1:Name)[1]', 'nvarchar(max)') AS [Manufacturer]
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
        (/p1:ProductDescription/p1:Manufacturer/p1:Copyright)[1]', 'nvarchar(30)') AS [Copyright]
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
        (/p1:ProductDescription/p1:Manufacturer/p1:ProductURL)[1]', 'nvarchar(256)') AS [ProductURL]
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
        declare namespace wm="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain";
        (/p1:ProductDescription/p1:Features/wm:Warranty/wm:WarrantyPeriod)[1]', 'nvarchar(256)') AS [WarrantyPeriod]
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
        declare namespace wm="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain";
        (/p1:ProductDescription/p1:Features/wm:Warranty/wm:Description)[1]', 'nvarchar(256)') AS [WarrantyDescription]
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
        declare namespace wm="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain";
        (/p1:ProductDescription/p1:Features/wm:Maintenance/wm:NoOfYears)[1]', 'nvarchar(256)') AS [NoOfYears]
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
        declare namespace wm="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain";
        (/p1:ProductDescription/p1:Features/wm:Maintenance/wm:Description)[1]', 'nvarchar(256)') AS [MaintenanceDescription]
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
        declare namespace wf="http://www.adventure-works.com/schemas/OtherFeatures";
        (/p1:ProductDescription/p1:Features/wf:wheel)[1]', 'nvarchar(256)') AS [Wheel]
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
        declare namespace wf="http://www.adventure-works.com/schemas/OtherFeatures";
        (/p1:ProductDescription/p1:Features/wf:saddle)[1]', 'nvarchar(256)') AS [Saddle]
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
        declare namespace wf="http://www.adventure-works.com/schemas/OtherFeatures";
        (/p1:ProductDescription/p1:Features/wf:pedal)[1]', 'nvarchar(256)') AS [Pedal]
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
        declare namespace wf="http://www.adventure-works.com/schemas/OtherFeatures";
        (/p1:ProductDescription/p1:Features/wf:BikeFrame)[1]', 'nvarchar(max)') AS [BikeFrame]
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
        declare namespace wf="http://www.adventure-works.com/schemas/OtherFeatures";
        (/p1:ProductDescription/p1:Features/wf:crankset)[1]', 'nvarchar(256)') AS [Crankset]
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
        (/p1:ProductDescription/p1:Picture/p1:Angle)[1]', 'nvarchar(256)') AS [PictureAngle]
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
        (/p1:ProductDescription/p1:Picture/p1:Size)[1]', 'nvarchar(256)') AS [PictureSize]
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
        (/p1:ProductDescription/p1:Picture/p1:ProductPhotoID)[1]', 'nvarchar(256)') AS [ProductPhotoID]
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
        (/p1:ProductDescription/p1:Specifications/Material)[1]', 'nvarchar(256)') AS [Material]
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
        (/p1:ProductDescription/p1:Specifications/Color)[1]', 'nvarchar(256)') AS [Color]
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
        (/p1:ProductDescription/p1:Specifications/ProductLine)[1]', 'nvarchar(256)') AS [ProductLine]
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
        (/p1:ProductDescription/p1:Specifications/Style)[1]', 'nvarchar(256)') AS [Style]
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
        (/p1:ProductDescription/p1:Specifications/RiderExperience)[1]', 'nvarchar(1024)') AS [RiderExperience]
    ,[rowguid]
    ,[ModifiedDate]
FROM [SalesLT].[ProductModel]
WHERE [CatalogDescription] IS NOT NULL;
