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

-- SELECT *
-- FROM orders
-- ORDER BY order_date DESC;

-- SELECT *
-- FROM orders
-- ORDER BY order_date DESC
-- LIMIT 2 OFFSET 1;

--OFFSET : 건너뛸 행 수 지정(1은 1행 건너뛰기)



--문제 풀며 복습하기
--1 서비스에 가입한 유저들의 정보를 담을 테이블 생성(고유id, 이름, 가입 시기)
-- CREATE TABLE user_list (
--     user_id INTEGER PRIMARY KEY,
--     name TEXT,
--     signup_date DATE
-- );

-- SELECT * 
-- FROM user_list;

--2 user_list 테이블에 유저 정보 삽입
-- INSERT INTO user_list VALUES
--     (1, 'Eve', '2024-01-15'),
--     (2, 'Frank', '2024-02-20'),
--     (3, 'Grace', NULL);

-- SELECT *
-- FROM user_list;

--3 테이블에서 id와 가입 시기만 조회하기
-- SELECT
--     user_id,
--     signup_date
-- FROM user_list;

--4 가입 시기가 2024년 2월 이후인 유저 조회하기
-- SELECT *
-- FROM user_list
-- WHERE signup_date >= '2024-02-01';

--5 테이블에서 id가 1또는 3인 유저 조회하기(In 사용)
-- SELECT *
-- FROM user_list
-- WHERE user_id
-- IN (1,3);

--6 이름이 'F'로 시작하는 유저 조회하기
-- SELECT *
-- FROM user_list
-- WHERE name LIKE 'f%';

--7 이름에 'ac'가 포함되지 않은 유저 조회하기
-- SELECT *
-- FROM user_list
-- WHERE name NOT LIKE '%ac%';

-- INSERT INTO user_list VALUES
--     (4, 'Eve', '2024-04-23');

--8 유저 리스트에서 유저들의 이름을 중복없이 조회하기
-- SELECT DISTINCT name
-- FROM user_list;

--9 가입 시기가 오래된 유저부터 조회하기
-- SELECT *
-- FROM user_list
-- ORDER BY signup_date DESC;

--10 가입 시기가 NULL인 유저 제외하고 조회하기
-- SELECT *
-- FROM user_list
-- WHERE signup_date IS NOT NULL;

--11 user_id를 id로 바꿔서 조회하기(AS 사용)
-- SELECT user_id AS id
-- FROM user_list;

--12 id에 2를 더한 값을 조회하기
-- SELECT user_id + 2 AS user_id
-- FROM user_list;

--14 가입시기를 월(mm)/일(dd) 형식으로 조회하기
-- SELECT strftime('%m/%d', signup_date) AS signup_date
-- FROM user_list;

-- SELECT *
-- FROM orders;

--15 orders 테이블에서 주문 수량이 150 이상, 주문 날짜가 2023-02-01 이후인 주문을 
--주문 날짜 기준 오름차순으로 정렬해서 최대 2개만 조회하기

-- SELECT *
-- FROM orders
-- WHERE amount > 150 AND order_date > '2023-02-01'
-- ORDER BY order_date ASC
-- LIMIT 2;