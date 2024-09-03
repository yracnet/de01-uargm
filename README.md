# Data Engineering - MDEISV2E3

Este documento detalla las tareas realizadas en el módulo "Data Engineering - MDEISV2E3", dividido por semanas. A lo largo del curso, se desarrollaron diferentes componentes relacionados con la ingeniería de datos, incluyendo la creación de un modelo de negocio, la implementación de un almacén de datos, el diseño de procesos ETL, y la construcción de un modelo OLAP.

## Semana 1: Presentación del Modelo de Negocio y Flujo de Datos

### Descripción:
En la primera semana, se presentó el modelo de negocio y se explicó el flujo de datos que se utilizará durante el proyecto. Se realizó un diagrama entidad-relación (ER) que muestra cómo los datos se relacionan entre sí en la base de datos principal.

### Archivos:
- **Diagrama ER:**  
  ![Diagrama ER](semana1/diagrama-er.png)

- **Script de Creación de Base de Datos:**  
  `semana1/step00-CreateDB.sql`

## Semana 2: Diseño e Implementación de un Almacén de Datos

### Descripción:
Durante la segunda semana, se diseñó e implementó un almacén de datos para almacenar información histórica de la empresa. El diseño se centró en un modelo multidimensional, desnormalizando el modelo entidad-relación original para adaptarlo a un enfoque orientado a hechos y dimensiones.

### Archivos:
- **Scripts de Creación y Población del Almacén de Datos:**  
  - `semana2/pubs-scripts`
  - `semana2/pubsDW-scripts`
  - `semana2/install.sql`

- **Backups:**
  - `semana2/pubs.bak`
  - `semana2/pubsDW.bak`

- **Imágenes:**
  - **Modelo pubs:**  
    ![Modelo pubs](semana2/pubs.png)
  - **Modelo pubsDW:**  
    ![Modelo pubsDW](semana2/pubsDW.png)

- **Documentación Adicional:**  
  `semana2/readme.txt`

## Semana 3: Diseño e Implementación de un Proceso ETL

### Descripción:
En la tercera semana, se diseñó e implementó un proceso ETL (Extract, Transform, Load) utilizando SQL Server Integration Services (SSIS). Este proceso se encargó de la integración y transformación de datos desde la base de datos transaccional hacia el almacén de datos.

### Archivos:
- **ETL Scripts:**
  - `semana3/etl-pubs`
  - `semana3/00-Modelo.png`
  - `semana3/01-CreateSQLConection.png`
  - `semana3/02-Clean.sql`
  - `semana3/03-Changes.sql`
  - `semana3/04-Restore.sql`

- **Backups:**
  - `semana3/pubs.bak`
  - `semana3/pubsDW.bak`

- **ETL Imágenes:**
  - **Modelo ETL:**  
    ![Modelo ETL](semana3/00-Modelo.png)
  - **Conexión SQL:**  
    ![Conexión SQL](semana3/01-CreateSQLConection.png)
  - **ETL Categorías:**  
    ![ETL Categorías](semana3/ETL-Categories.png)
  - **ETL Clientes:**  
    ![ETL Clientes](semana3/ETL-Customers.png)
  - **ETL Empleados:**  
    ![ETL Empleados](semana3/ETL-Employees.png)
  - **ETL Órdenes Final:**  
    ![ETL Órdenes Final](semana3/ETL-OrdersFinal.png)
  - **ETL Órdenes:**  
    ![ETL Órdenes](semana3/ETL-Ordes.png)
  - **ETL Productos:**  
    ![ETL Productos](semana3/ETL-Products.png)
  - **ETL Ciudad de Envío:**  
    ![ETL Ciudad de Envío](semana3/ETL-ShipCity.png)
  - **ETL País de Envío:**  
    ![ETL País de Envío](semana3/ETL-ShipCountry.png)
  - **ETL Nombre de Envío:**  
    ![ETL Nombre de Envío](semana3/ETL-ShipName.png)
  - **ETL Transportistas:**  
    ![ETL Transportistas](semana3/ETL-Shippers.png)
  - **ETL Región de Envío:**  
    ![ETL Región de Envío](semana3/ETL-ShipRegion.png)
  - **ETL Proveedores:**  
    ![ETL Proveedores](semana3/ETL-Suppliers.png)

- **Log de Información:**
  - `semana3/info.log`

## Semana 4: Proyecto Final - Modelo OLAP y Reportes en BI

### Descripción:
En la última semana, se diseñó e implementó un modelo OLAP utilizando SQL Server Analysis Services (SSAS). Además, se elaboraron reportes utilizando herramientas de BI para analizar los datos del modelo OLAP.

### Archivos:
- **Modelo OLAP y SSAS:**
  - **Modelo pubs OLAP v2:**  
    ![Modelo pubs OLAP](semana4/ModeloPubsOLAPv2.png)
  - **Modelo BI Importado:**  
    ![Modelo BI Importado](semana4/ModeloBI-Importado.png)
  - **Modelo SSAS:**  
    ![Modelo SSAS](semana4/ModeloSSAS.png)
  - **Despliegue del Modelo Tabular:**  
    ![Despliegue del Modelo Tabular](semana4/DeployModeloTabular.png)

- **Backups y Archivos Relacionados:**
  - `semana4/pubs.bak`
  - `semana4/pubsDW.bak`
  - `semana4/pubsOLAP.abf`

- **Reportes BI:**
  - **Reporte de Inicio:**  
    ![Reporte de Inicio](semana4/Report00_Home.png)
  - **Desempeño de Ventas:**  
    ![Desempeño de Ventas](semana4/Report01_SalesPerformance.png)
  - **Desempeño de Productos:**  
    ![Desempeño de Productos](semana4/Report02_ProductPerformance.png)
  - **Desempeño de Ventas por País:**  
    ![Desempeño de Ventas por País](semana4/Report03_SalesPerformanceByCountry.png)
  - **Desempeño de Clientes:**  
    ![Desempeño de Clientes](semana4/Report04_CustomersPerformance.png)
  - **Desempeño de Ventas por Categorías:**  
    ![Desempeño de Ventas por Categorías](semana4/Report05_SalesPerformanceByCategories.png)
  - **Reporte de Productos - Cantidad Vendida:**  
    ![Reporte de Productos - Cantidad Vendida](semana4/Reporte-Productos-CantidadVendida.png)
