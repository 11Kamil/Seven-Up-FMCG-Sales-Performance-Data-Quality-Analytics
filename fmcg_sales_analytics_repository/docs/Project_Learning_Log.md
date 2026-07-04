# Project Learning Log

This project included several important errors, corrections, and workflow lessons.

## Power Query lessons

- The customer table needed cleaning before it could be used as a reliable dimension.
- Grouping order lines before reconciliation was necessary to compare line totals with order-header totals.
- Decimal precision noise created false reconciliation differences until values were rounded to two decimal places.
- Numeric fields had to be converted properly before grouping and summing.
- A clean Power BI model required a unique customer dimension rather than using duplicate-prone raw CRM data directly.

## Power BI lessons

- Card visuals may show both a visual title and category label, creating duplicated labels.
- Currency formatting should be applied at the measure/column level.
- The naira symbol can be applied through formatting, custom format strings, or model formatting.
- Single-direction relationships are usually safer than bidirectional relationships unless there is a clear reason.
- QA tables should usually remain independent or be used carefully to avoid confusing the core model.

## MySQL Workbench lessons

- MySQL Workbench has multiple execute buttons. Running the full script can rerun destructive commands like DROP TABLE or TRUNCATE TABLE.
- The safest workflow is to highlight the exact statement or block to run, then execute only the selected portion.
- Raw tables should preserve imported values first; type conversion should happen in clean views.
- SQL views are better than manual spreadsheet outputs when logic must be repeated.
- `LOAD DATA LOCAL INFILE` may fail until local infile permissions are configured, so the Table Data Import Wizard is a practical fallback.

## Power BI + MySQL connection lesson

Power BI Desktop required Oracle MySQL Connector/NET before it could connect to the MySQL database. After installation, Power BI connected to `localhost` and loaded the MySQL views.

## Prompt engineering lesson

AI was useful for planning, documentation, debugging, and dashboard design guidance, but generated dashboards still required human review. AI should accelerate the workflow, not replace validation.
