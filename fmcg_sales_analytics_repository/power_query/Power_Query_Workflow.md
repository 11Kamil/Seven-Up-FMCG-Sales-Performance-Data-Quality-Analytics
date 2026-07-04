# Power Query Workflow

## Objective

Use Excel Power Query to clean and validate raw CRM and SAP-style sales data before loading outputs into Power BI.

## Steps performed

1. Loaded all raw CSV files into one Excel workbook.
2. Created `Clean_CRM_Customers`.
3. Applied Trim and Clean transformations to text columns.
4. Checked duplicate customer names and duplicate customer records.
5. Created duplicate-customer detail tables for review.
6. Created `QA_Orders_Invalid_Customers` by matching sales orders to CRM customers.
7. Grouped sales order lines by `order_id` to create order-line totals.
8. Merged order-line totals back to sales order headers.
9. Created `value_variance` to compare header value against line total.
10. Rounded variance to two decimal places to avoid floating-point noise.
11. Filtered non-zero variance records to isolate true order-value exceptions.
12. Created `QA_Invalid_Product_Codes` by matching sales order lines to the product master.
13. Created `Customer_Order_Trend` by grouping monthly order value and order count by customer and month.
14. Loaded clean and QA outputs into Power BI.

## Key Power Query outputs

| Output | Purpose |
|---|---|
| `Clean_CRM_Customers` | Cleaned customer data |
| `Dim_Customers` | Unique customer dimension for Power BI relationships |
| `QA_Orders_Invalid_Customers` | SAP orders with customer IDs missing from CRM |
| `QA_Order_Value_Reconciliation` | Header-vs-line value exceptions |
| `QA_Invalid_Product_Codes` | Order lines with product codes missing from product master |
| `Customer_Order_Trend` | Customer monthly order value and order count |

## Lessons

Power Query was effective for fast inspection and transformation, but SQL was more suitable for repeatable validation logic and production-style reporting.
