# Employee Attendance & Salary Analytics System

A MySQL-based system for tracking employee attendance, calculating working hours, overtime, and generating monthly payroll reports.

## Overview

This system manages employee attendance records and automatically calculates:
- Daily hours worked
- Late arrivals (after 10:00 AM)
- Overtime hours (hours beyond 8 per day)
- Monthly payroll with overtime compensation

## Features

- **Attendance Tracking**: Daily check-in/check-out records
- **Automated Calculations**: Hours worked, late days, and overtime computed automatically
- **Monthly Summaries**: Aggregated statistics per employee per month
- **Payroll Generation**: Stored procedure to generate monthly payroll reports
- **Analytics Views**: Pre-built views for daily metrics, monthly summaries, and payroll previews

## Database Structure

- **departments**: Department information
- **employees**: Employee details with base salary and overtime rates
- **attendance**: Daily check-in/check-out records
- **payroll_monthly**: Generated monthly payroll snapshots

## Setup

1. Ensure MySQL 8+ is installed and running
2. Execute the SQL files in order:
   ```
   01_schema.sql      - Creates database and tables
   02_seed_data.sql   - Inserts sample data
   03_views.sql       - Creates analytical views
   04_procedures.sql  - Creates payroll generation procedure
   05_sample_queries.sql - Example queries
   ```
3. (Optional) Run `99_reset.sql` to drop and recreate the database

## Usage

### Generate Monthly Payroll
```sql
CALL sp_generate_payroll('2025-10');
```

### View Daily Attendance Metrics
```sql
SELECT * FROM v_daily_work;
```

### View Monthly Summary
```sql
SELECT * FROM v_monthly_summary WHERE month_year = '2025-10';
```

### View Payroll Preview
```sql
SELECT * FROM v_payroll_preview WHERE month_year = '2025-10';
```

## Business Rules

- Standard work hours: 8 hours per day
- Late cutoff: 10:00 AM (hour 10 or later)
- Overtime: Hours worked beyond 8 hours per day
- Salary calculation: Base salary + (overtime hours × overtime rate)

## Technology

- MySQL 8+
- SQL Views
- Stored Procedures

