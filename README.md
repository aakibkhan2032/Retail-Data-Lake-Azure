# Cloud-Based Retail Analytics Platform (Medallion Architecture)

## 📌 Project Overview
This project implements an **end-to-end cloud data engineering pipeline** using **Azure Databricks, ADLS Gen2, Delta Lake, and MS SQL Server** based on the **Medallion Architecture (Bronze → Silver → Gold)**.

The pipeline processes the **Olist Brazilian E-Commerce Dataset** to produce **analytics-ready fact and dimension tables**, which are finally consumed in **Microsoft SQL Server** for reporting and analysis.

The project emphasizes **data quality, scalability, analytics modeling, and cost optimization**, closely following real-world data engineering best practices.

---

## 🏗️ Architecture Overview
---

## 📂 Data Source
- **Dataset:** Olist Brazilian E-Commerce Dataset  
- **Format:** CSV  
- **Domain:** Retail / E-Commerce  

---

## 🔄 Project Flow

### 1️⃣ Data Ingestion (Raw Layer)
- Raw CSV files are stored in **Azure Data Lake Storage Gen2 (ADLS)**.
- No transformations are applied.
- Acts as an immutable backup of the source data.

---

### 2️⃣ Bronze Layer – Raw Delta Storage
- Raw data is ingested into **Azure Databricks** using **PySpark**.
- Stored in **Delta Lake format**.
- Purpose:
  - Schema enforcement
  - Data versioning
  - Reprocessing capability

---

### 3️⃣ Silver Layer – Cleaned & Conformed Data
- Applies data engineering best practices:
  - Primary-key based deduplication
  - Referential integrity checks
  - Regex-based timestamp validation
  - Safe casting of data types
  - Text normalization
  - Preservation of business-meaningful NULLs
- Produces clean, standardized Delta tables for each entity.

---

### 4️⃣ Gold Layer – Business & Analytics Model
- Implements a **Star Schema** optimized for analytics.

#### Fact Tables:
- `fact_orders`
- `fact_order_items`
- `fact_payments`
- `fact_order_reviews`

#### Dimension Tables:
- `dim_date`
- `dim_customers`
- `dim_products`
- `dim_sellers`

- Clearly defined grain for each fact table
- Business metrics precomputed for efficient querying

---

### 5️⃣ Serving / Export Layer
- Gold tables are exported as **CSV files** to an `/export` folder in ADLS.
- Designed for easy integration with external analytics systems.

---

### 6️⃣ Analytics & Reporting Layer (MS SQL Server)
- Exported CSVs are loaded into **Microsoft SQL Server (local)**.
- Star schema is recreated using fact and dimension tables.
- Analytical SQL views are built for:
  - Sales analysis
  - Customer insights
  - Regional and time-based reporting
- SQL Queries
  - staging.dim
  - staging.fact
  - dw.dim

---

### 7️⃣ Cost Optimization Strategy
- Azure Databricks is used as an **ephemeral compute layer**.
- After Gold export:
  - Databricks clusters and workspace are deleted
  - Data remains safely stored in ADLS
- Ensures minimal cloud cost while preserving data integrity.

---

## 🛠️ Technologies Used
- Azure Data Lake Storage Gen2 (ADLS)
- Azure Databricks
- PySpark
- Delta Lake
- Microsoft SQL Server
- SQL (Analytical Views)

---

## ✅ Key Learnings & Outcomes
- Designed and implemented **Medallion Architecture**
- Built **production-style fact & dimension models**
- Applied real-world **data quality checks**
- Optimized cloud cost by separating **compute and storage**
- Delivered an **analytics-ready retail data platform**

---

## 📌 Future Enhancements
- Automate ingestion using Azure Data Factory
- Incremental data loading
- Power BI dashboard integration
- CI/CD for data pipelines

---

## 👤 Author
**Aakib Khan**  
Aspiring Data Engineer  

---

⭐ *If you find this project useful, feel free to star the repository!*
