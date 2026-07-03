-- 1. Create Database if it doesn't exist
CREATE DATABASE IF NOT EXISTS ecom_pipeline_db

-- 2. Target the newly created database
USE ecom_pipeline_db


USE ecom_pipeline_db;

-- 1. I-drop muna natin ang pasaway na table
DROP TABLE IF EXISTS t_2026_001_may_2022;

-- 2. I-recreate natin kung saan LAHAT ay VARCHAR para walang error sa "Nill"
CREATE TABLE t_2026_001_may_2022 (
    index_no VARCHAR(100),
    sku VARCHAR(100),
    style_id VARCHAR(100),
    catalog VARCHAR(100),
    weight VARCHAR(100),
    tp VARCHAR(100),
    mrp_old VARCHAR(100),
    final_mrp_old VARCHAR(100),
    ajio_mrp VARCHAR(100),
    amazon_mrp VARCHAR(100),
    amazon_fba_mrp VARCHAR(100),
    flipkart_mrp VARCHAR(100),
    limeroad_mrp VARCHAR(100),
    myntra_mrp VARCHAR(100),
    paytm_mrp VARCHAR(100),
    snapdeal_mrp VARCHAR(100)
);

-- 1. Amazon Sales Report (DATA-2026-001)
DROP TABLE IF EXISTS t_2026_001_amazon_sale_report;
CREATE TABLE t_2026_001_amazon_sale_report (
    index_no VARCHAR(100),
    order_id VARCHAR(100),
    date_raw VARCHAR(100),
    status VARCHAR(100),
    fulfilment VARCHAR(100),
    sales_channel VARCHAR(100),
    ship_service_level VARCHAR(100),
    style VARCHAR(100),
    sku VARCHAR(100),
    category VARCHAR(100),
    size VARCHAR(50),
    asin VARCHAR(100),
    courier_status VARCHAR(100),
    qty VARCHAR(50),
    currency VARCHAR(50),
    amount VARCHAR(100),
    ship_city VARCHAR(100),
    ship_state VARCHAR(100),
    ship_postal_code VARCHAR(100),
    ship_country VARCHAR(100),
    promotion_ids TEXT,
    b2b VARCHAR(50),
    fulfilled_by VARCHAR(100),
    unnamed_22 VARCHAR(100)
);

-- 2. International Sales Report (DATA-2026-001)
DROP TABLE IF EXISTS t_2026_001_international_sale_report
CREATE TABLE t_2026_001_international_sale_report (
    index_no VARCHAR(100),
    date_raw VARCHAR(100),
    months_raw VARCHAR(100),
    customer VARCHAR(255),
    style VARCHAR(100),
    sku VARCHAR(100),
    size VARCHAR(50),
    pcs VARCHAR(50),
    rate VARCHAR(50),
    gross_amt VARCHAR(100)
);

-- 3. Cloud Warehouse Comparison Chart (DATA-2026-001)
DROP TABLE IF EXISTS t_2026_001_cloud_warehouse_comparison;
CREATE TABLE t_2026_001_cloud_warehouse_comparison (
    index_no VARCHAR(100),
    shiprocket TEXT,
    unnamed_1 TEXT,
    increff TEXT
);

-- 4. Expense IIGF (DATA-2026-001)
DROP TABLE IF EXISTS t_2026_001_expense_iigf;
CREATE TABLE t_2026_001_expense_iigf (
    index_no VARCHAR(100),
    received_amount_raw VARCHAR(100),
    unnamed_1 VARCHAR(100),
    expense_particular TEXT,
    unnamed_3 VARCHAR(100)
);

-- 5. May-2022 Inventory (DATA-2026-001)
DROP TABLE IF EXISTS t_2026_001_may_2022;
CREATE TABLE t_2026_001_may_2022 (
    index_no VARCHAR(100),
    sku VARCHAR(100),
    style_id VARCHAR(100),
    catalog VARCHAR(100),
    weight VARCHAR(50),
    tp VARCHAR(50),
    mrp_old VARCHAR(50),
    final_mrp_old VARCHAR(50),
    ajio_mrp VARCHAR(50),
    amazon_mrp VARCHAR(50),
    amazon_fba_mrp VARCHAR(50),
    flipkart_mrp VARCHAR(50),
    limeroad_mrp VARCHAR(50),
    myntra_mrp VARCHAR(50),
    paytm_mrp VARCHAR(50),
    snapdeal_mrp VARCHAR(50)
);

-- 6. P&L March 2021 (DATA-2026-001)
DROP TABLE IF EXISTS t_2026_001_pl_march_2021;
CREATE TABLE t_2026_001_pl_march_2021 (
    index_no VARCHAR(100),
    sku VARCHAR(100),
    style_id VARCHAR(100),
    catalog VARCHAR(100),
    category VARCHAR(100),
    weight VARCHAR(50),
    tp_1 VARCHAR(50),
    tp_2 VARCHAR(50),
    mrp_old VARCHAR(50),
    final_mrp_old VARCHAR(50),
    ajio_mrp VARCHAR(50),
    amazon_mrp VARCHAR(50),
    amazon_fba_mrp VARCHAR(50),
    flipkart_mrp VARCHAR(50),
    limeroad_mrp VARCHAR(50),
    myntra_mrp VARCHAR(50),
    paytm_mrp VARCHAR(50),
    snapdeal_mrp VARCHAR(50)
);

-- 7. Sale Report Inventory (DATA-2026-001)
DROP TABLE IF EXISTS t_2026_001_sale_report;
CREATE TABLE t_2026_001_sale_report (
    index_no VARCHAR(100),
    sku_code VARCHAR(100),
    design VARCHAR(100),
    stock VARCHAR(50),
    category VARCHAR(100),
    size VARCHAR(50),
    color VARCHAR(100)
);

