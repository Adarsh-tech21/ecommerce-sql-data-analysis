# 🛒 E-Commerce SQL Data Analysis

<p align="center">
  <b>MySQL • SQL Analytics • Business Intelligence</b><br>
  An end-to-end SQL project focused on extracting actionable insights from e-commerce data
</p>

## 📌 Project Overview

This project presents an end-to-end **E-Commerce Data Analysis solution using MySQL**.

The objective is to analyze structured business data across customers, products, transactions, reviews, and digital sessions to understand **sales performance, customer behavior, product performance, engagement, conversion, and churn**.

The project contains **30 business-oriented SQL analyses**, progressing from fundamental data exploration to advanced analytical queries. The analysis is designed around practical business questions that a Data Analyst may encounter while working with e-commerce data.

The final output is a structured set of SQL analyses that can be used to understand business performance and support **data-driven decision-making**.

---

## 🎯 Business Objectives

The project focuses on answering key business needs such as:

- 👥 Understanding customer demographics and customer segments
- 💰 Measuring revenue and transaction performance
- 📦 Identifying high-performing products and categories
- 💳 Understanding payment and discount patterns
- 🌍 Comparing business performance across countries
- ⭐ Evaluating product ratings and customer feedback
- 🌐 Measuring customer engagement across channels and devices
- 📈 Understanding conversion and bounce behavior
- 🔄 Identifying churned and high-value customers
- 💡 Converting raw data into meaningful business insights

---

## 🗂️ Dataset Overview

The dataset contains **236,000+ records** distributed across five relational tables.

| Table | Records | Purpose |
|---|---:|---|
| 👥 `customers` | 10,000 | Customer demographics, segments, churn and lifetime value |
| 📦 `products` | 1,000 | Product information, pricing, ratings and inventory |
| 💰 `transactions` | 120,000 | Orders, revenue, discounts, payment and shipping information |
| ⭐ `reviews` | 25,000 | Customer ratings, reviews and feedback |
| 🌐 `sessions` | 80,000 | Website/app sessions, engagement and conversion data |

### Total Records

**236,000+ records across 5 tables**

---

## 🧩 Data Model

The project uses a relational structure where customer and product identifiers connect information across different business areas.

```text
                         👥 CUSTOMERS
                              │
              ┌───────────────┼───────────────┐
              │               │               │
              ▼               ▼               ▼
        💰 TRANSACTIONS   ⭐ REVIEWS     🌐 SESSIONS
              │               │
              └──────────┬────┘
                         ▼
                    📦 PRODUCTS
```

Key relationships include:

- `customers.customer_id` → customer activity across transactions, reviews and sessions
- `products.product_id` → product activity across transactions and reviews
- `transactions` → connects customers with purchased products
- `reviews` → connects customers with product feedback
- `sessions` → captures customer engagement and conversion activity

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|---|---|
| 🐬 **MySQL** | Database management and SQL analysis |
| 🖥️ **MySQL Workbench** | Query development, execution and validation |
| 🐙 **GitHub** | Project version control and documentation |
| 📄 **CSV** | Source data format |

---

## 🔍 Analysis Scope

### 👥 Customer Analytics

Customer-level analysis covers:

- Customer demographics
- Customer segmentation
- Average age
- Customer lifetime value
- Customer spending
- Customer churn
- High-value customers

### 💰 Sales & Revenue Analytics

Sales analysis covers:

- Monthly revenue
- Completed transactions
- Average order value
- Revenue by country
- Customer spending
- Transaction status
- Payment methods
- Discount analysis

### 📦 Product & Category Analytics

Product analysis covers:

- Product revenue
- Category performance
- Product rankings
- Product ratings
- Inventory levels
- Highly rated products
- Top-performing products

### ⭐ Review Analytics

Review analysis covers:

- Product ratings
- Review volume
- Helpful votes
- Verified purchases
- Customer feedback patterns

### 🌐 Digital Engagement Analytics

Session analysis covers:

