SET search_path TO ecom;

-- ============================================================
-- TASK 3: REVENUE & BUSINESS HEALTH
-- Financial population: delivered orders only.
-- Status is normalized because capitalization is inconsistent.
-- ============================================================

-- 1. Overall delivered revenue and order count
SELECT
    COUNT(DISTINCT order_id) AS delivered_orders,
    ROUND(SUM(total)::numeric, 2) AS total_revenue
FROM orders
WHERE LOWER(TRIM(status)) = 'delivered';

-- 2. Monthly revenue, order count and AOV
SELECT
    DATE_TRUNC('month', created_at)::date AS revenue_month,
    COUNT(DISTINCT order_id) AS order_count,
    ROUND(SUM(total)::numeric, 2) AS total_revenue,
    ROUND(SUM(total)::numeric / COUNT(DISTINCT order_id), 2) AS aov
FROM orders
WHERE LOWER(TRIM(status)) = 'delivered'
GROUP BY DATE_TRUNC('month', created_at)
ORDER BY revenue_month;

-- 3. Month-over-month revenue and order growth
-- June is a partial month and should be interpreted cautiously.
WITH monthly AS (
    SELECT
        DATE_TRUNC('month', created_at)::date AS revenue_month,
        COUNT(DISTINCT order_id) AS order_count,
        SUM(total) AS total_revenue
    FROM orders
    WHERE LOWER(TRIM(status)) = 'delivered'
    GROUP BY DATE_TRUNC('month', created_at)
), growth AS (
    SELECT
        revenue_month,
        order_count,
        total_revenue,
        LAG(order_count) OVER (ORDER BY revenue_month) AS previous_order_count,
        LAG(total_revenue) OVER (ORDER BY revenue_month) AS previous_revenue
    FROM monthly
)
SELECT
    revenue_month,
    order_count,
    ROUND(total_revenue::numeric, 2) AS total_revenue,
    ROUND(100.0 * (order_count - previous_order_count)
        / NULLIF(previous_order_count, 0), 2) AS order_growth_pct,
    ROUND(100.0 * (total_revenue - previous_revenue)
        / NULLIF(previous_revenue, 0), 2) AS revenue_growth_pct
FROM growth
ORDER BY revenue_month;

-- 4. Delivered order-value distribution
SELECT
    MIN(total) AS min_order_total,
    MAX(total) AS max_order_total,
    ROUND(AVG(total)::numeric, 2) AS avg_order_total
FROM orders
WHERE LOWER(TRIM(status)) = 'delivered';

SELECT
    ROUND(PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total)::numeric, 2) AS p25,
    ROUND(PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY total)::numeric, 2) AS median,
    ROUND(PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total)::numeric, 2) AS p75,
    ROUND(PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY total)::numeric, 2) AS p90,
    ROUND(PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY total)::numeric, 2) AS p95,
    ROUND(PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY total)::numeric, 2) AS p99
FROM orders
WHERE LOWER(TRIM(status)) = 'delivered';

-- 5. Subtotal vs final order total
SELECT
    ROUND(AVG(subtotal)::numeric, 2) AS avg_subtotal,
    ROUND(AVG(total)::numeric, 2) AS avg_total,
    ROUND(AVG(total - subtotal)::numeric, 2) AS avg_difference
FROM orders
WHERE LOWER(TRIM(status)) = 'delivered';

-- 6. Average items per delivered order
-- Aggregate order_items to one row per order first to avoid
-- duplicating orders.total in the one-to-many join.
SELECT
    ROUND(AVG(item_count)::numeric, 2) AS avg_items_per_order,
    MIN(item_count) AS min_items,
    MAX(item_count) AS max_items
FROM (
    SELECT order_id, SUM(qty) AS item_count
    FROM order_items
    GROUP BY order_id
) item_summary
JOIN orders o USING (order_id)
WHERE LOWER(TRIM(o.status)) = 'delivered';

-- 7. Monthly AOV vs items per order
SELECT
    DATE_TRUNC('month', o.created_at)::date AS revenue_month,
    COUNT(DISTINCT o.order_id) AS order_count,
    SUM(i.total_items) AS items_count,
    ROUND(SUM(o.total)::numeric, 2) AS total_revenue,
    ROUND(SUM(o.total)::numeric / COUNT(DISTINCT o.order_id), 2) AS aov,
    ROUND(SUM(i.total_items)::numeric / COUNT(DISTINCT o.order_id), 2) AS items_per_order
FROM orders o
JOIN (
    SELECT order_id, SUM(qty) AS total_items
    FROM order_items
    GROUP BY order_id
) i ON o.order_id = i.order_id
WHERE LOWER(TRIM(o.status)) = 'delivered'
GROUP BY DATE_TRUNC('month', o.created_at)
ORDER BY revenue_month;

-- 8. Delivered items and average revenue per item
SELECT
    SUM(i.qty) AS total_delivered_items,
    ROUND(SUM(o.total)::numeric / NULLIF(SUM(i.qty), 0), 2) AS avg_revenue_per_item
FROM orders o
JOIN order_items i USING (order_id)
WHERE LOWER(TRIM(o.status)) = 'delivered';

-- 9. Unit-price range for delivered items
SELECT
    MIN(i.unit_price) AS min_unit_price,
    MAX(i.unit_price) AS max_unit_price,
    ROUND(AVG(i.unit_price)::numeric, 2) AS avg_unit_price
FROM orders o
JOIN order_items i USING (order_id)
WHERE LOWER(TRIM(o.status)) = 'delivered';

-- 10. Revenue reconciliation check
-- This should match the overall delivered revenue/order count.
SELECT
    COUNT(DISTINCT order_id) AS delivered_orders,
    ROUND(SUM(total)::numeric, 2) AS delivered_revenue
FROM orders
WHERE LOWER(TRIM(status)) = 'delivered';
