/*
	=== 조인(join, 결합하다) ===
    : 두 개의 테이블을 서로 묶어서 하나의 결과를 만들어 내는 것
    : 공통된 열(Column)을 기준으로 데이터를 연결
    
    종류) 내부 조인, 외부 조인, 상호 조인, 자체 조인
    
    1. 내부 조인(Inner Join): 조건에 일치하는 데이터만 결과로 출력 (== 교집합) ***
	   >> 정확히 일치한 행만 
       
	2. 외부 조인(Outer Join): 한쪽 테이블에 일치하지 않아도 결과로 포함 (== 합집합) **
       >> NULL 포함 가능
	
    3. 상호 조인(Cross Join): 모든 조합을 반환 (테이블1 * 테이블2)
    
    4. 자체 조인(Self Join): 자기 자신 테이블과의 조인, 동일 테이블 비교
*/

/*
	=== 1. 내부 조인(iNNER JOIN) ===
    : 두 개 이상의 테이블에서 특정 열(기준 열)의 값이 일치하는 행만 가져오는 조인
    : 두 테이블 간에 조건이 일치하는 행들만! 결과로 반환 (공통된 키 값을 기준으로 조인)
    - 교집합을 반환 
    
    cf) 일대다(1:N) 관계를 맺을 때 주로 사용
    
		EX) members 테이블 - purchases 테이블
        : 각 회원은 여러 구매 기록을 가질 수 있음
        
        EX) 회사원 테이블 - 금여 테이블 / 학생 테이블 - 학점 테이블
	
    ## 내부 조인의 기본 형태 ##
    select 
		열 목록
	from
		기존 테이블(첫 번째 테이블) as 별칭
			inner join 조인 테이블(두 번째 테이블) as 별칭
            on 조인될 조건
	[where 조건식 ...]
*/

USE `korea_db`;

# 내부 조인 예제1
# : 특정 회원이 구매한 상품 확인
SELECT 
    *
FROM
    `purchases` AS p
        INNER JOIN
    members AS m ON p.member_id = m.member_id
    -- members 테이블의 모든 회원이 조회 X
    -- / purchases 테이블의 member_id에 존재하는 회원 정보만 출력
WHERE
    p.member_id = 1;
    
# cf) 조인 시 두 개 이상의 테이블에서 동일한 열 이름이 존재하는 경우
#     , 테이블명(별칭).열이름 형식으로 표기를 권장

# 내부 조인 예제2
# : 금액이 20000 이상인 모든 구매 내열을 조회
# +) 조인 시 테이블 별칭은 각 테이블명의 제일 첫 알파벳을 대문자 사용 권장

SELECT * FROM `purchases`;

SELECT * FROM `purchases` WHERE amount >= 20000;

# 회원 이름, 구매 날짜, 금액
SELECT 
    M.name, P.purchase_date, P.amount
FROM
    `members` M
        INNER JOIN
    `purchases` P ON M.member_id = P.member_id
WHERE
    P.amount >= 20000;

# 내부 조인 예제3
# : 회원 이름 별로 구매 금액을 내림차순 정렬
SELECT 
    M.name, SUM(P.amount) total_purchases
FROM
    `members` M
		JOIN -- inner join은 가장 기본 조인이기 때문에 inner 키워드 생략 가능
    `purchases` P ON M.member_id = P.member_id
GROUP BY M.name
ORDER BY total_purchases DESC;

# 내부 조인 예제 4
# : 단 한번이라도 구매한 기록이 있는 회원 목로을 조회
SELECT DISTINCT
    M.name, M.contact -- 조인한 테이블의 데이터가 반드시 조회될 필요 X
FROM
    `members` M
        JOIN
    `purchases` P ON M.member_id = P.member_id;















