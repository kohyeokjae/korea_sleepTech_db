### 트리거 예제 ###

USE `market_db`;

# singer 테이블: member 테이블에서 데이터를 추출
CREATE TABLE IF NOT EXISTS singer (
	SELECT
		mem_id, mem_name, mem_number, addr 
    FROM
		`member`
);

SELECT * FROM singer;

# 백업 테이블: 변동 사항ㅇ을 기록할 테이블
CREATE TABLE `backup_signer` (
    mem_id CHAR(8) NOT NULL,
    mem_name VARCHAR(10) NOT NULL,
    mem_number INT NOT NULL,
    addr CHAR(2) NOT NULL,
    
    modType CHAR(2), -- 변경된 타입 (수정 | 삭제)
    modDate DATE, -- 변경된 날짜
    modUser VARCHAR(30) -- 변경한 사용자
);

-- 변경(update)이 발생했을 때 작동하는 트리거
drop trigger if exists singer_updateTrg;

delimiter $$

create trigger singer_updateTrg -- 트리거명
	after update -- 변경 후에 작동하도록 지정
    on singer -- 트리거를 부착할 테이블
    for each row
begin
	insert into backup_singer
    values( 
		OLD.mem_id, OLD.mem_name, OLD.mem_number, OLD.addr,
        '수정', curdate(), current_user()
    );
end $$

delimiter ;

# OLD 테이블
# : update 나 delete가 수행될 때
# - 변경되기 전의 데이터가 잠깐 저장되는 임시 테이블

# curdate(): 현재 날짜
SELECT CURDATE();

# current_user(): 현재 작업 중인 사용자
SELECT CURRENT_USER();

SELECT * FROM singer;

UPDATE singer 
SET 
    addr = '미국'
WHERE
    mem_id = 'BLK';
    
UPDATE singer 
SET 
    mem_number = 10
WHERE
    mem_id = 'BLK';

SELECT * FROM backup_singer;

## 삭제 시 발생되는 트리거 ##
drop trigger if exists singer_deleteTrg;

delimiter $$
create trigger singer_deleteTrg
	after delete
    on singer
    for each row
begin	
	insert into backup_singer
    values
		(
			OLD.mem_id, OLD.mem_name, OLD.mem_number, OLD.addr
            , '삭제',  curdate(), current_user()
        );
end $$
delimiter ;

DELETE FROM singer 
WHERE
    mem_number >= 7;
    
SELECT * FROM backup_singer;

SELECT * FROM singer;