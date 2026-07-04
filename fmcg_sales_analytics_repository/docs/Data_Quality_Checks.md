# Data Quality Checks

## 1. Row-count validation

After importing raw CSV files, row counts were checked to confirm that no records were missed during ingestion.

## 2. Duplicate customer checks

Customer records were checked for duplicate IDs and duplicate customer names. A clean customer dimension was created to prevent double-counting in Power BI.

## 3. Invalid CRM orders

Sales order headers were matched against the customer dimension. Orders with customer IDs missing from CRM were flagged as invalid CRM orders.

Result: **47 invalid CRM orders**.

## 4. Invalid product-code lines

Sales order lines were matched against the product master. Lines with missing product codes in the product master were flagged.

Result: **66 invalid product-code lines**.

## 5. Order-value reconciliation

Order-line net values were summed by order ID and compared against header-level net order value. Differences were rounded to two decimal places to remove floating-point noise.

Result: **75 order-value exceptions**.

## 6. Delivery and invoice exceptions

Delivery records were analyzed for not-delivered, partially delivered, and delivered-but-not-invoiced records.

## 7. Target matching checks

Target records were joined to actual sales at month, sales rep, region, territory, and category grain. Two QA views were created:

- Targets without actual sales: **1,587**
- Actual sales without targets: **349**

## 8. Payment-status cleaning

Blank payment statuses were relabeled as **Unknown Payment Status** to avoid silent blank categories in reports.

## 9. Collection risk

Customers with outstanding and overdue balances were classified by collection-risk level.
