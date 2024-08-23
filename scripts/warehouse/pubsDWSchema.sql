SET
	NOCOUNT ON
GO
set
	nocount on
set
	dateformat mdy USE master declare @dttm varchar(55)
select
	@dttm = convert(varchar, getdate(), 113) raiserror('Beginning InstPubs.SQL at %s ....', 1, 1, @dttm) with nowait
GO
	if exists (
		select
			*
		from
			sysdatabases
		where
			name = 'pubsDW'
	) begin raiserror('Dropping existing pubs database ....', 0, 1) DROP database pubsDW
end
GO
	CHECKPOINT
go
	raiserror('Creating pubs database....', 0, 1)
go
	/*
	 Use default size with autogrow
	 */
	CREATE DATABASE pubsDW
GO
	CHECKPOINT
GO
	USE pubsDW
GO
	if db_name() <> 'pubsDW' raiserror(
		'Error in InstPubs.SQL, ''USE pubsDW'' failed!  Killing the SPID now.',
		22,
		127
	) with log
GO
	CREATE TABLE "DimProducts" (
		"ProductSK" "int" IDENTITY(1, 1) NOT NULL,
		"ProductID" "int" NOT NULL,
		"ProductName" nvarchar (40) NOT NULL,
		"QuantityPerUnit" nvarchar (20) NULL,
		"UnitPrice" "money" NULL CONSTRAINT "DF_Products_UnitPrice" DEFAULT (0),
		"UnitsInStock" "smallint" NULL CONSTRAINT "DF_Products_UnitsInStock" DEFAULT (0),
		"UnitsOnOrder" "smallint" NULL CONSTRAINT "DF_Products_UnitsOnOrder" DEFAULT (0),
		"ReorderLevel" "smallint" NULL CONSTRAINT "DF_Products_ReorderLevel" DEFAULT (0),
		"Discontinued" "bit" NOT NULL CONSTRAINT "DF_Products_Discontinued" DEFAULT (0),
		"SupplierID" "int" NULL,
		"SupplierCompanyName" nvarchar (40) NOT NULL,
		"SupplierContactName" nvarchar (30) NULL,
		"SupplierContactTitle" nvarchar (30) NULL,
		"SupplierAddress" nvarchar (60) NULL,
		"SupplierCity" nvarchar (15) NULL,
		"SupplierRegion" nvarchar (15) NULL,
		"SupplierPostalCode" nvarchar (10) NULL,
		"SupplierCountry" nvarchar (15) NULL,
		"SupplierPhone" nvarchar (24) NULL,
		"SupplierFax" nvarchar (24) NULL,
		"SupplierHomePage" "ntext" NULL,
		"CategoryID" "int" NULL,
		"CategoryName" nvarchar (15) NOT NULL,
		CONSTRAINT "PK_DimProducts" PRIMARY KEY CLUSTERED ("ProductSK" ASC),
		CONSTRAINT "CK_Products_UnitPrice" CHECK (UnitPrice >= 0),
		CONSTRAINT "CK_ReorderLevel" CHECK (ReorderLevel >= 0),
		CONSTRAINT "CK_UnitsInStock" CHECK (UnitsInStock >= 0),
		CONSTRAINT "CK_UnitsOnOrder" CHECK (UnitsOnOrder >= 0)
	)
GO
	CREATE TABLE "DimCustomers" (
		"CustomerSK" "int" IDENTITY(1, 1) NOT NULL,
		"CustomerID" nchar (5) NOT NULL,
		"CompanyName" nvarchar (40) NOT NULL,
		"ContactName" nvarchar (30) NULL,
		"ContactTitle" nvarchar (30) NULL,
		"Address" nvarchar (60) NULL,
		"City" nvarchar (15) NULL,
		"Region" nvarchar (15) NULL,
		"PostalCode" nvarchar (10) NULL,
		"Country" nvarchar (15) NULL,
		"Phone" nvarchar (24) NULL,
		"Fax" nvarchar (24) NULL,
		"CustomerTypeID" nchar (10) NOT NULL,
		"CustomerDemographicsDesc" ntext NULL,
		CONSTRAINT "PK_DimCustomers" PRIMARY KEY CLUSTERED ("CustomerSK" ASC)
	)
