### 비정규화(반정규화, denormalization) ###
# : 정규화된 DB를 조회 성능 향상이나 복잡한 조인의 단순화 등을 위해
#   , 의도적으로 중복을 허용하며 다시 통합하는 과정
# - 정규화를 뒤집는 개념 X, 특정 상황의 성능을 위해 설게적으로 일부 정규화를 되돌리는 작업

# cf) 정규화: 테이블의 중복을 없애는 것

-- 정규화된 테이블 예시 --
DROP DATABASE IF EXISTS `비정규화`;
CREATE DATABASE `비정규화`;
USE `비정규화`;

# 고객 테이블
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100), -- 컬럼명으로 name 보다는 '테이블명_name' 사용을 권장
    address VARCHAR(255)
);

# 제품 테이블
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price INT
);

# 주문 테이블
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount INT,
    FOREIGN KEY (customer_id)
        REFERENCES customers (customer_id)
);

# 주문 상세 테이블
CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price INT,
    FOREIGN KEY (order_id)
        REFERENCES orders (order_id),
    FOREIGN KEY (product_id)
        REFERENCES products (product_id)
);

### 1. 정규화의 장단점 ###
# 1) 장점: 중복 최소화, 데이터 무결성 유지
# 2) 단점: 데이터를 조회할 때마다 여러 테이블을 조인해야 하므로 성능 저하 가능

-- 비정규화된 테이블 예시 --
CREATE TABLE orders_denormalized (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    customer_address VARCHAR(255),
    order_date DATE,
    product_name VARCHAR(100),
    quantity INT,
    price INT,
    total_amount INT -- 총 주문 금액
);