-- Database Setup
CREATE DATABASE IF NOT EXISTS attendance_db;
USE attendance_db;

-- Departments Table
CREATE TABLE IF NOT EXISTS departments (
  dept_id INT PRIMARY KEY AUTO_INCREMENT,
  dept_name VARCHAR(50) NOT NULL UNIQUE
);

-- Employees Table
CREATE TABLE IF NOT EXISTS employees (
  emp_id INT PRIMARY KEY AUTO_INCREMENT,
  emp_code VARCHAR(10) NOT NULL UNIQUE,
  full_name VARCHAR(80) NOT NULL,
  dept_id INT NOT NULL,
  base_salary DECIMAL(10,2) NOT NULL,
  overtime_rate DECIMAL(10,2) NOT NULL,
  join_date DATE NOT NULL,
  status ENUM('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
  CONSTRAINT fk_emp_dept FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- Attendance Table
CREATE TABLE IF NOT EXISTS attendance (
  att_id INT PRIMARY KEY AUTO_INCREMENT,
  emp_id INT NOT NULL,
  att_date DATE NOT NULL,
  check_in DATETIME NOT NULL,
  check_out DATETIME NOT NULL,
  notes VARCHAR(120),
  CONSTRAINT fk_att_emp FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
  CONSTRAINT uq_att UNIQUE (emp_id, att_date)
);

-- Monthly Payroll Table
CREATE TABLE IF NOT EXISTS payroll_monthly (
  payroll_id INT PRIMARY KEY AUTO_INCREMENT,
  emp_id INT NOT NULL,
  month_year CHAR(7) NOT NULL,
  total_present INT NOT NULL,
  total_hours DECIMAL(10,2) NOT NULL,
  late_days INT NOT NULL,
  overtime_hours DECIMAL(10,2) NOT NULL,
  base_salary DECIMAL(10,2) NOT NULL,
  overtime_pay DECIMAL(10,2) NOT NULL,
  total_salary DECIMAL(10,2) NOT NULL,
  generated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_pay_emp FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
  CONSTRAINT uq_pay UNIQUE (emp_id, month_year)
);