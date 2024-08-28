-- Author: Rimberth Villca
-- Crea SP para la base de datos pubsDW
-- SETTING ENVIROMENT 
USE pubsDW
GO
    -- Procedure to load data from GetLastPackageRowVersion
    IF EXISTS (
        SELECT *
        FROM sys.objects
        WHERE object_id = OBJECT_ID(N'dbo.InsertIfNotExists') AND type in (N'P', N'PC')
    ) 
    DROP PROCEDURE dbo.InsertIfNotExists
GO
    CREATE PROCEDURE InsertIfNotExists @TableName NVARCHAR(255) AS BEGIN IF NOT EXISTS(
        SELECT
            TOP(1) 1
        FROM
            [dbo].[PackageConfig]
        WHERE
            [TableName] = @TableName
    ) BEGIN
INSERT INTO
    [dbo].[PackageConfig] ([TableName], [LastRowVersion])
VALUES
    (@TableName, 0)
END
END
GO
;

EXEC InsertIfNotExists 'Categories';

EXEC InsertIfNotExists 'Suppliers';

EXEC InsertIfNotExists 'Products';

EXEC InsertIfNotExists 'Customers';

EXEC InsertIfNotExists 'Employees';

EXEC InsertIfNotExists 'ShipName';

EXEC InsertIfNotExists 'ShipCountry';

EXEC InsertIfNotExists 'ShipCity';

EXEC InsertIfNotExists 'ShipRegion';

EXEC InsertIfNotExists 'Orders';

EXEC InsertIfNotExists 'Categories';

EXEC InsertIfNotExists 'Shippers';


--EXEC InsertIfNotExists '';