GO
	CREATE TABLE "DimEmployees" (
		"EmployeeSK" "int" IDENTITY(1, 1) NOT NULL,
		"EmployeeID" "int" NOT NULL,
		"LastName" nvarchar (20) NOT NULL,
		"FirstName" nvarchar (10) NOT NULL,
		"Title" nvarchar (30) NULL,
		"TitleOfCourtesy" nvarchar (25) NULL,
		"BirthDate" "datetime" NULL,
		"HireDate" "datetime" NULL,
		"Address" nvarchar (60) NULL,
		"City" nvarchar (15) NULL,
		"Region" nvarchar (15) NULL,
		"PostalCode" nvarchar (10) NULL,
		"Country" nvarchar (15) NULL,
		"HomePhone" nvarchar (24) NULL,
		"Extension" nvarchar (4) NULL,
		"Photo" "image" NULL,
		"Notes" "ntext" NULL,
		"ReportsTo" "int" NULL,
		"PhotoPath" nvarchar (255) NULL,
		"TerritoryID" nvarchar (20) NOT NULL,
		"TerritoryDescription" nchar (50) NOT NULL,
		"RegionID" "int" NOT NULL,
		"RegionDescription" nchar (50) NOT NULL,
		CONSTRAINT "PK_DimEmployees" PRIMARY KEY CLUSTERED ("EmployeeSK" ASC),
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
		CONSTRAINT "PK_DimDate" PRIMARY KEY CLUSTERED ("DateKey")
	)
GO
	CREATE TABLE "DimShipName"(
		"ShipNameSK" "int" IDENTITY(1, 1) NOT NULL,
		"Name" nvarchar (100) NULL,
		CONSTRAINT "PK_ShipNameKey" PRIMARY KEY CLUSTERED ("ShipNameSK")
	)
GO
	CREATE TABLE "DimShipCountry"(
		"ShipCountrySK" "int" IDENTITY(1, 1) NOT NULL,
		"Name" nvarchar (100) NULL,
		CONSTRAINT "PK_ShipCountryKey" PRIMARY KEY CLUSTERED ("ShipCountrySK")
	)
GO
	CREATE TABLE "DimShipCity"(
		"ShipCitySK" "int" IDENTITY(1, 1) NOT NULL,
		"Name" nvarchar (100) NULL,
		CONSTRAINT "PK_ShipCityKey" PRIMARY KEY CLUSTERED ("ShipCitySK")
	)
GO
	CREATE TABLE "DimShipRegion"(
		"ShipRegionSK" "int" IDENTITY(1, 1) NOT NULL,
		"Name" nvarchar (100) NULL,
		CONSTRAINT "PK_ShipRegionKey" PRIMARY KEY CLUSTERED ("ShipRegionSK")
	)
GO
	CREATE TABLE "FactOrders" (
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
		"ShippersCompanyName" nvarchar (40) NOT NULL,
		CONSTRAINT "PK_Orders" PRIMARY KEY CLUSTERED ("OrderID" ASC, "ProductID" ASC),
		CONSTRAINT "FK_Orders_Products" FOREIGN KEY ("ProductSK") REFERENCES "dbo"."DimProducts" ("ProductSK"),
		CONSTRAINT "FK_Orders_DimCustomers" FOREIGN KEY ("CustomerSK") REFERENCES "dbo"."DimCustomers" ("CustomerSK"),
		CONSTRAINT "FK_Orders_DimEmployees" FOREIGN KEY ("EmployeeSK") REFERENCES "dbo"."DimEmployees" ("EmployeeSK"),
		CONSTRAINT "FK_DimDate_OrderDate" FOREIGN KEY ("OrderDateKey") REFERENCES "dbo"."DimDate" ("DateKey"),
		CONSTRAINT "FK_DimDate_RequiredDate" FOREIGN KEY ("RequiredDateKey") REFERENCES "dbo"."DimDate" ("DateKey"),
		CONSTRAINT "FK_DimDate_ShippedDate" FOREIGN KEY ("ShippedDateKey") REFERENCES "dbo"."DimDate" ("DateKey"),
		CONSTRAINT "FK_FactOrders_DimShipName" FOREIGN KEY ("ShipNameSK") REFERENCES "dbo"."DimShipName" ("ShipNameSK"),
		CONSTRAINT "FK_FactOrders_DimShipCountry" FOREIGN KEY ("ShipCountrySK") REFERENCES "dbo"."DimShipCountry" ("ShipCountrySK"),
		CONSTRAINT "FK_FactOrders_DimShipCity" FOREIGN KEY ("ShipCitySK") REFERENCES "dbo"."DimShipCity" ("ShipCitySK"),
		CONSTRAINT "FK_FactOrders_DimShipRegion" FOREIGN KEY ("ShipRegionSK") REFERENCES "dbo"."DimShipRegion" ("ShipRegionSK"),
		CONSTRAINT "CK_Discount" CHECK (
			Discount >= 0
			and (Discount <= 1)
		),
		CONSTRAINT "CK_Quantity" CHECK (Quantity > 0),
		CONSTRAINT "CK_UnitPrice" CHECK (UnitPrice >= 0)
	)
GO
	CREATE TABLE "PackageConfig"(
		"PackageID" "int" IDENTITY(1, 1) NOT NULL,
		"TableName" varchar (50) NOT NULL,
		"LastRowVersion" "bigint" NULL,
		CONSTRAINT "PK_PackageConfig" PRIMARY KEY CLUSTERED ("PackageID" ASC)
	)
GO