SHOW TABLES

SELECT * FROM t_2026_001_amazon_sale_report

SELECT COUNT(*) FROM t_2026_001_amazon_sale_report
SELECT COUNT(*) FROM t_2026_001_amazon_sale_report_stagging
SELECT COUNT(*) FROM t_2026_001_cloud_warehouse_comparison
SELECT COUNT(*) FROM t_2026_001_cloud_warehouse_comparison_stagging
SELECT COUNT(*) FROM t_2026_001_expense_iigf
SELECT COUNT(*) FROM t_2026_001_expense_iigf_stagging
SELECT COUNT(*) FROM t_2026_001_international_sale_report
SELECT COUNT(*) FROM t_2026_001_international_sale_report_stagging
SELECT COUNT(*) FROM t_2026_001_may_2022
SELECT COUNT(*) FROM t_2026_001_may_202_stagging
SELECT COUNT(*) FROM t_2026_001_pl_march_2021
SELECT COUNT(*) FROM t_2026_001_pl_march_2021_stagging
SELECT COUNT(*) FROM t_2026_001_sale_report
SELECT COUNT(*) FROM t_2026_001_sale_report_Stagging

USE ecom_pipeline_db
-- Direct load 2 tables
LOAD DATA INFILE 'E:/Projects/Data Analyst/DATA-2026-001_ECom_EndToEnd_Pipeline/01_Raw_Data/May-2022.csv'
INTO TABLE t_2026_001_may_2022
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n' -- \r\n ang gamit sa Windows Excel files
IGNORE 1 LINES;

SELECT COUNT(*) AS total_rows_imported FROM t_2026_001_may_2022;
SELECT * FROM t_2026_001_amazon_sale_report_stagging

-- Create staging table (copy the data from raw)
USE ecom_pipeline_db

-- 1. Kopyahin ang istraktura ng table (Nagawa mo na ito)
CREATE TABLE IF NOT EXISTS t_2026_001_sale_report_stagging LIKE t_2026_001_sale_report;

-- 2. DITO NATIN IPAPASOK ANG DATA GALING RAW PAPUNTANG STAGING:
INSERT INTO t_2026_001_sale_report_stagging
SELECT * FROM t_2026_001_sale_report;


-- Clean: Remove the deduplication each table

SELECT * FROM t_2026_001_amazon_sale_report_stagging

USE ecom_pipeline_db

WITH CTE_duplicates AS (
	SELECT *, 
		ROW_NUMBER() OVER(
			PARTITION BY order_id, sku, `Date` -- the baseline of uniques for Amazon Orders
			ORDER BY index_no
		) AS row_num
	FROM t_2026_001_amazon_sale_report_stagging
) 

-- Check if there's more than 1
SELECT * FROM CTE_duplicates
WHERE row_num > 1

-- Order id with duplications
-- 171-3249942-2207542 
-- 171-9628368-5329958
-- 405-8669298-3850736
-- 406-0372545-6086735
-- 407-4853873-4978725
-- 407-8364731-6449117
-- 408-0373839-4433120

-- Check the order id
SELECT *
FROM t_2026_001_amazon_sale_report_stagging
WHERE order_id = '407-4853873-4978725'

-- Step 1: Create a permanent, clean production table for Amazon Sale Report
-- Step 2: Remove duplicate records using ROW_NUMBER() window function

CREATE TABLE t_clean_amazon_sale_report AS
WITH CTE_Deduplicate AS(
	SELECT *,
		ROW_NUMBER() OVER(
			PARTITION BY order_id, sku, `Date` -- Define uniqueness criteria for each order
			ORDER BY index_no -- Keep the earliest record based on the index number
		) AS row_num
	FROM t_2026_001_amazon_sale_report_stagging
)
-- Filter to retain only the unique records (first occurrence)
SELECT * 
FROM CTE_Deduplicate
WHERE row_num = 1

-- Verify that the specific duplicate Order ID found earlier is now unique
SELECT order_id, sku, COUNT(*) AS record_count
FROM t_clean_amazon_sale_report
WHERE order_id = '408-0373839-4433120'
GROUP BY order_id, sku

-- Order id with duplications
-- 171-3249942-2207542 
-- 171-9628368-5329958
-- 405-8669298-3850736
-- 406-0372545-6086735
-- 407-4853873-4978725
-- 407-8364731-6449117
-- 408-0373839-4433120

-- Final audit to ensure no duplicate rows exist in the production table
WITH CTE_Final_Audit AS (
	SELECT *,
		ROW_NUMBER() OVER(
			PARTITION BY order_id, sku, `Date`
			ORDER BY index_no
		) AS row_num1
	FROM t_clean_amazon_sale_report
)

SELECT COUNT(*) AS remaining_duplicates
FROM CTE_Final_Audit
WHERE row_num1 > 1

-- Audit the clean table to identify columns with missing or NULL values
SELECT
	COUNT(*) AS total_records,
	SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS null_order_id,
	SUM(CASE WHEN sku IS NULL THEN 1 ELSE 0 END) AS null_sku,
	SUM(CASE WHEN qty IS NULL THEN 1 ELSE 0 END) AS null_qty,
	SUM(CASE WHEN amount IS NULL THEN 1 ELSE 0 END) AS null_amount,
	SUM(CASE WHEN courier_status IS NULL OR courier_status = '' THEN 1 ELSE 0 END) AS null_empty_courier_status
