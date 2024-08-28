-- Author: Rimberth Villca
-- Crea SP para la base de datos pubsDW
-- SETTING ENVIROMENT 
USE pubsDW
GO
	if db_name() <> 'pubsDW' raiserror(
		'Error in pubsDW.SQL, ''USE pubsDW'' failed!  Killing the SPID now.',
		22,
		127
	) with log
GO
SET
	ANSI_NULLS ON
SET
	QUOTED_IDENTIFIER ON
GO
	-- START CREATE STORE PROCEDURES
	-- Procedure to load data from GetLastPackageRowVersion
	IF EXISTS (
		SELECT
			*
		FROM
			sys.objects
		WHERE
			object_id = OBJECT_ID(N'dbo.GetLastPackageRowVersion')
			AND type in (N'P', N'PC')
	) DROP PROCEDURE dbo.GetLastPackageRowVersion
GO
	-- Crear el store procedure GetLastPackageRowVersion que recupera la ultima version en base al nombre de la tabla.
	CREATE PROCEDURE dbo.GetLastPackageRowVersion (@tableName VARCHAR(50)) AS BEGIN
SELECT
	LastRowVersion
FROM
	dbo.PackageConfig
WHERE
	TableName = @tableName;

END
GO
	-- StoredProcedure [dbo].[UpdateLastPackageRowVersion]
	IF EXISTS (
		SELECT
			*
		FROM
			sys.objects
		WHERE
			object_id = OBJECT_ID(N'dbo.UpdateLastPackageRowVersion')
			AND type in (N'P', N'PC')
	) DROP PROCEDURE dbo.UpdateLastPackageRowVersion
GO
	CREATE PROCEDURE dbo.UpdateLastPackageRowVersion (
		@tableName VARCHAR(50),
		@lastRowVersion BIGINT
	) AS BEGIN
UPDATE
	dbo.PackageConfig
SET
	LastRowVersion = @lastRowVersion
WHERE
	TableName = @tableName;

END
GO
	-- ================================================================
	IF EXISTS (
		SELECT
			*
		FROM
			sys.objects
		WHERE
			object_id = OBJECT_ID(N'dbo.DW_MergeDimCategories')
			AND type in (N'P', N'PC')
	) DROP PROCEDURE dbo.DW_MergeDimCategories
GO
	CREATE PROCEDURE dbo.DW_MergeDimCategories AS BEGIN
UPDATE
	"dp"
SET
	--"CategoryID" = "sp"."CategoryID",
	"CategoryName" = "sp"."CategoryName",
	"Description" = "sp"."Description",
	"Picture" = "sp"."Picture"
FROM
	"dbo"."DimCategories" "dp"
	INNER JOIN "staging"."Categories" "sp" ON ("dp"."CategorySK" = "sp"."CategorySK")
END;

--- =================================================================================
IF EXISTS (
	SELECT
		*
	FROM
		sys.objects
	WHERE
		object_id = OBJECT_ID(N'dbo.DW_MergeDimCustomers')
		AND type in (N'P', N'PC')
) DROP PROCEDURE dbo.DW_MergeDimCustomers
GO
	CREATE PROCEDURE dbo.DW_MergeDimCustomers AS BEGIN
UPDATE
	"dc"
SET
	--"CustomerID" = "sc"."CustomerID",
	"CompanyName" = "sc"."CompanyName",
	"ContactName" = "sc"."ContactName",
	"ContactTitle" = "sc"."ContactTitle",
	"Address" = "sc"."Address",
	"City" = "sc"."City",
	"Region" = "sc"."Region",
	"PostalCode" = "sc"."PostalCode",
	"Country" = "sc"."Country",
	"Phone" = "sc"."Phone",
	"Fax" = "sc"."Fax"
FROM
	"dbo"."DimCustomers" "dc"
	INNER JOIN "staging"."Customers" "sc" ON ("dc"."CustomerSK" = "sc"."CustomerSK")
END;

GO
	--- =================================================================================
	IF EXISTS (
		SELECT
			*
		FROM
			sys.objects
		WHERE
			object_id = OBJECT_ID(N'dbo.DW_MergeDimEmployees')
			AND type in (N'P', N'PC')
	) DROP PROCEDURE dbo.DW_MergeDimEmployees
