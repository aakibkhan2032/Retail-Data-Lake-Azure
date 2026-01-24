# Cloud-Based Retail Data Lake on Azure

## 📌 Project Overview
This project demonstrates the design and implementation of a scalable cloud-based data lake using Azure and Databricks to process retail e-commerce data.

## 🛠 Tech Stack
- Azure Data Lake Storage Gen2
- Azure Databricks
- PySpark
- Delta Lake
- MS SQL Server

## 🏗 Architecture
The project follows the Medallion Architecture:
- **Bronze Layer**: Raw data ingestion from source files
- **Silver Layer**: Data cleaning, validation, and transformation
- **Gold Layer**: Analytics-ready datasets for reporting and insights
- Refer to the architecture folder for the Medallion Architecture overview of this project.


## 📂 Dataset
Olist Brazilian E-Commerce Dataset

## 🚀 Key Data Engineering Concepts
- Medallion Architecture (Bronze–Silver–Gold)
- ETL pipelines using PySpark
- Delta Lake ACID transactions
- Data quality checks and validation

## 📘 Documentation
Detailed project flow and design decisions are available in the `docs` folder.

#Notebooks
- Bronze
  - 01_bronze_olist_ingestion
- Silver
  - 01_silver_orders
  - 02_silver_order_items
  - 03_silver_payments
  - 04_silver_order_reviews
 -Sql
  - sql_register_tables
#Synopsis
 -Project Synopsis 
