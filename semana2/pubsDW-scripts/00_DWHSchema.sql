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
	) 
	begin 
		-- raiserror('Dropping existing pubs database ....', 0, 1)
		DROP database pubsDW;
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
	CREATE TABLE "PackageConfig"(
		"PackageID" "int" IDENTITY(1, 1) NOT NULL,
		"TableName" varchar (50) NOT NULL,
		"LastRowVersion" "bigint" NULL DEFAULT 0,
		CONSTRAINT "PK_PackageConfig" PRIMARY KEY CLUSTERED ("PackageID" ASC)
	)
GO
	CREATE TABLE "DimDate"(
		"DateKey" int NOT NULL,
		"FullDate" date NOT NULL,
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
	CREATE TABLE "DimCategories" (
		"CategorySK" "int" IDENTITY (1, 1) NOT NULL,
		"CategoryID" "int" NULL,
		"CategoryName" nvarchar (15) NOT NULL,
		"Description" "ntext" NULL,
		"Picture" "image" NULL,
		CONSTRAINT "PK_DimCategories" PRIMARY KEY CLUSTERED ("CategorySK" ASC)
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
		CONSTRAINT "PK_DimEmployees" PRIMARY KEY CLUSTERED ("EmployeeSK" ASC)
	)
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
		CONSTRAINT "PK_DimProducts" PRIMARY KEY CLUSTERED ("ProductSK" ASC)
	)
GO
	CREATE TABLE "DimSuppliers" (
		"SupplierSK" "int" IDENTITY (1, 1) NOT NULL,
		"SupplierID" "int" NOT NULL,
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
		"HomePage" "ntext" NULL,
		CONSTRAINT "PK_DimSuppliers" PRIMARY KEY CLUSTERED ("SupplierSK" ASC)
	)
GO
	CREATE TABLE "DimShippers"(
		"ShipperSK" "int" IDENTITY(1, 1) NOT NULL,
		"ShipperID" "int" NOT NULL,
		"CompanyName" nvarchar (15) NULL,
		"Phone" nvarchar (15) NULL
		CONSTRAINT "PK_DimShipperSK" PRIMARY KEY CLUSTERED ("ShipperSK")
	)
GO
	CREATE TABLE "DimShipName"(
		"ShipNameSK" "int" IDENTITY(1, 1) NOT NULL,
		"ShipName" nvarchar (100) NULL,
		CONSTRAINT "PK_DimShipNameKey" PRIMARY KEY CLUSTERED ("ShipNameSK")
	)
GO
	CREATE TABLE "DimShipCountry"(
		"ShipCountrySK" "int" IDENTITY(1, 1) NOT NULL,
		"CountryName" nvarchar (100) NULL,
		CONSTRAINT "PK_DimShipCountryKey" PRIMARY KEY CLUSTERED ("ShipCountrySK")
	)
GO
	CREATE TABLE "DimShipCity"(
		"ShipCitySK" "int" IDENTITY(1, 1) NOT NULL,
		"CityName" nvarchar (100) NULL,
		CONSTRAINT "PK_DimShipCityKey" PRIMARY KEY CLUSTERED ("ShipCitySK")
	)
GO
	CREATE TABLE "DimShipRegion"(
		"ShipRegionSK" "int" IDENTITY(1, 1) NOT NULL,
		"RegionName" nvarchar (100) NULL,
		CONSTRAINT "PK_DimShipRegionKey" PRIMARY KEY CLUSTERED ("ShipRegionSK")
	)
GO
	CREATE TABLE "FactOrders" (
		"OrderID" "int" NOT NULL,
		"ProductID" "int" NOT NULL,

		"ProductSK" "int" NOT NULL,
		"CategorySK" "int" NOT NULL,
		"SupplierSK" "int" NOT NULL,
		"EmployeeSK" "int" NOT NULL,
		"CustomerSK" "int" NOT NULL,
		"ShipperSK" "int" NOT NULL,

		"OrderDateKey" "int" NOT NULL,
		"RequiredDateKey" "int" NOT NULL,
		"ShippedDateKey" "int" NOT NULL,

		"ShipNameSK" "int" NULL,
		"ShipCountrySK" "int" NULL,
		"ShipCitySK" "int" NULL,
		"ShipRegionSK" "int" NULL,

		"ShipPostalCode" nvarchar (10) NULL,
		"Freight" "money" DEFAULT (0),
		"UnitPrice" "money" DEFAULT (0),
		"Quantity" "smallint" DEFAULT (1),
		"Discount" "real" DEFAULT (0),

		CONSTRAINT "PK_Orders" PRIMARY KEY CLUSTERED ("OrderID" ASC, "ProductID" ASC),
		
		CONSTRAINT "FK_Orders_DimProducts" FOREIGN KEY ("ProductSK") REFERENCES "dbo"."DimProducts" ("ProductSK"),
		CONSTRAINT "FK_Orders_DimCategories" FOREIGN KEY ("CategorySK") REFERENCES "dbo"."DimCategories" ("CategorySK"),
		CONSTRAINT "FK_Orders_DimSuppliers" FOREIGN KEY ("SupplierSK") REFERENCES "dbo"."DimSuppliers" ("SupplierSK"),
		CONSTRAINT "FK_Orders_DimEmployees" FOREIGN KEY ("EmployeeSK") REFERENCES "dbo"."DimEmployees" ("EmployeeSK"),
		CONSTRAINT "FK_Orders_DimCustomers" FOREIGN KEY ("CustomerSK") REFERENCES "dbo"."DimCustomers" ("CustomerSK"),
		CONSTRAINT "FK_Orders_DimShippers" FOREIGN KEY ("ShipperSK") REFERENCES "dbo"."DimShippers" ("ShipperSK"),


		CONSTRAINT "FK_DimDate_OrderDate" FOREIGN KEY ("OrderDateKey") REFERENCES "dbo"."DimDate" ("DateKey"),
		CONSTRAINT "FK_DimDate_RequiredDate" FOREIGN KEY ("RequiredDateKey") REFERENCES "dbo"."DimDate" ("DateKey"),
		CONSTRAINT "FK_DimDate_ShippedDate" FOREIGN KEY ("ShippedDateKey") REFERENCES "dbo"."DimDate" ("DateKey"),
		
		--CONSTRAINT "FK_FactOrders_DimShipName" FOREIGN KEY ("ShipNameSK") REFERENCES "dbo"."DimShipName" ("ShipNameSK"),
		--CONSTRAINT "FK_FactOrders_DimShipCountry" FOREIGN KEY ("ShipCountrySK") REFERENCES "dbo"."DimShipCountry" ("ShipCountrySK"),
		--CONSTRAINT "FK_FactOrders_DimShipCity" FOREIGN KEY ("ShipCitySK") REFERENCES "dbo"."DimShipCity" ("ShipCitySK"),
		--CONSTRAINT "FK_FactOrders_DimShipRegion" FOREIGN KEY ("ShipRegionSK") REFERENCES "dbo"."DimShipRegion" ("ShipRegionSK"),
	)
GO