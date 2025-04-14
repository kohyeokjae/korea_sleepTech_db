USE `market_db`;

SELECT * FROM `member`;
SELECT * FROM `buy`;

### 1. 변수 ###
# : 데이터를 저장할 수 있는 임시 저장 공간 (그릇)
# - SQL에서는 간단한 데이터 연산, 조건 비교, 동적 쿠쿼리 등에 사용

# 1) 변수 선언 규칙
# : 우항의 데이터를 좌항의 변수에 저장
# set @변수명 = 변수의 값;

# 2) 변수 값 출력(사용)
# select @변수명;

# cf) SQL 변수의 특징
# : MySQL 워크벤치 사작 시 유지, 종료할 경우 사라짐 (임시 저장 공간)

-- SQL 변수 사용 예제 --

# cf) SQL은 비절차적 언어이기 때문에 원하는 구문을 따로 실행 
#     >> 변수 선언(초기화)문 실행 >> 변수 출력

# 변수 선언
set @myVar1 = 5;
set @myVar2 = 3.14;

#변수 출력
select @myvar1;
select @myVar2;

# 파일 전체 실행 ctrl + shift + enter
# 부분 실행: ctrl + enter

# 테이블 조회 시 변수 사용
select * from `member`;
# 166 시상인 가수 이름 출력
set @txt = '가수 이름: ';
set @height = 166;

select @txt, mem_name from `member` where height > @height;

# cf) limit 키워드에 변수 사용 X
#     >> 반환하는 행을 제한

set @count = 3;
-- select * from `member` limit @count

-- PREPARE, EXECUTE 키워드를 사용한 변수 사용 --
# - ? 키워드를 사용하여 코드 작성 시에는 값이 채워지지 않지만, 실행 시 채워지는 코드 작성 가능

# EXECUTE: 해당 키워드를 만나야 PREPARE 코드가 실행

# prepare 실행시킬문장명(코드블럭명)
# from '실제 SQL문';
PREPARE mySQL from 'select * from `member` order by height limit ?';
#키가 작은 순서(오름차순)에서 상위 3개 레코드 출력

# execute 실행시킬문장명 useing 변수명;
EXECUTE mySQL using @count;

# Prepare: 쿼리를 미리 준비 (실행 X)
# Execute: 분비된 쿠러리를 실행
# ?: 실행 시 채워질 자리 (플레이스 홀더)
# using: 플레이스 홀더에 넣을 값 지정