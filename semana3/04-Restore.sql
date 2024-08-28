-- Author: Willyams Yujra
-- Restaura los valores Iniciales para 
-- forzar la actualizacion del Timestamp 
-- de la tabla y que JOB de DWH se ejecute automaticamente
-- Restore Values
USE pubs;

-- dbo.Categories
UPDATE dbo.Categories 
SET CategoryName = 'Beverages'
WHERE CategoryID = 1;
UPDATE dbo.Categories 
SET CategoryName = 'Grains/Cereals'
WHERE CategoryID = 5;


-- dbo.Customers
UPDATE dbo.Customers 
SET CompanyName='Blauer See Delikatessen'
WHERE CustomerID='BLAUS';

UPDATE dbo.Customers 
SET CompanyName='Godos Cocina Típica'
WHERE CustomerID='GODOS';


-- dbo.Employees
UPDATE dbo.Employees
SET LastName='Peacock'
WHERE EmployeeID=4;
UPDATE dbo.Employees
SET LastName='Callahan'
WHERE EmployeeID=8;


-- dbo.Products
UPDATE dbo.Products
SET ProductName='Chai'
WHERE ProductID=1;
UPDATE dbo.Products
SET ProductName='Ipoh Coffee'
WHERE ProductID=43;