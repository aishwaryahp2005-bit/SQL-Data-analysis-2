USE `task-2`;

-- Drop tables in order: child table first, then parents
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS students;
-- 1. Create Students table (Foundation)
CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50)
);

-- 2. Create Courses table [cite: 33, 34]
CREATE TABLE courses (
    id INT PRIMARY KEY,
    name VARCHAR(58)
);

-- 3. Create Enrollments table [cite: 35-39]
CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    grade INT,
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);
-- Insert Sample Students
INSERT INTO students (id, name, email) VALUES 
(1, 'Aman', 'aman@email.com'), 
(2, 'Sana', 'sana@email.com'),
(3, 'Rahul', 'rahul@email.com');

-- Insert Sample Courses
INSERT INTO courses (id, name) VALUES 
(101, 'Data Analysis'), 
(102, 'Supply Chain');

-- Insert Sample Enrollments
INSERT INTO enrollments (student_id, course_id, grade) VALUES 
(1, 101, 85), (1, 102, 92),
(2, 101, 35), (2, 102, 45),
(3, 101, 78), (3, 102, 30);
SELECT s.name AS student_name, c.name AS course_name
FROM enrollments e
JOIN students s ON e.student_id = s.id
JOIN courses c ON e.course_id = c.id;
SELECT c.name, AVG(e.grade) AS avg_grade
FROM enrollments e
JOIN courses c ON e.course_id = c.id
GROUP BY c.name;
SELECT s.name, AVG(e.grade) AS overall_avg
FROM enrollments e
JOIN students s ON e.student_id = s.id
GROUP BY s.name
ORDER BY overall_avg DESC
LIMIT 3;
SELECT COUNT(DISTINCT student_id) AS failed_count
FROM enrollments
WHERE grade < 40;