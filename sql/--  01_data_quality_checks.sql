 USE arel;
 
 -- 01_data_quality_checks
-- purpose: check the underlying records before trusting any analysis built 
-- on them

-- attendance data quality checks
-- Enrollments per status- unknown records
SELECT status, COUNT(*) AS total_enrollments
FROM enrollments
GROUP BY status;

-- 178/565 (31.5) of enrollments have an unknown status,
-- attendance by status- Not Recorded
SELECT status, COUNT(*) AS total_attendance
FROM attendance
WHERE status = 'Not Recorded'
GROUP BY status;

-- 1873/58944 (3.2%) attendance records have 'Not Recorded'
-- missing contact information for students
SELECT
SUM(email ='') AS missing_email,
SUM(phone ='') AS missing_phone
FROM students;

-- 195/260 of students have missing contact information (eamail or phone,).

-- Decision made from these results:
-- 'Not Recorded' attendance rows are excluded from attendance-rate calculations
-- unknown enrollment status is kept as its own category.
