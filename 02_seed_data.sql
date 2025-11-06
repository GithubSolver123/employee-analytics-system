USE attendance_db;

-- Insert Departments
INSERT INTO departments (dept_name) VALUES
('Engineering'),
('HR'),
('Finance')
ON DUPLICATE KEY UPDATE dept_name = VALUES(dept_name);

-- Insert Employees
INSERT INTO employees (emp_code, full_name, dept_id, base_salary, overtime_rate, join_date, status) VALUES
('E001','Aarav Mehta', 1, 60000, 300, '2024-01-10','ACTIVE'),
('E002','Riya Sharma', 1, 55000, 300, '2024-02-01','ACTIVE'),
('E003','Kabir Singh', 2, 45000, 250, '2024-03-15','ACTIVE'),
('E004','Ishita Roy', 3, 50000, 250, '2024-01-05','ACTIVE'),
('E005','Vihaan Nair', 1, 62000, 350, '2023-12-20','ACTIVE')
ON DUPLICATE KEY UPDATE full_name = VALUES(full_name);

-- Insert Attendance Records (October 2025)
INSERT INTO attendance (emp_id, att_date, check_in, check_out, notes) VALUES
(1,'2025-10-01','2025-10-01 09:02','2025-10-01 17:40',''),
(1,'2025-10-02','2025-10-02 09:20','2025-10-02 17:35','late'),
(1,'2025-10-03','2025-10-03 08:58','2025-10-03 18:10','overtime'),
(2,'2025-10-01','2025-10-01 09:05','2025-10-01 17:20',''),
(2,'2025-10-02','2025-10-02 09:00','2025-10-02 19:10','overtime'),
(2,'2025-10-03','2025-10-03 09:45','2025-10-03 18:30','late'),
(3,'2025-10-01','2025-10-01 09:10','2025-10-01 17:40',''),
(3,'2025-10-02','2025-10-02 09:12','2025-10-02 17:32',''),
(4,'2025-10-01','2025-10-01 08:55','2025-10-01 17:50','overtime'),
(4,'2025-10-02','2025-10-02 09:18','2025-10-02 17:28','late'),
(5,'2025-10-01','2025-10-01 09:03','2025-10-01 20:10','overtime'),
(5,'2025-10-02','2025-10-02 09:40','2025-10-02 18:05','late');