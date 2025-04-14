/*
	=== SELECT: 선택하다(조회하다) ===
    
    cf) DB는 '어떻게'보다 '무엇을' 가지고 오는지가 중요!
        >> SELECT는 '무엇을' 선택할 것인지 결정하는 키워드
	
    # SELECT 문의 기본 구조 ('작성 순서') #
		1. SELECT 컬럼명(열 목록): 원하는 컬럼(열)을 지정
        2. FROM 테이블명; 어떤 테이블에서 데이터를 가져올 지 결정
        3. WHere 조건식: 특정 조건에 맞는 데이터만 선택(필터링)
		4. GROUP BY 그룹화 할 컬럼명: 특정 열을 기준으로 그룹화
        5. HAVING 그룹 조건: 그룹화된 데이터에 대한 조건을 지정
        6. ORDER BY 정렬 컬럼명: 결과를 특정 컬럼의 순서로  정렬
        7. LIMIT 컬럼 수 제한: 반환할 행(레코드)의 수를 제한
        
	# DB 내부의 처리 순서 (SELECT문 실행 순서) 
    # FROM, JOIN(추가 테이블 데이터 가져오기)
    # > WHERE > GROUP BY > HAVING > SELECT > ORDER BY > LIMIT
*/

USE `korea_db`;

## 1. 기본 조회
# : SELECT 컬럼명 FROM 데이터베이스명.테이블명;

SELECT `name` FROM `korea_db`.`members`;
# : 정렬을 하지 않고 조회 시 데이터 입력 순서대로 출력

# cf) 전체 컬럼 조회(전체 테이블 조회)
# 컬럼명 작성에 *를 사용하여 조회
SELECT * FROM `korea_db`.`members`; -- 회원 테이블
SELECT * FROM `korea_db`.`purchases`; -- 구매 목록 테이블

# cf) 두 개 이상의 컬럼을 조회 (,) 콤마로 구분하여 나열
SELECT 
    `member_id`, `name`, `contact`
FROM
    `members`;

# cf) alias 별칭 부여 조회 ( as 키워드 )
# : 별칭을 부여하지 않을 경우 테이블 생성 시 지정한 컬럼명을 조회
# - 열 이름으로 별칭으로 조회할 때 사용 ( >> 컬럼명 변경 X )
# - 공백 사용 시 따옴표로 반드시 묶어야 함
# - AS 키워드 생략 가능
SELECT
    `member_id` AS 고유번호, `name` '멤버 이름' , `contact` AS '회원 연락처'
FROM
    `members`;

## 2. 특정 조건을 부합하는 데이터 조회 
# : SELECT A FROM B WHERE C

SELECT 
    `member_id`, `name`, `contact`
FROM
    `members`
WHERE 
    # WHERE 조건절에는 연사자가 주로 사용
    points > 200;
    
# cf) WHERE 조건절에 주로 사용되는 연산자
# 1) 관계 연산자
# : 이상, 이하, 초과, 미만, 일치(=), 불일치(!=)
SELECT 
    `member_id`, `name`, `points`
FROM
    `members`
WHERE
    name = 'Minji';
    
# 2) 논리 연산자
# : 여러 조건을 조합하여 데이터 조회
# : AND, OR, NOT 등

# AND - 모든 조건이 참
SELECT 
    *
FROM
    `members`
WHERE
    area_code = 'Jeju' AND points > 400;

# OR - 조건 중 하나라도 참
SELECT 
    *
FROM
    `members`
WHERE
    area_code = 'Busan'
        OR area_code = 'Seoul';

# NOT - 조건이 거짓일 때 (결과를 반대)
SELECT 
    *
FROM
    `members`
WHERE
    NOT grade = 'Bronze';
    
# cf) null은 연산이 불가!
-- SELECT 
--     *
-- FROM
--     `members`
-- WHERE
--     points != NULL;

# >> null이 '값이 없음'을 나타내기 때문에 그 어떤 값과도 비교하거나 연산이 불가
#    : is null, is not null 키워드를 통해 null 여부만 확인 가능

# A is null
# : null인 경우 true 반환, 아닌 경우 false 반환

# A is not null
# : null이 아닌 경우 true 반환, null 인 경우 false 반환
SELECT 
    *
FROM
    `members`
WHERE
    points IS NULL;

# between A and B
# : A와 B 사이에
SELECT 
    *
FROM
    `members`
WHERE
    points BETWEEN 200 AND 400; -- 이상, 이하 (숫자형)
    
# in 연산자
# : 지정할 범위의 문자 데이터를 나열
# - 지정된 리스트 중 하나와 일치하면 참
SELECT 
    *
FROM
    `members`
WHERE
    area_code IN ('Seoul' , 'Busan', 'Jeju');
    
# >> 문자열 데이터에 대한 OR 식의 간소화

# like 연산자
# : 문자열 일부를 검색

# cf) 와일드 카드 문자: _(언더스코어), %(퍼센트)
# _: 하나의 언더스코어에 한 글자를 허용 (정확하게 하나의 임의의 문자를 나타냄)
# %: 무엇이든 허용 (0개 이상의 임의의 문자를 나타냄)

SELECT * FROM `members`;

SELECT 
    *
FROM
    `members`
WHERE
    name LIKE 'J%'; -- 시작만 J이고 뒤는 0개 이상의 무자를 허용 / Jin, Joon

SELECT 
    *
FROM
    `members`
WHERE
    name LIKE 'J___'; -- 시작이 J이고 뒤에는 3개의 임의의 문자를 허용 / Joon

SELECT 
    *
FROM
    `members`
WHERE
    name LIKE '%un%'; -- 어떤 문자열 내에서든 un이 포함되면 허용

SELECT 
    *
FROM
    `members`
WHERE
    name LIKE '_u%'; -- 1개의 임의의 문자 + u + 상관 없음: 이름의 두 번째 글자가 u인 모든 회원 조회

SELECT 
    *
FROM
    `members`
WHERE
    name LIKE '____';
    
## 날짜와 시간 조회
# DATE: 'YYYY-MM-DD'
# TIME: 'HH:mm:SS'

# =, != (일치, 불일치)
SELECT * FROM`members`
WHERE
    join_date = '2022-01-02';

SELECT * FROM `members`
WHERE
    join_date != '2022-01-02';

# between A and B
SELECT * FROM `members` 
WHERE
	join_date BETWEEN '2023-06-01' AND '2025-01-01';
    
# cf) 특정 시간 기준 그 이후의 데이터 조회
# 컬럼명 > 특정 시간
SELECT 
    *
FROM
    `members`
WHERE
    join_date > '2022-01-02';
    
# cf) 날짜나 시간의 특정 부분과 일치하는 데이터 조회
# 연도 일치: year(컬럼명)
# 월 일치: month(컬럼명)
# 일 일치: day(컬럼명)
SELECT * FROM `members` 
WHERE
	year(join_date) = '2022';

# 시간: hour()
# 분: minute()
# 초: second()

# cf) 현재 날짜나 시간을 기준으로 조회
# curdate()
# now()
SELECT * FROM `members` 
WHERE
	join_date < curdate();







