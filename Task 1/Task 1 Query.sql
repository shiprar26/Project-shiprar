--1. Database Creation:
--a) Create the StudentInfo table with columns STU_ ID, STU_NAME, DOB, PHONE_NO,EMAIL_ID,ADDRESS.

CREATE TABLE StudentInfo (
    STU_ID INT PRIMARY KEY,
    STU_NAME VARCHAR(100),
    DOB DATE,
    PHONE_NO VARCHAR(15),
    EMAIL_ID VARCHAR(100),
    ADDRESS VARCHAR(255)
);

--b Create the CoursesInfo table with columns COURSE_ID,COURSE_NAME,COURSE_INSTRUCTOR NAME
CREATE TABLE CoursesInfo (
    COURSE_ID INT PRIMARY KEY,
    COURSE_NAME VARCHAR(100),
    COURSE_INSTRUCTOR_NAME VARCHAR(100)
);

/*c) Create the EnrollmentInfo with columns ENROLLMENT_ID, STU_ ID, COURSE_ID,
ENROLL_STATUS(Enrolled/Not Enrolled). The FOREIGN KEY constraint in the EnrollmentInfo
table references the STU_ID column in the StudentInfo table and the COURSE_ID column in the
CoursesInfo table*/

CREATE TABLE EnrollmentInfo (
    ENROLLMENT_ID INT PRIMARY KEY,
    STU_ID INT,
    COURSE_ID INT,
    ENROLL_STATUS VARCHAR(20),
    FOREIGN KEY (STU_ID) REFERENCES StudentInfo(STU_ID),
    FOREIGN KEY (COURSE_ID) REFERENCES CoursesInfo(COURSE_ID)
);

--2. Data Creation
/*Insert some sample data for StudentInfo table , CoursesInfo table, EnrollmentInfo with
respective fields.*/
INSERT INTO StudentInfo (STU_ID, STU_NAME, DOB, PHONE_NO, EMAIL_ID, ADDRESS)
VALUES 
(1, 'John Doe', '2000-01-15', '1234567890', 'john.doe@example.com', '123 Main St'),
(2, 'Jane Smith', '1999-05-20', '0987654321', 'jane.smith@example.com', '456 Elm St');

INSERT INTO CoursesInfo (COURSE_ID, COURSE_NAME, COURSE_INSTRUCTOR_NAME)
VALUES 
(101, 'Database Systems', 'Dr. Alan Turing'),
(102, 'Algorithms', 'Dr. Ada Lovelace');

INSERT INTO EnrollmentInfo (ENROLLMENT_ID, STU_ID, COURSE_ID, ENROLL_STATUS)
VALUES 
(1001, 1, 101, 'Enrolled'),
(1002, 2, 102, 'Enrolled'),
(1003, 1, 102, 'Enrolled');

--3) Retrieve the Student Information
/*a) Write a query to retrieve student details, such as student name, contact informations, and
Enrollment status.*/
SELECT STU_NAME, PHONE_NO, EMAIL_ID, ENROLL_STATUS
FROM StudentInfo
JOIN EnrollmentInfo ON StudentInfo.STU_ID = EnrollmentInfo.STU_ID;

/*b) Write a query to retrieve a list of courses in which a specific student is enrolled.*/
SELECT COURSE_NAME
FROM CoursesInfo
JOIN EnrollmentInfo ON CoursesInfo.COURSE_ID = EnrollmentInfo.COURSE_ID
WHERE EnrollmentInfo.STU_ID = 1;

--c) Write a query to retrieve course information, including course name, instructor information
SELECT COURSE_NAME, COURSE_INSTRUCTOR_NAME
FROM CoursesInfo;

--d) Write a query to retrieve course information for a specific course .
SELECT COURSE_NAME, COURSE_INSTRUCTOR_NAME
FROM CoursesInfo
WHERE COURSE_ID = 101;

--e) Write a query to retrieve course information for multiple courses
SELECT COURSE_NAME, COURSE_INSTRUCTOR_NAME
FROM CoursesInfo
WHERE COURSE_ID IN (101, 102);

/*f) Test the queries to ensure accurate retrieval of student information.( execute the queries and
verify the results against the expected output - executed and output are as matching)*/

--4. Reporting and Analytics (Using joining queries
--a) Write a query to retrieve the number of students enrolled in each course
SELECT COURSE_NAME, COUNT(*) AS NumberOfStudents
FROM CoursesInfo
JOIN EnrollmentInfo ON CoursesInfo.COURSE_ID = EnrollmentInfo.COURSE_ID
GROUP BY COURSE_NAME;

--b) Write a query to retrieve the list of students enrolled in a specific course
SELECT STU_NAME
FROM StudentInfo
JOIN EnrollmentInfo ON StudentInfo.STU_ID = EnrollmentInfo.STU_ID
WHERE COURSE_ID = 101; 

--c) Write a query to retrieve the count of enrolled students for each instructor
SELECT COURSE_INSTRUCTOR_NAME, COUNT(*) AS NumberOfStudents
FROM CoursesInfo
JOIN EnrollmentInfo ON CoursesInfo.COURSE_ID = EnrollmentInfo.COURSE_ID
GROUP BY COURSE_INSTRUCTOR_NAME;

--d) Write a query to retrieve the list of students who are enrolled in multiple courses
SELECT STU_NAME
FROM StudentInfo
JOIN EnrollmentInfo ON StudentInfo.STU_ID = EnrollmentInfo.STU_ID
GROUP BY STU_NAME
HAVING COUNT(DISTINCT COURSE_ID) > 1;

/*e) Write a query to retrieve the courses that have the highest number of enrolled
students(arranging from highest to lowest)*/
SELECT COURSE_NAME, COUNT(*) AS NumberOfStudents
FROM CoursesInfo
JOIN EnrollmentInfo ON CoursesInfo.COURSE_ID = EnrollmentInfo.COURSE_ID
GROUP BY COURSE_NAME
ORDER BY NumberOfStudents DESC;




