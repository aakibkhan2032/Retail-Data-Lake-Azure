use RetailAnalytics;
GO

create table staging.fact_orders(
order_id varchar(50),
customer_id varchar(50),
primary_seller_id varchar(50),
order_date_key Int,
order_count Int,
total_order_amount Float,
total_items Int,
delivery_days Int,
shipping_days Int,
is_delivered Int,
is_canceled Int
);
GO

Bulk insert staging.fact_orders
from "D:\Retail-Data-Analysis-data\export\fact_orders\fact_orders.csv"
with(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO

select count(*) from staging.fact_orders;
GO
select top 5 * from staging.fact_orders;
GO

create table staging.fact_order_items(
order_id varchar(50),
order_item_id Int,
product_id varchar(50),
seller_id varchar(50),
shipping_limit_date Datetime,
price Float,
freight_value Float,
total_item_amount Float
);
GO

Bulk  insert staging.fact_order_items
from "D:\Retail-Data-Analysis-data\export\fact_order_items\fact_order_items.csv"
with(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO

select count(*) from staging.fact_order_items;
GO
select top 5 * from staging.fact_order_items;
GO


create table staging.fact_order_reviews(
review_id varchar(50),
order_id varchar(50),
review_score Int,
review_comment_title varchar(500),
review_comment_message varchar(500),
review_creation_date varchar(500)
);
GO

BULK INSERT staging.fact_order_reviews
FROM 'D:\Retail-Data-Analysis-data\export\fact_order_reviews\fact_order_reviews.csv'
WITH (
     FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO

select count(*) from staging.fact_order_reviews;
GO
select top 10 * from staging.fact_order_reviews;
GO

ALTER TABLE staging.fact_order_reviews
DROP COLUMN review_creation_date;
GO


create table staging.fact_payments(
order_id varchar(50),
payment_sequential Int,
payment_type varchar(50),
payment_installments Int,
payment_value Float
);
GO

Bulk insert staging.fact_payments
from "D:\Retail-Data-Analysis-data\export\fact_payments\fact_payments.csv"
with(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO

select count(*) from staging.fact_payments;
GO
select top 10 * from staging.fact_payments;
GO