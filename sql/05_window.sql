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
--(8, '민신입', '영업', 2800, '2023-06-20'),
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

--SUM() / AVG() 집계함수
-- SELECT DISTINCT dept, 
--     AVG(salary) OVER(
--         PARTITION BY dept --ORDER BY가 없으면 파티션 전체 집계 (FROUP BY와 같음)
--     ) AS avg_salary
-- FROM EMPLOYEES;

--ROWS 와 RANGE의 차이
--ROWS : 물리적 행 기준 ex) 최근 3개 행
--RANGE : 논리적 행 기준 ex) 날짜 차이로 최근 3개월
-- SELECT *,
-- AVG(salary) OVER(
--     PARTITION BY dept
--     ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
-- ) AS current_row
--FROM EMPLOYEES; --지금 행과 바로 위의 2개 행의 평균 계산

--SELECT *,
--     AVG(salary) OVER(
--         PARTITION BY dept
--         ORDER BY salary 
--         RANGE 500 PRECEDING --내 salary를 기준으로 +500인 사람들의 평균 salary를 계산
--     ) AS range_row
-- FROM EMPLOYEES;

--LAG / LEAD
--전월 대비, 이전 데이터 비교, 증감 계산에 사용
-- SELECT *,
--     LAG(name) OVER(
--         PARTITION BY dept
--     ) AS lag_use, --현재행의 이전 값 찾기
--     LEAD(name) OVER(
--         PARTITION BY dept
--     ) AS lead_use --현재행의 다음 값 찾기
-- FROM EMPLOYEES;

--누적합 계산
--처음 행부터 현재 행까지 누적 계산
--매출 누적, 유저 수 누적, 트래픽 누적 등에 사용
-- SELECT *,
--  SUM(salary) OVER(
--     PARTITION BY dept
--     ORDER BY hire_date
--     ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
--  ) AS cumulative_sum
--  FROM EMPLOYEES;
-- SELECT *,
--     FIRST_VALUE(salary) OVER(
--         PARTITION BY dept
--         ORDER BY salary DESC
--     ) top_salary,
--     LAST_VALUE(salary) OVER(
--         PARTITION BY dept
--         ORDER BY salary DESC
--         ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING --SQL에서 값을 찾을 떄 전체 데이터를 보는게 아닌, 현제 행만 보고 계산하기 떄문에 현제 값을 반환함, 이 구문 추가 필요
--     ) last_salary
-- FROM EMPLOYEES;

--TOP N 개만 추출
-- WITH ranked AS (
--     SELECT *,
--     ROW_NUMBER() OVER(
--         PARTITION BY dept
--         ORDER BY salary DESC
--     ) AS rn
--     FROM EMPLOYEES
-- )
-- SELECT *
-- FROM ranked
-- WHERE rn <= 2

