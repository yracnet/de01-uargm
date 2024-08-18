-- Author: Willyams Yujra
-- Crea SP para rescatar datos modificados

-- SETTING ENVIROMENT 
USE pubs
GO
if db_name() <> 'pubs'
   raiserror('Error in InstPubs.SQL, ''USE pubs'' failed!  Killing the SPID now.',22,127) with log
GO
SET
ANSI_NULLS ON
GO
SET
QUOTED_IDENTIFIER ON
GO


-- CREATE CURRENT TIMESTAP


-- Eliminar la función si existe
IF OBJECT_ID('dbo.GetCurrentRowVersion', 'FN') IS NOT NULL
BEGIN
    DROP FUNCTION dbo.GetCurrentRowVersion;
END
GO

-- Crear la nueva función
CREATE FUNCTION dbo.GetCurrentRowVersion()
RETURNS BIGINT
AS
BEGIN
    DECLARE @dbts BIGINT;

    -- Obtener el valor actual de rowversion
    SET @dbts = CONVERT(BIGINT, MIN_ACTIVE_ROWVERSION()) - 1;

    RETURN @dbts;
END
GO



-- START CREATE STORE PROCEDURES


-- Procedure to load data from Categories
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetCategoriesByRowVersion') AND type in (N'P', N'PC'))
    DROP PROCEDURE dbo.GetCategoriesByRowVersion
GO

CREATE PROCEDURE dbo.GetCategoriesByRowVersion
(
    @startRow BIGINT,
    @endRow BIGINT
)
AS
BEGIN
    SELECT
        CategoryID,
        CategoryName,
        Description,
        Picture,
        rowversion
    FROM
        dbo.Categories
    WHERE
        [rowversion] > CONVERT(BIGINT, @startRow)
        AND [rowversion] <= CONVERT(BIGINT, @endRow)
END
GO

-- Procedure to load data from Customers
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetCustomersByRowVersion') AND type in (N'P', N'PC'))
    DROP PROCEDURE dbo.GetCustomersByRowVersion
GO

CREATE PROCEDURE dbo.GetCustomersByRowVersion
(
    @startRow BIGINT,
    @endRow BIGINT
)
AS
BEGIN
    SELECT
        CustomerID,
        CompanyName,
        ContactName,
        ContactTitle,
        Address,
        City,
        Region,
        PostalCode,
        Country,
        Phone,
        Fax,
        rowversion
    FROM
        dbo.Customers
    WHERE
        [rowversion] > CONVERT(BIGINT, @startRow)
        AND [rowversion] <= CONVERT(BIGINT, @endRow)
END
GO

-- Procedure to load data from Employees
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetEmployeesByRowVersion') AND type in (N'P', N'PC'))
    DROP PROCEDURE dbo.GetEmployeesByRowVersion
GO

CREATE PROCEDURE dbo.GetEmployeesByRowVersion
(
    @startRow BIGINT,
    @endRow BIGINT
)
AS
BEGIN
    SELECT
        EmployeeID,
        LastName,
        FirstName,
        Title,
        TitleOfCourtesy,
        BirthDate,
        HireDate,
        Address,
        City,
        Region,
        PostalCode,
        Country,
        HomePhone,
        Extension,
        Photo,
        Notes,
        ReportsTo,
        PhotoPath,
        rowversion
    FROM
        dbo.Employees
    WHERE
        [rowversion] > CONVERT(BIGINT, @startRow)
        AND [rowversion] <= CONVERT(BIGINT, @endRow)
END
GO

-- Procedure to load data from Products
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetProductsByRowVersion') AND type in (N'P', N'PC'))
    DROP PROCEDURE dbo.GetProductsByRowVersion
GO

CREATE PROCEDURE dbo.GetProductsByRowVersion
(
    @startRow BIGINT,
    @endRow BIGINT
)
AS
BEGIN
    SELECT
        ProductID,
        ProductName,
        SupplierID,
        CategoryID,
        QuantityPerUnit,
        UnitPrice,
        UnitsInStock,
        UnitsOnOrder,
        ReorderLevel,
        Discontinued,
        rowversion
    FROM
        dbo.Products
    WHERE
        [rowversion] > CONVERT(BIGINT, @startRow)
        AND [rowversion] <= CONVERT(BIGINT, @endRow)
END
GO

-- Procedure to load data from Suppliers
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetSuppliersByRowVersion') AND type in (N'P', N'PC'))
    DROP PROCEDURE dbo.GetSuppliersByRowVersion
GO

CREATE PROCEDURE dbo.GetSuppliersByRowVersion
(
    @startRow BIGINT,
    @endRow BIGINT
)
AS
BEGIN
    SELECT
        SupplierID,
        CompanyName,
        ContactName,
        ContactTitle,
        Address,
        City,
        Region,
        PostalCode,
        Country,
        Phone,
        Fax,
        HomePage,
        rowversion
    FROM
        dbo.Suppliers
    WHERE
        [rowversion] > CONVERT(BIGINT, @startRow)
        AND [rowversion] <= CONVERT(BIGINT, @endRow)
END
GO

-- Procedure to load data from Shippers
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetShippersByRowVersion') AND type in (N'P', N'PC'))
    DROP PROCEDURE dbo.GetShippersByRowVersion
GO

CREATE PROCEDURE dbo.GetShippersByRowVersion
(
    @startRow BIGINT,
    @endRow BIGINT
)
AS
BEGIN
	SELECT
	ShipperID,
	CompanyName,
	Phone,
	rowversion
FROM
	dbo.Shippers
WHERE
	[rowversion] > CONVERT(BIGINT,
	@startRow)
	AND [rowversion] <= CONVERT(BIGINT,
	@endRow)
END
GO





-- Procedure to load data from FacOrders
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetOrdersByRowVersion') AND type in (N'P', N'PC'))
    DROP PROCEDURE dbo.GetOrdersByRowVersion
GO

CREATE PROCEDURE dbo.GetOrdersByRowVersion
(
    @startRow BIGINT,
    @endRow BIGINT
)
AS
BEGIN
SELECT
	o.OrderID,
	od.ProductID,
	p.CategoryID,
	p.SupplierID,
	o.EmployeeID,
	o.CustomerID,
	o.ShipVia ShipperID,
	CONVERT(VARCHAR(8), o.OrderDate, 112) OrderDateKey,
	CONVERT(VARCHAR(8), o.RequiredDate, 112) RequiredDateKey,
	ISNULL(CONVERT(VARCHAR(8), o.ShippedDate, 112), '00000000') AS ShippedDateKey,
	o.Freight,
	o.ShipName,
	o.ShipAddress,
	o.ShipCity,
	o.ShipRegion,
	o.ShipPostalCode,
	o.ShipCountry,
	od.UnitPrice,
	od.Quantity,
	od.Discount
FROM
	Orders o
LEFT JOIN OrderDetails od ON o.OrderID = od.OrderID
LEFT JOIN Products p ON p.ProductID = od.ProductID
WHERE
    (o.rowversion > CONVERT(BIGINT, @startRow) AND o.rowversion <= CONVERT(BIGINT, @endRow))
    OR
    (od.rowversion > CONVERT(BIGINT, @startRow) AND od.rowversion <= CONVERT(BIGINT, @endRow))
END
GO


