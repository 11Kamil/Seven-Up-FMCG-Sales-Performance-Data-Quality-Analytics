# Validation Checklist

Use this as a self-check after cleaning. Do not start by reading it as an answer sheet; use it after attempting the project.

## CRM checks
- Missing phone numbers
- Invalid email formats
- Duplicate or duplicate-like customers
- Invalid route codes
- State naming inconsistencies
- Customers assigned to wrong or unknown routes
- Inactive/dormant customers with current-period sales

## SAP order checks
- Orders with customer IDs not found in CRM
- Orders missing CRM reference
- Header net order value not equal to sum of line net values
- Order lines with invalid product codes
- Zero ordered cases
- Discount percentages above normal range
- Confirmed cases less than ordered cases

## Delivery and invoice checks
- Delivery before order date
- Invoice before order date or delivery date
- Delivered cases greater than ordered cases
- Cancelled/blocked orders with delivery or invoice records
- Duplicate invoice IDs
- Delivered orders not invoiced
- Returns and return reasons
- Outstanding/overdue customer balances

## Insight checks
- Region, territory, rep and category performance
- Actual vs target performance
- Product mix by value and cases
- Fill rate and delivery efficiency
- CRM completeness score
- Order-to-cash exception rate