GO
	CREATE PROCEDURE dbo.DW_MergeDimEmployees AS BEGIN
UPDATE
	"de"
SET
	--"EmployeeID" = "se"."EmployeeID",
	"LastName" = "se"."LastName",
	"FirstName" = "se"."FirstName",
	"Title" = "se"."Title",
	"TitleOfCourtesy" = "se"."TitleOfCourtesy",
	"BirthDate" = "se"."BirthDate",
	"HireDate" = "se"."HireDate",
	"Address" = "se"."Address"
FROM
	"dbo"."DimEmployees" "de"
	INNER JOIN "staging"."Employees" "se" ON ("de"."EmployeeSK" = "se"."EmployeeSK")
END
GO
	--- =================================================================================
	IF EXISTS (
		SELECT
			*
		FROM
			sys.objects
		WHERE
			object_id = OBJECT_ID(N'dbo.DW_MergeDimProducts')
			AND type in (N'P', N'PC')
	) DROP PROCEDURE dbo.DW_MergeDimProducts
GO
	CREATE PROCEDURE dbo.DW_MergeDimProducts AS BEGIN
UPDATE
	"dp"
SET
	--"ProductID" = "sp"."ProductID",
	"ProductName" = "sp"."ProductName",
	"QuantityPerUnit" = "sp"."QuantityPerUnit",
	"UnitPrice" = "sp"."UnitPrice",
	"UnitsInStock" = "sp"."UnitsInStock",
	"UnitsOnOrder" = "sp"."UnitsOnOrder",
	"ReorderLevel" = "sp"."ReorderLevel",
	"Discontinued" = "sp"."Discontinued"
FROM
	"dbo"."DimProducts" "dp"
	INNER JOIN "staging"."Products" "sp" ON ("dp"."ProductSK" = "sp"."ProductSK")
END
GO
	--- =================================================================================
	IF EXISTS (
		SELECT
			*
		FROM
			sys.objects
		WHERE
			object_id = OBJECT_ID(N'dbo.DW_MergeDimSuppliers')
			AND type in (N'P', N'PC')
	) DROP PROCEDURE dbo.DW_MergeDimSuppliers
GO
	CREATE PROCEDURE dbo.DW_MergeDimSuppliers AS BEGIN
UPDATE
	"dp"
SET
	--"SupplierID" = "sp"."SupplierID",
	"CompanyName" = "sp"."CompanyName",
	"ContactName" = "sp"."ContactName",
	"ContactTitle" = "sp"."ContactTitle",
	"Address" = "sp"."Address",
	"City" = "sp"."City",
	"Region" = "sp"."Region",
	"PostalCode" = "sp"."PostalCode",
	"Country" = "sp"."Country",
	"Phone" = "sp"."Phone",
	"Fax" = "sp"."Fax",
	"HomePage" = "sp"."HomePage"
FROM
	"dbo"."DimSuppliers" "dp"
	INNER JOIN "staging"."Suppliers" "sp" ON ("dp"."SupplierSK" = "sp"."SupplierSK")
END
GO
	--- =================================================================================
	IF EXISTS (
		SELECT
			*
		FROM
			sys.objects
		WHERE
			object_id = OBJECT_ID(N'dbo.DW_MergeDimShippers')
			AND type in (N'P', N'PC')
	) DROP PROCEDURE dbo.DW_MergeDimShippers
GO
	CREATE PROCEDURE dbo.DW_MergeDimShippers AS BEGIN
UPDATE
	"dp"
SET
	--"ShipperID" = "sp"."ShipperID",
	"CompanyName" = "sp"."CompanyName",
	"Phone" = "sp"."Phone"
FROM
	"dbo"."DimShippers" "dp"
	INNER JOIN "staging"."Shippers" "sp" ON ("dp"."ShipperSK" = "sp"."ShipperSK")
END
GO
	--- =================================================================================
	IF EXISTS (
		SELECT
			*
		FROM
			sys.objects
		WHERE
			object_id = OBJECT_ID(N'dbo.DW_MergeDimShipName')
			AND type in (N'P', N'PC')
	) DROP PROCEDURE dbo.DW_MergeDimShipName
