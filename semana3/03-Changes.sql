-- Author: Willyams Yujra
-- Adiciona un sufijo a un atributo para 
-- forzar la actualizacion del Timestamp 
-- de la tabla y que JOB de DWH se ejecute automaticamente
-- Change Values
USE pubs;

-- dbo.Categories
UPDATE dbo.Categories 
SET CategoryName = 'Bever ' + FORMAT(GETDATE(), 'ss')
WHERE CategoryID = 1;

UPDATE dbo.Categories 
SET CategoryName = 'Grains/ ' + FORMAT(GETDATE(), 'ss')
WHERE CategoryID = 5;

-- dbo.Customers
UPDATE dbo.Customers 
SET CompanyName='Blauer See ' + FORMAT(GETDATE(), 'ss')
WHERE CustomerID='BLAUS';
UPDATE dbo.Customers 
SET CompanyName='Godos Cocina ' + FORMAT(GETDATE(), 'ss')
WHERE CustomerID='GODOS';

-- dbo.Employees
UPDATE dbo.Employees
SET LastName='Pea_' + FORMAT(GETDATE(), 'ss')
WHERE EmployeeID=4;
UPDATE dbo.Employees
SET LastName='Call ' + FORMAT(GETDATE(), 'ss')
WHERE EmployeeID=8;

-- dbo.Products
UPDATE dbo.Products
SET ProductName='Chai ' + FORMAT(GETDATE(), 'ss')
WHERE ProductID=1;
UPDATE dbo.Products
SET ProductName='Ipoh ' + FORMAT(GETDATE(), 'ss')
WHERE ProductID=43;