FROM t_clean_amazon_sale_report

-- Result
-- total_records : 128968
-- null_order_id : 0
-- null_sku : 0
-- null_qty : 0
-- null_amount : 0
-- null_empty_courier_status : 6872

-- Step 1: Update empty or NULL values in the Courier Status column to 'Unknown'
-- Step 2: Ensure data categorization is clean for dashboard reporting
UPDATE t_clean_amazon_sale_report
SET courier_status = 'Unknown'
WHERE courier_status IS NULL OR courier_status = '' -- 2 repeat column for 'courier_status' for null and emptry string

-- Verify that all NULL or empty Courier Status records have been resolved
SELECT
	COUNT(*) AS total_records,
	SUM(CASE WHEN courier_status IS NULL OR courier_status = '' THEN 1 ELSE 0 END) AS remaining_null_courier,
	SUM(CASE WHEN courier_status = 'Unknown' THEN 1 ELSE 0 END) AS total_unknown_courier
FROM t_clean_amazon_sale_report

-- RESULTS
-- total_records: 128968
-- remaining_null_courier: 0
-- total_unknown_courier: 6872

-- ---------------------------------------------------------------------------------
-- LINE SEPARATION: CONVERTING QUANTITY COLUMN TO INTEGER (DATA STANDARDIZATION)
-- ---------------------------------------------------------------------------------

-- Step 1: Ensure all blanks/NULLs in Qty are 0 before conversion
UPDATE t_clean_amazon_sale_report
SET qty = 0
WHERE qty IS NULL OR qty = ''
-- Updated Rows: 0

-- Step 2: Modify the structure to INT
ALTER TABLE t_clean_amazon_sale_report
MODIFY COLUMN qty INT
-- Updated Rows: 128968

-- ---------------------------------------------------------------------------------
-- LINE SEPARATION: CONVERTING AMOUNT COLUMN TO DECIMAL
-- ---------------------------------------------------------------------------------
-- Step 1: Ensure all blanks/NULLs in Amount are 0.00 before conversion
UPDATE t_clean_amazon_sale_report
SET amount = 0.00
WHERE amount IS NULL OR amount = ''
-- Updated Rows: 7792

-- Step 2: Modify the structure to DECIMAL(10,2)
ALTER TABLE t_clean_amazon_sale_report
MODIFY COLUMN amount DECIMAL(10,2)
-- Updated Rows: 128968

SELECT *
FROM t_clean_amazon_sale_report

DESCRIBE t_clean_amazon_sale_report;

-- ---------------------------------------------------------------------------------
-- LINE SEPARATION: STANDARDIZING CURRENCY COLUMN VALUES
-- ---------------------------------------------------------------------------------
-- Ensure no hidden leading or trailing spaces exist in the Currency field
UPDATE t_clean_amazon_sale_report
SET currency = TRIM(currency)
WHERE currency IS NOT NULL
-- Updated Rows: 128968

-- ---------------------------------------------------------------------------------
-- LINE SEPARATION: CONVERTING TEXT DATE TO STANDARD SQL DATE TYPE
-- ---------------------------------------------------------------------------------
-- Step 1: Add a temporary proper DATE column to prevent data loss during transformation
ALTER TABLE t_clean_amazon_sale_report
ADD COLUMN temp_date DATE

-- Step 2: Convert the string dates into the temporary date column 
-- Note: Assumes standard format. Adjust format string if raw data uses a different sequence.
UPDATE t_clean_amazon_sale_report
SET temp_date = STR_TO_DATE(date_raw, '%Y-%m-%d')
WHERE date_raw IS NOT NULL AND date_raw != ''
-- Error: date error

-- LINE SEPARATION: SAFE RESET OF TEMPORARY COLUMN IF EXISTS
-- ---------------------------------------------------------------------------------
ALTER TABLE t_clean_amazon_sale_report DROP COLUMN IF EXISTS `temp_date`
ALTER TABLE t_clean_amazon_sale_report DROP COLUMN IF EXISTS `sales_date`

-- LINE SEPARATION: STRUCTURAL CHANGE - ADD TEMPORARY COLUMN
-- ---------------------------------------------------------------------------------
ALTER TABLE t_clean_amazon_sale_report ADD COLUMN `temp_date` DATE

-- LINE SEPARATION: DATA MANIPULATION - PARSING DATE_ROW TO NEW COLUMN
UPDATE t_clean_amazon_sale_report
SET temp_date = STR_TO_DATE(date_raw, '%m-%d-%y')
WHERE date_raw IS NOT NULL AND date_raw != ''
-- Updated Rows: 128968

-- LINE SEPARATION: STRUCTURAL CHANGE - DROP OLD AND RENAME NEW COLUMN
ALTER TABLE t_clean_amazon_sale_report DROP COLUMN date_raw
ALTER TABLE t_clean_amazon_sale_report CHANGE COLUMN temp_date sales_date DATE

DESCRIBE t_clean_amazon_sale_report

-- =================================================================================
-- SYSTEM MODULE : E-COMMERCE DATA PIPELINE (AUDIT LAYER)
-- COMPONENT     : TABLE 2 - CLOUD WAREHOUSE COMPARISON
-- AUTHOR        : Erick Andos Golo
-- UPGRADE DATE  : 2026-06-30
-- DESCRIPTION   : INITIATING STEP 1 - INITIAL DUPLICATE DETECTION COUNT
-- =================================================================================

-- ---------------------------------------------------------------------------------
-- LINE SEPARATION: AUDITING STAGING TABLE USING ROW_NUMBER()
-- ---------------------------------------------------------------------------------

