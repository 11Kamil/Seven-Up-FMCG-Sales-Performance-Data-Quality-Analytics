# Executive Insight Report

## Sales performance

The dataset produced total sales of **₦600.34M** across **3,400 orders**, **190,925 cases**, and **676 active customers**. Average order value was **₦176,570.15**. This provides a strong base for regional, product, and customer-level performance analysis.

## Regional and product contribution

Sales were further analyzed by region and brand family to identify major revenue contributors. This allows the sales team to focus on high-performing regions while investigating underperforming markets.

## Data-quality risk

Three major data-quality issues were identified:

- **47 invalid CRM orders** where SAP-style sales orders contained customer IDs missing from CRM.
- **66 invalid product-code lines** where order-line product codes were missing from the product master.
- **75 order-value exceptions** where header-level order value did not reconcile with line-level totals.

These issues can distort customer counts, territory performance, product contribution, and revenue reporting if not corrected.

## Delivery and invoicing

Delivery and invoice data was analyzed to calculate delivery rate, invoice rate, fulfilment rate, and operational exceptions. Delivery and invoice gaps require follow-up because they affect revenue recognition, customer satisfaction, and sales team performance measurement.

## Customer decline risk

A strict 3-month decline analysis identified **104 customers** with at least a 10% drop in order value across the latest three-month window. These customers should be reviewed by sales reps for possible stock availability, pricing, competitor activity, complaint, delivery, or credit-term issues.

## Target-vs-actual risk

The target-vs-actual model revealed:

- **1,587 targets without actual sales**
- **349 actual sales combinations without matching targets**

This means target achievement reports must be interpreted carefully. Some apparent underperformance may come from mismatched month, sales rep, territory, category, or region mappings.

## Payment and collection risk

Payment analysis showed:

- Total invoice value: **₦436.93M**
- Total amount paid: **₦279.42M**
- Outstanding amount: **₦157.51M**
- Collection rate: **64.0%**

The project also found **89 records with unknown payment status**, which were relabeled to avoid blank reporting categories.

## Recommendations

1. Clean CRM customer master data and prevent unmapped customer IDs from entering sales orders.
2. Enforce product-code validation before order-line reporting.
3. Investigate all order-value exceptions above materiality thresholds.
4. Review not-delivered and partially delivered orders weekly.
5. Assign sales-rep follow-up to customers with strict 3-month decline.
6. Reconcile target setup with actual sales grain before using target achievement for performance evaluation.
7. Prioritize collection follow-up on high outstanding balances and overdue accounts.
