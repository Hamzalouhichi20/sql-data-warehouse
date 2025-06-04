/*
====================================================================
					CREATE DATA BASE AND SCHEMAS
====================================================================
Script purpose:
	this script creates a new database named "DataWarehouse"
	AND sets up three schemas within the database : 'bronze' , 'silver' and 'gold'.
*/
Use master;
GO
--create 'DataWarehouse' database --
Create DATABASE DataWarehouse;
Use DataWarehouse;
GO
--create 'bronze' schema --
Create schema bronze;
GO
--create 'gold' schema --
Create schema gold;
GO
--create 'silver' schema --
Create schema silver;