SELECT * 
FROM t_2026_001_cloud_warehouse_comparison_stagging

-- CTE Function with Window function count the nulls
WITH CTE_Matrix_Audit AS (
	SELECT *,
		ROW_NUMBER() OVER(
			PARTITION BY shiprocket -- Checking if specific service heads are duplicated
			ORDER BY index_no
		) AS row_num2
	FROM t_2026_001_cloud_warehouse_comparison_stagging
	WHERE shiprocket IS NOT NULL AND shiprocket != '' -- Exclude empty rows from primary key check
)

SELECT COUNT(*) AS duplicate_count
FROM CTE_Matrix_Audit
WHERE row_num2 > 1

-- RESULT
-- duplicate_count: 0

-- ---------------------------------------------------------------------------------
-- LINE SEPARATION: CREATE AND POPULATE PRODUCTION CLEAN TABLE
-- ---------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS t_clean_cloud_warehouse_comparison AS
SELECT
	index_no,
	shiprocket AS `service_component`, -- Renaming to descriptive header
	unnamed_1  AS `shiprocket_rate`,   -- Assigning proper ownership of the column
	increff	   AS `increff_rate`	   -- Standardizing the comparison target column
FROM t_2026_001_cloud_warehouse_comparison_stagging
WHERE index_no > 0
 

SELECT * FROM t_clean_cloud_warehouse_comparison

-- ---------------------------------------------------------------------------------
-- LINE SEPARATION: COUNTING NULL OR EMPTY VALUES FOR RATES
-- ---------------------------------------------------------------------------------
SELECT
	COUNT(*) total_records,
	SUM(CASE WHEN shiprocket_rate IS NULL OR shiprocket_rate = '' THEN 1 ELSE 0 END) AS null_shiprocket_rate,
	SUM(CASE WHEN increff_rate IS NULL OR increff_rate = '' THEN 1 ELSE 0 END) AS null_increff_rate
FROM t_clean_cloud_warehouse_comparison

/*
 * RESULTs
 * total_records: 49
 * null_shiprocket_rate: 9
 * null_increff_rate: 22
 * */

-- ---------------------------------------------------------------------------------
-- LINE SEPARATION: CONVERTING NULL / EMPTY SHIPROCKET RATES TO STANDARD VALUE
-- ---------------------------------------------------------------------------------

UPDATE t_clean_cloud_warehouse_comparison
SET shiprocket_rate = 'Not Specified'
WHERE shiprocket_rate IS NULL OR shiprocket_rate = ''

SELECT *
FROM t_clean_cloud_warehouse_comparison

-- ---------------------------------------------------------------------------------
-- LINE SEPARATION: CONVERTING NULL / EMPTY INCREFF RATES TO STANDARD VALUE
-- ---------------------------------------------------------------------------------
UPDATE t_clean_cloud_warehouse_comparison
SET increff_rate = 'Not Specified'
WHERE increff_rate IS NULL OR increff_rate = ''

-- Final quality assurance check to ensure zero unhandled missing data point
SELECT 
	COUNT(*) total_records,
	SUM(CASE WHEN shiprocket_rate IS NULL OR shiprocket_rate = 'Not Specified' THEN 1 ELSE 0 END) AS total_not_specified_shiprocket,
	SUM(CASE WHEN increff_rate IS NULL OR increff_rate = 'Not Specified' THEN 1 ELSE 0 END) AS total_not_specified_increff
FROM t_clean_cloud_warehouse_comparison

/*
RESULTS:
total_records: 49
total_not_specified_shiprocket: 9
total_not_specified_increff: 22
**/
SELECT *
FROM t_2026_001_expense_iigf_stagging

-- =================================================================================
-- SYSTEM MODULE : E-COMMERCE DATA PIPELINE (AUDIT LAYER)
-- COMPONENT     : TABLE 3 - EXPENSE IIGF LEDGER
-- AUTHOR        : Erick Andos Golo
-- UPGRADE DATE  : 2026-06-30
-- DESCRIPTION   : STEP 1 - DUPLICATE DETECTION FOR FINANCIAL OUTFLOWS
-- =================================================================================

-- ---------------------------------------------------------------------------------
-- LINE SEPARATION: AUDITING EXPENSE RECORDS USING ACTUAL COLUMN HEADERS
-- ---------------------------------------------------------------------------------
WITH CTE_Expense_Audit AS (
	SELECT *,
		ROW_NUMBER() OVER (
			PARTITION BY Expance, unnamed_3 -- Checking unique combination of item and price
			ORDER BY index_no
		) AS row_num	
	FROM t_2026_001_expense_iigf_stagging
	WHERE index_no > 0 AND Expance IS NOT NULL AND Expance != ''
)
SELECT COUNT(*) AS duplicate_count
FROM CTE_Expense_Audit
WHERE row_num > 1
-- Result: 0

-- Inspect the current data types and column structural blueprint
DESCRIBE t_2026_001_expense_iigf_stagging


SELECT * FROM t_2026_001_expense_iigf_stagging LIMIT 5;

-- ---------------------------------------------------------------------------------
-- LINE SEPARATION: CREATE AND POPULATE PRODUCTION CLEAN EXPENSE TABLE
-- ---------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS t_clean_expense_iigf AS
SELECT 
	CAST(index_no AS UNSIGNED) AS transaction_id,
	-- Correcting and casting the date column from MM-DD-YY text to proper SQL DATE
	-- STR_TO_DATE(received_amount_raw, '%m-%d-%y') AS expense_date,
	
