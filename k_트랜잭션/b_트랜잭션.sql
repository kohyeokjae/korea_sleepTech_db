USE `트랜잭션`;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE user_setting (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    dark_mode BOOLEAN,
    FOREIGN KEY (user_id)
        REFERENCES users (id)
        ON DELETE CASCADE
);

# cf) ON DELETE CASCADE
# : 외래키 제약 조건
# - 부모 테이블의 행이 삭제될 때(사용자가 삭제: 탈퇴)
# - , 참조한 자식 테이블의 행도 자동으로 삭제되도록 설정하는 옵션
# >> 참조 무결성 유지

CREATE TABLE logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    message TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

SELECT * FROM users;
SELECT * FROM user_setting;
SELECT * FROM logs;

START TRANSACTION;

-- 1단계: 사용자 등록
INSERT INTO users (username, password) VALUES ('hgd', '1234');
SAVEPOINT step1; # 저장 위치명 저장

-- 2단계: 설정 추가
INSERT INTO user_setting (user_id, dark_mode)
VALUES 
	(last_insert_id(), true);
    
    # cf) last_inser_id(): 마지막으로 자동 증가된 ID값을 반환
    #                     >> users 테이블의 id값을 반환
SAVEPOINT step2;

-- 3단계: 로그 저장
INSERT INTO logs (message) VALUES ('회원가입 시도');

ROLLBACK TO SAVEPOINT step1;
# >> 에러 발생했다고 가정! (2단계가 문제 > 1단계는 유지 / 2단계만 취소)

COMMIT; -- 이후 다른 작업 이어가기 가능 (전체 종료 시 커밋)