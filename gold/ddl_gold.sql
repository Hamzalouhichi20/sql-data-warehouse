    /*
    ========================================
                dim_customer VIEW
    ========================================
    */
CREATE VIEW gold.dim_customer AS 
SELECT 
	ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key,--Surrogate key
	client.cst_id as customer_id,
	client.cst_key as customer_number ,
	client.cst_firstname AS first_name ,
	client.cst_lastname AS last_name ,
	LOC.cntry AS country,
	ca.bdate birthdate,
	client.cst_material_status AS material_status ,
	CASE WHEN client.cst_gndr != 'unknown' THEN client.cst_gndr
	ELSE COALESCE (ca.gen,'unknown') 
	END gender,
	client.cst_create_date AS create_date
FROM silver.crm_cust_info client
LEFT JOIN silver.erp_cust_az12 ca 
ON client.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 LOC
ON client.cst_key = LOC.cid;

 /*
    ========================================
                dim_product VIEW
    ========================================
  */
CREATE VIEW gold.dim_product AS 
SELECT
		ROW_NUMBER() OVER (ORDER BY prd_id) AS product_key,--Surrogate key
		pro.prd_id AS product_id,
		pro.prd_key AS product_number,
		pro.prd_nm AS product_name,
	    pro.cat_id as category_id ,
	    cat AS category,
	     subcat AS subcategory,
	    pro.prd_cost as cost ,
	    pro.prd_line as product_line ,
	    pro.prd_start_dt as start_date ,
	    maintenance
from silver.crm_prd_info pro
LEFT JOIN silver.erp_cat_g1v2 cat
ON pro.cat_id = cat.id
where pro.prd_end_dt IS NULL  --no need for historical data

 /*
    ========================================
              fact_sales_details VIEW
    ========================================
  */
  CREATE VIEW gold.fact_sales AS 
  SELECT 
		sls.sls_ord_num AS order_number,
		pr.product_key ,
		cu.customer_key,
	    sls.sls_order_dt AS order_date ,
	    sls.sls_ship_dt AS shipping_date,
	    sls.sls_due_dt AS due_date,
	    sls.sls_sales AS sales_amount,
	    sls.sls_quantity as quantity ,
	    sls.sls_price as price
FROM silver.crm_sales_details sls
LEFT JOIN gold.dim_product pr
ON sls.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customer cu
ON sls.sls_cust_id = cu.customer_id