-- Safe Date Parsing: Converts only non-blank, formatted strings to prevent Error 1411
CASE
	WHEN received_amount_raw REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{2}$'
	THEN STR_TO_DATE(received_amount_raw, '%m-%d-%y')
	ELSE NULL
END AS expense_date,

	
	-- Mapping and casting financial numerical columns to DECIMAL
	CAST(IF(unnamed_1 = '' OR unnamed_1 IS NULL, 0.00, unnamed_1) AS DECIMAL(10,2)) AS received_amount,
	CAST(IF(unnamed_3 = '' OR unnamed_3 IS NULL, 0.00, unnamed_3) AS DECIMAL(10,2)) AS expense_amount,
	
	-- Standardizing the text description column and trimming hidden spaces
	TRIM(Expance) AS expense_description
FROM t_2026_001_expense_iigf_stagging 
WHERE index_no > 0 -- Explicitly filters out the messy Row 0 headers
	
USE ecom_pipeline_db

-- Validate the new creating table
SELECT *
FROM t_clean_expense_iigf 

-- =================================================================================
-- SYSTEM MODULE : E-COMMERCE DATA PIPELINE (STAGING LAYER)
-- COMPONENT     : TABLE 4 - INTERNATIONAL SALE REPORT ALIGNMENT
-- AUTHOR        : Erick Andos Golo
-- UPGRADE DATE  : 2026-07-01
-- DESCRIPTION   : CREATING UNIFORM STAGING LAYER FROM RAW IMPORTED TABLE
-- =================================================================================

DROP TABLE IF EXISTS t_2026_001_international_sale_report_stagging
-- Unknown table

-- LINE SEPARATION: CREATE STAGING TABLE WITH MATCHING STRUCTURE
CREATE TABLE t_2026_001_international_sale_report_stagging AS 
SELECT * FROM international_sale_report
-- Updated Rows: 49025

SELECT *
FROM t_2026_001_international_sale_report_stagging

-- ---------------------------------------------------------------------------------
-- LINE SEPARATION: AUDIT QUERY FOR IDENTIFYING REPETITIVE TRANSACTION RECORDS
-- ---------------------------------------------------------------------------------
SELECT
	`index`,
	COUNT(*) AS row_occurrence
FROM t_2026_001_international_sale_report_stagging
GROUP BY `index`
HAVING row_occurrence > 1

SELECT `DATE` 
FROM  t_2026_001_international_sale_report_stagging LIMIT 5

-- DEDUPLICATION & DATE CASTING VIA DISTINCT LAYER
DROP TABLE IF exists t_clean_international_sale_report

-- CREATE PRODUCTION TABLE WITH TRANSFORMED DATA SCHEMA
DROP TABLE IF EXISTS t_clean_international_sale_report

CREATE TABLE t_clean_international_sale_report AS
SELECT DISTINCT
    `index` AS `index_no`,
    STR_TO_DATE(`DATE`, '%m-%d-%y') AS `transaction_date`,
    `Months` AS `month_name`,
    `CUSTOMER` AS `customer_name`,
    `Style` AS `style_code`,
    `SKU` AS `sku_code`,
    `Size` AS `product_size`,
    `PCS` AS `quantity_pcs`,
    `RATE` AS `unit_rate`,
    `GROSS AMT` AS `gross_amount`
FROM t_2026_001_international_sale_report_stagging
WHERE `DATE` REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{2}$'
-- Updated Rows: 18635
	
SELECT *
FROM t_2026_001_may_2022
	
-- Checking the nulls
SELECT
 COUNT(CASE WHEN transaction_date IS NULL THEN 1 END) AS null_dates,
 COUNT(CASE WHEN gross_amount IS NULL THEN 1 END) AS null_amounts,
 COUNT(CASE WHEN sku_code IS NULL THEN 1 END) AS null_skus
FROM t_clean_international_sale_report
	
-- Result: 
-- null_dates: 0
-- null_amounts: 0
-- null_skus: 0

-- =================================================================================
-- SYSTEM MODULE : E-COMMERCE DATA PIPELINE (STAGING LAYER)
-- COMPONENT     : TABLE 5 - MAY 2022 SALES CLEANSING & ALIGNMENT
-- AUTHOR        : Erick Andos Golo
-- UPGRADE DATE  : 2026-07-01
-- DESCRIPTION   : CLEANSING RAW VARCHAR DATA AND MIGRATING TO UNIFORM NUMERIC TYPES
-- ================================================================================
DROP TABLE IF EXISTS t_2026_001_may_2022_raw_all

CREATE TABLE t_2026_001_may_2022_raw_all (
    `index` VARCHAR(255),
    sku VARCHAR(255),
    style_id VARCHAR(255),
    catalog VARCHAR(255),
    category VARCHAR(255),
    weight VARCHAR(255),
    tp VARCHAR(255),
    mrp_old VARCHAR(255),
    final_mrp_old VARCHAR(255),
    ajio_mrp VARCHAR(255),
    amazon_mrp VARCHAR(255),
    amazon_fba_mrp VARCHAR(255),
    flipkart_mrp VARCHAR(255),
    limeroad_mrp VARCHAR(255),
    myntra_mrp VARCHAR(255),
    paytm_mrp VARCHAR(255),
    snapdeal_mrp VARCHAR(255)
)

DROP TABLE IF EXISTS t_2026_001_may_2022_sales_staging

