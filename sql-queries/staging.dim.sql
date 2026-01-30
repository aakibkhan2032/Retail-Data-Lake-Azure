create database RetailAnalytics;

use RetailAnalytics;

CREATE TABLE staging.dim_customers (
    customer_id           VARCHAR(50),
    customer_unique_id    VARCHAR(50),
    customer_city         VARCHAR(100),
    customer_state        VARCHAR(10)
);

BULK INSERT staging.dim_customers
FROM "D:\Retail-Data-Analysis-data\export\dim_customers\dim_customers.csv"
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

select count(*) as total_count from staging.dim_customers;
select top 5 * from staging.dim_customers;



create table staging.dim_date(
full_date Date,
date_key Int,
year Int,
month Int,
month_name varchar(20),
day Int,
day_of_week Int,
day_name Varchar(20),
week_of_year Int,
is_weekend BIT
);

BULK INSERT staging.dim_date
FROM "D:\Retail-Data-Analysis-data\export\dim_date\dim_date.csv"
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

select count(*) from staging.dim_date;
select top 5 * from staging.dim_date;

drop table staging.dim_products;

create table staging.dim_products(
product_id varchar(100),
product_category_name varchar(500),
product_name_lenght varchar(500),
product_description_lenght varchar(50),
product_photos_qty varchar(50)
);

BULK INSERT staging.dim_products
FROM "D:\Retail-Data-Analysis-data\export\dim_products\dim_products.csv"
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

select count(*) from staging.dim_products;
select top 5 * from staging.dim_products;



create table staging.dim_sellers(
seller_id varchar(50),
seller_city varchar(50),
seller_state varchar(50)
);


BULK INSERT staging.dim_sellers
FROM "D:\Retail-Data-Analysis-data\export\dim_sellers\dim_sellers.csv"
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

select count(*) from staging.dim_sellers;
select top 5 * from staging.dim_sellers;

