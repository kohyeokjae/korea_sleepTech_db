CREATE DATABASE `school_db`;

USE `school_db`;

### 테이블 간 관계 ###
# 1. 교수-강의(1:N, 일대다)
# : 한 명의 교소는 여러 강의를 담당
# : 강의 테이블에 담당교수ID 존재 - FK 참조값
# - ERD 선: 점선(비식별 관계)
#   >> 교수ID가 FK로만 사용 (PK X)

# 2.  학생-수강내역-강의 관계 (N:M, 다대다)
# : 학생은 여러 강의를 수강할 수 있고
# : 한 강의는 여러 학생이 수강할 수 있음
# >> 다대다(N:M)관계는 RDB에서 직접적인 표현이 불가
#    : 중간 테이블로 해결
# - 다대다(N:M)관계는 두 개의 1:N 관계로 분해
    # 학생 - 수강 내역 (1:N)
    # 강의 - 수강 내역 (1:N)

CREATE TABLE students (
    std_id INT PRIMARY KEY,
    name VARCHAR(100),
    major VARCHAR(255),
    year YEAR
);

CREATE TABLE professors (
    pro_id INT PRIMARY KEY,
    name VARCHAR(100),
    major VARCHAR(255),
    office VARCHAR(100)
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    name VARCHAR(100),
    pro_id INT,
    std_num INT,
    FOREIGN KEY (pro_id)
        REFERENCES `professors` (pro_id)
);

CREATE TABLE enrollments (
    en_id INT PRIMARY KEY,
    std_id INT,
    course_id INT,
    year YEAR,
    term INT,
    FOREIGN KEY (std_id)
        REFERENCES `students` (std_id),
    FOREIGN KEY (course_id)
        REFERENCES `courses` (course_id)
);

/*
전공이 컴퓨터 과학인 학생들의 이름과 입학년도를 조회하는 SQL 명령문을 작성
담당 교수 ID가 2인 강의의 강의명과 학점 수를 조회하는 SQL 명령문을 작성
2023년도 1학기에 수강하는 학생들의 목록을 조회하는 SQL 명령문을 작성 (학생 ID와 이름을 포함)
*/ 

SELECT 
    name, year
FROM
    students
WHERE
    major = 'Computer Science';

SELECT 
    name, std_num
FROM
    courses
WHERE
    pro_id = 2;

SELECT 
    s.std_id, s.name
FROM
    students s
        JOIN
    enrollments e ON s.std_id = e.std_id
WHERE
    e.year = 2023 AND term = 1;