CREATE TABLE t_2026_001_may_2022_sales_staging AS
SELECT 
    -- 1. Index at Keys (Naka-int na ang index mo kaya CAST as signed)
    CAST(NULLIF(TRIM(`index`), '') AS SIGNED) AS `index`,
    TRIM(sku) AS sku,
    TRIM(`Style Id`) AS style_id,
    TRIM(`Catalog`) AS catalog,
    TRIM(category) AS category,
    
    -- 2. Metrics & Measures (May backticks na ang mga may espasyo)
    CAST(CASE WHEN TRIM(weight) REGEXP '^[0-9]+(\.[0-9]+)?$' THEN TRIM(weight) ELSE 0 END AS DECIMAL(10,2)) AS weight,
    CAST(CASE WHEN TRIM(tp) REGEXP '^[0-9]+(\.[0-9]+)?$' THEN TRIM(tp) ELSE 0 END AS DECIMAL(10,2)) AS tp,
    CAST(CASE WHEN TRIM(`MRP Old`) REGEXP '^[0-9]+(\.[0-9]+)?$' THEN TRIM(`MRP Old`) ELSE 0 END AS DECIMAL(10,2)) AS mrp_old,
    CAST(CASE WHEN TRIM(`Final MRP Old`) REGEXP '^[0-9]+(\.[0-9]+)?$' THEN TRIM(`Final MRP Old`) ELSE 0 END AS DECIMAL(10,2)) AS final_mrp_old,
    CAST(CASE WHEN TRIM(`Ajio MRP`) REGEXP '^[0-9]+(\.[0-9]+)?$' THEN TRIM(`Ajio MRP`) ELSE 0 END AS DECIMAL(10,2)) AS ajio_mrp,
    CAST(CASE WHEN TRIM(`Amazon MRP`) REGEXP '^[0-9]+(\.[0-9]+)?$' THEN TRIM(`Amazon MRP`) ELSE 0 END AS DECIMAL(10,2)) AS amazon_mrp,
    CAST(CASE WHEN TRIM(`Amazon FBA MRP`) REGEXP '^[0-9]+(\.[0-9]+)?$' THEN TRIM(`Amazon FBA MRP`) ELSE 0 END AS DECIMAL(10,2)) AS amazon_fba_mrp,
    CAST(CASE WHEN TRIM(`Flipkart MRP`) REGEXP '^[0-9]+(\.[0-9]+)?$' THEN TRIM(`Flipkart MRP`) ELSE 0 END AS DECIMAL(10,2)) AS flipkart_mrp,
    CAST(CASE WHEN TRIM(`Limeroad MRP`) REGEXP '^[0-9]+(\.[0-9]+)?$' THEN TRIM(`Limeroad MRP`) ELSE 0 END AS DECIMAL(10,2)) AS limeroad_mrp,
    CAST(CASE WHEN TRIM(`Myntra MRP`) REGEXP '^[0-9]+(\.[0-9]+)?$' THEN TRIM(`Myntra MRP`) ELSE 0 END AS DECIMAL(10,2)) AS myntra_mrp,
    
    -- Ang huling dalawang pasaway, pinalayas na ang #VALUE! at ginawang NULL kung may dumi
    CAST(CASE WHEN TRIM(`Paytm MRP`) REGEXP '^[0-9]+(\.[0-9]+)?$' THEN TRIM(`Paytm MRP`) ELSE NULL END AS DECIMAL(10,2)) AS paytm_mrp,
    CAST(CASE WHEN TRIM(`Snapdeal MRP`) REGEXP '^[0-9]+(\.[0-9]+)?$' THEN TRIM(`Snapdeal MRP`) ELSE NULL END AS DECIMAL(10,2)) AS snapdeal_mrp

FROM May2022

SELECT style_id, catalog, amazon_fba_mrp, snapdeal_mrp, paytm_mrp 
FROM t_2026_001_may_2022_sales_staging 
LIMIT 8



-- =================================================================================
-- SYSTEM MODULE : E-COMMERCE DATA PIPELINE (STAGING LAYER)
-- COMPONENT     : TABLE 6 - MARCH 2021 P&L CLEANSING & STANDARDIZATION
-- AUTHOR        : Erick Andos Golo
-- UPGRADE DATE  : 2026-07-01
-- DESCRIPTION   : CASTING VARCHAR FIELDS TO PROPER NUMERIC TYPES FOR P&L ANALYSIS
-- =================================================================================
SELECT * 
FROM t_2026_001_pl_march_2021_stagging

SELECT 
	COUNT(*) AS total_rows,
	SUM(CASE WHEN sku IS NULL OR TRIM(sku) = '' THEN 1 ELSE 0 END) AS blank_skus,
	SUM(CASE WHEN revenue IS NULL THEN 1 ELSE 0 END) AS null_revenues
FROM t_2026_001_pl_march_2021_stagging


DESCRIBE t_2026_001_pl_march_2021_stagging

DROP TABLE IF EXISTS t_2026_001_pl_march_2021_cleaned


