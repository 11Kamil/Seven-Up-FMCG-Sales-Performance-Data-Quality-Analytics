-- Seven-Up Style Sales Data Analyst Project
-- MySQL Workbench 8.0 CE starter script
-- Layer 1: raw tables preserve CSV data as text
-- Layer 2: cleaned analytical views cast dates/numbers and standardize text
-- Layer 3: QA/analysis views reproduce the Power Query checks

CREATE DATABASE IF NOT EXISTS sevenup_sales_project;
USE sevenup_sales_project;

SET sql_mode = REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', '');

-- =========================
-- 1) RAW TABLES
-- =========================

DROP TABLE IF EXISTS raw_crm_customers;
CREATE TABLE raw_crm_customers (
  customer_id VARCHAR(50), crm_account_no VARCHAR(50), sap_customer_code VARCHAR(50), customer_name VARCHAR(255),
  outlet_type VARCHAR(100), channel VARCHAR(100), region VARCHAR(100), state VARCHAR(100), city VARCHAR(100),
  territory VARCHAR(150), route_code VARCHAR(50), sales_rep_id VARCHAR(50), assigned_sales_rep VARCHAR(150),
  distributor_id VARCHAR(50), phone VARCHAR(50), email VARCHAR(255), address VARCHAR(255), gps_lat VARCHAR(50),
  gps_lng VARCHAR(50), account_status VARCHAR(50), customer_grade VARCHAR(50), credit_limit VARCHAR(50),
  payment_terms VARCHAR(50), date_created VARCHAR(50), last_visit_date VARCHAR(50), last_order_date VARCHAR(50),
  cooler_asset_tag VARCHAR(100), tin_no VARCHAR(100)
);

DROP TABLE IF EXISTS raw_crm_sales_rep_route_master;
CREATE TABLE raw_crm_sales_rep_route_master (
  sales_rep_id VARCHAR(50), sales_rep_name VARCHAR(150), region VARCHAR(100), state VARCHAR(100), city VARCHAR(100),
  territory VARCHAR(150), route_code VARCHAR(50), depot VARCHAR(100), area_manager VARCHAR(150), sales_channel VARCHAR(100),
  rep_status VARCHAR(50), hire_date VARCHAR(50)
);

DROP TABLE IF EXISTS raw_sap_product_master;
CREATE TABLE raw_sap_product_master (
  product_code VARCHAR(50), sap_material_no VARCHAR(50), sku_name VARCHAR(255), brand_family VARCHAR(100), category VARCHAR(120),
  pack_size VARCHAR(80), units_per_case VARCHAR(50), returnable_flag VARCHAR(10), product_status VARCHAR(50),
  list_price_case VARCHAR(50), standard_cost_case VARCHAR(50), barcode VARCHAR(50)
);

DROP TABLE IF EXISTS raw_sap_price_list;
CREATE TABLE raw_sap_price_list (
  product_code VARCHAR(50), sku_name VARCHAR(255), valid_from VARCHAR(50), valid_to VARCHAR(50), price_case VARCHAR(50), currency VARCHAR(10)
);

DROP TABLE IF EXISTS raw_sap_sales_orders_header;
CREATE TABLE raw_sap_sales_orders_header (
  order_id VARCHAR(50), order_date VARCHAR(50), customer_id VARCHAR(50), sap_customer_code VARCHAR(50), crm_reference VARCHAR(100),
  sales_org VARCHAR(50), distribution_channel VARCHAR(50), division VARCHAR(50), region VARCHAR(100), territory VARCHAR(150),
  sales_rep_id VARCHAR(50), order_type VARCHAR(100), order_status VARCHAR(50), payment_terms VARCHAR(50), requested_delivery_date VARCHAR(50),
  currency VARCHAR(10), gross_value VARCHAR(50), discount_value VARCHAR(50), net_order_value VARCHAR(50), source_system VARCHAR(100), created_by VARCHAR(100)
);

