use RetailAnalytics;
GO

CREATE TABLE dw.DimCustomers (
    customer_key INT IDENTITY(1,1) PRIMARY KEY,
    customer_id NVARCHAR(50),
    customer_unique_id NVARCHAR(50),
    customer_city NVARCHAR(100),
    customer_state NVARCHAR(10)
);
GO

INSERT INTO dw.DimCustomers
SELECT DISTINCT
    customer_id,
    customer_unique_id,
    customer_city,
    customer_state
FROM staging.dim_customers;
GO

select top 5 * from dw.DimCustomers;
select count(*) from dw.DimCustomers;
GO


CREATE TABLE dw.DimProducts (
    product_key INT IDENTITY(1,1) PRIMARY KEY,
    product_id NVARCHAR(50),
    product_category_name NVARCHAR(100),
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT
);
GO

INSERT INTO dw.DimProducts
SELECT DISTINCT
    product_id,
    product_category_name,
    product_name_lenght,
    product_description_lenght,
    product_photos_qty
FROM staging.dim_products;
GO

select top 5 * from dw.DimProducts;
select count(*) from dw.DimProducts;
GO


CREATE TABLE dw.DimSellers (
    seller_key INT IDENTITY(1,1) PRIMARY KEY,
    seller_id NVARCHAR(50),
    seller_city NVARCHAR(100),
    seller_state varchar(50)
);
GO


Insert into dw.DimSellers
select distinct 
    seller_id ,
    seller_city ,
    seller_state
from staging.dim_sellers;
GO


select top 5 * from dw.DimSellers;
select count(*) from dw.DimSellers;
GO


CREATE TABLE dw.DimDate (
    date_key INT PRIMARY KEY,
    full_date DATE,
    year INT,
    month INT,
    month_name NVARCHAR(20),
    day INT,
    day_of_week INT,
    day_name NVARCHAR(20),
    week_of_year INT,
    is_weekend BIT
);
GO


INSERT INTO dw.DimDate
SELECT DISTINCT
    date_key,
    full_date,
    year,
    month,
    month_name,
    day,
    day_of_week,
    day_name,
    week_of_year,
    is_weekend
FROM staging.dim_date;
GO

select top 5 * from dw.DimDate;
select count(*) from dw.DimDate;
GO