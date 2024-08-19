-- Author: Willyams Yujra
-- Test SP para verificar integracion

DECLARE @startRow bigint
DECLARE @endRow bigint
set @startRow = 0
set @endRow = dbo.GetCurrentRowVersion ()

-- EXECUTE dbo.GetCategoriesByRowVersion @startRow, @endRow
-- EXECUTE dbo.GetCustomersByRowVersion @startRow, @endRow
EXECUTE dbo.GetEmployeesByRowVersion @startRow, @endRow
-- EXECUTE dbo.GetProductsByRowVersion @startRow, @endRow
-- EXECUTE dbo.GetSuppliersByRowVersion @startRow, @endRow
-- EXECUTE dbo.GetShippersByRowVersion @startRow, @endRow
-- EXECUTE dbo.GetOrdersByRowVersion @startRow, @endRow