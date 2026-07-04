# AI-Assisted Workflow and Prompt Engineering Notes

AI was used as a productivity and reasoning assistant during the project. It supported:

- Project framing and business-question definition.
- SQL logic planning.
- Debugging MySQL and Power BI issues.
- Explaining tool differences between Power Query, SQL, Python, and Power BI.
- Drafting dashboard page structures.
- Writing executive insight narratives.
- Creating repository documentation.

## Responsible AI use

The project did not rely on AI outputs blindly. Key metrics were validated across Power Query and SQL before being presented as final results.

## Suggested prompt template

```text
Act as a senior sales data analyst. I am working with CRM and SAP-style FMCG sales data. Help me design a reliable analytics workflow that includes data cleaning, data-quality checks, KPI calculations, target-vs-actual analysis, customer decline analysis, delivery/invoice analysis, payment collection risk, and Power BI dashboard recommendations. Do not assume the data is clean. Include validation steps and explain how each output should be checked.
```

## AI limitation discovered

AI-generated dashboard images in Colab required strong layout instructions and still needed human review. For this project, the stronger portfolio angle is the Power Query vs SQL validation pipeline, with AI documented as an acceleration and support tool.