DROP TABLE IF EXISTS raw_sap_sales_order_lines;
CREATE TABLE raw_sap_sales_order_lines (
  order_id VARCHAR(50), line_no VARCHAR(50), product_code VARCHAR(50), product_name VARCHAR(255), category VARCHAR(120),
  ordered_cases VARCHAR(50), confirmed_cases VARCHAR(50), unit_price_case VARCHAR(50), discount_pct VARCHAR(50),
  gross_line_value VARCHAR(50), discount_line_value VARCHAR(50), line_net_value VARCHAR(50), plant VARCHAR(50),
  storage_location VARCHAR(50), rejection_reason VARCHAR(255)
);

DROP TABLE IF EXISTS raw_sap_delivery_invoice;
CREATE TABLE raw_sap_delivery_invoice (
  order_id VARCHAR(50), delivery_id VARCHAR(50), invoice_id VARCHAR(50), delivery_date VARCHAR(50), invoice_date VARCHAR(50),
  delivery_status VARCHAR(80), invoice_status VARCHAR(80), ordered_cases VARCHAR(50), confirmed_cases VARCHAR(50), delivered_cases VARCHAR(50),
  invoice_value VARCHAR(50), return_cases VARCHAR(50), return_reason VARCHAR(255), proof_of_delivery VARCHAR(50), payment_status VARCHAR(80)
);

DROP TABLE IF EXISTS raw_sap_customer_payments;
CREATE TABLE raw_sap_customer_payments (
  invoice_id VARCHAR(50), order_id VARCHAR(50), customer_id VARCHAR(50), invoice_date VARCHAR(50), due_date VARCHAR(50),
  invoice_value VARCHAR(50), amount_paid VARCHAR(50), outstanding_amount VARCHAR(50), payment_status VARCHAR(80),
  last_payment_date VARCHAR(50), collection_owner VARCHAR(100)
);

DROP TABLE IF EXISTS raw_sales_targets;
CREATE TABLE raw_sales_targets (
  target_month VARCHAR(50), sales_rep_id VARCHAR(50), region VARCHAR(100), state VARCHAR(100), territory VARCHAR(150),
  category VARCHAR(120), target_cases VARCHAR(50), target_value VARCHAR(50)
);

DROP TABLE IF EXISTS raw_data_dictionary;
CREATE TABLE raw_data_dictionary (
  file VARCHAR(255), field VARCHAR(100), description TEXT
);

-- Import the CSV files into these raw tables using MySQL Workbench:
-- Right-click sevenup_sales_project > Table Data Import Wizard > choose CSV > Use existing table > select matching raw_* table.
-- Tick/confirm that the first row contains column names.

-- =========================
-- 2) ROW COUNT CHECKS
-- =========================

SELECT 'raw_crm_customers' AS table_name, COUNT(*) AS row_count FROM raw_crm_customers
UNION ALL SELECT 'raw_crm_sales_rep_route_master', COUNT(*) FROM raw_crm_sales_rep_route_master
UNION ALL SELECT 'raw_sap_product_master', COUNT(*) FROM raw_sap_product_master
UNION ALL SELECT 'raw_sap_price_list', COUNT(*) FROM raw_sap_price_list
UNION ALL SELECT 'raw_sap_sales_orders_header', COUNT(*) FROM raw_sap_sales_orders_header
UNION ALL SELECT 'raw_sap_sales_order_lines', COUNT(*) FROM raw_sap_sales_order_lines
UNION ALL SELECT 'raw_sap_delivery_invoice', COUNT(*) FROM raw_sap_delivery_invoice
UNION ALL SELECT 'raw_sap_customer_payments', COUNT(*) FROM raw_sap_customer_payments
UNION ALL SELECT 'raw_sales_targets', COUNT(*) FROM raw_sales_targets
UNION ALL SELECT 'raw_data_dictionary', COUNT(*) FROM raw_data_dictionary;

-- Expected row counts:
-- customers 640; routes 94; products 62; price list 124; order headers 3400; order lines 9226;
-- delivery/invoice 3400; payments 2762; targets 2820; data dictionary 16.

-- =========================
-- 3) CLEANED VIEWS
-- =========================

