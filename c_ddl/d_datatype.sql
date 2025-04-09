# 날짜형, 열거형 데이터 타입

/*
	5. 날짜형
    : 날짜 및 시간을 저장할 때 사용
    
    a) DATE (3byte)
		: 날짜만 저장 / YYYY-MM-DD 형식
        EX) 기념일, 생일 등
    
    b) TIME (3byte)
		: 시간만 저장 / HH:mm:SS 형식
        EX) 수업 시간, 타이머 등
    
    c) DATETIME 8(byte)
		: 날짜와 시간을 저장 / YYYY-MM-DD HH:mm:SS 형식
        EX) 주문 시간 / 가입 일자 등
*/

CREATE DATABASE IF NOT EXISTS `example`;
USE `example`;

CREATE TABLE `events` (
	event_name VARCHAR(100),
    event_date DATE
);

INSERT INTO `events` VALUES ('Birthday', '2024-03-14');

SELECT * FROM `events`;

/*
	6. 열거형 타입(enum)
    : 사전에 정의된 값의 집합 중 하나의 값을 저장
    - 제한된 값 목록 중 선택
*/

CREATE TABLE rainbow (
	color ENUM('red', 'orange', 'yellow', 'purple'),
    description VARCHAR(100)
);

INSERT INTO `rainbow` VALUES ('red', '빨강'), ('orange', '주황'), ('yellow', '노랑'), ('purple', '보라');

# Error Code: 1265. Data truncated for column 'color' at row 1	0.00071 sec
# INSERT INTO `rainbow` VALUES ('green', '초록'); 

