/*
	=== 상호 조인(Cross Join) ===
    : 두 테이블의 모든 조합을 반환하는 조인
    - A CROSS JOIN B는 A의 각 행과 B의 각 행을 모두 조합
      >> 결과 행 수: A의 행 수 X B의 행 수
      
	cf) on절이 필요 X
        , where 절로 필터링하지 않을 경우 모든 조합이 출력되어 결과량이 많을 수 있음
*/

# 모든 회원과 모든 구매 정보 조합
SELECT 
    M.name, P.product_code, P.amount
FROM
    `members` M
        CROSS JOIN
    `purchases` P;
-- 회원 10명 * 구매 8건 = 80개의 행 반환

# 필터 조건과 함께 cross join 사용
SELECT 
    M.name, P.product_code, P.amount
FROM
    `members` M
        CROSS JOIN
    `purchases` P
WHERE
    M.member_id = P.member_id; -- 내부 조인(inner join)과 같은 결과
    
/*
	=== 자체 조깅(Self Join) ===
    : 자기 자신을 기준으로 한 조인
    - 실제 테이블은 자기 자신 하나이지만, 테이블을 두번 사용하는 것 처럼 별칭(alias)를 부여하여 조인
*/

# 같은 지역에 사는 회원끼리 묶기
SELECT 
    A.name AS 회원1, B.name AS 회원2, A.area_code
FROM
    `members` A
        JOIN
    `members` B ON A.area_code = B.area_code
WHERE
    A.member_id < B.member_id;
    
SELECT 
    A.name AS 회원1, B.name AS 회원2, A.grade
FROM
    `members` A
        JOIN
    `members` B ON A.grade = B.grade
WHERE
    A.member_id < B.member_id;