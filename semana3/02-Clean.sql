use pubsDW;
GO

delete from dbo.DimCategories where 1=1;
delete from dbo.DimCustomers where 1=1;
delete from dbo.DimEmployees where 1=1;
delete from dbo.DimProducts where 1=1;
delete from dbo.DimShipCity where 1=1;
delete from dbo.DimShipCountry where 1=1;
delete from dbo.DimShipName where 1=1;
delete from dbo.DimShippers where 1=1;
delete from dbo.DimShipRegion where 1=1;
delete from dbo.DimSuppliers where 1=1;
delete from dbo.FactOrders where 1=1;


update dbo.PackageConfig 
set LastRowVersion = 0
where 1=1;
