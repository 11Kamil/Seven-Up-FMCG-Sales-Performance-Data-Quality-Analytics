# SQL Layer

The SQL layer was built in MySQL Workbench 8.0 CE.

## Main script

Run:

```sql
sql/sevenup_mysql_cleaning_analysis_project.sql
```

## Recommended execution discipline

Do not run the entire script repeatedly after importing data unless you intend to recreate raw tables. Use selected execution for the specific section you need.

Suggested script sections:

```sql
-- 01 Create database
-- 02 Create raw tables
-- 03 Import/load data
-- 04 Create dimension views
-- 05 Create fact views
-- 06 Create QA views
-- 07 Create analysis views
-- 08 Create executive summary
```

## Important views created

- `dim_customers`
- `dim_products`
- `fact_sales_orders_header`
- `fact_sales_order_lines`
- `fact_delivery_invoice`
- `fact_sales_targets`
- `fact_customer_payments`
- `kpi_sales_overview`
- `kpi_delivery_invoice_summary`
- `kpi_customer_payments_summary`
- `analysis_monthly_sales_trend`
- `analysis_sales_by_region`
- `analysis_sales_by_brand_family`
- `analysis_top_customers`
- `analysis_customer_order_trend`
- `analysis_target_vs_actual`
- `analysis_target_vs_actual_by_region`
- `analysis_payment_status_mix`
- `analysis_outstanding_by_customer`
- `qa_orders_invalid_customers`
- `qa_invalid_product_codes`
- `qa_order_value_reconciliation`
- `qa_customers_strict_3month_order_drop`
- `qa_targets_without_actual_sales`
- `qa_actual_sales_without_targets`
- `qa_high_collection_risk_customers`
- `executive_kpi_summary`
