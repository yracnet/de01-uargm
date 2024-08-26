USE pubsDW
GO
/****** Object:  Schema [staging]    Script Date: 25/08/2024 9:23:53 PM ******/
CREATE SCHEMA "staging"

GO

CREATE TABLE "staging"."Products" (
	"ProductSK" "int" NOT NULL,
	"ProductName" nvarchar (40) NOT NULL ,
	"QuantityPerUnit" nvarchar (20) NULL ,
	"UnitPrice" "money" NULL CONSTRAINT "DF_Products_UnitPrice" DEFAULT (0),
	"UnitsInStock" "smallint" NULL CONSTRAINT "DF_Products_UnitsInStock" DEFAULT (0),
	"UnitsOnOrder" "smallint" NULL CONSTRAINT "DF_Products_UnitsOnOrder" DEFAULT (0),
	"ReorderLevel" "smallint" NULL CONSTRAINT "DF_Products_ReorderLevel" DEFAULT (0),
	"Discontinued" "bit" NOT NULL CONSTRAINT "DF_Products_Discontinued" DEFAULT (0),
	
	"SupplierID" "int" NULL ,
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
	
	"CategoryID" "int" NULL ,
	"CategoryName" nvarchar (15) NOT NULL 
)
GO 

CREATE TABLE "staging"."Customers" (
	"CustomerSK" "int" NOT NULL,
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
	
	"CustomerTypeID" nchar (10) NOT NULL ,
	"CustomerDemographicsDesc" ntext NULL
)
GO

CREATE TABLE "staging"."Employees" (
	"EmployeeSK" "int" NOT NULL,
	"EmployeeID" "int" NOT NULL ,
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
	
	"TerritoryID" nvarchar (20) NOT NULL ,
	"TerritoryDescription" nchar (50) NOT NULL ,
	
	"RegionID" "int" NOT NULL ,
	"RegionDescription" nchar (50) NOT NULL
)
GO

CREATE TABLE "staging"."Orders" (
		"OrderID" "int" NOT NULL,
		"ProductID" "int" NOT NULL,
		"ProductSK" "int" NULL,
		"CustomerSK" "int" NULL,
		"EmployeeSK" "int" NULL,
		"OrderDateKey" "int" NOT NULL,
		"RequiredDateKey" "int" NOT NULL,
		"ShippedDateKey" "int" NOT NULL,
		"ShipVia" "int" NULL,
		"Freight" "money" NULL CONSTRAINT "DF_Orders_Freight" DEFAULT (0),
		"ShipNameSK" "int" NOT NULL,
		"ShipCountrySK" "int" NOT NULL,
		"ShipCitySK" "int" NOT NULL,
		"ShipRegionSK" "int" NOT NULL,
		"UnitPrice" "money" NOT NULL CONSTRAINT "DF_Order_Details_UnitPrice" DEFAULT (0),
		"Quantity" "smallint" NOT NULL CONSTRAINT "DF_Order_Details_Quantity" DEFAULT (1),
		"Discount" "real" NOT NULL CONSTRAINT "DF_Order_Details_Discount" DEFAULT (0),
		"ShipperID" "int" NOT NULL,
		"ShippersCompanyName" nvarchar (40) NOT NULL
)
GO

	INSERT "PackageConfig" VALUES('Products', 0)
	INSERT "PackageConfig" VALUES('Customers', 0)
	INSERT "PackageConfig" VALUES('Employees', 0)
	INSERT "PackageConfig" VALUES('Orders', 0)
GO 
