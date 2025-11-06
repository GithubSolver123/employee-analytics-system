USE attendance_db;

DELIMITER $$

-- Stored Procedure: Generate Monthly Payroll
CREATE PROCEDURE sp_generate_payroll(IN p_month_year CHAR(7))
BEGIN
  INSERT INTO payroll_monthly (
    emp_id, 
    month_year, 
    total_present, 
    total_hours, 
    late_days,
    overtime_hours, 
    base_salary, 
    overtime_pay, 
    total_salary
  )
  SELECT
    m.emp_id, 
    m.month_year, 
    m.total_present, 
    m.total_hours, 
    m.late_days,
    m.overtime_hours, 
    e.base_salary,
    ROUND(m.overtime_hours * e.overtime_rate, 2) AS overtime_pay,
    ROUND(e.base_salary + (m.overtime_hours * e.overtime_rate), 2) AS total_salary
  FROM v_monthly_summary m
  JOIN employees e ON e.emp_id = m.emp_id
  WHERE m.month_year = p_month_year
  ON DUPLICATE KEY UPDATE
    total_present = VALUES(total_present),
    total_hours = VALUES(total_hours),
    late_days = VALUES(late_days),
    overtime_hours = VALUES(overtime_hours),
    base_salary = VALUES(base_salary),
    overtime_pay = VALUES(overtime_pay),
    total_salary = VALUES(total_salary);
END$$

DELIMITER ;