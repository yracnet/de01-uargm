-- Author: Willyams Yujra
-- Adicionar rowversion a las tables existentes

-- REMOVE
IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'pubs.dbo.Categories') AND name = 'rowversion')
BEGIN
    ALTER TABLE pubs.dbo.Categories DROP COLUMN [rowversion];
END

IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'pubs.dbo.CustomerCustomerDemo') AND name = 'rowversion')
BEGIN
    ALTER TABLE pubs.dbo.CustomerCustomerDemo DROP COLUMN [rowversion];
END

IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'pubs.dbo.CustomerDemographics') AND name = 'rowversion')
BEGIN
    ALTER TABLE pubs.dbo.CustomerDemographics DROP COLUMN [rowversion];
END

IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'pubs.dbo.Customers') AND name = 'rowversion')
BEGIN
    ALTER TABLE pubs.dbo.Customers DROP COLUMN [rowversion];
END

IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'pubs.dbo.EmployeeTerritories') AND name = 'rowversion')
BEGIN
    ALTER TABLE pubs.dbo.EmployeeTerritories DROP COLUMN [rowversion];
END

IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'pubs.dbo.Employees') AND name = 'rowversion')
BEGIN
    ALTER TABLE pubs.dbo.Employees DROP COLUMN [rowversion];
END

IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'pubs.dbo.OrderDetails') AND name = 'rowversion')
BEGIN
    ALTER TABLE pubs.dbo.OrderDetails DROP COLUMN [rowversion];
END

IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'pubs.dbo.Orders') AND name = 'rowversion')
BEGIN
    ALTER TABLE pubs.dbo.Orders DROP COLUMN [rowversion];
END

IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'pubs.dbo.Products') AND name = 'rowversion')
BEGIN
    ALTER TABLE pubs.dbo.Products DROP COLUMN [rowversion];
END

IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'pubs.dbo.Region') AND name = 'rowversion')
BEGIN
    ALTER TABLE pubs.dbo.Region DROP COLUMN [rowversion];
END

IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'pubs.dbo.Shippers') AND name = 'rowversion')
BEGIN
    ALTER TABLE pubs.dbo.Shippers DROP COLUMN [rowversion];
END

IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'pubs.dbo.Suppliers') AND name = 'rowversion')
BEGIN
    ALTER TABLE pubs.dbo.Suppliers DROP COLUMN [rowversion];
END

IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'pubs.dbo.Territories') AND name = 'rowversion')
BEGIN
    ALTER TABLE pubs.dbo.Territories DROP COLUMN [rowversion];
END


-- ADD

ALTER TABLE pubs.dbo.Categories ADD [rowversion] [timestamp] NOT NULL;

ALTER TABLE pubs.dbo.CustomerCustomerDemo ADD [rowversion] [timestamp] NOT NULL;

ALTER TABLE pubs.dbo.CustomerDemographics ADD [rowversion] [timestamp] NOT NULL;

ALTER TABLE pubs.dbo.Customers ADD [rowversion] [timestamp] NOT NULL;

ALTER TABLE pubs.dbo.EmployeeTerritories ADD [rowversion] [timestamp] NOT NULL;

ALTER TABLE pubs.dbo.Employees ADD [rowversion] [timestamp] NOT NULL;

ALTER TABLE pubs.dbo.OrderDetails ADD [rowversion] [timestamp] NOT NULL;

ALTER TABLE pubs.dbo.Orders ADD [rowversion] [timestamp] NOT NULL;

ALTER TABLE pubs.dbo.Products ADD [rowversion] [timestamp] NOT NULL;

ALTER TABLE pubs.dbo.Region ADD [rowversion] [timestamp] NOT NULL;

ALTER TABLE pubs.dbo.Shippers ADD [rowversion] [timestamp] NOT NULL;

ALTER TABLE pubs.dbo.Suppliers ADD [rowversion] [timestamp] NOT NULL;

ALTER TABLE pubs.dbo.Territories ADD [rowversion] [timestamp] NOT NULL;