- Device performance
- Marketing channel performance
- Session engagement
- Conversion rate
- Bounce rate
- Customer activity

### 🔄 Churn Analytics

Churn analysis focuses on:

- Churned customers
- High-value churned customers
- Customer value and churn
- Customer behavior related to churn

---

## 🧠 SQL Analysis Approach

The project uses SQL progressively, starting with basic exploration and moving toward advanced analytical techniques.

The analysis includes:

- Data filtering and aggregation
- Grouped business metrics
- Multi-table analysis
- Subqueries
- Common Table Expressions (CTEs)
- Ranking analysis
- Window functions
- Running totals
- Month-over-month analysis
- Customer-level analytical metrics

The purpose is not only to retrieve data, but to transform raw records into **business-relevant metrics and insights**.

---

## 🔄 Project Workflow

```text
📥 Raw CSV Data
        ↓
🗂️ Data Import
        ↓
🧱 Database & Table Creation
        ↓
🔎 Data Exploration
        ↓
📊 Business Metrics
        ↓
🔗 Multi-Table Analysis
        ↓
🧠 Advanced SQL Analysis
        ↓
💡 Business Insights
        ↓
🏁 Final Conclusion
```

---

## 💡 Business Insights

The analysis provides a structured view of e-commerce performance across multiple dimensions.

### Customer Perspective
Understanding customer segments, spending patterns, lifetime value and churn helps evaluate customer behavior and value.

### Revenue Perspective
Transaction analysis provides visibility into revenue trends, order value, payment methods, discounts and geographic performance.

### Product Perspective
Product and category analysis helps identify revenue contributors, ratings, inventory levels and product performance.

### Engagement Perspective
Session analysis helps evaluate how customers interact with the platform across different devices and marketing channels.

### Customer Experience Perspective
Review and rating analysis provides information about customer feedback and product satisfaction.

### Retention Perspective
Churn analysis helps identify customers who may represent lost or declining business value, particularly high-value customers.

---

## 📈 Project Outcome

The project demonstrates how multiple business datasets can be combined and analyzed to create a more complete view of an e-commerce business.

Instead of analyzing sales in isolation, the project connects:

**Customers → Transactions → Products → Reviews → Sessions → Engagement → Conversion → Churn**

This provides a broader analytical perspective and demonstrates the application of SQL to **real-world business problems**.

---

## 📁 Project Structure

```text
ecommerce-sql-data-analysis/
│
├── 📄 Ecommerce_SQL_Data_Analysis_Project.sql
│
└── 📄 README.md
```

### SQL Project File

`Ecommerce_SQL_Data_Analysis_Project.sql`

The SQL file contains:

- Project overview
- Database and table setup
- 30 analytical SQL questions
- Overall business insights
- Final conclusion

---

## 🎓 Skills Demonstrated

This project demonstrates practical application of:

`SQL` • `MySQL` • `Data Analysis` • `Business Analytics` • `Data Exploration` • `Business Insights`

---

## 🏁 Conclusion

This project demonstrates how **SQL can be used as a business analysis tool**, not only as a method for retrieving data.

By analyzing customers, transactions, products, reviews and sessions together, the project provides a structured approach to understanding **revenue, customer behavior, product performance, engagement and churn**.

The project reflects a practical Data Analyst workflow:

**Understand the data → Ask business questions → Analyze with SQL → Interpret results → Generate insights.**

---

## 👨‍💻 Author

## **Adarsh Sahal**

**Aspiring Data Analyst**

**Skills:**  
`SQL` • `MySQL` • `Excel` • `Data Analysis` • `Business Analytics`

---

## 🔗 Connect With Me

##🐙 GitHub

https://github.com/Adarsh-tech21

## 💼 LinkedIn

https://www.linkedin.com/in/adarsh-sahal/

---

<p align="center">
  <b>🛒 E-Commerce SQL Data Analysis</b><br>
  MySQL • SQL • Data Analytics • Business Insights
</p>