CREATE OR REPLACE VIEW dim_customers AS
SELECT
  customer_id, crm_account_no, sap_customer_code, customer_name, outlet_type, channel,
  COALESCE(NULLIF(TRIM(region), ''), 'Unmapped Region') AS region,
  COALESCE(NULLIF(TRIM(state), ''), 'Unmapped State') AS state,
  COALESCE(NULLIF(TRIM(city), ''), 'Unmapped City') AS city,
  territory, route_code, sales_rep_id, assigned_sales_rep, distributor_id, phone, email, address,
  CAST(NULLIF(gps_lat, '') AS DECIMAL(12,6)) AS gps_lat,
  CAST(NULLIF(gps_lng, '') AS DECIMAL(12,6)) AS gps_lng,
  account_status, customer_grade,
  CAST(NULLIF(credit_limit, '') AS DECIMAL(18,2)) AS credit_limit,
  payment_terms,
  STR_TO_DATE(NULLIF(date_created, ''), '%Y-%m-%d') AS date_created,
  STR_TO_DATE(NULLIF(last_visit_date, ''), '%Y-%m-%d') AS last_visit_date,
  STR_TO_DATE(NULLIF(last_order_date, ''), '%Y-%m-%d') AS last_order_date,
  cooler_asset_tag, tin_no
FROM (
  SELECT
    TRIM(customer_id) AS customer_id, TRIM(crm_account_no) AS crm_account_no, TRIM(sap_customer_code) AS sap_customer_code,
    TRIM(customer_name) AS customer_name, TRIM(outlet_type) AS outlet_type, TRIM(channel) AS channel, TRIM(region) AS region,
    TRIM(state) AS state, TRIM(city) AS city, TRIM(territory) AS territory, TRIM(route_code) AS route_code,
    TRIM(sales_rep_id) AS sales_rep_id, TRIM(assigned_sales_rep) AS assigned_sales_rep, TRIM(distributor_id) AS distributor_id,
    TRIM(phone) AS phone, TRIM(email) AS email, TRIM(address) AS address, TRIM(gps_lat) AS gps_lat, TRIM(gps_lng) AS gps_lng,
    TRIM(account_status) AS account_status, TRIM(customer_grade) AS customer_grade, TRIM(credit_limit) AS credit_limit,
    TRIM(payment_terms) AS payment_terms, TRIM(date_created) AS date_created, TRIM(last_visit_date) AS last_visit_date,
    TRIM(last_order_date) AS last_order_date, TRIM(cooler_asset_tag) AS cooler_asset_tag, TRIM(tin_no) AS tin_no,
    ROW_NUMBER() OVER (
      PARTITION BY TRIM(customer_id)
      ORDER BY CASE WHEN UPPER(TRIM(account_status)) = 'ACTIVE' THEN 0 ELSE 1 END,
               STR_TO_DATE(NULLIF(TRIM(last_order_date), ''), '%Y-%m-%d') DESC
    ) AS rn
  FROM raw_crm_customers
  WHERE NULLIF(TRIM(customer_id), '') IS NOT NULL
) x
WHERE rn = 1;

CREATE OR REPLACE VIEW dim_products AS
SELECT
  TRIM(product_code) AS product_code,
  TRIM(sap_material_no) AS sap_material_no,
  TRIM(sku_name) AS sku_name,
  TRIM(brand_family) AS brand_family,
  TRIM(category) AS category,
  TRIM(pack_size) AS pack_size,
  CAST(NULLIF(TRIM(units_per_case), '') AS UNSIGNED) AS units_per_case,
  TRIM(returnable_flag) AS returnable_flag,
  TRIM(product_status) AS product_status,
  CAST(NULLIF(TRIM(list_price_case), '') AS DECIMAL(18,2)) AS list_price_case,
  CAST(NULLIF(TRIM(standard_cost_case), '') AS DECIMAL(18,2)) AS standard_cost_case,
  TRIM(barcode) AS barcode
FROM raw_sap_product_master
WHERE NULLIF(TRIM(product_code), '') IS NOT NULL;

