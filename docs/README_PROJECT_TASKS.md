# Seven-Up-Style Sales Data Analyst Practice Pack

Synthetic dataset for interview practice only. It is designed to mirror a beverage FMCG sales environment using CRM-style customer data and SAP-style ERP order, delivery, invoice and payment data. It does not contain real Seven-Up data.

## Your 4-hour sprint

### Hour 1: Import and clean
1. Import all CSV files into Excel Power Query, Power BI, or SQL.
2. Check data types: dates, numbers, customer IDs, product codes and currency fields.
3. Standardize customer names, states, route codes and email/phone formats.
4. Identify missing values, duplicate-like customers, invalid routes and invalid product codes.
5. Validate orders against CRM customers and product master.

### Hour 2: Reconcile and model
1. Build a star schema:
   - Fact: sales order lines
   - Fact: delivery/invoice
   - Fact: targets
   - Dimension: customers
   - Dimension: products
   - Dimension: sales reps/routes
   - Dimension: calendar
2. Reconcile sales order header totals against sales order line totals.
3. Reconcile delivered cases against ordered/confirmed cases.
4. Reconcile invoice value against delivered value.

### Hour 3: Analyse insights
Answer these questions:
1. Which region has the highest net sales and cases sold?
2. Which region has the weakest target achievement?
3. Which product category contributes the highest value and cases?
4. Which sales reps are underperforming against target?
5. Which customers are top contributors by invoice value?
6. Which customers are active in SAP orders but inactive/dormant in CRM?
7. Where are CRM records incomplete or duplicated?
8. Which orders are open, blocked, cancelled, not delivered, or not invoiced?
9. What is the overall order fill rate?
10. What is the return rate and which return reasons dominate?

### Hour 4: Dashboard and interview story
Build a simple Power BI dashboard with:
1. KPI cards: Net Sales, Invoice Value, Cases Sold, Fill Rate, Target Achievement %, Active Customers, Open Orders, Overdue Amount.
2. Trend: monthly net sales and invoice value.
3. Matrix: region > territory > rep, with target vs actual.
4. Bar chart: product category performance.
5. Table: data quality exceptions.
6. Table: process exceptions in SAP order-to-cash.

## DAX measures to revise

Net Sales = SUM('Sales Order Lines'[line_net_value])

Gross Sales = SUM('Sales Order Lines'[gross_line_value])

Total Ordered Cases = SUM('Sales Order Lines'[ordered_cases])

Total Confirmed Cases = SUM('Sales Order Lines'[confirmed_cases])

Fill Rate % = DIVIDE([Total Confirmed Cases], [Total Ordered Cases])

Invoice Value = SUM('Delivery Invoice'[invoice_value])

Delivered Cases = SUM('Delivery Invoice'[delivered_cases])

Return Rate % = DIVIDE(SUM('Delivery Invoice'[return_cases]), [Delivered Cases])

Target Value = SUM('Sales Targets'[target_value])

Target Achievement % = DIVIDE([Net Sales], [Target Value])

Outstanding Amount = SUM('Customer Payments'[outstanding_amount])

MoM Growth % =
DIVIDE(
    [Net Sales] - CALCULATE([Net Sales], DATEADD('Calendar'[Date], -1, MONTH)),
    CALCULATE([Net Sales], DATEADD('Calendar'[Date], -1, MONTH))
)

## SQL practice questions

1. Find SAP orders with customer IDs not found in CRM.
2. Find order lines with product codes not found in product master.
3. Find duplicate-like customers using same phone number or address.
4. Calculate monthly net sales by region.
5. Calculate target achievement by rep and category.
6. Calculate fill rate by region and product category.
7. Find cancelled or blocked orders that still have delivery/invoice records.
8. Find invoices dated before the order date.
9. Find invoice IDs appearing more than once.
10. Find top 20 customers by invoice value and outstanding amount.

## Suggested interview positioning

"I currently use Sage X3 as our ERP at Sundry Foods, so I understand the same ERP logic behind customer master data, sales orders, stock movement, delivery, invoicing and reporting. Even if Seven-Up uses SAP, the business process is familiar: clean master data, correct order entry, accurate fulfilment, proper invoicing and reliable reporting. My strength is combining ERP understanding, Power BI reporting and operations insight."
