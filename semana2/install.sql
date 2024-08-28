
-- Author: Willyams Yujra
-- Script para instalar todo el proyecto
-- sqlcmd -S localhost -d master -i install.sql
-- PUBS-SCRIPTS
:r ./semana2/pubs-scripts/step00-CreateDB.sql 
:r ./semana2/pubs-scripts/step01-AddRowVersion.sql 
:r ./semana2/pubs-scripts/step02-CreateStoresProcedures.sql 
:r ./semana2/pubs-scripts/step04-CreateStoresProcedureDataBase.sql


-- DATAWEREHOUSE-SCRIPTS
:r ./semana2/pubsDW-scripts/00_pubsDWSchema.sql 
:r ./semana2/pubsDW-scripts/01_StaginSchema.sql 
:r ./semana2/pubsDW-scripts/02_storeProcedure_DW.sql 
:r ./semana2/pubsDW-scripts/03_Populate_PackageConfig.sql 
:r ./semana2/pubsDW-scripts/04_script_DimDate.sql
