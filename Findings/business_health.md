# Business Health — Revenue Analysis

## Revenue overview

This analysis uses **delivered orders only** as the financial population. Order status is normalized with `LOWER(TRIM(status))` because the dataset contains inconsistent capitalization such as `delivered`, `DELIVERED`, and `Delivered`.

The business has **19,979 delivered orders** generating **$150.42M in recorded order revenue**. Monthly revenue is volatile rather than consistently increasing: revenue was **$35.70M in March**, increased sharply to **$66.62M in April**, and then declined to **$38.05M in May**. June recorded **$10.05M**, but June is a partial month and should not be compared directly with the completed months.

## Revenue trajectory and growth

The largest movement occurred between March and April. Delivered orders increased from **4,762 to 8,718**, while revenue increased from **$35.70M to $66.62M**. This represents approximately **83% order growth** and **87% revenue growth**. AOV changed only slightly, from **$7,497.79 to $7,641.43**, indicating that the April revenue increase was primarily associated with higher order volume rather than substantially higher spending per order.

The reverse pattern appears in May. Orders fell to **5,104** and revenue fell to **$38.05M**, while AOV remained broadly stable at **$7,454.47**. This suggests that order volume is the main factor behind the observed month-to-month revenue movement.

## AOV and cart behaviour

Overall delivered-order AOV is **$7,528.82**. The average delivered order contains **2.65 items**, with monthly items per order staying between **2.61 and 2.67**. This stability suggests that changes in cart size are not a major driver of revenue changes.

The order-value distribution is right-skewed: the median delivered order is approximately **$4,597**, compared with the average of **$7,529**, indicating that higher-value orders pull the mean upward.

The dataset's actual AOV is substantially above the assignment's $20–$100 sanity-check range. The analysis therefore retains the actual recorded values rather than changing the calculation to fit the expected range.

## Key takeaway

Revenue changes are primarily **volume-driven**. April was the strongest complete month because substantially more orders were delivered, while AOV and items per order remained broadly stable. May's decline similarly coincided with lower order volume. The next business question is what caused the changes in order volume, such as acquisition, marketing activity, promotions, or other demand drivers.
