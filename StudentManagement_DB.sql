CREATE DATABASE StudentManagement;

CREATE TABLE Students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    contact VARCHAR(15)
);

CREATE TABLE Courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    duration INT NOT NULL,  -- Duration in weeks
    credits INT NOT NULL
);

CREATE TABLE Enrollments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enroll_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES Students(id),
    FOREIGN KEY (course_id) REFERENCES Courses(id)
);

CREATE TABLE Grades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    grade CHAR(1) CHECK (grade IN ('A', 'B', 'C', 'D', 'F')),
    FOREIGN KEY (student_id) REFERENCES Students(id),
    FOREIGN KEY (course_id) REFERENCES Courses(id)
);


INSERT INTO Students (name, dob, email, contact)
VALUES 
('Alice', '2000-05-15', 'alice@example.com', '1234567890'),
('Bob', '1998-07-20', 'bob@example.com', '9876543210'),
('Charlie', '1999-08-10', 'charlie@example.com', '5678901234'),
('Diana', '2001-02-14', 'diana@example.com', '4567890123'),
('Eve', '1997-11-30', 'eve@example.com', '6789012345'),
('Frank', '2000-01-25', 'frank@example.com', '7890123456'),
('Grace', '2002-03-12', 'grace@example.com', '8901234567'),
('Hank', '1998-12-05', 'hank@example.com', '9012345678'),
('Ivy', '1999-07-07', 'ivy@example.com', '2345678901'),
('Jack', '2001-09-21', 'jack@example.com', '3456789012');

INSERT INTO Courses (name, duration, credits)
VALUES 
('Mathematics', 12, 3),
('Physics', 10, 4),
('Chemistry', 8, 3),
('Biology', 14, 4),
('Computer Science', 16, 5),
('History', 6, 2),
('Economics', 10, 3),
('English Literature', 8, 3),
('Philosophy', 12, 3),
('Art and Design', 14, 4),
('Statistics', 10, 4);

INSERT INTO Enrollments (student_id, course_id)
VALUES 
(1, 1),  -- Alice -> Mathematics
(2, 2),  -- Bob -> Physics
(1, 3),  -- Alice -> Chemistry
(2, 4),  -- Bob -> Biology
(3, 1),  -- Charlie -> Mathematics
(3, 5),  -- Charlie -> Computer Science
(4, 2),  -- Diana -> Physics
(4, 6),  -- Diana -> History
(5, 7),  -- Eve -> Economics
(6, 8),  -- Frank -> English Literature
(7, 9),  -- Grace -> Philosophy
(8, 10), -- Hank -> Art and Design
(9, 11), -- Ivy -> Statistics
(10, 5), -- Jack -> Computer Science
(10, 4); -- Jack -> Biology

INSERT INTO Grades (student_id, course_id, grade)
VALUES 
(1, 1, 'A'),  -- Alice -> Mathematics
(2, 2, 'B'),  -- Bob -> Physics
(1, 3, 'B+'),  -- Alice -> Chemistry
(2, 4, 'A-'),  -- Bob -> Biology
(3, 1, 'C'),  -- Charlie -> Mathematics
(3, 5, 'B'),  -- Charlie -> Computer Science
(4, 2, 'A'),  -- Diana -> Physics
(4, 6, 'C+'),  -- Diana -> History
(5, 7, 'B-'),  -- Eve -> Economics
(6, 8, 'A+'),  -- Frank -> English Literature
(7, 9, 'B+'),  -- Grace -> Philosophy
(8, 10, 'C'),  -- Hank -> Art and Design
(9, 11, 'A'),  -- Ivy -> Statistics
(10, 5, 'B+'),  -- Jack -> Computer Science
(10, 4, 'A-');  -- Jack -> Biology

DESCRIBE Grades;

ALTER TABLE Grades MODIFY grade VARCHAR(3);

ALTER TABLE Grades DROP CONSTRAINT grades_chk_1;

select * from Students;

select * from courses;

select * from enrollments;

select * from grades;

SELECT s.name AS student_name, c.name AS course_name, e.enroll_date
FROM Enrollments e
JOIN Students s ON e.student_id = s.id
JOIN Courses c ON e.course_id = c.id;

SELECT s.name AS student_name, c.name AS course_name, g.grade
FROM Grades g
JOIN Students s ON g.student_id = s.id
JOIN Courses c ON g.course_id = c.id
WHERE s.id = 1;

SELECT c.name AS course_name, AVG(CASE 
    WHEN g.grade = 'A' THEN 4
    WHEN g.grade = 'A-' THEN 3.7
    WHEN g.grade = 'B+' THEN 3.3
    WHEN g.grade = 'B' THEN 3
    WHEN g.grade = 'B-' THEN 2.7
    WHEN g.grade = 'C+' THEN 2.3
    WHEN g.grade = 'C' THEN 2
    WHEN g.grade = 'C-' THEN 1.7
    WHEN g.grade = 'D' THEN 1
    WHEN g.grade = 'F' THEN 0
    ELSE 0 END) AS avg_grade
FROM Grades g
JOIN Courses c ON g.course_id = c.id
WHERE c.id = 1;


