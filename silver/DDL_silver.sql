/*
===============================================================================
DDL Script: Create silver Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'silver' schema
	dwh_create_date : to know when exactly the data is charged
===============================================================================
*/
Create table silver.crm_cust_info (
	cst_id int,
	cst_key varchar(50),
	cst_firstname varchar(50),
	cst_lastname varchar(50),
	cst_material_status varchar(50),
	cst_gndr varchar(50),
	cst_create_date DATE,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
	);
Create table silver.crm_prd_info (
	prd_id int,
	cat_id varchar(50),
	prd_key varchar(50),
	prd_nm varchar(50),
	prd_cost int,
	prd_line varchar(50),
	prd_start_dt DATE,
	prd_end_dt DATE,
	dwh_create_date DATETIME2 DEFAULT GETDATE());

Create table silver.crm_sales_details (
	sls_ord_num varchar(50),
	sls_prd_key varchar(50),
	sls_cust_id int,
	sls_order_dt DATE,
	sls_ship_dt DATE,
	sls_due_dt DATE,
	sls_sales int,
	sls_quantity int,
	sls_price int,
	dwh_create_date DATETIME2 DEFAULT GETDATE());
Create table silver.erp_loc_a101 (
	cid varchar(50),
	cntry varchar(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE());
Create table silver.erp_cust_az12 (
	cid varchar(50),
	bdate DATE,
	gen varchar(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE());
Create table silver.erp_cat_g1v2 (
	id varchar(50),
	cat varchar(50),
	subcat varchar(50),
	maintenance varchar(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE());
