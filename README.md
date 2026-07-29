# Loan Portfolio Performance & Risk Analysis

## Overview

This project analyzes over 2.6 million Lending Club loan records to evaluate portfolio performance, identify credit risk factors, assess pricing strategy effectiveness, and examine rejected loan applications.

The analysis was completed using **Google BigQuery**, **SQL**, and **Tableau**, with GitHub as the documentation and version control platform.

The goal is to demonstrate an end-to-end analytics workflow, from raw data cleaning through dashboard development, while providing actionable business recommendations that could support lending decisions.

---
## Interactive Dashboard

Explore the interactive Tableau dashboard here:

https://public.tableau.com/app/profile/alexander.kayser/viz/LendingClubPortfolioandRiskAnalysis/PortfolioOverview#1

---
## Business Problem

Financial institutions must balance profitability with risk when issuing loans.

This project explores questions such as:

- Which loan grades generate the highest profit?
- Which borrower characteristics contribute most to default?
- Are interest rates appropriately aligned with portfolio risk?
- What patterns exist among rejected loan applications?
- How can portfolio performance be improved while controlling credit risk?

---

## Project Objectives

- Clean and validate Lending Club loan data using SQL
- Create analysis-ready summary tables using SQL
- Design executive-level Tableau dashboards
- Identify key drivers of profitability and default
- Develop business recommendations supported by data

---

## Dataset

This project analyzes Lending Club's accepted and rejected loan datasets, containing millions of consumer loan applications and funded loans across multiple years. The data was imported into Google BigQuery, where it was cleaned, validated, and transformed into analysis-ready summary tables using SQL before being visualized in Tableau.

The raw datasets are not included in this repository due to their size. However, they can be downloaded from Kaggle using the link below.

**Dataset Source:** https://www.kaggle.com/datasets/wordsforthewise/lending-club

These datasets were not joined since they did not have a key that supported a full join. Instead, they are analyzed independently using common fields such as:

- Loan Amount
- Debt-to-Income Ratio (DTI)
- Employment Length
- Loan Purpose

---

## Tools Used

| Tool | Purpose |
|------|---------|
| Google BigQuery | Data storage and SQL analysis |
| SQL | Data cleaning, feature engineering, aggregation |
| Tableau Public | Dashboard development |
| GitHub | Documentation and version control |

---

# Dashboard Structure

## 1. Executive Portfolio Overview

Provides a high-level summary of the portfolio including:

- Total Loans Issued
- Total Funded Amount
- Total Payment Received
- Lending Growth Over Time
- Loan Purpose Distribution
- Geographic Distribution

![Executive Dashboard](images/executive_dashboard.png)
---

## 2. Risk Analysis

Evaluates factors associated with loan defaults.

Key analyses include:

- Overall Default Rate
- Total Portfolio Loss
- Default Rate by Loan Grade
- Default Rate by DTI
- Default Rate by Loan Amount
- Default Rate by Loan Purpose

![Risk Dashboard](images/risk_dashboard.png)
---

## 3. Risk Based Pricing Performance

Examines whether loan pricing appropriately reflects portfolio risk.

Includes:

- Total Net Profit
- Average Profit by Loan Size (Fully Paid Only)
- Average Interest Rate by Grade/Term
- Net Profit by Grade/Term
- Net Profit vs Interest Rate

![Pricing Dashboard](images/pricing_dashboard.png)
---

## 4. Rejected Applications

Analyzes characteristics of rejected loan requests.

Includes:

- Rejection Volume
- Average Requested Loan Amount
- Employment Length Distribution
- DTI Distribution
- Loan Purpose Distribution

![Rejections Dashboard](images/rejections_dashboard.png)
---

# SQL Workflow

The project followed a structured SQL workflow:

1. Data Import
2. Data Cleaning
3. Data Validation
4. Feature Engineering
5. Summary Table Creation

Example feature engineering included:

- Income Bands
- DTI Bands
- Loan Size Groups
- Issue Year
- Net Profit Calculations
- Portfolio Loss Metrics

---

# Repository Structure

```
Loan-Portfolio-Performance-Risk-Analysis/
│
├── README.md
├── business_questions.md
├── sql/
│ ├── Cleaning/
│ ├── Feature_Engineering/
│ └── Analysis/
|
├── images/
  ├── Executive_Dashboard.png
  ├── Risk_Dashboard.png
  ├── Pricing_Dashboard.png
  └── Rejections_Dashboard.png
```

---

# Key Findings

- Grades **A–C** generated the majority of portfolio profit, while **Grades E–G** produced net losses despite charging substantially higher average interest rates.
- Loan grade exhibited the strongest relationship with loan performance among all borrower characteristics analyzed, making it the single most influential predictor of default risk.
- Default rates increased consistently as borrower credit quality declined, demonstrating that higher interest rates did not fully compensate for the elevated credit risk associated with lower credit grades.
- Borrowers with high debt-to-income (DTI) ratios experienced noticeably higher default rates, reinforcing DTI as a meaningful predictor of loan performance.

---

# Business Recommendations

Based on the analysis:

- Continue prioritizing lending within **Grades A–C**, as these segments generated the majority of portfolio profit while maintaining comparatively low default rates.
- Reevaluate underwriting standards and pricing strategies for **Grades E–G**, where substantially higher interest rates were incapable of offsetting higher credit losses.
- Incorporate loan grade as the primary driver of risk assessment while using borrower debt-to-income (DTI) as a complementary underwriting metric to improve credit decision-making.
- Continuously monitor portfolio performance by credit grade and DTI to identify shifts in borrower risk and adjust pricing or approval criteria.

---

# Skills Demonstrated

- SQL
- Google BigQuery
- Data Cleaning
- Data Validation
- Feature Engineering
- Exploratory Data Analysis (EDA)
- Financial Analytics
- Credit Risk Analysis
- Portfolio Performance Analysis
- Data Visualization
- Tableau
- Dashboard Design
- Business Intelligence
- Git
- GitHub

---

# Project Architecture

```
Raw Lending Club Data
│
▼
Data Cleaning (SQL)
│
▼
Feature Engineering
│
▼
Summary Tables
│
▼
Tableau Dashboards
│
▼
Business Insights & Recommendations
```

---

# Author

**Alexander Kayser**

Aspiring Data Analyst with experience in lending operations, portfolio analysis, and business intelligence.

- GitHub: https://github.com/xkayser1997
- LinkedIn: https://linkedin.com/in/alexander-kayser-82a51b420/