GO
	CREATE PROCEDURE dbo.DW_MergeDimShipName AS BEGIN
UPDATE
	"dp"
SET
	"ShipName" = "sp"."ShipName"
FROM
	"dbo"."DimShipName" "dp"
	INNER JOIN "staging"."ShipName" "sp" ON ("dp"."ShipNameSK" = "sp"."ShipNameSK")
END
GO
	--- =================================================================================
	IF EXISTS (
		SELECT
			*
		FROM
			sys.objects
		WHERE
			object_id = OBJECT_ID(N'dbo.DW_MergeDimShipCountry')
			AND type in (N'P', N'PC')
	) DROP PROCEDURE dbo.DW_MergeDimShipCountry
GO
	CREATE PROCEDURE dbo.DW_MergeDimShipCountry AS BEGIN
UPDATE
	"dp"
SET
	"CountryName" = "sp"."CountryName"
FROM
	"dbo"."DimShipCountry" "dp"
	INNER JOIN "staging"."ShipCountry" "sp" ON ("dp"."ShipCountrySK" = "sp"."ShipCountrySK")
END
GO
	--- =================================================================================
	IF EXISTS (
		SELECT
			*
		FROM
			sys.objects
		WHERE
			object_id = OBJECT_ID(N'dbo.DW_MergeDimShipCity')
			AND type in (N'P', N'PC')
	) DROP PROCEDURE dbo.DW_MergeDimShipCity
GO
	CREATE PROCEDURE dbo.DW_MergeDimShipCity AS BEGIN
UPDATE
	"dp"
SET
	"CityName" = "sp"."CityName"
FROM
	"dbo"."DimShipCity" "dp"
	INNER JOIN "staging"."ShipCity" "sp" ON ("dp"."ShipCitySK" = "sp"."ShipCitySK")
END
GO
	--- =================================================================================
	IF EXISTS (
		SELECT
			*
		FROM
			sys.objects
		WHERE
			object_id = OBJECT_ID(N'dbo.DW_MergeDimShipRegion')
			AND type in (N'P', N'PC')
	) DROP PROCEDURE dbo.DW_MergeDimShipRegion
GO
	CREATE PROCEDURE dbo.DW_MergeDimShipRegion AS BEGIN
UPDATE
	"dp"
SET
	"RegionName" = "sp"."RegionName"
FROM
	"dbo"."DimShipRegion" "dp"
	INNER JOIN "staging"."ShipRegion" "sp" ON ("dp"."ShipRegionSK" = "sp"."ShipRegionSK")
END
GO
	--- =================================================================================
	IF EXISTS (
		SELECT
			*
		FROM
			sys.objects
		WHERE
			object_id = OBJECT_ID(N'dbo.DW_MergeFactOrders')
			AND type in (N'P', N'PC')
	) DROP PROCEDURE dbo.DW_MergeFactOrders
GO
	CREATE PROCEDURE dbo.DW_MergeFactOrders AS BEGIN
UPDATE
	"df"
SET
	"ProductSK" = "so"."ProductSK",
	"CategorySK" = "so"."CategorySK",
	"SupplierSK" = "so"."SupplierSK",
	"EmployeeSK" = "so"."EmployeeSK",
	"CustomerSK" = "so"."CustomerSK",
	"ShipperSK" = "so"."ShipperSK",

	"OrderDateKey" = "so"."OrderDateKey",
	"RequiredDateKey" = "so"."RequiredDateKey",
	"ShippedDateKey" = "so"."ShippedDateKey",
	
	"ShipNameSK" = "so"."ShipNameSK",
	"ShipCountrySK" = "so"."ShipCountrySK",
	"ShipCitySK" = "so"."ShipCitySK",
	"ShipRegionSK" = "so"."ShipRegionSK",
	
	"ShipPostalCode" = "so"."ShipPostalCode",
	"Freight" = "so"."Freight",
	"UnitPrice" = "so"."UnitPrice",
	"Quantity" = "so"."Quantity",
	"Discount" = "so"."Discount"
FROM
	"dbo"."FactOrders" "df"
	INNER JOIN "staging"."Orders" "so" ON (
		"df"."OrderID" = "so"."OrderID"
		AND "df"."ProductID" = "so"."ProductID"
	)
END
GO