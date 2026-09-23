# Executive Summary

## Ecommerce Sales & Customer Analytics

This project analyzes ecommerce sales and customer behavior using PostgreSQL to answer three business questions: How is revenue performing? What is driving order value and revenue changes? And which customer segments contribute the most value? The analysis uses delivered orders and covers 10,000 customers and 40,000 orders in the available dataset.

### Key Takeaways

1. Revenue changes were primarily driven by order volume rather than average order value.
   Delivered revenue increased from $35.70M in March to $66.62M in April, an 86.58% increase, before falling to $38.05M in May. During the same period, AOV remained relatively stable at approximately $7.45K–$7.64K, indicating that changes in order volume had a larger effect on monthly revenue than changes in basket value. March and June are partial months, so they are not directly comparable with full months.

2. Revenue is highly concentrated among returning customers.
   Repeat and VIP customers represent 30.18% of the customer base but generate 84.61% of delivered revenue. VIP customers alone account for just 11.25% of customers but contribute 56.85% of revenue, making customer retention and loyalty important considerations for future marketing activity.

3. Customer lifetime value increases substantially with repeat purchasing.
   One-Time Buyers have an average lifetime spend of $7,630.70, compared with $22,059.42 for Repeat Buyers and $76,007.30 for VIP Buyers. Repeat Buyers spend 2.89× as much as One-Time Buyers on average, while VIP Buyers spend 9.96× as much.

## Business Recommendation

The analysis suggests a two-part customer strategy: protect existing high-value customers while developing the next tier of valuable customers. VIP customers warrant retention-focused initiatives because of their disproportionate contribution to revenue. Repeat Buyers represent an opportunity to increase customer lifetime value by encouraging continued purchasing and movement toward the VIP segment. One-Time Buyers remain a sizeable reactivation pool, although their current revenue contribution is substantially lower.

## What I'd Analyze Next

The current segmentation is based on delivered order count and lifetime spend. A next phase could incorporate purchase recency, time between orders, product/category preferences, acquisition source, and customer profitability. This would help distinguish customers who make purchases frequently from those who return only after long gaps, and would allow marketing investment to be evaluated using both customer value and behavior.
