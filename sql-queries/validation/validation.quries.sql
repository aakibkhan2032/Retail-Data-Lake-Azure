use RetailAnalytics;
GO

-- Row Count Reconciliation

-- Order Items
select count(*) from staging.fact_order_items;
select count(*) from dw.FactOrderItems;
GO

-- Orders
select count(*) from staging.fact_orders;
select count(*) from dw.FactOrders;
GO


-- Revenue Reconciliation

--From items
select sum(total_item_amount)
from staging.fact_order_items;
GO

-- From reporting
select sum(monthly_revenue)
from reporting.vw_monthly_revenue;
GO


-- Orphan Key Detection

-- Orders without customers
SELECT *
FROM dw.FactOrders
WHERE customer_key IS NULL;
GO

-- Items without products
SELECT *
FROM dw.FactOrderItems
WHERE product_key IS NULL;
GO


-- Date Coverage Check

SELECT
    MIN(full_date) AS min_date,
    MAX(full_date) AS max_date
FROM dw.DimDate;
GO

SELECT
    MIN(shipping_limit_date),
    MAX(shipping_limit_date)
FROM dw.FactOrderItems;
GO


-- Business Logic Sanity Checks

-- Delivered orders should not be canceled
SELECT *
FROM dw.FactOrders
WHERE is_delivered = 1 AND is_canceled = 1;
GO

-- Negative payments should not exist
SELECT * 
FROM dw.FactPayments
WHERE payment_value < 0;
GO


