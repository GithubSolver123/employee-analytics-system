USE attendance_db;

-- View: Daily Work Metrics
CREATE OR REPLACE VIEW v_daily_work AS
SELECT
  a.att_id,
  a.att_date,
  a.check_in,
  a.check_out,
  e.emp_id,
  e.emp_code,
  e.full_name,
  d.dept_name,
  ROUND(TIMESTAMPDIFF(HOUR, a.check_in, a.check_out), 2) AS hours_worked,
  CASE 
    WHEN HOUR(a.check_in) >= 10 THEN 1
    ELSE 0
  END AS is_late,
  GREATEST(
    ROUND(TIMESTAMPDIFF(HOUR, a.check_in, a.check_out), 2) - 8, 
    0
  ) AS overtime_hours
FROM attendance a
JOIN employees e ON e.emp_id = a.emp_id
JOIN departments d ON d.dept_id = e.dept_id;

-- View: Monthly Summary
CREATE OR REPLACE VIEW v_monthly_summary AS
SELECT
  e.emp_id,
  e.emp_code,
  e.full_name,
  d.dept_name,
  DATE_FORMAT(a.att_date, '%Y-%m') AS month_year,
  COUNT(*) AS total_present,
  ROUND(SUM(TIMESTAMPDIFF(HOUR, a.check_in, a.check_out)), 2) AS total_hours,
  SUM(
    CASE 
      WHEN HOUR(a.check_in) >= 10 THEN 1
      ELSE 0
    END
  ) AS late_days,
  ROUND(
    SUM(
      GREATEST(TIMESTAMPDIFF(HOUR, a.check_in, a.check_out) - 8, 0)
    ), 
    2
  ) AS overtime_hours
FROM attendance a
JOIN employees e ON e.emp_id = a.emp_id
JOIN departments d ON d.dept_id = e.dept_id
GROUP BY 
  e.emp_id, 
  e.emp_code, 
  e.full_name, 
  d.dept_name, 
  DATE_FORMAT(a.att_date, '%Y-%m');

-- View: Payroll Preview
CREATE OR REPLACE VIEW v_payroll_preview AS
SELECT
  m.emp_id,
  m.emp_code,
  m.full_name,
  m.dept_name,
  m.month_year,
  m.total_present,
  m.total_hours,
  m.late_days,
  m.overtime_hours,
  e.base_salary,
  e.overtime_rate,
  ROUND(m.overtime_hours * e.overtime_rate, 2) AS overtime_pay,
  ROUND(e.base_salary + (m.overtime_hours * e.overtime_rate), 2) AS total_salary
FROM v_monthly_summary m
JOIN employees e ON e.emp_id = m.emp_id;