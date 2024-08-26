-- Author: Rimberth Villca
-- Crea SP para la base de datos pubsDW

-- SETTING ENVIROMENT 
USE pubsDW
GO
if db_name() <> 'pubsDW'
   raiserror('Error in pubsDW.SQL, ''USE pubsDW'' failed!  Killing the SPID now.',22,127) with log
GO
SET
ANSI_NULLS ON
GO
SET
QUOTED_IDENTIFIER ON
GO

-- START CREATE STORE PROCEDURES

-- Procedure to load data from GetLastPackageRowVersion
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetLastPackageRowVersion') AND type in (N'P', N'PC'))
    DROP PROCEDURE dbo.GetLastPackageRowVersion
GO

-- Crear el store procedure GetLastPackageRowVersion que recupera la ultima version en base al nombre de la tabla.
CREATE PROCEDURE dbo.GetLastPackageRowVersion
(
	@tableName VARCHAR(50)
)
AS
BEGIN
	SELECT LastRowVersion
	FROM dbo.PackageConfig
	WHERE TableName = @tableName;
END
GO

-- StoredProcedure [dbo].[UpdateLastPackageRowVersion]
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.UpdateLastPackageRowVersion') AND type in (N'P', N'PC'))
    DROP PROCEDURE dbo.UpdateLastPackageRowVersion
GO

CREATE PROCEDURE dbo.UpdateLastPackageRowVersion
(
    @tableName VARCHAR(50)
	,@lastRowVersion BIGINT
)
AS
BEGIN
    UPDATE dbo.PackageConfig
	SET LastRowVersion = @lastRowVersion
	WHERE TableName = @tableName;
END
GO

