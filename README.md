# 📊 SQL Data Warehouse Project

Welcome to the **SQL Data Warehouse & Analytics** project repository! 🚀  
This project demonstrates how to build a modern data warehouse using **SQL Server**, following industry best practices in **data architecture**, **ETL design**, and **analytics**.

---

## 🏗️ Data Architecture — Medallion Approach

The architecture follows the **Medallion pattern**, organizing data into three structured layers to ensure scalability, maintainability, and clarity:

### 🥉 Bronze Layer  
Raw data is ingested **as-is** from CSV files into SQL Server with minimal transformation.

### 🥈 Silver Layer  
Data is **cleaned**, **standardized**, and **joined** across sources to produce an integrated dataset ready for modeling.

### 🥇 Gold Layer  
Business-ready data is **modeled using a star schema** to support analytics, KPIs, and reporting.

![Medallion Architecture](https://github.com/user-attachments/assets/12f71afd-5f4e-40bc-8c8c-9caa3dc3744d)

---

## 🔗 Data Integration Model

This model represents how the project unifies and cleanses data from multiple source systems before applying dimensional modeling.

![Data Integration Model](https://github.com/user-attachments/assets/09fbc605-782f-48bb-a092-dac24c9ab9af)

---

## 🔄 Data Flow Overview

The diagram below illustrates the full ETL pipeline:  
From **raw CSV ingestion** → **cleaned Silver data** → **modeled Gold data**.

![Data Flow Diagram](https://github.com/user-attachments/assets/9dfca8d0-8ceb-40ee-a61f-95e667c30ccf)

---

## 🌟 Dimensional Model

The project uses a **Star Schema** for the Gold layer, optimizing query performance and simplifying analytical workloads.

![Dimensional Model (Star Schema)](https://github.com/user-attachments/assets/ffe78cda-2c23-4e28-8bf3-5cf8cceccae3)

---

## 📖 Project Overview

This project includes:

- **Data Architecture**: Bronze, Silver, and Gold layers using Medallion architecture
- **ETL Pipelines**: Loading and transforming raw CSVs into a structured warehouse
- **Data Integration**: Merging CRM and ERP data into unified entities
- **Data Modeling**: Creating fact and dimension tables for reporting
- **Analytics**: Enabling insights via SQL-based queries and dashboards

---

## 🎯 Key Learning Objectives

This project is a solid showcase of skills in:

- ✅ SQL Development
- ✅ Data Modeling (Star Schema)
- ✅ ETL & Data Integration
- ✅ Data Architecture Design
- ✅ Data Analytics for Business Intelligence
- ✅ Using SQL Server & SSMS

---



