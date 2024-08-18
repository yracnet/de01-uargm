CREATE DATABASE pubsDW
GO

CHECKPOINT

GO

USE pubsDW

GO

CREATE TABLE "DimProducts" (
	"ProductID" "int" IDENTITY (1, 1) NOT NULL ,
	"ProductName" nvarchar (40) NOT NULL ,
	"SupplierID" "int" NULL ,
	"CategoryID" "int" NULL ,
	"QuantityPerUnit" nvarchar (20) NULL ,
	"UnitPrice" "money" NULL CONSTRAINT "DF_Products_UnitPrice" DEFAULT (0),
	"UnitsInStock" "smallint" NULL CONSTRAINT "DF_Products_UnitsInStock" DEFAULT (0),
	"UnitsOnOrder" "smallint" NULL CONSTRAINT "DF_Products_UnitsOnOrder" DEFAULT (0),
	"ReorderLevel" "smallint" NULL CONSTRAINT "DF_Products_ReorderLevel" DEFAULT (0),
	"Discontinued" "bit" NOT NULL CONSTRAINT "DF_Products_Discontinued" DEFAULT (0),
	
	"SupplierCompanyName" nvarchar (40) NOT NULL ,
	"SupplierContactName" nvarchar (30) NULL ,
	"SupplierContactTitle" nvarchar (30) NULL ,
	"SupplierAddress" nvarchar (60) NULL ,
	"SupplierCity" nvarchar (15) NULL ,
	"SupplierRegion" nvarchar (15) NULL ,
	"SupplierPostalCode" nvarchar (10) NULL ,
	"SupplierCountry" nvarchar (15) NULL ,
	"SupplierPhone" nvarchar (24) NULL ,
	"SupplierFax" nvarchar (24) NULL ,
	"SupplierHomePage" "ntext" NULL ,
	
	"CategoryName" nvarchar (15) NOT NULL ,
	
	CONSTRAINT "PK_DimProducts" PRIMARY KEY  CLUSTERED 
	(
		"ProductID"
	),

	CONSTRAINT "CK_Products_UnitPrice" CHECK (UnitPrice >= 0),
	CONSTRAINT "CK_ReorderLevel" CHECK (ReorderLevel >= 0),
	CONSTRAINT "CK_UnitsInStock" CHECK (UnitsInStock >= 0),
	CONSTRAINT "CK_UnitsOnOrder" CHECK (UnitsOnOrder >= 0)
)
GO 

CREATE TABLE "DimCustomers" (
	"CustomerID" nchar (5) NOT NULL ,
	"CompanyName" nvarchar (40) NOT NULL ,
	"ContactName" nvarchar (30) NULL ,
	"ContactTitle" nvarchar (30) NULL ,
	"Address" nvarchar (60) NULL ,
	"City" nvarchar (15) NULL ,
	"Region" nvarchar (15) NULL ,
	"PostalCode" nvarchar (10) NULL ,
	"Country" nvarchar (15) NULL ,
	"Phone" nvarchar (24) NULL ,
	"Fax" nvarchar (24) NULL ,
	"CustomerDemographicsDesc" ntext NULL,
	CONSTRAINT "PK_DimCustomers" PRIMARY KEY  CLUSTERED 
	(
		"CustomerID"
	)
)
GO

CREATE TABLE "DimEmployees" (
	"EmployeeID" "int" IDENTITY (1, 1) NOT NULL ,
	"LastName" nvarchar (20) NOT NULL ,
	"FirstName" nvarchar (10) NOT NULL ,
	"Title" nvarchar (30) NULL ,
	"TitleOfCourtesy" nvarchar (25) NULL ,
	"BirthDate" "datetime" NULL ,
	"HireDate" "datetime" NULL ,
	"Address" nvarchar (60) NULL ,
	"City" nvarchar (15) NULL ,
	"Region" nvarchar (15) NULL ,
	"PostalCode" nvarchar (10) NULL ,
	"Country" nvarchar (15) NULL ,
	"HomePhone" nvarchar (24) NULL ,
	"Extension" nvarchar (4) NULL ,
	"Photo" "image" NULL ,
	"Notes" "ntext" NULL ,
	"ReportsTo" "int" NULL ,
	"PhotoPath" nvarchar (255) NULL ,
	
	"TerritoryDescription" nchar (50) NOT NULL ,
	
	"RegionDescription" nchar (50) NOT NULL, 
	
	CONSTRAINT "PK_DimEmployees" PRIMARY KEY  CLUSTERED 
	(
		"EmployeeID"
	),
	CONSTRAINT "FK_Employees_Employees" FOREIGN KEY 
	(
		"ReportsTo"
	) REFERENCES "dbo"."DimEmployees" (
		"EmployeeID"
	),
	CONSTRAINT "CK_Birthdate" CHECK (BirthDate < getdate())
)
GO