/****** Object:  StoredProcedure [dbo].[DW_MergeDimProducts]    Script Date: 25/08/2024 9:23:54 PM ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.DW_MergeDimProducts') AND type in (N'P', N'PC'))
    DROP PROCEDURE dbo.DW_MergeDimProducts
GO

CREATE PROCEDURE dbo.DW_MergeDimProducts
AS
BEGIN

	UPDATE "dp"
	SET "ProductName" 			 = "sp"."ProductName" 			
		,"QuantityPerUnit"       = "sp"."QuantityPerUnit"     
		,"UnitPrice"             = "sp"."UnitPrice"           
		,"UnitsInStock"          = "sp"."UnitsInStock"        
		,"UnitsOnOrder"          = "sp"."UnitsOnOrder"        
		,"ReorderLevel"          = "sp"."ReorderLevel"        
		,"Discontinued"          = "sp"."Discontinued"        
		,"SupplierID"            = "sp"."SupplierID"          
		,"SupplierCompanyName"   = "sp"."SupplierCompanyName" 
		,"SupplierContactName" 	 = "sp"."SupplierContactName" 
		,"SupplierContactTitle"  = "sp"."SupplierContactTitle"
		,"SupplierAddress"       = "sp"."SupplierAddress"     
		,"SupplierCity"          = "sp"."SupplierCity"        
		,"SupplierRegion"        = "sp"."SupplierRegion"      
		,"SupplierPostalCode"    = "sp"."SupplierPostalCode"  
		,"SupplierCountry"       = "sp"."SupplierCountry"     
		,"SupplierPhone"         = "sp"."SupplierPhone"       
		,"SupplierFax"           = "sp"."SupplierFax"         
		,"SupplierHomePage"      = "sp"."SupplierHomePage"    
		,"CategoryID"            = "sp"."CategoryID"          
		,"CategoryName"          = "sp"."CategoryName"        
	FROM "dbo"."DimProducts"        "dp"
	INNER JOIN "staging"."Products" "sp" ON ("dp"."ProductSK"="sp"."ProductSK")
END
GO

/****** Object:  StoredProcedure [dbo].[DW_MergeDimCustomers]    Script Date: 25/08/2024 9:35:18 PM ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.DW_MergeDimCustomers') AND type in (N'P', N'PC'))
    DROP PROCEDURE dbo.DW_MergeDimCustomers
GO

CREATE PROCEDURE dbo.DW_MergeDimCustomers
AS
BEGIN

	UPDATE "dc"
	SET "CustomerID"				= "sc"."CustomerID"				 
		,"CompanyName"               = "sc"."CompanyName"             
		,"ContactName"               = "sc"."ContactName"             
		,"ContactTitle"              = "sc"."ContactTitle"            
		,"Address"                   = "sc"."Address"                 
		,"City"                      = "sc"."City"                    
		,"Region"                    = "sc"."Region"                  
		,"PostalCode"                = "sc"."PostalCode"              
		,"Country"                   = "sc"."Country"                 
		,"Phone"                     = "sc"."Phone"                   
		,"Fax"                       = "sc"."Fax"                     
		,"CustomerTypeID"            = "sc"."CustomerTypeID"          
		,"CustomerDemographicsDesc"  = "sc"."CustomerDemographicsDesc"
	FROM "dbo"."DimCustomers"        "dc"
	INNER JOIN "staging"."Customers" "sc" ON ("dc"."CustomerSK"="sc"."CustomerSK")
END
GO

/****** Object:  StoredProcedure [dbo].[DW_MergeDimEmployees]    Script Date: 25/08/2024 9:45:24 PM ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.DW_MergeDimEmployees') AND type in (N'P', N'PC'))
    DROP PROCEDURE dbo.DW_MergeDimEmployees
GO

CREATE PROCEDURE dbo.DW_MergeDimEmployees
AS
BEGIN

	UPDATE "de"
	SET "EmployeeID"             ="se"."EmployeeID"          
		,"LastName"              ="se"."LastName"            
		,"FirstName"             ="se"."FirstName"           
		,"Title"                 ="se"."Title"               
		,"TitleOfCourtesy"       ="se"."TitleOfCourtesy"     
		,"BirthDate"             ="se"."BirthDate"           
		,"HireDate"              ="se"."HireDate"            
		,"Address"               ="se"."Address"             
		,"City"                  ="se"."City"                
		,"Region"                ="se"."Region"              
		,"PostalCode"            ="se"."PostalCode"          
		,"Country"               ="se"."Country"             
		,"HomePhone"             ="se"."HomePhone"           
		,"Extension"             ="se"."Extension"           
		,"Photo"                 ="se"."Photo"               
		,"Notes"                 ="se"."Notes"               
		,"ReportsTo"             ="se"."ReportsTo"           
		,"PhotoPath"             ="se"."PhotoPath"           
		,"TerritoryID"           ="se"."TerritoryID"         
		,"TerritoryDescription"  ="se"."TerritoryDescription"
		,"RegionID"              ="se"."RegionID"            
		,"RegionDescription"     ="se"."RegionDescription"   
	FROM "dbo"."DimEmployees"        "de"
	INNER JOIN "staging"."Employees" "se" ON ("de"."EmployeeSK"="se"."EmployeeSK")
END
GO

/****** Object:  StoredProcedure [dbo].[DW_MergeFactOrders]    Script Date: 25/08/2024 9:58:33 PM ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.DW_MergeFactOrders') AND type in (N'P', N'PC'))
    DROP PROCEDURE dbo.DW_MergeFactOrders
GO

CREATE PROCEDURE dbo.DW_MergeFactOrders
AS
BEGIN

	UPDATE "df"
	SET "ProductSK"             = "so"."ProductSK"          
		,"CustomerSK"            = "so"."CustomerSK"         
		,"EmployeeSK"            = "so"."EmployeeSK"         
		,"OrderDateKey"          = "so"."OrderDateKey"       
		,"RequiredDateKey"       = "so"."RequiredDateKey"    
		,"ShippedDateKey"        = "so"."ShippedDateKey"     
		,"ShipVia"               = "so"."ShipVia"            
		,"Freight"               = "so"."Freight"            
		,"ShipNameSK"            = "so"."ShipNameSK"         
		,"ShipCountrySK"         = "so"."ShipCountrySK"      
		,"ShipCitySK"            = "so"."ShipCitySK"         
		,"ShipRegionSK"          = "so"."ShipRegionSK"       
		,"UnitPrice"             = "so"."UnitPrice"          
		,"Quantity"              = "so"."Quantity"           
		,"Discount"              = "so"."Discount"           
		,"ShipperID"             = "so"."ShipperID"          
		,"ShippersCompanyName"   = "so"."ShippersCompanyName"
		
	FROM "dbo"."FactOrders" "df"
	INNER JOIN "staging"."Orders" "so" ON ("df"."OrderID"="so"."OrderID" AND "df"."ProductID"="so"."ProductID")
END
GO