CREATE OR REPLACE VIEW fact_sales_orders_header AS
SELECT
  TRIM(order_id) AS order_id,
  STR_TO_DATE(NULLIF(TRIM(order_date), ''), '%Y-%m-%d') AS order_date,
  TRIM(customer_id) AS customer_id,
  TRIM(sap_customer_code) AS sap_customer_code,
  TRIM(crm_reference) AS crm_reference,
  TRIM(sales_org) AS sales_org,
  TRIM(distribution_channel) AS distribution_channel,
  TRIM(division) AS division,
  COALESCE(NULLIF(TRIM(region), ''), 'Unmapped Region') AS region,
  TRIM(territory) AS territory,
  TRIM(sales_rep_id) AS sales_rep_id,
  TRIM(order_type) AS order_type,
  TRIM(order_status) AS order_status,
  TRIM(payment_terms) AS payment_terms,
  STR_TO_DATE(NULLIF(TRIM(requested_delivery_date), ''), '%Y-%m-%d') AS requested_delivery_date,
  TRIM(currency) AS currency,
  CAST(NULLIF(TRIM(gross_value), '') AS DECIMAL(18,2)) AS gross_value,
  CAST(NULLIF(TRIM(discount_value), '') AS DECIMAL(18,2)) AS discount_value,
  CAST(NULLIF(TRIM(net_order_value), '') AS DECIMAL(18,2)) AS net_order_value,
  TRIM(source_system) AS source_system,
  TRIM(created_by) AS created_by
FROM raw_sap_sales_orders_header
WHERE NULLIF(TRIM(order_id), '') IS NOT NULL;

CREATE OR REPLACE VIEW fact_sales_order_lines AS
SELECT
  TRIM(order_id) AS order_id,
  CAST(NULLIF(TRIM(line_no), '') AS UNSIGNED) AS line_no,
  TRIM(product_code) AS product_code,
  TRIM(product_name) AS product_name,
  TRIM(category) AS category,
  CAST(NULLIF(TRIM(ordered_cases), '') AS DECIMAL(18,2)) AS ordered_cases,
  CAST(NULLIF(TRIM(confirmed_cases), '') AS DECIMAL(18,2)) AS confirmed_cases,
  CAST(NULLIF(TRIM(unit_price_case), '') AS DECIMAL(18,2)) AS unit_price_case,
  CAST(NULLIF(TRIM(discount_pct), '') AS DECIMAL(18,2)) AS discount_pct,
  CAST(NULLIF(TRIM(gross_line_value), '') AS DECIMAL(18,2)) AS gross_line_value,
  CAST(NULLIF(TRIM(discount_line_value), '') AS DECIMAL(18,2)) AS discount_line_value,
  CAST(NULLIF(TRIM(line_net_value), '') AS DECIMAL(18,2)) AS line_net_value,
  TRIM(plant) AS plant,
  TRIM(storage_location) AS storage_location,
  TRIM(rejection_reason) AS rejection_reason
FROM raw_sap_sales_order_lines
WHERE NULLIF(TRIM(order_id), '') IS NOT NULL;

CREATE OR REPLACE VIEW fact_delivery_invoice AS
SELECT
  TRIM(order_id) AS order_id,
  TRIM(delivery_id) AS delivery_id,
  TRIM(invoice_id) AS invoice_id,
  STR_TO_DATE(NULLIF(TRIM(delivery_date), ''), '%Y-%m-%d') AS delivery_date,
  STR_TO_DATE(NULLIF(TRIM(invoice_date), ''), '%Y-%m-%d') AS invoice_date,
  TRIM(delivery_status) AS delivery_status,
  TRIM(invoice_status) AS invoice_status,
  CAST(NULLIF(TRIM(ordered_cases), '') AS DECIMAL(18,2)) AS ordered_cases,
  CAST(NULLIF(TRIM(confirmed_cases), '') AS DECIMAL(18,2)) AS confirmed_cases,
  CAST(NULLIF(TRIM(delivered_cases), '') AS DECIMAL(18,2)) AS delivered_cases,
  CAST(NULLIF(TRIM(invoice_value), '') AS DECIMAL(18,2)) AS invoice_value,
  CAST(NULLIF(TRIM(return_cases), '') AS DECIMAL(18,2)) AS return_cases,
  TRIM(return_reason) AS return_reason,
  TRIM(proof_of_delivery) AS proof_of_delivery,
  TRIM(payment_status) AS payment_status
