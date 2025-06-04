/*
===============================================================================
Stored Procedure: Load Bronze Layer 
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage:
    EXEC bronze.load_bronze;
===============================================================================
*/
Create or alter Procedure bronze.load_bronze AS 
BEGIN 
	DECLARE @start_time DATETIME,@end_time DATETIME,@batch_start_time DATETIME, @batch_end_time DATETIME;
	SET @batch_start_time = GETDATE();
	BEGIN TRY
		PRINT '================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '================================================';

		PRINT '------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_cust_info;
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\louhi\OneDrive\Documents\sql-data-warehouse\datasets\source_crm\cust_info.csv'
		With ( FIRSTROW = 2 , FIELDTERMINATOR = ',', TABLOCK );
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_prd_info;
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\louhi\OneDrive\Documents\sql-data-warehouse\datasets\source_crm\prd_info.csv'
		With ( FIRSTROW = 2 , FIELDTERMINATOR = ',', TABLOCK );
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_sales_details;
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\louhi\OneDrive\Documents\sql-data-warehouse\datasets\source_crm\sales_details.csv'
		With ( FIRSTROW = 2 , FIELDTERMINATOR = ',', TABLOCK );
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';
		PRINT '------------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '------------------------------------------------';
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_loc_a101;
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\louhi\OneDrive\Documents\sql-data-warehouse\datasets\source_erp\LOC_A101.csv'
		With ( FIRSTROW = 2 , FIELDTERMINATOR = ',', TABLOCK );
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_cust_az12;
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\louhi\OneDrive\Documents\sql-data-warehouse\datasets\source_erp\CUST_AZ12.csv'
		With ( FIRSTROW = 2 , FIELDTERMINATOR = ',', TABLOCK );
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_cat_g1v2;
		BULK INSERT bronze.erp_cat_g1v2
		FROM 'C:\Users\louhi\OneDrive\Documents\sql-data-warehouse\datasets\source_erp\PX_CAT_G1V2.csv'
		With ( FIRSTROW = 2 , FIELDTERMINATOR = ',', TABLOCK );
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';
		SET @batch_end_time = GETDATE();
		PRINT '=========================================='
		PRINT 'Loading Bronze Layer is Completed';
        PRINT 'Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '=========================================='
	END TRY
	BEGIN CATCH 
		PRINT '========================================'
		PRINT 'ERROR OCCURED DURING LODING BRONZE LAYER'
		PRINT '========================================'
	END CATCH
END