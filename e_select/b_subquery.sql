# === 서브 쿼리 (subquery) ===
# : 메인 쿼리 내부에서 실행되는 하위 쿼리
# - 중첩 쿼리
# - 메인 쿼리에 필요한 데이터를 동적으로 제공하는 역할

# = 특징 =
# : SELECT, FROM, WHERE 절 등 댜양한 곳에서 사용 가능
# : 하나의 값(단일 행) 또는 여러 값(다중 행)을 반환 가능

# cf) 2023년 이후에 가입한 회원의 이름과 지역 코드 조회

-- 일반 조건 검색
SELECT 
    name, area_code
FROM
    `members`
WHERE
    YEAR(join_date) >= 2023;

-- 서브쿼리 사용 조회
# Bronze 등급이 아닌 회원의 이름과 등급을 조회

# 1) 서브 쿼리: 'Bronze' 등급만 선택
# 2) 메인 쿼리: 그 외의 등급만 출력
-- SELECT 
--     name, grade
-- FROM
--     `members`
-- WHERE
--     grade NOT IN (SELECT 
--             grade
--         FROM
--             `members`
--         WHERE
--             grade = 'Bronze');
            
SELECT 
    name, grade
FROM
    `members`
WHERE
    grade != 'Bronze';
    
# 서브 쿼리 사용 예제
SELECT 
    grade, AVG(points) AS avg_points
FROM
    (SELECT 
        grade, points
    FROM
        `members`
    WHERE
        points IS NOT NULL) AS member_points # 서브 쿼리의 별칭 (반드시 지정)
GROUP BY grade; # 등급렬로 데이터를 묶어주는 기능 (묶은 값들의 평균을 AVG()에서 계산)

# 서브 쿼리 사용 예제
# 회원 중 가장 많은 포인트를 보유한 사람의 이름과 포인트를 조회
SELECT 
    MAX(points)
FROM
    `members`; -- 600
    
SELECT 
    name, points
FROM
    `members`
WHERE
    points = (SELECT 
            MAX(points)
        FROM
            `members`);

# 서브 쿼리: 집계, 조건 비교, 연관 데이터 추출 등에서 사용            