FROM raw_sap_delivery_invoice
WHERE NULLIF(TRIM(order_id), '') IS NOT NULL;

CREATE OR REPLACE VIEW fact_sales_targets AS
SELECT
  STR_TO_DATE(NULLIF(TRIM(target_month), ''), '%Y-%m-%d') AS target_month,
  TRIM(sales_rep_id) AS sales_rep_id,
  COALESCE(NULLIF(TRIM(region), ''), 'Unmapped Region') AS region,
  TRIM(state) AS state,
  TRIM(territory) AS territory,
  TRIM(category) AS category,
  CAST(NULLIF(TRIM(target_cases), '') AS DECIMAL(18,2)) AS target_cases,
  CAST(NULLIF(TRIM(target_value), '') AS DECIMAL(18,2)) AS target_value
FROM raw_sales_targets;

-- =========================
-- 4) QA / ANALYSIS VIEWS
-- =========================

CREATE OR REPLACE VIEW qa_duplicate_customer_ids AS
SELECT customer_id, COUNT(*) AS customer_id_count
FROM raw_crm_customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

CREATE OR REPLACE VIEW qa_duplicate_customer_names AS
SELECT UPPER(TRIM(customer_name)) AS customer_name_clean, COUNT(*) AS customer_name_count
FROM raw_crm_customers
WHERE NULLIF(TRIM(customer_name), '') IS NOT NULL
GROUP BY UPPER(TRIM(customer_name))
HAVING COUNT(*) > 1;

CREATE OR REPLACE VIEW qa_orders_invalid_customers AS
SELECT h.order_id, h.order_date, h.customer_id, h.sap_customer_code, h.region, h.territory, h.sales_rep_id, h.net_order_value
FROM fact_sales_orders_header h
LEFT JOIN dim_customers c ON h.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

CREATE OR REPLACE VIEW qa_invalid_product_codes AS
SELECT l.order_id, l.line_no, l.product_code, l.product_name, l.ordered_cases, l.line_net_value, l.plant, l.storage_location
FROM fact_sales_order_lines l
LEFT JOIN dim_products p ON l.product_code = p.product_code
WHERE p.product_code IS NULL;

CREATE OR REPLACE VIEW qa_order_line_summary AS
SELECT order_id, ROUND(SUM(line_net_value), 2) AS line_total_value
FROM fact_sales_order_lines
GROUP BY order_id;

CREATE OR REPLACE VIEW qa_order_value_reconciliation AS
SELECT
  h.order_id,
  h.customer_id,
  h.order_date,
  h.region,
  h.territory,
  h.net_order_value AS header_value,
  s.line_total_value,
  ROUND(h.net_order_value - s.line_total_value, 2) AS variance,
  ABS(ROUND(h.net_order_value - s.line_total_value, 2)) AS abs_variance
FROM fact_sales_orders_header h
JOIN qa_order_line_summary s ON h.order_id = s.order_id
WHERE ABS(ROUND(h.net_order_value - s.line_total_value, 2)) > 1
ORDER BY abs_variance DESC;

CREATE OR REPLACE VIEW qa_delivery_invoice_exceptions AS
SELECT
  d.*,
  CASE
    WHEN delivery_status = 'Delivered' AND delivery_date IS NULL THEN 'Delivered but delivery date missing'
    WHEN invoice_status = 'Invoiced' AND (invoice_id IS NULL OR invoice_id = '') THEN 'Invoiced but invoice ID missing'
    WHEN delivered_cases < confirmed_cases THEN 'Partial fulfilment'
    WHEN invoice_status = 'Invoiced' AND (invoice_value IS NULL OR invoice_value = 0) THEN 'Invoiced but invoice value missing/zero'
    ELSE NULL
  END AS exception_reason
