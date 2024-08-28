USE pubsDW
GO
/****** Object:  Schema [staging]    Script Date: 25/08/2024 9:23:53 PM ******/
CREATE SCHEMA "staging"

GO

CREATE TABLE "staging"."Categories" (
	"CategorySK" "int" NOT NULL ,
	"CategoryID" "int" NOT NULL ,
	"CategoryName" nvarchar (15) NULL ,
	"Description" "ntext" NULL ,
	"Picture" "image" NULL 
)
GO

CREATE TABLE "staging"."Suppliers" (
	"SupplierSK" "int" NOT NULL ,
	"SupplierID" "int" NOT NULL ,
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
	"HomePage" "ntext" NULL 
)
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
	
	"CategorySK" "int" NULL ,
	"SupplierSK" "int" NULL 
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
	
	"CustomerTypeID" nchar (10) NULL ,
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
	
	"TerritoryID" nvarchar (20) NULL ,
	"TerritoryDescription" nchar (50) NULL ,
	
	"RegionID" "int" NOT NULL ,
	"RegionDescription" nchar (50) NULL
)
GO

CREATE TABLE "staging"."ShipName"(
		"ShipNameSK" "int" NOT NULL,
		"Name" nvarchar (100) NULL
	)
GO

	CREATE TABLE "staging"."ShipCountry"(
		"ShipCountrySK" "int" NOT NULL,
		"Name" nvarchar (100) NULL
	)
GO

	CREATE TABLE "staging"."ShipCity"(
		"ShipCitySK" "int" NOT NULL,
		"Name" nvarchar (100) NULL
	)
GO

	CREATE TABLE "staging"."ShipRegion"(
		"ShipRegionSK" "int" NOT NULL,
		"Name" nvarchar (100) NULL
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
		"ShipperID" "int" NULL,
		"ShippersCompanyName" nvarchar (40) NULL
)
GO
