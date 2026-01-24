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
--     GROUP BY id
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
--     SELECT l.id, l.name, strftime("%Y-%M") AS signup_date
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