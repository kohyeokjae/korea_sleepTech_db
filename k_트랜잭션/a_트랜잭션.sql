### 1. 트랜잭션(transaction - 처리) ###
# : DB에서 하나의 논리적인 작업 단위를 의미
# : 여러 개의 작업(명령어)이 한 번에 처리되어야 할 때 사용
# - 중간에 하나라도 실패하면 '전체 작업을 취소(Rollback)'
# - 모든 작업이 '문제없이 완료되면 확정(Commit)'

/*
	은행에서 A가 B에게 돈을 보낼 때
    A 계좌에서 출금 + B 계좌에 입금하는 두 작업은 함께 처리
    >> 하나는 성공하고 하나는 실패하면 돈이 사라지거나 두 번 생기는 문제 발생
*/

### 2. 트랜잭션의 특징(ACID) ###
# Atomicity(원자성): 모두 성공하거나 모두 실패 (ALL OR Nothing)
# Consistency(일관성): 실행 전과 실행 후, 데이터의 일관성이 유지 (DB의 상태가 변경 X)
# Isolation(독립성): 동시에 여러 개의 트랜잭션이 실행되어도, 서로 간섭하지 않아야 함
# Durability(지속성): 트랜잭션이 성공하면, 그 결과는 영구적으로 보존(트랜잭션 완료 후 시스템 오류 시 결과 보존)

### 3. 트랜잭션 실행 흐름 ###
# 1) 트랜잭션 시작: START, TRANSACTION
# 2) SQL 실행(작업 실행): 여러 SQL 명령어를 통해 트랜잭션 내에서 실행(INSERT, UPDATE 등)
# 3) 성공하면 커밋: 모든 작업이 성공적으로 완료되면, DB에 변경 사항을 확정(COMMIT)
# 4) 실패하면 롤백: 작업 중 오류 발생 | 작업을 취소하고 싶을 때(ROLLBACK)
#    >> 트랜잭션 시작 전 상태로 되돌림

/*
	start transaction;
    
    # 해당 블럭 내의 명령어들은 '하나의 명령어처럼 처리'
    # >> 성공 OR 실패 둘 중 하나의 결과만 반환
    update account set balance = balance - 1000 where account_id = 'A';
    update account set balance = balance - 1000 where account_id = 'B';
    
    commit;
    
	cf) SAVEPOINT: 트랜잭션 내에서 특정 지점을 저장하여 해당 지점으로 롤백
		SAVEPOINT 이름
			>> 되돌릴 수 있는 지점을 저장
		ROLLBACK TO SAVEPOINT 이름
			>> 지정한 지점으로 롤백
*/

DROP DATABASE IF EXISTS `트랜잭션`;
CREATE DATABASE `트랜잭션`;
USE `트랜잭션`;

CREATE TABLE `members` (
    member_id INT PRIMARY KEY,
    member_name VARCHAR(50),
    member_age INT
);

CREATE TABLE `purchases` (
    purchase_id INT PRIMARY KEY,
    member_id INT,
    product_name VARCHAR(100),
    price INT,
    FOREIGN KEY (member_id)
        REFERENCES members (member_id)
);

SELECT @@autocommit; # 1: 자동 커밋이 활성화된 상태
# >> 트랜잭션이 자동으로 COMMIT (무조건 성공)

SET autocommit = 0; # 트랜잭션 수동 처리

-- 트랜재션 시작 --
START TRANSACTION;

# 이후 SQL문은 하나의 명령문으로 처리
INSERT INTO members VALUES (5, '홍길동', 30);

INSERT INTO purchases VALUES (4, 999, '노트북', 200); # 외래키 제약 조건 오류

COMMIT; # 예외가 없으면 변경 사항을 저장

SELECT * FROM members;
SELECT * FROM purchases;

### 
CREATE TABLE `accounts` (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    account_holder VARCHAR(50),
    balance INT UNSIGNED
);

CREATE TABLE transaction_log (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    from_account_id INT,
    to_account_id INT,
    amount INT,
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (from_account_id)
        REFERENCES accounts (account_id),
    FOREIGN KEY (to_account_id)
        REFERENCES accounts (account_id)
);

INSERT INTO accounts (account_holder, balance) 
VALUES 
	('홍길동', 5000), 
    ('고길동', 3000);
    
### 스토어드 프로시저 작성: SQL 내의 조건문이나 반복문은 SQL 스크립트 내에서 바로 실행 X, 프로시저나 트리거 내에서 사용 ###

delimiter $$

create procedure transfer_money()
begin
	declare from_balance int; -- 변수 선언
    
	-- 자동 커밋 해제
	set autocommit = 0;

	start transaction; 

	select balance into from_balance # select 결과를 변수에 저장할 때 사용
	from accounts
	where account_holder = '홍길동';

	-- 잔액이 1000원 이상일 경우에만 송금 실행
	if from_balance >= 1000 then
		
		update accounts
		set balance = balance - 1000
		where account_holder = '홍길동';

		update accounts
		set balance = balance + 1000
		where account_holder = '고길동';

		insert into transaction_log (from_account_id, to_account_id, amount)
		values (
			(select account_id from accounts where account_holder = '홍길동'),
			(select account_id from accounts where account_holder = '고길동'),
			1000
		);

		commit;
	else
		rollback;

	end if;

	set autocommit = 1;
end $$

delimiter ;

call transfer_money();

select * from transaction_log;