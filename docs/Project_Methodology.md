# Project Methodology

## 1. Project objective

The objective was to build a portfolio-ready FMCG sales analytics project that simulates a beverage company sales environment. The project needed to go beyond dashboard visuals by proving data reliability through cleaning, reconciliation, validation, and repeatable reporting logic.

## 2. Data sources

The raw dataset contains CRM-style customer records, sales rep/route master data, SAP-style product master, price list, sales order headers, sales order lines, delivery/invoice records, customer payment records, sales targets, and a data dictionary.

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

## 3. Power Query workflow

Power Query was used first because it is fast for visual cleaning and exploratory checks. The process included:

- Importing all CSVs into Excel/Power Query.
- Applying Trim and Clean transformations to text columns.
- Checking duplicate customer names and duplicate customer identifiers.
- Creating a clean customer dimension.
- Validating sales order customer IDs against the CRM customer table.
- Grouping order lines by order ID to compare line totals against order-header totals.
- Fixing decimal precision noise by rounding value variance to two decimal places.
- Creating a customer monthly trend table.
- Loading cleaned tables and QA tables into Power BI.

Important discoveries in Power Query included invalid CRM orders, invalid product-code lines, and order-value exceptions.

## 4. SQL workflow

The SQL workflow recreated and extended the Power Query analysis using MySQL Workbench 8.0 CE.

The SQL approach used a layered model:

1. **Raw tables**: preserved imported CSV values mostly as text.
2. **Clean views**: trimmed text, cast date fields, cast numeric values, and standardized blanks.
3. **Dimension/fact views**: created customer, product, sales order, delivery, target, and payment views.
4. **QA views**: flagged duplicate customer names, invalid CRM orders, invalid product codes, order-value exceptions, delivery/invoice exceptions, target matching issues, and payment-status issues.
5. **KPI views**: calculated sales, delivery, target, and payment KPIs.
6. **Executive summary view**: combined major KPIs and QA findings into one management table.

## 5. Key SQL outputs

| Area | Output |
|---|---:|
| Total sales | ₦600,338,502.20 |
| Total cases | 190,925 |
| Orders | 3,400 |
| Active customers | 676 |
| Average order value | ₦176,570.15 |
| Invalid CRM orders | 47 |
| Invalid product-code lines | 66 |
| Order-value exceptions | 75 |
| Strict 3-month declining customers | 104 |
| Targets without actual sales | 1,587 |
| Actual sales without targets | 349 |
| Collection rate | 64.0% |
| Outstanding amount | ₦157,507,412.93 |

## 6. Power BI workflow

Power BI was connected to the MySQL database after installing MySQL Connector/NET. The report was designed to load clean SQL views rather than raw data tables.

The dashboard was structured into seven pages:

1. Executive Summary
2. Sales Overview
3. Delivery & Invoice Performance
4. Data Quality Exceptions
5. Customer Order Trend
6. Target vs Actual
7. Payments & Collection Risk

## 7. Validation approach

The project used cross-tool validation. Core KPIs from Power Query were compared with SQL outputs. Matching results increased confidence that transformations, joins, and aggregations were correct.

Key validation checks included:

- Raw row-count confirmation after import.
- CRM customer ID validation.
- Product-code validation against product master.
- Header-level vs line-level sales reconciliation.
- Delivery and invoice status checks.
- Target-vs-actual join-grain checks.
- Payment status cleaning and collection-risk checks.

## 8. Important learning moments

- A clean customer dimension was needed because raw CRM data contained duplicate records.
- SQL execution discipline matters: selected statements should be run carefully to avoid rerunning destructive commands.
- Target-vs-actual analysis can be misleading if the actual sales grain does not match the target grain.
- Payment analysis revealed unknown payment-status records that required labeling before reporting.
- Power BI should consume clean analytical views, not all raw tables.
