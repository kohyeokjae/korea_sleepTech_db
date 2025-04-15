### 제3정규형 (3NF: 3 normal form) ###
# : 정규화의 세 번재 단계
# : 2NF(제2정규형)을 만족하는 테이블에서, 모든 비기본 속성이 기본키에만 함수적으로 종속
# - 이행적 종속성을 제거

# cf) 이행적 종속성
# : 어떤 속성 A가 다른 속성 B에 종속되고
#   , B가 또 다른 속성 C에 종속된 경우
# >> A가 C에 이행적으로 종속됨

# 제3정규형은 '이행적 종속성'을 제거

/*
	학번 / 이름 / 학과ID / 학과명 / 학과위치
    1    홍길동   101     컴공     부산 
    
    - 기본키(PK): 학번
    - 비기본 속성: 이름, 학과ID, 학과명, 학과위치
    
    학번 > 학과ID (학생이 소속한 학과)
    학과ID > 학과명, 학과위치 (학과ID로 학과정보 확인 가능)
	
    : 학번 > 학과명, 학과위치 - 직접적이지 않음
    : 학번 > 학과ID > 학과명, 학과 위치 (이행적 종속성 존재)
    
    >> 분리하여 데이터 중복과 이상 현상을 방지
*/

# 제3정규형 예시 #
drop table if exists students_3;
drop table if exists departments_3;

CREATE TABLE departments_3 (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100),
    location VARCHAR(100)
);

CREATE TABLE students_3 (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT, -- 학과 ID만 저장 (학과 정보가 생략)
    FOREIGN KEY (department_id)
        REFERENCES departments_3 (department_id)
);

-- 정보 입력
insert into departments_3
values 
	(101, '컴공', '서울'),
	(103, '전자공학', '부산');
    
insert into students_3
values 
	(1, '홍길동', 101),
	(2, '고길동', 103),
	(3, '구길동', 101);
    
# 학생 번호 > 강의 ID
# 강의 ID > 강의 위치 
# : 하나의 테이블에서 A > B > C의 이행적 종속성을 분리하여
# A > B
# B > C 로 구조화
# - 학생의 정보에서 조인을 통해 강의 위치를 확인

SELECT * FROM departments_3;

SELECT 
    S.student_id, S.name, D.department_name, D.location
FROM
    students_3 S
        JOIN
    departments_3 D ON S.department_id = D.department_id;
    
#### 서로 다른 종류의 정보를 따로 담아야 안점함 ####