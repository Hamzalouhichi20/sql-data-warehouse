# 📊 SQL Data Warehouse

Building a modern data warehouse using **SQL Server**, including the full **ETL process**, **data modeling**, and **analytics pipeline**.

---

## 🏗️ Data Architecture: Medallion Approach

This project follows the **Medallion Architecture** — a clean, scalable, and practical framework for organizing data in three logical layers:

### 🥉 Bronze Layer  
Raw data is ingested **as-is** from multiple CSV files into SQL Server tables with minimal or no transformation.

### 🥈 Silver Layer  
Data is **cleaned**, **standardized**, and **joined**. This layer serves as a refined and consistent foundation for business analysis.

### 🥇 Gold Layer  
Data is **modeled in a star schema**, enabling efficient business intelligence, KPI dashboards, and advanced reporting.

![Medallion Architecture](https://github.com/user-attachments/assets/12f71afd-5f4e-40bc-8c8c-9caa3dc3744d)

---
## 🔄 Data indetgration  model 
![Data Integration Model](https://github.com/user-attachments/assets/09fbc605-782f-48bb-a092-dac24c9ab9af)
## 🔄 Data Flow Overview

This pipeline illustrates the flow from **raw CSV ingestion** to **business-ready data** through a structured ETL process within SQL Server:

![data_flow](https://github.com/user-attachments/assets/9dfca8d0-8ceb-40ee-a61f-95e667c30ccf)

## 🔄dimensional model 
![Dimensional model (star schema)](https://github.com/user-attachments/assets/ffe78cda-2c23-4e28-8bf3-5cf8cceccae3)