CREATE TABLE t_2026_001_pl_march_2021_cleaned AS
SELECT 
    -- 1. Identity & Structural Keys
    CAST(NULLIF(TRIM(`index_no`), '') AS SIGNED) AS index_no,
    TRIM(sku) AS sku,
    TRIM(style_id) AS style_id,
    TRIM(catalog) AS catalog,
    TRIM(category) AS category,
    
    -- 2. Physical & Operational Measures
    CAST(CASE WHEN TRIM(weight) REGEXP '^[0-9]+(\.[0-9]+)?$' THEN TRIM(weight) ELSE 0 END AS DECIMAL(10,2)) AS weight,
    CAST(CASE WHEN TRIM(tp_1) REGEXP '^[0-9]+(\.[0-9]+)?$' THEN TRIM(tp_1) ELSE 0 END AS DECIMAL(10,2)) AS tp_1,
    CAST(CASE WHEN TRIM(tp_2) REGEXP '^[0-9]+(\.[0-9]+)?$' THEN TRIM(tp_2) ELSE 0 END AS DECIMAL(10,2)) AS tp_2,
    
    -- 3. Pricing Matrix (Balik sa DECIMAL at gawing NULL ang mga text errors)
    CAST(CASE WHEN TRIM(mrp_old) REGEXP '^[0-9]+(\.[0-9]+)?$' THEN TRIM(mrp_old) ELSE NULL END AS DECIMAL(10,2)) AS mrp_old,
    CAST(CASE WHEN TRIM(final_mrp_old) REGEXP '^[0-9]+(\.[0-9]+)?$' THEN TRIM(final_mrp_old) ELSE NULL END AS DECIMAL(10,2)) AS final_mrp_old,
    CAST(CASE WHEN TRIM(ajio_mrp) REGEXP '^[0-9]+(\.[0-9]+)?$' THEN TRIM(ajio_mrp) ELSE NULL END AS DECIMAL(10,2)) AS ajio_mrp,
    CAST(CASE WHEN TRIM(amazon_mrp) REGEXP '^[0-9]+(\.[0-9]+)?$' THEN TRIM(amazon_mrp) ELSE NULL END AS DECIMAL(10,2)) AS amazon_mrp,
    CAST(CASE WHEN TRIM(amazon_fba_mrp) REGEXP '^[0-9]+(\.[0-9]+)?$' THEN TRIM(amazon_fba_mrp) ELSE NULL END AS DECIMAL(10,2)) AS amazon_fba_mrp,
    CAST(CASE WHEN TRIM(flipkart_mrp) REGEXP '^[0-9]+(\.[0-9]+)?$' THEN TRIM(flipkart_mrp) ELSE NULL END AS DECIMAL(10,2)) AS flipkart_mrp,
    CAST(CASE WHEN TRIM(limeroad_mrp) REGEXP '^[0-9]+(\.[0-9]+)?$' THEN TRIM(limeroad_mrp) ELSE NULL END AS DECIMAL(10,2)) AS limeroad_mrp,
    CAST(CASE WHEN TRIM(myntra_mrp) REGEXP '^[0-9]+(\.[0-9]+)?$' THEN TRIM(myntra_mrp) ELSE NULL END AS DECIMAL(10,2)) AS myntra_mrp,
    CAST(CASE WHEN TRIM(paytm_mrp) REGEXP '^[0-9]+(\.[0-9]+)?$' THEN TRIM(paytm_mrp) ELSE NULL END AS DECIMAL(10,2)) AS paytm_mrp,
    CAST(CASE WHEN TRIM(snapdeal_mrp) REGEXP '^[0-9]+(\.[0-9]+)?$' THEN TRIM(snapdeal_mrp) ELSE NULL END AS DECIMAL(10,2)) AS snapdeal_mrp

FROM t_2026_001_pl_march_2021_stagging

DESCRIBE t_2026_001_pl_march_2021_cleaned

-- Check duplication
SELECT index_no, COUNT(*) AS occurence
FROM t_2026_001_pl_march_2021_cleaned
GROUP BY index_no
HAVING COUNT(*) > 1


-- table 7
DESCRIBE t_2026_001_sale_report_stagging


/* ================================================================================
SECTION: EXPLORATORY DATA ANALYSIS (EDA)
--------------------------------------------------------------------------------
PURPOSE     : DATA INSIGHTS, TREND ANALYSIS, AND BUSINESS INTELLIGENCE
STATUS      : POST-CLEANING PHASE
AUTHOR      : Erick Andos Golo
DATE        : 2026-07-02
================================================================================
*/

USE ecom_pipeline_db
SHOW TABLES


/* SECTION: DATA WAREHOUSE RENAMING TO UNIFORM CLEANED NAMES */

-- 1. Rename Table 1
RENAME TABLE t_clean_amazon_sale_report TO t_2026_001_amazon_sale_cleaned

-- 2. Rename Table 2
RENAME TABLE t_clean_cloud_warehouse_comparison TO t_2026_001_cloud_warehouse_cleaned

-- 3. Rename Table 3
RENAME TABLE t_clean_expense_iigf TO t_2026_001_expense_cleaned

-- 4. Rename Table 4
RENAME TABLE t_clean_international_sale_report TO t_2026_001_international_sale_cleaned

-- 5. Rename Table 5 (May 2022)
RENAME TABLE t_2026_001_may_2022_sales_staging TO t_2026_001_may_2022_sales_cleaned

-- 6. Table 6 is already t_2026_001_pl_march_2021_cleaned (Good!)

-- 7. Rename Table 7 (Sale Report)
RENAME TABLE t_2026_001_sale_report_stagging TO t_2026_001_sale_report_cleaned



-- Exploratory Data Analysis (EDA)
-- sub-section: data volume sanity check


SELECT  COUNT(*) AS total_rows FROM t_2026_001_amazon_sale_cleaned
UNION ALL
SELECT  COUNT(*) FROM t_2026_001_cloud_warehouse_cleaned
UNION ALL
SELECT COUNT(*) FROM t_2026_001_expense_cleaned
UNION ALL 
SELECT  COUNT(*) FROM t_2026_001_international_sale_cleaned
UNION ALL 
SELECT  COUNT(*) FROM t_2026_001_may_2022_sales_cleaned
UNION ALL 
SELECT COUNT(*) FROM t_2026_001_pl_march_2021_cleaned
UNION ALL 
SELECT  COUNT(*) FROM t_2026_001_sale_report_cleaned
-- RESULTS:
-- amazon_sale_table: 128968
-- cloud_warehouse_table: 49
-- expense_table: 16
-- international_sale_table: 18635
-- may_2022_sales_table: 1330
-- pl_march_2021_table: 1330
-- sale_report_table: 9271


