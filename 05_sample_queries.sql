USE attendance_db;

-- Query 1: View all daily attendance records
SELECT * 
FROM v_daily_work 
ORDER BY att_date, emp_id;

-- Query 2: Monthly summary for October 2025
SELECT * 
FROM v_monthly_summary 
WHERE month_year = '2025-10';

-- Query 3: Generate and view payroll for October 2025
CALL sp_generate_payroll('2025-10');

SELECT * 
FROM payroll_monthly 
WHERE month_year = '2025-10' 
ORDER BY total_salary DESC;

-- Query 4: Top late employees (October 2025)
SELECT 
  emp_id, 
  full_name, 
  late_days
FROM v_monthly_summary
WHERE month_year = '2025-10'
ORDER BY late_days DESC;

-- Query 5: Department-wise total salary cost (October 2025)
SELECT 
  p.month_year, 
  d.dept_name, 
  ROUND(SUM(p.total_salary), 2) AS dept_cost
FROM payroll_monthly p
JOIN employees e ON e.emp_id = p.emp_id
JOIN departments d ON d.dept_id = e.dept_id
WHERE p.month_year = '2025-10'
GROUP BY p.month_year, d.dept_name
ORDER BY dept_cost DESC;

-- Query 6: Top 5 employees with highest overtime (October 2025)
SELECT 
  emp_id, 
  full_name, 
  overtime_hours
FROM v_monthly_summary
WHERE month_year = '2025-10'
ORDER BY overtime_hours DESC
LIMIT 5;