FROM fact_delivery_invoice d
WHERE
  (delivery_status = 'Delivered' AND delivery_date IS NULL)
  OR (invoice_status = 'Invoiced' AND (invoice_id IS NULL OR invoice_id = ''))
  OR delivered_cases < confirmed_cases
  OR (invoice_status = 'Invoiced' AND (invoice_value IS NULL OR invoice_value = 0));

CREATE OR REPLACE VIEW customer_order_trend AS
SELECT
  customer_id,
  DATE_FORMAT(order_date, '%Y-%m-01') AS order_month,
  ROUND(SUM(net_order_value), 2) AS monthly_order_value,
  COUNT(DISTINCT order_id) AS monthly_order_count
FROM fact_sales_orders_header
GROUP BY customer_id, DATE_FORMAT(order_date, '%Y-%m-01');

CREATE OR REPLACE VIEW customer_monthly_change AS
SELECT
  customer_id,
  order_month,
  monthly_order_value,
  monthly_order_count,
  LAG(monthly_order_value) OVER (PARTITION BY customer_id ORDER BY order_month) AS previous_month_value,
  ROUND(
    (monthly_order_value - LAG(monthly_order_value) OVER (PARTITION BY customer_id ORDER BY order_month)) /
    NULLIF(LAG(monthly_order_value) OVER (PARTITION BY customer_id ORDER BY order_month), 0) * 100,
    2
  ) AS mom_change_pct
FROM customer_order_trend;

CREATE OR REPLACE VIEW qa_customers_10pct_order_drop AS
SELECT *
FROM customer_monthly_change
WHERE mom_change_pct <= -10
ORDER BY mom_change_pct ASC;

-- =========================
-- 5) MANAGEMENT SUMMARY QUERIES
-- =========================

-- Total sales, cases, orders, active customers, AOV
SELECT
  ROUND(SUM(l.line_net_value), 2) AS total_sales,
  ROUND(SUM(l.ordered_cases), 2) AS total_cases,
  COUNT(DISTINCT h.order_id) AS order_count,
  COUNT(DISTINCT h.customer_id) AS active_customers,
  ROUND(SUM(l.line_net_value) / NULLIF(COUNT(DISTINCT h.order_id), 0), 2) AS average_order_value
FROM fact_sales_orders_header h
JOIN fact_sales_order_lines l ON h.order_id = l.order_id;

-- Sales by month
SELECT DATE_FORMAT(h.order_date, '%Y-%m') AS sales_month, ROUND(SUM(l.line_net_value), 2) AS total_sales
FROM fact_sales_orders_header h
JOIN fact_sales_order_lines l ON h.order_id = l.order_id
GROUP BY DATE_FORMAT(h.order_date, '%Y-%m')
ORDER BY sales_month;

-- Sales by region
SELECT COALESCE(c.region, h.region, 'Unmapped Region') AS region, ROUND(SUM(l.line_net_value), 2) AS total_sales
FROM fact_sales_orders_header h
JOIN fact_sales_order_lines l ON h.order_id = l.order_id
LEFT JOIN dim_customers c ON h.customer_id = c.customer_id
GROUP BY COALESCE(c.region, h.region, 'Unmapped Region')
ORDER BY total_sales DESC;

-- Sales by brand family
SELECT p.brand_family, ROUND(SUM(l.line_net_value), 2) AS total_sales
FROM fact_sales_order_lines l
LEFT JOIN dim_products p ON l.product_code = p.product_code
GROUP BY p.brand_family
ORDER BY total_sales DESC;

-- Top customers
SELECT c.customer_name, c.region, ROUND(SUM(l.line_net_value), 2) AS total_sales, COUNT(DISTINCT h.order_id) AS orders
FROM fact_sales_orders_header h
JOIN fact_sales_order_lines l ON h.order_id = l.order_id
LEFT JOIN dim_customers c ON h.customer_id = c.customer_id
GROUP BY c.customer_name, c.region
ORDER BY total_sales DESC
LIMIT 20;
