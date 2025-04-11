# DELETE VS DROP VS TRUNCATE

# 공통점
# : 삭제를 담당하는 키워드

# 차이점
# 1) DELETE (DML)
# : 테이블의 틀은 남기면서 데이터를 삭제 - 적은 용량의 데이터 | 조건이 필요한 데이터(WHERE)

# 2) DROP (DDL)
# : 테이블 자체를 삭제 (틀 + 데이터)

# 3) TRUNCATE (DDL)
# : 테이블의 틀은 남기면서 데이터를 삭제 - 대용량의 데이터

-- 대용량 테이블 생성
CREATE TABLE `big1` (SELECT * FROM `world`.`city`, `sakila`.`actor`);
CREATE TABLE `big2` (SELECT * FROM `world`.`city`, `sakila`.`actor`);
CREATE TABLE `big3` (SELECT * FROM `world`.`city`, `sakila`.`actor`);

-- 삭제 명령어 비교
# DELETE FROM `big1`;
# : TRUNCATE 보다 느림! (테이블 형식은 남지만, 조건없이 삭제를 권장하지 않음)

DROP TABLE `big2`; -- 가장 빠름 (0.015s)

TRUNCATE TABLE `big3`; -- 약 0.030s