-- OBJECTIVE: Get the 'Big 5' Performance Metrics to understand business volume and revenue.
SELECT
	COUNT(order_id) AS total_orders,
	SUM(qty) AS total_units_sold,
	SUM(amount) AS total_revenue,
	SUM(amount) / COUNT(order_id) AS average_order_value
FROM t_2026_001_amazon_sale_cleaned

-- Metric		    	Result				 Interpretation
-- Total Orders			128,968				the volume of transaction
-- Total Units Sold		116,645				The total orders are high than total units sold?
-- Total Revenue		₱78,589,556.30		This is the incone
-- Average Order Value	₱609.37				Average exoenses per each customer


-- Investigate why units sold < total orders.
-- Check for zero or null quantities in the sales table.

SELECT
	COUNT(order_id) AS orders_with_zero_or_null_qty
FROM t_2026_001_amazon_sale_cleaned
WHERE qty <= 0 OR qty IS NULL
-- 12804

-- Identify the status of orders with zero or null quantities.
SELECT
	status,
	COUNT(*) AS count_of_orders
FROM t_2026_001_amazon_sale_cleaned
WHERE qty <= 0 OR qty IS NULL
GROUP BY status
ORDER BY count_of_orders DESC

/*		STATUS							Count_of_orders
 * 1.	Cancelled								  12698
 * 2.   Shipped				   	   				     93
 * 3.   Shipped - Delivered to Buyer				  8
 * 4.	Shipped - Returned to Seller				  3
 * 5.	Pending										  2
 * */

-- Calculate 'Net Revenue' by excluding 'Cancelled' orders.
-- to see the actual income from unsuccessful transactions
SELECT
	COUNT(order_id) AS total_valid_orders,
	SUM(amount) AS net_revenue,
	SUM(amount) / COUNT(order_id) AS net_average_order_value
FROM t_2026_001_amazon_sale_cleaned
WHERE status != 'Cancelled'
-- total_valid_orders: 110639
-- net_revenue: 71670272.00
-- net_average_order_value: 647.784886


/* ======================================================================================
OBJECTIVE: Identify the Top 5 Product Categories driving our Net Revenue.
We filter out 'Cancelled' orders to ensure we only look at successful sales.
=======================================================================================*/
SELECT category, SUM(amount) AS category_revenue
FROM t_2026_001_amazon_sale_cleaned
WHERE status != 'Cancelled'
GROUP BY category
ORDER BY category_revenue DESC
LIMIT 5
/*
CATEGORY		CATEGORY_REVENUE
Set  			35729571.00
kurta			19424850.00
Western Dress	10209590.00
Top				4904066.00
Ethnic Dress	732744.00*/

/* ======================================================================================
OBJECTIVE: Compare Revenue vs. Transaction Volume per Category.
Why Set is popular because of price or volume?
====================================================================================*/
SELECT category, 
		COUNT(order_id) AS total_transactions,
		SUM(amount) AS total_revenue
FROM t_2026_001_amazon_sale_cleaned
WHERE status != 'Cancelled'
GROUP BY category
ORDER BY total_transactions DESC
/*
CATEGORY			TOTAL_TRANSACTIONS		TOTAL_REVENUE
Set					42945					35729571.00
kurta				42620					19424850.00
Western Dress		13378					10209590.00
Top					9346					4904066.00
Ethnic Dress		1014					732744.00
Blouse				810						418389.00
Bottom				380						135453.00
Saree				143						114694.00
Dupatta				3						915.00
 * */

-- Sets are our High-Value products with similar transaction volume as Kurtas, making them our primary revenue driver.

/* ======================================================================================
OBJECTIVE: Trend Analysis - Calculate Total Net Revenue per Month.
PURPOSE: To identify seasonality and understand when we have peak and off-peak sales periods.
====================================================================================*/
SELECT MONTH(sales_date) AS month_number,
	   SUM(amount) AS monthly_revenue
FROM t_2026_001_amazon_sale_cleaned
WHERE status != 'Cancelled'
GROUP BY MONTH(sales_date)
ORDER BY month_number ASC
/*
3 (March)	94,810.00
4 (April)	2,6234,520.00
5 (May)		23,951,575.00
6 (June)	21,389,367.00
 * */

/* ======================================================================================
OBJECTIVE: Geographic Analysis - Total Net Revenue per State.
PURPOSE: To identify which states are our top-performing markets.
==================================================================================== */
SELECT ship_state,
		SUM(amount) AS state_revenue
FROM t_2026_001_amazon_sale_cleaned
WHERE status != 'Cancelled'
GROUP BY ship_state
ORDER BY state_revenue DESC
LIMIT 10
/*
SHIP_STATE				STATE_REVENUE
MAHARASHTRA				12,223,831.00
KARNATAKA				9,649,981.00
TELANGANA				6,290,128.00
UTTAR PRADESH			6,186,123.00
TAMIL NADU				5,953,862.00
DELHI					4,007,579.00
KERALA					3,377,321.00
WEST BENGAL				3,207,213.00
ANDHRA PRADESH			2,882,206.00
HARYANA					2,654,274.00
*/

-- IMPORT DATA FOR TABLEAU Data visualization
USE ecom_pipeline_db

SELECT 
   COUNT(*)
FROM ecom_pipeline_db.t_2026_001_amazon_sale_cleaned
WHERE status != 'Cancelled'