### 제약 조건 (Constraint) ###
# 1. 제약 조건
# : 데이터의 정확성, 일관성, 신뢰성, 무결성을 유지하기 위해
#   DB 시스템을 활용하여 강제하는 규칙

# 2. 제약 조건 사용 목적
# - 데이터 무결성 보장
# - 오류 방지
# - 관계 유지 (테이블 간의 관계 정의)

# 3. 제약 조건의 종류
# 1) Primary Key (기본 키)
# 2) Foreign Key (외래 키)
# 3) Unique
# 4) Check
# 5) NOT NULL
# 6) Default

/*
	1. PK (primary Key, 기본 키)
    : 테이블의 각 행을 고유하게 식별하는 열
    : 테이블의 레코드(행)를 고유하게 구분할 수 있는 식별자 역할
    
    - 고유성: 중복될 수 X
    - NOT NULL: null 값이 될 수 X (반드시 유요한 데이터를 포함)
    
    cf) 유일성 제약: 하나의 테이블 당 하나의 기본 키만 지정 가능
		>> 테이블의 특성을 가장 잘 반영한 열 선택을 권장
			EX) members 테이블(member_id), books 테이블(isbn | book_id)과 같이
				PK 컬럼을 따로 생성 권장
*/

DROP DATABASE IF EXISTS `example`;

CREATE DATABASE `example`;

use `example`;

# 기본 키 지정 방법
# 테이블 생성 시
# 1) 컬럼명 데이터타입 Primary Key
CREATE TABLE `students` (
	student_id INT PRIMARY KEY,
    name VARCHAR(100),
    major VARCHAR(100)
);

# 2) 테이블 생성 마지막 부분에 제약 조건 작성
-- CREATE TABLE `students` (
--     student_id INT,
--     name VARCHAR(100),
--     major VARCHAR(100),
--     # 제약 조건 (설정할 컬럼명)
--     PRIMARY KEY (student_id)
-- );

DESC `students`;

# 데이터 삽입 
INSERT INTO `students` VALUES (1, '홍길동', 'A전공'); 
INSERT INTO `students` VALUES (2, '홍길동', 'B전공'); 
INSERT INTO `students` VALUES (3, '고길동', 'A전공'); 

INSERT INTO `students` VALUES (1, '구길동', 'C전공');

SELECT * FROM `students`;

# 제약 조건 수정 (ALTER)
# : 테이블 구조의 제약 조건 수정: ddl 문법

# 1) '기존 테이블의' 제약 조건 삭제
# : 기본 키 제약 조건 삭제 시 not null에 대한 조건은 사라지지 않음
ALTER TABLE `students` DROP PRIMARY KEY;

DESC `students`;

# 2) '기본 테이블의' 제약 조건 추가
ALTER TABLE `students` ADD PRIMARY KEY (student_id);

DESC `students`;

/*
	2. FK (Foreign Key, 외래 키, 참조 키)
    : 두 테이블 사이의 관계를 연결, 데이터의 무결성을 유지
    : 외래 키가 설정된 열은 반드시 다른 테이블의 기본 키(PK)와 연결
    
    - 기본 테이블(기본 키가 있는 테이블)
    - 참조 테이블(외래 키가 있는 테이블)
*/

# 외래 키 사용 예시: 회원(Members) - 주문(Orders)
# >> 고객이 실제로 존재하는 지 확인, 고객과 주문 간의 관계를 명시

CREATE TABLE `members` (
	member_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE `orders` (
	order_id INT PRIMARY KEY, -- 주문 번호
    order_date DATE, -- 주문 날짜
    member_id INT, -- 주문자 정보
    # 외래 키 지정 방식
    # FOREIGN KEY (참조 컬럼, 해당 테이블의 컬럼) references 기본테이블(기본 컬럼)
    FOREIGN KEY (member_id) REFERENCES `members` (member_id)
);

# 유효하지 않은 고객 참조 시도 (오류)
# INSERT INTO `orders` VALUES (1, '2025-04-11', 123);

# 고개 데이터 입력
INSERT INTO `members` VALUES (123, '홍길동');

# 유효한 고개 참조 시도
INSERT INTO `orders` VALUES (1, '2025-04-11', 123);

# Error Code: 1452. Cannot add or update a child row
# : a foreign key constraint fails (`example`.`orders`, CONSTRAINT `orders_ibfk_1` 
# FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`))

### 외래 키 제약 조건 수정(삭제 & 추가) ###
# cf) 외래 키 제약 조건 삭제 시 주의점
# 	  - 해당 데이터를 참조하는 데이터가 있을 경우 삭제 불가!
TRUNCATE TABLE `orders`;
SELECT * FROM `orders`;

#     - 제약 조건 이름 검색이 필수

# 외래 키 제약 조건 이름 확인
SELECT 
    `constraint_name`
FROM
    information_schema.key_column_usage
# where 조건 내에서 테이블명과 컬럼명을 테이터처럼 사용: 따옴표 지정
WHERE
    table_name = 'orders'
        AND column_name = 'member_id';

# >>> 'orders_ibfk_1'

# 1) '기본 테이블의' 외래 키 삭제
ALTER TABLE `orders` DROP FOREIGN KEY `orders_ibfk_1`;

DESC `orders`;

# 2) '기존 테이블의' 외래 키 제약 조건 추가
ALTER TABLE `orders` ADD CONSTRAINT FOREIGN KEY (member_id) REFERENCES members(member_id);

DESC `orders`;
DESC `members`;

/*
	3. Unique
    : 특정 열에 대해 모든 값이 고유해야 함을 보장
    : 한 테이블 내에서 여러 개 지정 가능 (각각 다른 컬럼에 독립적으로 적용 가능)
    - Null 값 허홍 (cf. PK는 Unique + Not Null + 한 테이블에 하나만)
*/

CREATE TABLE `users` (
    user_id INT PRIMARY KEY,
    user_email VARCHAR(100) UNIQUE,
    user_number VARCHAR(100) UNIQUE
);

# INSERT INTO `users` VALUES (1, '홍길동', 'qwe123') (2, '고길동', 'qwe123');