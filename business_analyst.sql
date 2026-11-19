1.Analisis Kebocoran Profit per Sub-Kategori (Profit Leakage)
SELECT 
    category,
    sub_category,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin_pct,
    ROUND(AVG(discount) * 100, 2) AS avg_discount_pct,
    SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) AS loss_transactions
FROM superstore_cleaned
GROUP BY category, sub_category
ORDER BY total_profit ASC;

2.Evaluasi Dampak Wilayah (Regional & State Profitability)
WITH state_performance AS (
    SELECT 
        region,
        state,
        COUNT(DISTINCT order_id) AS total_orders,
        ROUND(SUM(sales), 2) AS total_sales,
        ROUND(SUM(profit), 2) AS total_profit,
        ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin_pct,
        ROUND(AVG(discount) * 100, 2) AS avg_discount_pct
    FROM superstore_cleaned
    GROUP BY region, state
)
SELECT 
    region,
    state,
    total_orders,
    total_sales,
    total_profit,
    profit_margin_pct,
    avg_discount_pct,
    RANK() OVER (ORDER BY total_profit ASC) AS loss_rank
FROM state_performance
WHERE total_profit < 0
ORDER BY loss_rank;

3.Segmentasi Pelanggan Menggunakan RFM (Recency, Frequency, Monetary)
WITH max_date AS (
    SELECT MAX(order_date) AS latest_date FROM superstore_cleaned
),
customer_rfm AS (
    SELECT 
        customer_id,
        customer_name,
        segment,
        (SELECT latest_date FROM max_date) - MAX(order_date) AS recency_days,
        COUNT(DISTINCT order_id) AS frequency,
        ROUND(SUM(sales), 2) AS monetary
    FROM superstore_cleaned
    GROUP BY customer_id, customer_name, segment
),
rfm_scores AS (
    SELECT 
        *,
        NTILE(4) OVER (ORDER BY recency_days DESC) AS r_score, -- Semakin kecil hari, skor semakin tinggi (4)
        NTILE(4) OVER (ORDER BY frequency ASC) AS f_score,
        NTILE(4) OVER (ORDER BY monetary ASC) AS m_score
    FROM customer_rfm
)
SELECT 
    CASE 
        WHEN r_score = 4 AND f_score >= 3 AND m_score >= 3 THEN 'Champions'
        WHEN r_score >= 3 AND f_score >= 3 THEN 'Loyal Customers'
        WHEN r_score <= 2 AND f_score >= 3 THEN 'At Risk (High Value)'
        WHEN r_score = 4 AND f_score <= 2 THEN 'New / Recent Customers'
        ELSE 'Regular / Hibernating'
    END AS customer_tier,
    COUNT(customer_id) AS customer_count,
    ROUND(AVG(recency_days), 0) AS avg_recency_days,
    ROUND(AVG(frequency), 1) AS avg_frequency,
    ROUND(SUM(monetary), 2) AS total_revenue
FROM rfm_scores
GROUP BY customer_tier
ORDER BY total_revenue DESC;