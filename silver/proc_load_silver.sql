/*
Data Cleansing : 
 Remove unwanted spaces
 data normalization and standardization 
 handling missing data
 remove duplicates
 data enrichment
*/
Create or alter Procedure silver.load_silver AS 
BEGIN 
    /*
    ========================================
                crm_cust_info TABLE
    ========================================
    */

    --check for nulls or duplicates in primary key 
    select cst_id , count(*)
    from bronze.crm_cust_info
    group by cst_id
    having count(*) > 1 or cst_id IS NULL;


    --check for unwated spaces 
    select cst_id, cst_firstname
    from bronze.crm_cust_info 
    where cst_firstname != TRIM(cst_firstname);
    -- Data Standardization & Consistency 
    SELECT DISTINCT cst_gndr
    FROM bronze.crm_cust_info;
    SELECT DISTINCT cst_material_status
    FROM bronze.crm_cust_info;
    TRUNCATE TABLE silver.crm_cust_info
    INSERT INTO silver.crm_cust_info (
        cst_id,
        cst_key,
        cst_firstname,
        cst_lastname,
        cst_material_status,
        cst_gndr,
        cst_create_date,
        dwh_create_date
    )
    SELECT 
        cst_id,
        cst_key,
        TRIM(cst_firstname),
        TRIM(cst_lastname),
        CASE 
            WHEN UPPER(TRIM(cst_material_status)) = 'S' THEN 'Single'
            WHEN UPPER(TRIM(cst_material_status)) = 'M' THEN 'Married'
            ELSE 'Unknown'
        END AS cst_material_status,
        CASE 
            WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
            WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
            ELSE 'Unknown'
        END AS cst_gndr,
        cst_create_date,
        GETDATE()  -- dwh_create_date
    FROM (
        SELECT *,
            ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
        FROM bronze.crm_cust_info
    ) t
    WHERE flag_last = 1 AND cst_id IS NOT NULL;

    SELECT * FROM silver.crm_cust_info;

    /*
    ========================================
                crm_prd_info TABLE
    ========================================
    */
    TRUNCATE TABLE silver.crm_prd_info
    INSERT INTO silver.crm_prd_info ( prd_id ,
	    cat_id ,
	    prd_key ,
	    prd_nm ,
	    prd_cost ,
	    prd_line ,
	    prd_start_dt ,
	    prd_end_dt)
    SELECT  
        prd_id ,
        REPLACE (SUBSTRING(prd_key,1,5),'-','_' ) AS cat_id,
        SUBSTRING(prd_key,7,len(prd_key)) AS prd_key,
	    prd_nm ,
	    ISNULL(prd_cost,0) AS prd_cost,
        CASE WHEN Upper(TRIM(prd_line)) = 'M' THEN 'Mountain'
             WHEN Upper(TRIM(prd_line)) = 'R' THEN 'Road'
             WHEN Upper(TRIM(prd_line)) = 'S' THEN 'Other Sales'
             WHEN Upper(TRIM(prd_line)) = 'T' THEN 'Touring'
        ELSE 'unkonwn'
        END prd_line,
	    prd_start_dt ,
        DATEADD(DAY, -1, LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt)) AS prd_end_dt

    FROM bronze.crm_prd_info;

    /*
    ========================================
                crm_sales_details TABLE
    ========================================
    */
    TRUNCATE TABLE silver.crm_sales_details

    INSERT INTO silver.crm_sales_details(
        sls_ord_num,
	    sls_prd_key ,
	    sls_cust_id ,
	    sls_order_dt ,
	    sls_ship_dt ,
	    sls_due_dt ,
	    sls_sales ,
	    sls_quantity ,
	    sls_price)
    select 
        sls_ord_num ,
	    sls_prd_key ,
	    sls_cust_id ,
	    case WHEN sls_order_dt = 0 OR LEN(sls_order_dt) != 8 THEN NULL
        ELSE  CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)
        END sls_order_dt,
        CASE WHEN sls_ship_dt = 0 OR LEN (sls_ship_dt) != 8 THEN NULL
        ELSE CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE)
        END sls_ship_dt,
        CASE WHEN sls_due_dt = 0 OR LEN (sls_due_dt) != 8 THEN NULL
        ELSE CAST(CAST(sls_due_dt AS VARCHAR) AS DATE)
        END sls_due_dt,
	    CASE WHEN sls_sales IS NULL OR sls_sales <=0 or sls_sales != sls_quantity * ABS(sls_price)
            THEN sls_quantity * ABS(sls_price)
            ELSE sls_sales 
            END AS sls_sales, 
	    sls_quantity ,
	    CASE WHEN sls_price IS NULL OR sls_price <=0 THEN sls_sales / NULLIF(sls_quantity,0)
            ELSE sls_price
         END sls_price 
    from bronze.crm_sales_details;
    /*
    ========================================
                erp_cust_az12 TABLE
    ========================================
    */
    TRUNCATE TABLE silver.erp_cust_az12
    INSERT INTO silver.erp_cust_az12(cid,bdate,gen)
    SELECT
    CASE WHEN SUBSTRING(cid,1,3) = 'NAS' 
    THEN SUBSTRING(cid,4,LEN(cid))
    ELSE cid
    END cid,
    CASE WHEN bdate > GETDATE() 
        THEN NULL
        ELSE bdate
        END bdate,
    CASE WHEN UPPER(TRIM(gen)) in ('F', 'FEMALE') THEN 'Female'
        WHEN UPPER(TRIM(gen)) in ('M', 'MALE') THEN 'Male'
        ELSE 'unknown'
        END gen
    from bronze.erp_cust_az12
    /*
    ========================================
                erp_loc_a101 TABLE
    ========================================
    */
    TRUNCATE TABLE silver.erp_loc_a101
    INSERT INTO silver.erp_loc_a101(cid,cntry)
    SELECT replace(cid,'-','')cid,
    CASE WHEN TRIM(cntry) = 'DE' THEN 'Germany'
    WHEN TRIM(cntry) in ('US', 'USA') THEN 'United States'
    WHEN cntry IS NULL OR cntry = '' THEN 'unknown'
    ELSE cntry
    END cntry
    FROM bronze.erp_loc_a101 
    /*
    ========================================
                erp_cat_g1v2 TABLE
    ========================================
    */
    TRUNCATE TABLE silver.erp_cat_g1v2
    INSERT INTO silver.erp_cat_g1v2 (id, cat, subcat,maintenance)
    SELECT id ,
	    cat ,
	    subcat ,
	    maintenance
    FROM bronze.erp_cat_g1v2 

END