-- CREATE TABLE list (
--     id INTEGER PRIMARY KEY,
--     name TEXT,
--     signup_date DATE
-- );

-- CREATE TABLE info (
--     id INTEGER PRIMARY KEY,
--     sale INTEGER,
--     goods TEXT
-- );

-- INSERT INTO list VALUES
-- (1, "Bob", "2025-01-02"),
-- (2, "Daniel", "2025-02-03"),
-- (3, "Jym", "2025-04-05");

-- INSERT INTO info VALUES
-- (1, 100, "Shoes"),
-- (2, 250, "Pants"),
-- (3, 400, "Clothes");

--CTE 기본 문법
-- WITH TEMP AS (
--     SELECT l.id, l.name
--     FROM list AS l
-- )
-- SELECT *
-- FROM TEMP;

-- WITH TEMP (col1, col2) AS (
--     SELECT l.id, l.name
--     FROM list AS l
-- ) TMEP라는 임시 테이블을 만들어 사용
-- SELECT col1, col2
-- FROM TEMP

--서브 쿼리와 CTE의 차이
--선언 위치
--서브쿼리 : 쿼리 내부 어디든 가능
--CTE : WITH 절 상단에 선언

--가독성
--서브쿼리 : 복잡할수록 떨어짐
--CTE : 구조적이고 깔끔함

--재사용
-- 서브쿼리 : 불가 (같은 쿼리 반복 필요)
--CTE : 가능 (한 번 정의 후 여러 번 사용)

--디버깅
--서브쿼리 : 상대적으로 어려움
--CTE : 블록 단위로 디버깅 용이

--재귀 쿼리
--서브쿼리 : 어려움
--CTE : 재귀 구조 지원 ex) 트리 구조 탐색

--서브 쿼리 버전
-- SELECT *
-- FROM (
--     SELECT l.id, l.name, i.sale AS total_sale
--     FROM list AS l
--     JOIN info AS i
--     ON l.id = i.id
--     GROUP BY l.id
-- )
-- WHERE total_sale >= 200;

-- --CTE 버전
-- WITH TEMP AS  (
--     SELECT l.id, l.name, i.sale AS total_sale
--     FROM list AS l
--     JOIn info AS i
--     ON l.id = i.id
--     GROUP BY l.id
-- )
-- SELECT *
-- FROM TEMP;

-- WITH TEMP AS (
--     SELECT i.id, SUM(i.sale) AS total_sale
--     FROM info AS i
-- )
-- SELECT l.name, t.total_sale
-- FROM list AS l
-- JOIN TEMP AS t
-- ON l.id = t.id

--여러개의 CTE 사용
-- WITH
-- total_sum AS (
--     SELECT i.id, SUM(i.sale) AS total_sale
--     FROM info AS i
--     GROUP BY id
-- ),
-- each_date AS (
--     SELECT l.id, l.name, strftime("%Y-%m") AS signup_date
--     FROM list AS l
--     GROUP BY id
-- )
-- SELECT
--     l.id,
--     e.name,
--     t.total_sale,
--     e.signup_date
-- FROM list AS l
-- JOIN total_sum AS t
-- ON l.id = t.id
-- JOIN each_date AS e
-- ON l.id = e.id

--단게별 데이터 처리 파이프라인

-- WITH
-- raw_sales AS (
--     SELECT *
--     FROM info
-- ),
-- sales_sum AS (
--     SELECT id, SUM(sale) AS total_sale
--     FROM raw_sales
--     GROUP BY id
-- ),
-- filtered AS (
--     SELECT *
--     FROM sales_sum
--     WHERE total_sale >= 200
-- )

-- SELECT *
-- FROM filtered;

--구매하지 않은 고객 찾기

-- WITH sales_user AS (
--     SELECT id
--     FROM info
-- )

-- SELECT l.name
-- FROM list AS l
-- LEFT JOIN sales_user AS s
-- ON l.id = s.id
-- WHERE s.id IS NULL;


------------------

-- 고객
-- CREATE TABLE customers (
--     customer_id INTEGER PRIMARY KEY,
--     name TEXT,
--     city TEXT,
--     signup_date DATE
-- );

-- 주문
-- CREATE TABLE orders (
--     order_id INTEGER PRIMARY KEY,
--     customer_id INTEGER,
--     order_date DATE,
--     amount INTEGER
-- );

-- 주문 상세
-- CREATE TABLE order_items (
--     order_id INTEGER,
--     product_id INTEGER,
--     quantity INTEGER
-- );

