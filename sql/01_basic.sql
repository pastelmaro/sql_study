--SQL의 기본적인 문법(SELECT, INSERT, CREATE TABLE 등)을 익히기 위한 예제들

-- CREATE TABLE users (
--     user_id INTEGER PRIMARY KEY,
--     name TEXT,
--     signup_date DATE
-- );

-- CREATE TABLE orders (
--     order_id INTEGER PRIMARY KEY,
--     user_id INTEGER,
--     order_date DATE,
--     amount INTEGER
-- );

-- CREATE TABLE products (
--     product_id INTEGER PRIMARY KEY,
--     product_name TEXT,
--     price INTEGER
-- );

-- PRIMARY KEY : 기본 키, 각 행을 고유하게 식별하는 열(중복,NULL값 방지)

-- INSERT INTO users VALUES
-- (1, 'Alice', '2023-01-10'),
-- (2, 'Bob', '2023-01-03'),
-- (3, 'Charlie', '2023-02-10');

-- INSERT INTO orders VALUES
-- (1, 1, '2023-01-10', 100),
-- (2, 1, '2023-02-05', 150),
-- (3, 2, '2023-02-20', 200),
-- (4, 3, '2023-03-01', 300);

-- SELECT * FROM users;
-- SELECT * FROM orders;

--유저 정보 테이블에서 유저 id, name을 가져오기
--SELECT 출력하고 싶은 결과
--FROM 출력할 테이블

-- SELECT user_id, name FROM users;

--모든 유저 정보를 가져오기
--SELECT *
--FROM 출력할 테이블
--LIMIT 출력할 행 수

-- SELECT * FROM users;

--SELECT * FROM users LIMIT 2; 데이터가 너무 클수도 있으니 LIMIT 구문과 사용하기

--대이터 필터링 WHERE 사용하기
--SELECT 출력할 결과
--FROM 출력할 테이블
--WHERE 조건

-- SELECT * FROM orders WHERE amount >= 200;
-- SELECT * FROM orders WHERE amount < 200 and user_id = 1; 두개 이상의 조건을 사용할 떄
-- SELECT * FROM orders WHERE amount > 200 or order_id < 2; 여러 조건 중 하나만 만족해도 될 떄
-- SELECT * FROM orders WHERE user_id <> 1; 제외하고 싶은 조건이 있을때

--같은 열을 이용한 조건은 IN 사용하기
--WHERE 열 IN (조건1, 조건2, ...)
--WHERE 열 NOT IN (조건1, 조건2, ...)

--BTWEEEN을 이용한 범위 조건
--SELECT 출력할 결과
--FROM 출력할 테이블
--WHERE 열 BETWEEN 조건1 AND 조건2

--SELECT * FROM orders WHERE amount BETWEEN 150 and 300;

--Like with%
--SELECT * FROM users WHERE name LIKE 'C%';
-- SELECT * FROM users WHERE name LIKE '%ie';
-- SELECT * FROM users WHERE name LIKE '%ar%';

--ORDER BY로 결과 정령하기
-- SELECT * FROM users ORDER BY signup_date ASC;
-- SELECT * FROM users ORDER BY signup_date DESC;

-- 중복 제거 DISTINCT
-- 주문한 유저 id 목록 (중복 제거)

-- SELECT DISTINCT user_id FROM orders;

--AS로 별칭 사용하기
-- SELECT user_id AS id, name AS user_name FROM users;

--NULL 처리
-- INSERT INTO users VALUES (
--     4, 'David', NULL
-- )

-- SELECT * FROM users;

-- SELECT * FROM users WHERE signup_date IS NULL;
-- SELECT * FROM users WHERE signup_date IS NOT NULL;

--계산 컬럼 만들기

-- SELECT
--     order_id,
--     amount,
--     amount * 1.1 AS taxed_amount
-- FROM orders;

-- 날짜 함수 사용하기
-- SELECT
--     order_id,
--     order_date,
--     strftime('%Y-%m', order_date) as order_month
-- FROM orders;

--페이징 개념 정리하기

SELECT *
FROM orders
ORDER BY order_date DESC;

SELECT *
FROM orders
ORDER BY order_date DESC
LIMIT 2 OFFSET 1;

--OFFSET : 건너뛸 행 수 지정(1은 1행 건너뛰기)