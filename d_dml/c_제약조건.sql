CREATE DATABASE `example`;

USE `example`;

/*
	4. Check 제약 조건
    : 입력되는 데이터를 점검하는 기능
    - 테이블의 열에 대해 특정 조건을 설정, 조건을 만족하지 않는 경우 입력을 막음
*/
CREATE TABLE `employees` (
	id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT(100)
    # Check 제약 조건 사용 방법
    # Check (조건 작성 - 조건식은 다양한 연산자 사용)
    CHECK (age >= 20)
);

INSERT INTO `employees` VALUES (1, '홍길동', 20);
INSERT INTO `employees` VALUES (2, '홍길동', 19);
INSERT INTO `employees` VALUES (3, null, 30);

SELECT * FROM `employees`;

/*
	5. Not Null 제약 조건
    : 특정 열에 null 값을 혀용하지 X
    : 비워질 수 없음
*/

CREATE TABLE `contacts` (
	contact_id INT PRIMARY KEY, -- PK값은 not null 지정하지 않아도 자동 not null
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(100) NOT NULL
); 

# INSERT INTO `contacts` VALUES (1, '홍길동', '1234'), (2, '고길동', null); 

/*
	6. default 제약 조건
    : 테이블의 열에 값이 명시적으로 제공되지 않는 경우 사용되는 기본 값
    - 선택적 필드에 대해 데이터 입력을 단순화 - 데이터 무결성 유지
*/

CREATE TABLE `cart` (
	cart_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    -- default 제약 조건
    -- 컬럼명 데이터타입 default 기본 값(데이터타입을 지켜야 함)
    quantity INT DEFAULT 1
);

INSERT INTO `cart` 
VALUES 
	(1, '노트북', 3), 
	(2, '스마트폰', null), # null 값 입력 시 null 값이 지정 (기본 값 설정 X)
	(3, '테블릿', 2);

SELECT * FROM `cart`;

INSERT INTO `cart` (cart_id, product_name) VALUES(4, '아이폰');

SELECT * FROM `cart`;

# cf) 제약 조건 사용 시 여러 개 동시 지정 가능
# EX) not null + check
CREATE TABLE `multiple` (
	multiple_col INT NOT NULL CHECK(multiple_col > 10)
);

INSERT INTO `multiple` VALUES (11);

DROP DATABASE IF EXISTS `example`;