-- 상품
-- CREATE TABLE products (
--     product_id INTEGER PRIMARY KEY,
--     product_name TEXT,
--     category TEXT,
--     price INTEGER
-- );

--데이터

-- INSERT INTO customers VALUES
-- (1,'Alice','Seoul','2025-01-02'),
-- (2,'Bob','Busan','2025-02-10'),
-- (3,'Chris','Seoul','2025-03-01'),
-- (4,'David','Incheon','2025-03-15'),
-- (5,'Emma','Seoul','2025-04-01');

-- INSERT INTO orders VALUES
-- (101,1,'2025-05-01',300),
-- (102,1,'2025-05-03',200),
-- (103,2,'2025-05-05',150),
-- (104,3,'2025-05-07',500),
-- (105,3,'2025-05-09',100);

-- INSERT INTO order_items VALUES
-- (101,1,1),
-- (101,3,1),
-- (102,2,1),
-- (103,4,3),
-- (104,3,2),
-- (105,1,1);

-- INSERT INTO products VALUES
-- (1,'Shoes','Fashion',100),
-- (2,'Pants','Fashion',150),
-- (3,'Keyboard','Electronics',200),
-- (4,'Mouse','Electronics',50);

--------------------------

--1 주문 테이블을 그대로 가져오는 CTE order_cte를 만들고 전체 조회
-- WITH order_cte AS (
--     SELECT *
--     FROM orders
-- )
-- SELECT *
-- FROM order_cte;

--2 고객별 주문 금액(total_amount) 구하기
--출력 : customer_id | total_amount
-- WITH temp AS (
--     SELECT customer_id, SUM(amount) AS total_amount
--     FROM orders
--     GROUP BY customer_id
-- )

-- SELECT *
-- FROM temp;

--3 고객명, 도시, 총 구매수량을 구하기
-- WITH total AS (
--     SELECT name, city, customer_id
--     FROM customers
-- )
-- SELECT t.name, t.city, SUM(o.amount) AS total_amount
-- FROM total AS t
-- JOIN orders AS o
-- ON t.customer_id = o.customer_id
-- GROUP BY t.name;

--4 다음 조건을 2단계 CTE로 작성
--조건 : 고객별 구매 금액 계산, 300 이상 고객만 필터
-- WITH 
-- sum_cte AS (
--     SELECT c.name, SUM(o.amount) AS total_amount
--     FROM customers AS c
--     JOIN orders AS o
--     ON c.customer_id = o.customer_id
--     GROUP BY c.name
-- ),
-- filtered AS (
--     SELECT *
--     FROM sum_cte
--     WHERE total_amount >= 300
-- )
-- SELECT *
-- FROM filtered;

--5 한 번도 주문하지 않은 고객 찾기
-- WITH none_order AS (
--     SELECT c.name, o.order_id
--     FROM customers AS c
--     LEFT JOIN orders AS o
--     ON c.customer_id = o.customer_id
-- )
-- SELECT n.name
-- FROM none_order AS n
-- WHERE n.order_id IS NULL;

--6 다음 요구사항을 3~4단계 CTE로 작성
-- 주문 + 주문상세 + 상품 JOIN
-- 고객별 실제 구매금액 계싼 (price * quantity)
-- 고객별 합계 400 이상 고객만 금액 내림차순으로 표시
--출력 : name | total_spent

-- WITH 
-- base AS (
--     SELECT
--         SUM(o.amount) AS total_amount,
--         SUM(i.quantity) AS total_quantity,
--         SUM(p.price) total_price,
--         o.customer_id
--     FROM order_items AS i
--     JOIN orders AS o
--     ON i.order_id = o.order_id
--     JOIN products AS p
--     ON i.product_id = p.product_id
--     GROUP BY o.customer_id
-- ),
-- total_sale AS (
--     SELECT 
--         c.name,
--         total_price * total_quantity AS total_spent
--     FROM base AS b
--     JOIN customers AS c
--     ON c.customer_id = b.customer_id
-- )
-- SELECT *
-- FROM total_sale
-- WHERE total_spent >= 400
-- ORDER BY total_spent DESC;

--8 가입월별 가입자 수 구하기
--출력 : signup_month | user_count
-- WITH day AS (
--     SELECT strftime("%Y-%m", signup_date) AS signup_month,
--         COUNT(*)
--     FROM customers
--     GROUP BY signup_month
-- )
-- SELECT *
-- FROM day