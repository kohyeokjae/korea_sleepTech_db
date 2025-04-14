### 야구 데이터베이스 ###
create database if not exists baseball_league;

use baseball_league;

create table teams (
	team_id int primary key,
    name varchar(100) unique,
    city varchar(100),
    founded_year year
);

create table players (
	player_id int primary key,
    name varchar(100),
    position enum('타자', '투수', '내야수', '외야수'),
    birth_date date not null,
    team_id int, -- 참조값
    foreign key (team_id) references teams(team_id)
);

insert into teams
values
	(1, 'LOTTE', 'Busan', 1982),
	(2, 'DOSAN', 'Seoul', 1999),
	(3, 'SSG', 'Incheon', 2000);
    
insert into players
values
	(101, 'Kim min', '타자', '1992-05-20', 1),
	(102, 'Lee Joon', '투수', '1990-08-15', 2),
	(103, 'Choi Hyeon', '내야수', '1988-03-05', 3),
	(104, 'Park seo', '외야수', '1994-11-22', 1),
	(105, 'Jung Tae', '타자', '1993-07-30', 2);

describe teams;
desc players;

# 1. 1990년 이후에 태어난 선수 목록 가져오기
SELECT 
    *
FROM
    `players`
WHERE
    year(birth_date) >= 1990;

# 2. 외야수인 선수 중 1995년 이전에 태어난 선수 목록 가져오기
SELECT 
    *
FROM
    `players`
WHERE
    position = '외야수'
        AND year(birth_date) <= '1995';

# 3. 선수들을 생년월일 순으로 정렬해서 가져오기
SELECT 
    *
FROM
    `players`
ORDER BY birth_date;

# 4. 팀별로 창단 연도 순으로 팀 목록 가져오기
SELECT 
    *
FROM
    teams
ORDER BY founded_year;

# 5. 중복을 제거한 팀 이름 목록 가져오기
SELECT DISTINCT
    name
FROM
    `teams`;

# 6. 중복을 제거한 포지션 목록 가져오기
select DISTINCT position from `players`;

# 7. 각 포지션별 선수 수가 2명 이상인 포지션 가져오기
SELECT 
    position, COUNT(*) player_count
FROM
    `players`
GROUP BY position
HAVING player_count >= 2;