CREATE TABLE "DimDate"(
	"DateKey" int NOT NULL,
	"FullDate" datetime NOT NULL,
	"DayNumberOfWeek" tinyint NOT NULL,
	"DayNameOfWeek" nvarchar (10) NOT NULL,
	"DayNumberOfMonth" tinyint NOT NULL,
	"DayNumberOfYear" smallint NOT NULL,
	"WeekNumberOfYear" tinyint NOT NULL,
	"MonthName" nvarchar (10) NOT NULL,
	"MonthNumberOfYear" tinyint NOT NULL,
	"CalendarQuarter" tinyint NOT NULL,
	"CalendarYear" smallint NOT NULL,
	"CalendarSemester" tinyint NOT NULL,
	CONSTRAINT "PK_DimDate" PRIMARY KEY CLUSTERED 
	(
		"DateKey"
	)
)
GO 

CREATE TABLE "FactOrders" (
	"OrderID" "int" IDENTITY (1, 1) NOT NULL ,
	"ProductSK" "int" NOT NULL ,
	"CustomerSK" nchar (5) NULL ,
	"EmployeeSK" "int" NULL ,
	
	"OrderDateKey" "int" NULL ,
	"RequiredDateKey" "int" NULL ,
	"ShippedDateKey" "int" NULL ,
	"ShipVia" "int" NULL ,
	"Freight" "money" NULL CONSTRAINT "DF_Orders_Freight" DEFAULT (0),
	"ShipName" nvarchar (40) NULL ,
	"ShipAddress" nvarchar (60) NULL ,
	"ShipCity" nvarchar (15) NULL ,
	"ShipRegion" nvarchar (15) NULL ,
	"ShipPostalCode" nvarchar (10) NULL ,
	"ShipCountry" nvarchar (15) NULL ,
	

	"UnitPrice" "money" NOT NULL CONSTRAINT "DF_Order_Details_UnitPrice" DEFAULT (0),
	"Quantity" "smallint" NOT NULL CONSTRAINT "DF_Order_Details_Quantity" DEFAULT (1),
	"Discount" "real" NOT NULL CONSTRAINT "DF_Order_Details_Discount" DEFAULT (0),
	
	"ShippersCompanyName" nvarchar (40) NOT NULL ,
	
	CONSTRAINT "PK_Orders" PRIMARY KEY  CLUSTERED 
	(
		"OrderID"
	),
	CONSTRAINT "FK_Orders_Products" FOREIGN KEY 
	(
		"ProductSK"
	) REFERENCES "dbo"."DimProducts" (
		"ProductID"
	),
	CONSTRAINT "FK_Orders_DimCustomers" FOREIGN KEY 
	(
		"CustomerSK"
	) REFERENCES "dbo"."DimCustomers" (
		"CustomerID"
	),
	CONSTRAINT "FK_Orders_DimEmployees" FOREIGN KEY 
	(
		"EmployeeSK"
	) REFERENCES "dbo"."DimEmployees" (
		"EmployeeID"
	),
	CONSTRAINT "FK_DimDate_OrderDate" FOREIGN KEY 
	(
		"OrderDateKey"
	) REFERENCES "dbo"."DimDate" (
		"DateKey"
	),
	CONSTRAINT "FK_DimDate_RequiredDate" FOREIGN KEY 
	(
		"RequiredDateKey"
	) REFERENCES "dbo"."DimDate" (
		"DateKey"
	),
	CONSTRAINT "FK_DimDate_ShippedDate" FOREIGN KEY 
	(
		"ShippedDateKey"
	) REFERENCES "dbo"."DimDate" (
		"DateKey"
	),
	
	CONSTRAINT "CK_Discount" CHECK (Discount >= 0 and (Discount <= 1)),
	CONSTRAINT "CK_Quantity" CHECK (Quantity > 0),
	CONSTRAINT "CK_UnitPrice" CHECK (UnitPrice >= 0)
)
GO