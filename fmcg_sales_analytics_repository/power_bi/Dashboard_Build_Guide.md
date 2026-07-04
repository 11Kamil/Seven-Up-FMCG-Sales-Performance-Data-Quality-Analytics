# Power BI Dashboard Build Guide

## Recommended data source

Connect Power BI directly to MySQL and load only the clean analysis views, not all raw tables.

If the MySQL connector is missing, install Oracle MySQL Connector/NET, close Power BI, reopen it, then connect again.

Connection details used during the project:

```text
Server: localhost or localhost:3306
Database: sevenup_sales_project
Authentication: Database
Username: root
Mode: Import
```

## Recommended pages

1. Executive Summary
2. Sales Overview
3. Delivery & Invoice Performance
4. Data Quality Exceptions
5. Customer Order Trend
6. Target vs Actual
7. Payments & Collection Risk

## Views to load

- `executive_kpi_summary`
- `kpi_sales_overview`
- `analysis_monthly_sales_trend`
- `analysis_sales_by_region`
- `analysis_sales_by_brand_family`
- `analysis_top_customers`
- `kpi_delivery_invoice_summary`
- `analysis_delivery_status_mix`
- `analysis_invoice_status_mix`
- `qa_orders_invalid_customers`
- `qa_invalid_product_codes`
- `qa_order_value_reconciliation`
- `analysis_customer_order_trend`
- `qa_customers_strict_3month_order_drop`
- `analysis_target_vs_actual_by_region`
- `qa_underperforming_sales_targets`
- `kpi_customer_payments_summary`
- `analysis_payment_status_mix`
- `qa_high_collection_risk_customers`

## Visual design guidance

- Use a clean 16:9 canvas.
- Use KPI cards at the top of each page.
- Use horizontal bar charts when category labels are long.
- Use tables only for exception details and top-N outputs.
- Avoid loading raw tables into visuals unless needed for debugging.
- Format naira values consistently.
- Keep page titles business-friendly and avoid raw field names.

## Dashboard exports

Static dashboard image examples are stored in `power_bi/dashboard_images`.
