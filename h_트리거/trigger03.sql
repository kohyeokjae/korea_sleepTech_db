### 트리거 예제 ###
use baseball_league;

SELECT * FROM players;
SELECT * FROM teams;

# 트리거 생성
# : 선수가 새로 등록될 때 마다 해당 선수가 속한 팀의 선수 수를 자동 업데이트
CREATE TABLE IF NOT EXISTS player_insert_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    team_id INT,
    log_msg VARCHAR(255),
    log_time DATETIME
);

DROP TRIGGER IF EXISTS after_player_insert;

delimiter $$

create trigger after_player_insert
	after insert
    on players
    for each row
begin
	insert into player_insert_logs (team_id, log_msg, log_time)
    values
		(NEW.team_id, concat('team', NEW.team_id), now());
end $$

delimiter ;

# OLD: update, delete 시 변경 상항이 임시로 저장되는 테이블
# NEW: insert, update, delete 시 방금 삽입 또는 갱신된 행을 참조

select * from player_insert_logs;

insert into players values (106, 'Lee Jun', '타자', '2000-01-01', 1);

select * from player_insert_logs;

insert into players 
values
	(107, 'Lee Jun', '타자', '2000-01-01', 1),
	(108, 'Choi Jun', '타자', '2000-01-01', 1),
	(109, 'Park Jun', '타자', '2000-01-01', 1),
	(110, 'Ko Jun', '타자', '2000-01-01', 1);
    
select * from player_insert_logs;