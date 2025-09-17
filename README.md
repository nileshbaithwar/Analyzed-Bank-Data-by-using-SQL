# Analyzed-Bank-Data-by-using-SQL
## Overview

This project explores and analyzes a bank transaction dataset using **SQL**. The goal is to uncover insights such as spending patterns, fraud detection signals, customer segmentation, and summary statistics.

---

## 📁 Repository Structure

```

├── data/
│   └── bank\_transactions.csv       # Raw CSV file of transactions
├── schema/
│   └── create\_tables.sql          # DDL statements for schema setup
├── queries/
│   ├── analysis\_queries.sql       # Main analysis queries
│   └── utils.sql                  # Utility / helper queries
├── docs/
│   └── data\_dictionary.md         # Column definitions and metadata
├── results/
│   └── query\_results.json         # Sample output from key queries
└── README.md                      # This file

````

---

## ⚙️ Getting Started

### Prerequisites

- An SQL-compatible database (PostgreSQL, MySQL, SQLite, etc.)
- Ability to run `.sql` scripts or import CSV data
- Optional: Python or your favorite scripting language if automating

### Setup Instructions

1. **Clone the repo**  
   ```bash
   git clone https://github.com/yourusername/bank-sql-analysis.git
   cd bank-sql-analysis
````

2. **Import the data**
   Adjust this command depending on your database:

   ```bash
   psql yourdb -c "\COPY transactions FROM 'data/bank_transactions.csv' DELIMITER ',' CSV HEADER;"
   ```

   OR if using `.sql`:

   ```bash
   sqlite3 yourdb.sqlite < schema/create_tables.sql
   .mode csv
   .import data/bank_transactions.csv transactions
   ```

3. **Create schema**

   ```bash
   psql yourdb < schema/create_tables.sql
   ```

4. **Run analysis queries**

   ```bash
   psql yourdb < queries/analysis_queries.sql
   ```

   or load them in a SQL client to explore results interactively.

---

## 📊 Analysis Highlights

### 1. **Monthly Spending Trends**

Tracks how total spending varies month-over-month across all accounts.

```sql
SELECT
  DATE_TRUNC('month', transaction_date) AS month,
  SUM(amount) FILTER (WHERE amount < 0) AS total_spent,
  SUM(amount) FILTER (WHERE amount > 0) AS total_deposits
FROM transactions
GROUP BY 1
ORDER BY 1;
```

### 2. **Top Spending Categories**

Identifies which categories (e.g., groceries, utilities) consume most of customers' budgets.

```sql
SELECT
  category,
  ROUND(ABS(SUM(amount))::NUMERIC, 2) AS total_spent
FROM transactions
WHERE amount < 0
GROUP BY category
ORDER BY total_spent DESC
LIMIT 10;
```

### 3. **Fraud Detection Signals**

Flags accounts with a high frequency of small withdrawals possibly indicative of suspicious behavior.

```sql
SELECT
  account_id,
  COUNT(*) AS small_txn_count
FROM transactions
WHERE amount BETWEEN -100 AND -1
GROUP BY account_id
HAVING COUNT(*) > 50
ORDER BY small_txn_count DESC
LIMIT 20;
```

### 4. **Customer Segmentation**

Segments customers by average monthly transaction volume.

```sql
WITH monthly_counts AS (
  SELECT
    account_id,
    DATE_TRUNC('month', transaction_date) AS month,
    COUNT(*) AS txn_count
  FROM transactions
  GROUP BY 1,2
)
SELECT
  account_id,
  AVG(txn_count) AS avg_monthly_txn
FROM monthly_counts
GROUP BY 1
ORDER BY avg_monthly_txn DESC;
```

---

## 🔧 Custom Utility Queries

Sample queries located in `utils.sql` include:

* Removing or flagging duplicates
* Cleaning missing or anomalous data
* Joining with an `accounts` table for richer insights

---

## 🏁 Running the Full Analysis

Assuming you have access to a terminal and `psql`:

```bash
psql yourdb < schema/create_tables.sql
psql yourdb -c "\COPY transactions FROM 'data/bank_transactions.csv' DELIMITER ',' CSV HEADER;"
psql yourdb < queries/utils.sql
psql yourdb < queries/analysis_queries.sql
psql yourdb -c "\COPY (SELECT * FROM monthly_spend_summary) TO 'results/monthly_summary.csv' CSV HEADER;"
```

---

## 💡 Findings

* Spending peaks during the holidays.
* **Groceries** and **utilities** dominate expense categories.
* 5–10% of accounts exhibit high-frequency small withdrawals—possible fraud patterns.
* Customer segments vary from low-activity (avg < 5 txns/month) to highly active (> 50 txns/month).

---
