select name from sys.databases;
GO

use RetailAnalytics;
GO

select name from sys.tables;
GO

SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='fact_orders';
GO

CREATE TABLE dw.FactOrders (
    fact_order_key INT IDENTITY(1,1) PRIMARY KEY,
    order_id NVARCHAR(50),

    customer_key INT,
    primary_seller_key INT,
    order_date_key INT,

    order_count INT,
    total_order_amount DECIMAL(12,2),
    total_items INT,
    delivery_days INT,
    shipping_days INT,
    is_delivered BIT,
    is_canceled BIT
);
GO


INSERT INTO dw.FactOrders
SELECT
    o.order_id,
    c.customer_key,
    s.seller_key,
    o.order_date_key,
    o.order_count,
    o.total_order_amount,
    o.total_items,
    o.delivery_days,
    o.shipping_days,
    o.is_delivered,
    o.is_canceled
FROM staging.fact_orders o
JOIN dw.DimCustomers c ON o.customer_id = c.customer_id
JOIN dw.DimSellers s ON o.primary_seller_id = s.seller_id;
GO

CREATE TABLE dw.FactOrderItems (
    fact_order_item_key INT IDENTITY(1,1) PRIMARY KEY,
    order_id NVARCHAR(50),

    product_key INT,
    seller_key INT,

    order_item_id INT,
    shipping_limit_date DATE,
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2),
    total_item_amount DECIMAL(10,2)
);
GO

INSERT INTO dw.FactOrderItems
SELECT
    i.order_id,
    p.product_key,
    s.seller_key,
    i.order_item_id,
    i.shipping_limit_date,
    i.price,
    i.freight_value,
    i.total_item_amount
FROM staging.fact_order_items i
JOIN dw.DimProducts p ON i.product_id = p.product_id
JOIN dw.DimSellers s ON i.seller_id = s.seller_id;
GO

CREATE TABLE dw.FactPayments (
    fact_payment_key INT IDENTITY(1,1) PRIMARY KEY,
    order_id NVARCHAR(50),

    payment_sequential INT,
    payment_type NVARCHAR(30),
    payment_installments INT,
    payment_value DECIMAL(10,2)
);


INSERT INTO dw.FactPayments
SELECT
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value
FROM staging.fact_payments;
GO

CREATE TABLE dw.FactOrderReviews (
    fact_review_key INT IDENTITY(1,1) PRIMARY KEY,
    review_id NVARCHAR(50),
    order_id NVARCHAR(50),
    review_score INT,
    review_comment_title NVARCHAR(255),
    review_comment_message NVARCHAR(MAX)
);
GO

INSERT INTO dw.FactOrderReviews
SELECT
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message
FROM staging.fact_order_reviews;
GO

SELECT COUNT(*) FROM staging.fact_order_items;
SELECT COUNT(*) FROM dw.FactOrderItems;
GO

SELECT *
FROM dw.FactOrders
WHERE customer_key IS NULL
   OR primary_seller_key IS NULL;
GO

