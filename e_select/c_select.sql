# SELECT A FROM B WHERE C;

/*
	1. ORDER BY
		: 데이터 정렬
        - 결과의 값이나 개수에 영향 X
        - 기본값 ASC(Ascending, 오름차순), DESC(Desending, 내림차순)
        
        cf) 오름차순: 알파벳(a), 자음(ㄱ), 날짜(오래된 순, 과거), 숫자(작은 데이터)
*/

select * from `members`; # 데이터 삽입 순서대로 정렬 (auto_increment PK 값에 따라 정렬)

SELECT 
    *
FROM
    `members`
ORDER BY join_date;

SELECT 
    *
FROM
    `members`
ORDER BY name DESC;

-- 정렬된 데이터를 기반으로 추가 정렬(콤마로 정렬 상태를 나열)
SELECT 
    *
FROM
    `members`
ORDER BY grade DESC, points DESC;

/*
	2. LIMIT: 출력하는 개수를 제한 (반환되는 행의 수를 제한)
    
    LIMIT 행수 (offset 시작행)
    
    cf) 첫 번째 행이 기본값 0
*/
SELECT 
    *
FROM
    `members`
LIMIT 5 OFFSET 2; -- 시작번호 2는 3번째 데이터 부터 (index 번호 체계와 동일)

SELECT 
    *
FROM
    `members`
ORDER BY grade DESC
LIMIT 5;

/*
	3. DISTINCT
		: 중복된 결과를 제거
        - 조회된 결과에서 중복된 데이터값 존재하면 1개만 남기고 생략
        
        - 조회할 열 이름 앞에 DISTINCT 키워듬나 작성
*/

SELECT DISTINCT
    area_code
FROM
    `members`;
    
SELECT DISTINCT
    grade
FROM
    `members`;
    
/*
	4. GROUP BY
		: 그룹을 묶어주는 역할
        - 여러 행을 그룹화하여 집계함수를 적용해 주로 사용
        
        cf) 집계 함수: 그룹화 된 데이터에 대한 계산
		- max(), min(), avg(), sum() 
        - count(): 행의 수
        - count(distinct): 행의 개수 (중복은 1개만 인정)
*/

# 등급별 회원 수 계산
# : 집계함수는 그룹화 된 영역 내에서 각각 계산
SELECT 
    grade, COUNT(*) AS member_count
FROM
    `members`
GROUP BY grade;

# 지역별 평균 포인트 계산
SELECT 
    area_code, AVG(points) AS member_point
FROM
    `members`
GROUP BY area_code;

/*
	5. HAVING
		: GROUP BY 함께 사용, 그룹화 된 결과에 대한 조건을 지정
        - WHERE 조건과 사용 식은 유사하지만, 그룸화된 데이터에 대해 조건을 지정
*/
SELECT 
    grade, COUNT(*) AS member_count
FROM
    `members`
GROUP BY grade
HAVING COUNT(*) >= 2;

SELECT 
    area_code, AVG(points) AS avg_points
FROM
    `members`
GROUP BY area_code
HAVING AVG(points) > 200;




