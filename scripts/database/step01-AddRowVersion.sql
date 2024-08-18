-- Author: Willyams Yujra
-- Adicionar rowversion a las tables existentes

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

-- REMOVE
IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.Categories') AND name = 'rowversion')
BEGIN
    ALTER TABLE dbo.Categories DROP COLUMN [rowversion];
END

IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.CustomerCustomerDemo') AND name = 'rowversion')
BEGIN
    ALTER TABLE dbo.CustomerCustomerDemo DROP COLUMN [rowversion];
END

IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.CustomerDemographics') AND name = 'rowversion')
BEGIN
    ALTER TABLE dbo.CustomerDemographics DROP COLUMN [rowversion];
END

IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.Customers') AND name = 'rowversion')
BEGIN
    ALTER TABLE dbo.Customers DROP COLUMN [rowversion];
END

IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.EmployeeTerritories') AND name = 'rowversion')
BEGIN
    ALTER TABLE dbo.EmployeeTerritories DROP COLUMN [rowversion];
END

IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.Employees') AND name = 'rowversion')
BEGIN
    ALTER TABLE dbo.Employees DROP COLUMN [rowversion];
END

IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.OrderDetails') AND name = 'rowversion')
BEGIN
    ALTER TABLE dbo.OrderDetails DROP COLUMN [rowversion];
END

IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.Orders') AND name = 'rowversion')
BEGIN
    ALTER TABLE dbo.Orders DROP COLUMN [rowversion];
END

IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.Products') AND name = 'rowversion')
BEGIN
    ALTER TABLE dbo.Products DROP COLUMN [rowversion];
END

IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.Region') AND name = 'rowversion')
BEGIN
    ALTER TABLE dbo.Region DROP COLUMN [rowversion];
END

IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.Shippers') AND name = 'rowversion')
BEGIN
    ALTER TABLE dbo.Shippers DROP COLUMN [rowversion];
END

IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.Suppliers') AND name = 'rowversion')
BEGIN
    ALTER TABLE dbo.Suppliers DROP COLUMN [rowversion];
END

IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.Territories') AND name = 'rowversion')
BEGIN
    ALTER TABLE dbo.Territories DROP COLUMN [rowversion];
END


-- ADD

ALTER TABLE dbo.Categories ADD [rowversion] [timestamp] NOT NULL;

ALTER TABLE dbo.CustomerCustomerDemo ADD [rowversion] [timestamp] NOT NULL;

ALTER TABLE dbo.CustomerDemographics ADD [rowversion] [timestamp] NOT NULL;

ALTER TABLE dbo.Customers ADD [rowversion] [timestamp] NOT NULL;

ALTER TABLE dbo.EmployeeTerritories ADD [rowversion] [timestamp] NOT NULL;

ALTER TABLE dbo.Employees ADD [rowversion] [timestamp] NOT NULL;

ALTER TABLE dbo.OrderDetails ADD [rowversion] [timestamp] NOT NULL;

ALTER TABLE dbo.Orders ADD [rowversion] [timestamp] NOT NULL;

ALTER TABLE dbo.Products ADD [rowversion] [timestamp] NOT NULL;

ALTER TABLE dbo.Region ADD [rowversion] [timestamp] NOT NULL;

ALTER TABLE dbo.Shippers ADD [rowversion] [timestamp] NOT NULL;

ALTER TABLE dbo.Suppliers ADD [rowversion] [timestamp] NOT NULL;

ALTER TABLE dbo.Territories ADD [rowversion] [timestamp] NOT NULL;
