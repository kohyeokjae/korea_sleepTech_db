# cf) ddl (definition 정의) - DB 정의 언어
# : Create 생성 / Alter 수정 / Drop 삭제 / Truncate 데이터 삭제

### DML (Data Manipulation 조작 language) - 데이터 조작(관리) 언어
# : 데이터를 삽입, 조회, 수정, 삭제 (CRUD)

CREATE DATABASE `company`;

USE `company`;

CREATE TABLE `example01` (
	name VARCHAR(100),
    age INT,
    major VARCHAR(100)
);

/*
	1. 데이터 삽입 (insert)
    : 테이블에 행 데이터(레코드)를 입력하는 키워드
    
    # 기본 형식
    INSERT INTO 테이블명 (열1, 열2, ...) VALUES (값1, 값2, ...);
    
    cf) 열 이름 나열을 생략할 경우 VALUES 뒤에 값 순서는 
		, 테이블 정의 시 지정한 열의 순서 & 개수와 동일
        >> name, age, major 순
        
	cf) 전체 테이블의 컬럼의 순서 & 개수와 차이가 나는 경우 반드시 열 이름 나열
*/

# 1) 컬럼명 지정 X
INSERT INTO `example01` VALUES ('홍길도', 32, '조선');

# Error Code: 1366. Incorrect integer value: '조선' for column 'age' at row 1
# INSERT INTO `example01` VALUES ('고길동', '조선', 34);

# 2) 컬럼명 지정 O
INSERT INTO `example01` (major, name, age) VALUES ('조선', '고길동', 23);

# cf) 데이터 삽입 시 데이터 값 입력을 하지 않을 경우
# - Null 허용: 자동 Null값 지정
# - Not Null 지정: 오류!

# cf) auto_increment
# : 열을 정의할 대 1부터 1씩 증가하는 값을 입력
# - insert에서는 해당 열이 없다고 가정하고 입력
# - 해당 옵션이 지정된 컬럼은 반드시 PK로 지정 (하나의 테이블에 auto_increment을 한 번만 지정 가능)

CREATE TABLE `example02` (
	-- 컬럼명 데이터타입 PRIMARY KEY AUTO_INCREMENT // 옵션 순서는 상관 X
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
); 

INSERT INTO `example02` (name) values ('홍길동'), ('고길동'), ('구길동');

SELECT * FROM `example02`;

INSERT INTO `example02` VALUES (null, '훙길동');

SELECT * FROM `example02`;

# cf) auto_increment 최대값 확인
# SELECT MAX(auto_increment컬럼영) FROM `테이블명`;
SELECT MAX(id) FROM `example02`;

# cf) 시작 값 변경
ALTER TABLE `example02` AUTO_INCREMENT=100; # 테이블 생성 시 작성 가능

INSERT INTO `example02` VALUES (null, '길동홍');

SELECT * FROM `example02`;

# cf) 다른 테이블의 테이터를 한 번에 삽입하는 구문
# INSERT INTO `삽입받을 테이블`
# SELECT ~~~
# >> 조회한 데이터를 INSERT로 삽입

CREATE TABLE `example03` (
	id INT,
    name VARCHAR(100)
);

# 컬럼의 순서, 개수, 자료형이 반드시 일치해야 함
INSERT INTO `example03` SELECT * FROM `example02`; 

SELECT * FROM `example03`;

/*
	2. 데이터 수정(update)
    : 테이블의 내용을 수정
    
    # 기본 형태
    update `테이블명` 
    set 열1=값1, 열2=값2, ....
    (where 조건);
    
    cf) where 조건이 없는 경우
        , 해당 열(컬럼)의 데이터는 해당 값으로 모두 변경
*/

UPDATE `example02` SET name='동길홍';

# safe update mode를 해제하는 코드
SET sql_safe_updates=0; # 1: 해제

UPDATE `example02` set name='홍길동' WHERE id=1;

SELECT * FROM `example02`;

# cf) 여러 컬럼의 값을 한번에 설정하는 경우 콤마(,)로 분리하여 나열

/*
	3. 데이터 삭제: delete
	: 테이블의 데이터를 삭제하기 위한 키워드
    
    # 기본 형태
    DELETE FROM `테이블명` WHERE 조건;
*/

SELECT * FROM `example02`;

# DELETE FROM `example02`;
# You are using safe update mode and you tried to update a table without a WHERE 
# "that uses a KEY column."
# >> 엄격모드에서는 Key(PK)값을 사용해야만 레코드 삭제 가능
DELETE FROM `example02` WHERE name='홍길동'
