# --- 데이터베이스 ---
# 1. 생성(CREATE)
CREATE DATABASE IF NOT EXISTS database_name;
CREATE DATABASE IF NOT EXISTS example;

# cf) if not exists 옵션
# : 데이터베이스의 유무를 확인하고 오류를 방지하는 SQL문
#   , 존재하지 않을 때만 새로 생성

# 2. 데이터베이스 선택(use)
# : 데이터베이스 선택 시 이후 모든 SQL 명령어가 선택된 DB 내에서 실행 
# - GUI로 Navigator의 스키마명 더블 클리과 동일

# - GUI(Graphical User Interface): 사용자가 컴퓨터와 상호작용 할 수 있도록 하는 시작적 인터페이스

USE database_name;
USE example;

# 3. 삭제(drop)
# : 데이터베이스 삭제, 해당 작업은 실행 후 되돌리 수 X
DROP DATABASE database_name;

# 4. 데이터베이스 목록 조회
# : 해당 SQL 서버에 존재하는 모든 데이터베이스(스키마) 목록을 확인
SHOW DATABASES;

# --- 테이블 ---
# 1. 테이블 생성 (CREATE TABLE)
USE example;

CREATE TABLE students ( 
	# 테이블 생성 시 DB명이 필수 X
    # USE 명령어를 통해 DB 지정이 되어 있는 경우 생략 가능
    # >> 오류 방지를 위해 작성을 권장
    student_id int PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    major VARCHAR(100)
);

# 2. 테이블 구조 조회 (DESCRIBE, DESC)
# : 정의된 컬럼, 데이터 타입, 키 정보(제약 조건) 등을 조회
# : DESCRIBE 테이블명;
# : DESC 테이블명;

# cf) DESC(descending): 내림차

DESCRIBE students;
DESC students;

# cf) 테이블의 구조
# Field: 각 컬럼의 이름
# Type: 각 컬럼의 데이터 타입
# Null: Null(데이터 생략, 비워짐) 허용 여부
# Key: 각 컬럼의 제약 사항
# Default: 기본값 지정
# Extra: 제약 사항 - 추가 옵션

# --- 테이블 수정 ---
# ALTER TABLE
# : 이미 존재하는 테이블의 구조를 변경하는데 사용
# - 컬럼 또는 제약조건을 추가, 수정, 삭제

# 1) 컬럼
### 컬럼 추가(ADD) ###
# ALTER TABLE 테이블명 ADD COLUMN 컬럼명 데이터타입 기타사항;
ALTER TABLE `students` ADD COLUMN email VARCHAR(255);

DESC students;

### 컬럼 수정(modify) ###
# ALTER TABLE 테이블명 MODIFY COLUMN 컬럼명 새로운 컬럼_데이터타입;
ALTER TABLE `students` MODIFY COLUMN email VARCHAR(100);

DESC students;

### 컬럼 삭제(DROP) ###
# ALTER TABLE 테이블명 DROP COLUMN 컬럼명;
ALTER TABLE `students` DROP email;

# cf) 테이블 수정 시 COLUMN 키워드 생략 가능 (ADD, MODIFY, DROP 만 작성 가능)

# --- 테이블 데이터 삭제(초기화) ---
# TRUNCATE
# : 테이블의 모든 데이터를 삭제하고 초기 상태로 되돌림
# - DB, 테이블의 구조는 삭제되지 X

TRUNCATE TABLE students;

SELECT * FROM `students`; # 테이블 조회

# cf) DROP: 전체 구조물을 삭제

# --- IF EXISTS / IF NOT EXISTS ---
# : 선택적 키워드, 테이블이 존재하거나 존재하지 않을 때만 실행
# - 오류 방지 키워드

DROP TABLE IF EXISTS `example`;
DROP TABLE students;








