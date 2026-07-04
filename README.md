# FMCG Sales Performance & Data Quality Analytics

> A Seven-Up-style **synthetic** FMCG Sales Data Analyst project covering sales performance, CRM/SAP-style data quality, delivery and invoicing, target-vs-actual performance, customer decline, and payment collection risk.

This project compares two practical analytics workflows:

1. **Excel Power Query + Power BI** for visual cleaning, exploration, and dashboarding.
2. **MySQL Workbench + SQL views + Power BI** for repeatable cleaning, QA checks, KPI logic, and dashboard-ready reporting views.

The project is not affiliated with Seven-Up Bottling Company. It is a synthetic, portfolio-ready dataset designed to simulate a beverage/FMCG sales operations environment.

## Business problem

A regional sales team needs a reliable performance dashboard that answers:

- What are total sales, total cases, order count, active customers, and average order value?
- Which regions, products, and customers drive sales?
- Are CRM customer records aligned with SAP-style order records?
- Are product codes valid against the product master?
- Do sales order header values reconcile with order-line totals?
- What are the delivery, invoice, and fulfilment rates?
- Which customers show a strict 3-month decline in order value?
- Which sales targets have no matching actual sales, and which actual sales have no matching targets?
- What is the payment collection rate and outstanding customer exposure?

## Dataset overview

| File | Rows | Columns |
|---|---:|---:|
| `01_crm_customers.csv` | 640 | 28 |
| `02_crm_sales_rep_route_master.csv` | 94 | 12 |
| `03_sap_product_master.csv` | 62 | 12 |
| `04_sap_price_list.csv` | 124 | 6 |
| `05_sap_sales_orders_header.csv` | 3400 | 21 |
| `06_sap_sales_order_lines.csv` | 9226 | 15 |
| `07_sap_delivery_invoice.csv` | 3400 | 15 |
| `08_sap_customer_payments.csv` | 2762 | 11 |
| `09_sales_targets.csv` | 2820 | 8 |
| `10_data_dictionary.csv` | 16 | 3 |

## Tools used

- **Excel Power Query**: initial cleaning, type conversion, QA checks, and business-user-friendly transformations.
- **MySQL Workbench 8.0 CE**: raw table creation, CSV import, cleaning views, fact/dimension views, QA views, KPI views, and executive summary view.
- **Power BI Desktop**: dashboard design and direct connection to clean MySQL views.
- **AI / Prompt Engineering**: planning support, debugging support, documentation, insight writing, and dashboard-layout ideation.

## Validated headline results

| Metric | Result |
|---|---:|
| Total sales | ₦600,338,502.20 |
| Total cases | 190,925 |
| Order count | 3,400 |
| Active customers | 676 |
| Average order value | ₦176,570.15 |
| Invalid CRM orders | 47 |
| Invalid product-code lines | 66 |
| Order-value exceptions | 75 |
| Strict 3-month declining customers | 104 |
| Targets without actual sales | 1,587 |
| Actual sales without targets | 349 |
| Payment rows | 2,762 |
| Total invoice value | ₦436,925,095.04 |
| Total amount paid | ₦279,417,682.11 |
| Total outstanding amount | ₦157,507,412.93 |
| Collection rate | 64.0% |

The same core outputs were validated across Power Query and SQL, which improved confidence in the analysis logic.

## Dashboard pages

The final dashboard structure contains seven pages:

1. Executive Summary
2. Sales Overview
3. Delivery & Invoice Performance
4. Data Quality Exceptions
5. Customer Order Trend
6. Target vs Actual
7. Payments & Collection Risk

Dashboard image exports are available in [`power_bi/dashboard_images`](power_bi/dashboard_images).

## Repository structure

```text
.
├── data/
│   ├── raw/                         # Synthetic raw CSV files
│   └── dictionary/                  # Data dictionary
├── sql/
│   └── sevenup_mysql_cleaning_analysis_project.sql
├── power_query/
│   └── Power_Query_Workflow.md
├── power_bi/
│   ├── Dashboard_Build_Guide.md
│   └── dashboard_images/
├── docs/
│   ├── Project_Methodology.md
│   ├── Power_Query_vs_SQL_Comparison.md
│   ├── Executive_Insight_Report.md
│   ├── Data_Quality_Checks.md
│   └── Project_Learning_Log.md
├── prompt_engineering/
│   └── AI_Assisted_Workflow.md
├── assets/
│   └── screenshots_to_review/
└── reports/
    └── Portfolio_Project_Summary.md
```

## How to reproduce

### Option 1: Power Query workflow

1. Load the CSV files from `data/raw` into Excel/Power Query.
2. Apply trim/clean transformations, type conversions, duplicate checks, and merge-based QA checks.
3. Export clean outputs to Power BI or load the resulting workbook into Power BI.
4. Build the seven dashboard pages listed above.

See [`power_query/Power_Query_Workflow.md`](power_query/Power_Query_Workflow.md).

### Option 2: SQL workflow

1. Open MySQL Workbench.
2. Run the script in [`sql/sevenup_mysql_cleaning_analysis_project.sql`](sql/sevenup_mysql_cleaning_analysis_project.sql).
3. Import the CSV files into the matching raw tables.
4. Run the SQL view sections to create clean, QA, KPI, and executive summary views.
5. Validate row counts and KPI outputs.
6. Connect Power BI to MySQL and load the clean views.

See [`docs/Project_Methodology.md`](docs/Project_Methodology.md).

## How the analysis can be made faster

- Use **folder-based Power Query import** so monthly CSVs refresh automatically.
- Keep one **master SQL script** with clearly separated sections for raw tables, imports, cleaning views, QA views, KPI views, and executive summary.
- Load only **clean SQL views** into Power BI, not all raw tables.
- Use a validation checklist before dashboarding: row counts, duplicate keys, unmatched joins, invalid codes, reconciliation variances, and KPI totals.
- Use AI/prompt engineering for documentation, SQL-template generation, insight writing, and debugging, while validating all outputs against known checks.

## Portfolio positioning

Suggested LinkedIn/GitHub description:

> Built an end-to-end FMCG sales analytics pipeline using Power Query, MySQL, and Power BI. The project cleaned CRM and SAP-style sales data, reconciled order values, flagged data-quality issues, analyzed sales and delivery performance, measured target-vs-actual gaps, and identified payment collection risk. Core KPIs were validated across Power Query and SQL to improve reporting reliability.


## Evidence Screenshots

Sanitized workflow screenshots are available in `assets/evidence_screenshots/`. They show selected Power Query, Power BI, and MySQL validation steps while avoiding browser tabs, inboxes, local paths, and account details.
