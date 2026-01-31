use RetailAnalytics;
GO

select name from sys.tables;
GO

select top 5 * from dw.FactOrderItems;
GO
-- How much revenue do we generate each month?

CREATE VIEW reporting.vw_monthly_revenue AS
SELECT
    d.year,
    d.month,
    d.month_name,
    SUM(f.total_item_amount) AS monthly_revenue
FROM dw.FactOrderItems f
JOIN dw.DimDate d
    ON CAST(f.shipping_limit_date AS DATE) = d.full_date
GROUP BY
    d.year,
    d.month,
    d.month_name;
GO

select * from reporting.vw_monthly_revenue;
GO

SELECT SUM(total_item_amount)
FROM dw.FactOrderItems;
GO

SELECT SUM(monthly_revenue)
FROM reporting.vw_monthly_revenue;
GO

-- How many orders are delivered vs canceled?

CREATE VIEW reporting.vw_order_status_summary AS
SELECT
    is_delivered,
    is_canceled,
    COUNT(order_id) AS total_orders
FROM dw.FactOrders
GROUP BY
    is_delivered,
    is_canceled;
Go

select * from reporting.vw_order_status_summary;
GO

-- Which products drive the most revenue?

CREATE VIEW reporting.vw_top_products_by_revenue AS
SELECT
    p.product_category_name,
    SUM(f.total_item_amount) AS revenue
FROM dw.FactOrderItems f
JOIN dw.DimProducts p
    ON f.product_key = p.product_key
GROUP BY
    p.product_category_name;
GO

select * from reporting.vw_top_products_by_revenue;
GO

-- How long does delivery usually take

CREATE VIEW reporting.vw_avg_delivery_time AS
SELECT
    AVG(delivery_days * 1.0) AS avg_delivery_days
FROM dw.FactOrders
WHERE is_delivered = 1;
GO

select * from reporting.vw_avg_delivery_time;
GO
-- How do customers pay?

CREATE VIEW reporting.vw_payment_method_distribution AS
SELECT
    payment_type,
    COUNT(order_id) AS total_transactions,
    SUM(payment_value) AS total_payment_value
FROM dw.FactPayments
GROUP BY payment_type;
GO
select * from reporting.vw_payment_method_distribution;
GO


-- Which sellers have better customer satisfaction?

CREATE VIEW reporting.vw_seller_review_scores AS
SELECT
    s.seller_id,
    AVG(r.review_score * 1.0) AS avg_review_score,
    COUNT(r.review_id) AS total_reviews
FROM dw.FactOrderReviews r
JOIN dw.DimSellers s
    ON r.order_id IS NOT NULL
GROUP BY s.seller_id;
GO

select * from reporting.vw_seller_review_scores;