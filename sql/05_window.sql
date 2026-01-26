--WINDOW 함수 공부
-- CREATE TABLE EMPLOYEES (
--     id INT PRIMARY KEY,
--     name VARCHAR(50),
--     dept VARCHAR(50),
--     salary INT,
--     hire_date DATE
-- );

-- INSERT INTO EMPLOYEES VALUES 
-- (1, '김철수', '영업', 3000, '2023-01-10'),
-- (2, '이영희', '영업', 3500, '2023-02-15'),
-- (3, '박민수', '개발', 4500, '2023-01-20'),
-- (4, '최지우', '개발', 5000, '2023-03-01'),
-- (5, '정본부', '영업', 3200, '2023-04-10'),
-- (6, '강팀장', '개발', 4500, '2023-02-10'),
-- (7, '윤사원', '인사', 2800, '2023-05-20');

--기본 문법
--SELECT column1,
--    FUNCTION(column2) OVER (PARTITION BY column3 ORDER BY column4) AS alias
--FROM table

--FUNCTION() : ROW_NUMBER(), RANK(), DENSE_RANK(), SUM(), AVG() 등 다양한 함수 사용 가능
--OVER() : 윈도우를 정의하는 절
--PARTITION BY : 그룹핑 기준
--ORDER BY : 정렬 기준(없을 수도 있음)

--ROW_NUMBER()
-- 행마다 고유한 순번을 매김
-- SELECT *,
--     ROW_NUMBER() OVER (
--         PARTITION BY dept
--         ORDER BY salary DESC
-- ) AS rank
-- FROM EMPLOYEES

--RANK와 DENSE_RANK의 차이 : RANK는 중복 순위 후 건너뛰고, DENSE_RANK는 건너뛰지 않음

--INSERT INTO EMPLOYEES VALUES
--(8, '민신입', '영업', 2800, '2023-06-20')
--(9, '고대리', '개발', 4000, '2023-01-05');

-- SELECT *,
--     RANK() OVER (
--         PARTITION BY dept
--         ORDER BY salary DESC
--     ) AS rank,
--     DENSE_RANK() OVER (
--         PARTITION BY dept
--         ORDER BY salary DESC
--     ) AS dense
-- FROM EMPLOYEES

