# Ecommerce Sales & Customer Analytics with SQL

PostgreSQL | SQL | Data Analysis | Customer Segmentation

## Project Overview

This project analyzes an ecommerce dataset to understand revenue performance, order behavior, and customer value. The analysis was built using PostgreSQL, with SQL developed and tested in VS Code using SQLTools.

The project translates three business questions into data-driven findings: How is the business performing? What is driving revenue changes? And which customers contribute the most value? The analysis focuses on delivered orders and covers 10,000 customers and 40,000 orders in the available dataset.

The goal is not just to produce SQL queries, but to turn raw transactional data into findings that can support business and marketing decisions.

---

## Key Business Insights

### 1. Revenue changes were primarily volume-driven

Delivered revenue increased from $35.70M in March to $66.62M in April, an 86.58% increase, before declining to $38.05M in May.

Average Order Value remained relatively stable at approximately $7.45K–$7.64K across March–May. This indicates that changes in order volume had a larger impact on monthly revenue than changes in average basket value.

> Note: March and June are partial months and should not be directly compared with full months.

### 2. Returning customers generate most of the revenue

Repeat and VIP customers represent only 30.18% of the customer base but contribute 84.61% of delivered revenue.

VIP customers alone represent 11.25% of customers but generate 56.85% of delivered revenue.

This concentration makes customer retention and continued engagement important areas for marketing consideration.

### 3. Customer value increases sharply with repeat purchasing

| Customer Segment | % of Customers | % of Revenue | Avg. Lifetime Spend |
| ---------------- | -------------: | -----------: | ------------------: |
| One-Time Buyer   |         30.34% |       15.39% |           $7,630.70 |
| Repeat Buyer     |         18.93% |       27.76% |          $22,059.42 |
| VIP Buyer        |         11.25% |       56.85% |          $76,007.30 |

Repeat Buyers have 2.89× the average lifetime spend of One-Time Buyers, while VIP Buyers have 9.96× the average lifetime spend.

---

## Business Questions

### Revenue & Business Health

* What is the delivered revenue trajectory?
* How does Average Order Value change over time?
* Are revenue changes driven by order volume or order value?

Finding: Revenue fluctuates substantially by month while AOV remains relatively stable, suggesting that order volume is the primary driver of the observed monthly revenue changes.

[Read the detailed business health analysis](findings/business_health.md)

### Customer Segmentation

* What proportion of customers purchase once versus repeatedly?
* How much revenue does each customer segment contribute?
* Which customer segment has the highest lifetime value?

Finding: A relatively small group of Repeat and VIP customers contributes the majority of delivered revenue.

[Read the detailed customer segmentation analysis](findings/03_customer_segments.md)

---

## Customer Segmentation Framework

Customers were segmented using the number of delivered orders during the analysis period:

| Segment        | Definition           |
| -------------- | -------------------- |
| No-orders      | 0 delivered orders   |
| One-Time Buyer | 1 delivered order    |
| Repeat Buyer   | 2–4 delivered orders |
| VIP Buyer      | 5+ delivered orders  |

This provides a simple, reproducible segmentation framework for understanding differences in customer value.

---

## Analytical Approach

The analysis followed a business-question-first workflow:

1. Explore the data

   * Understand available tables and relationships.
   * Check customer, order, and order-item coverage.
   * Validate dates, statuses, and basic data quality.

2. Analyze revenue

   * Standardize order status values.
   * Focus revenue analysis on delivered orders.
   * Calculate monthly revenue, order volume, and AOV.
   * Compare changes across months.

3. Analyze customer value

   * Aggregate delivered orders at customer level.
   * Calculate order count and lifetime spend.
   * Segment customers based on delivered order frequency.
   * Compare customer and revenue contribution across segments.

4. Validate results

   * Reconcile customer-level revenue with the overall delivered revenue.
   * Check for delivered orders without matching customers.
   * Validate segment percentages and revenue totals.

---

## Repository Structure

```text
Ecommerce_Sales_Analysis/
│
├── SQL/
│   ├── 01_exploration.sql
│   ├── 02_revenue.sql
│   └── 03_customers.sql
│
├── Findings/
│   ├── executive_summary.md
│   ├── business_health.md
│   └── customer_segments.md
│
└── README.md
```

### SQL

Contains the analytical SQL scripts used to explore the database and answer the business questions.

### Findings

Contains the business-facing interpretation of the SQL analysis, including quantified findings and recommendations.

---

## How to Reproduce

### Requirements

* PostgreSQL
* VS Code
* SQLTools extension for VS Code
* Access to the project PostgreSQL database

### Steps

1. Connect to the PostgreSQL database using SQLTools.
2. Open the project in VS Code.
3. Run the SQL scripts from the `SQL/` directory.
4. Each SQL file begins with:

```sql
SET search_path TO ecom;
```

5. Review the corresponding findings in the `Findings/` directory.

The SQL scripts are designed to run independently rather than requiring temporary tables or undocumented intermediate steps.

---

## Data & Methodology Notes

Revenue analysis uses delivered orders only, identified using:

```sql
LOWER(TRIM(status)) = 'delivered'
```

This handles inconsistent capitalization and whitespace in the order-status field.

For customer analysis, customers with no delivered orders are retained using a `LEFT JOIN`. Their lifetime spend is represented as zero using `COALESCE()`.

The reported revenue uses the recorded `orders.total` for delivered orders. This value includes the order-level adjustments represented in the source data.

March and June contain partial-period data, so monthly comparisons should account for the different observation periods.

---

## What I'd Analyze Next

The current analysis establishes revenue trends and customer value, but several questions could be explored in a next phase:

* Purchase recency: How recently did customers last purchase?
* Purchase frequency: How much time passes between repeat purchases?
* Customer profitability: Which segments generate the most margin rather than revenue?
* Product behavior: Which categories or products are associated with repeat purchasing?
* Acquisition: Which marketing channels bring customers with higher lifetime value?
* Retention: What percentage of first-time customers return within a defined period?

Adding these dimensions would move the analysis from descriptive segmentation toward customer lifecycle and marketing effectiveness analysis.

---

## Portfolio Takeaway

This project demonstrates an end-to-end SQL analytics workflow: translating business questions into analytical queries, validating the underlying data, calculating meaningful metrics, and communicating the results in business terms.

The key lesson from the analysis is that revenue is not evenly distributed across customers. Understanding where customer value is concentrated provides a stronger basis for retention, reactivation, and customer-growth decisions than looking at revenue totals alone.
