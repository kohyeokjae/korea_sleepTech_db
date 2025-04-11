/*
	=== ddl: 데이터 정의 언어 ===
    >> DB와 테이블의 구조를 생성, 수정, 삭제
    
    1. create(생성)
    2. alter(수정)
    3. drop(삭제 - 구조체)
    4. truncate(삭제 - 내부 데이터)
    
    +) use 데이터베이스명: DB를 지정하는 키워드
       desc(describe) 테이블명: 테이블 구조 조회
       show DB명: DB 목록 조회
       if exists / if not exists: 존재할 경우 실행 / 존재하지 않을 경우 실행
       
	=== 데이터 타입 ===
    : 정수형, 문자형, 실수형, 논리형, 열거형, 날짜형 등
*/

### 예제 실습: 야구 팀 관리 데이터를 저장하는 DB ###
CREATE DATABASE `baseball_league`;

USE `baseball_league`;

# 테이블 생성
CREATE TABLE `teams` (
	# 컬럼명 데이터 타입 옵션
    team_id INT, -- 팀 고유 번호
    name VARCHAR(100), -- 팀 이름
    city VARCHAR(100), -- 연고지
    founded_year YEAR -- 날짜(date) 중 연도 데이터만 저장하는 타임 'YYYY'
);

# cf) 세미콜론, 콤마 등 기호의 영향을 많이 받음
#	  >> 각 컬럼, 데이터 사이에 반드시 ,(콤마) 지정
#     >> 제일 마지막 컬럼, 데이터 뒤에는 ,(콤마) 사용 X

CREATE TABLE IF NOT EXISTS `players` (
	player_id INT, -- 선수 고유 번호
    name VARCHAR(100), -- 선수 이름
    position ENUM('타자', '투수', '내야수', '외야수') -- 선수 포지션
);

# 각 테이블 구조 확인 #
DESCRIBE `teams`;
DESC `players`;

# 테이블 구조 수정
# ALTER TABLE 테이블명 [ADD | MODIFY | DROP] (COLUMN) 컬럼명 데이터타입;
ALTER TABLE `players` ADD birth_date DATE;

DESC `players`;

DROP TABLE IF EXISTS `games`;
DROP TABLE IF EXISTS `players`;

DROP DATABASE `baseball_league`;




