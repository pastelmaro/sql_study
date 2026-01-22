--COUNT사용법(집계함수)
--행의 수를 셀때 사용, 빈행은 포함하지 않음
--COUNT(*) or COUNT(열이름)으로 사용, 뒤에 AS를 붙여 별칭 지정 가능
--COUNT(DISTINCT 열이름)을 사용하면 unique한 행의 수를 셀 수 있음
-- CREATE TABLE list (
--     id INTEGER PRIMARY KEY,
--     name TEXT,
--     country TEXT,
--     age INTEGER
-- );

-- INSERT INTO list VALUES
--     (1, 'Alice', 'USA', 30),
--     (2, 'Bob', 'Canada', 25),
--     (3, 'Charlie', 'USA', 35),
--     (4, 'David', 'UK', 30),
--     (5, 'Eve', 'Canada', 28);

-- SELECT COUNT(id) AS numberofid
-- FROM list;

--COUNT(*) 과 COUNT(column)의 차이
--COUNT(*) : 모든 행의 수
--COUNT(column) : NULL값 제와

--SUM, AVG, MIN, MAX 사용법(집계함수)
-- SELECT SUM(age) AS total_age
-- FROM list
-- WHERE country = 'USA';

--SUM과 AVG는 숫자형 데이터에만 사용 가능, 빈 행은 계산에 포함하지 않음

-- SELECT AVG(age) AS average_age
-- FROM list;

-- SELECT MIN(age) AS youngest_age
-- FROM list;

-- SELECT MAX(age) AS oldest_age
-- FROM list;

--GROUP BY 사용법
--GROUP BY는 각 항목별 집계를 조회할 떄 사용
--SELECT 뒤에 나오는 열이름 외에는 집계함수를 사용해야함
-- SELECT country, COUNT(id) AS number_of_users
-- FROM list
-- GROUP BY country
-- ORDER BY number_of_users DESC;

--나라 + 나이별 인원 수
-- SELECT country, age, COUNT(*) AS count_poeple
-- FROM list
-- GROUP BY country, age;

--30세 이하 대상의 국가별 평균 나이
-- SELECT country, AVG(age) AS average_age
-- FROM list
-- WHERE age <= 30
-- GROUP BY country;

--HAVING 사용법
--HAVING은 조회 결과에 대한 조건문을 지정할 때 사용함

-- SELECT country, AVG(age) AS average_age
-- FROM list
-- GROUP BY country
-- HAVING average_age > 25;

--WHERE과의 차이점 : GROUP By전에 필터링을하냐, 후에 필터링을 하냐에 따라 나뉨

--CASE WHEN 사용법
--조건에 따라 다른 값을 조회할 때 사용
-- SELECT *,
-- CASE WHEN age >= 30
--     THEN 'Senior'
--     ELSE 'Junior'
--     END AS age_group
-- FROM list;

--문제 풀며 복습하기
--1 전체 인원수를 구하시오
-- SELECT COUNT(*) AS total_people
-- FROM list;
--COUNT(*)를 사용해 전체 열의 수를 구함

--2 전체 나이의 합계를 구하시오
-- SELECT SUM(age) AS total_age
-- FROM list;
--SUM(age)로 전체 나이의 합계를 계산함

--3 전체 평균 나이를 구하시오
-- SELECT AVG(age) AS average_age
-- FROM list;
--AVG(age)집계 함수를 활용하여 나이의 평균을 구함

--4 가장 어린 사람과 나이 많은 사람의 나이를 각각 구하시오
-- SELECT MIN(age) as youngest_age, MAX(age) AS oldest_age
-- FROM list;
-- 집계함수 MIN과 MAX를 사용하여 최댓값과 최솟값을 구함

--5 국가별 인원수를 구하시오
-- SELECT country, COUNT(*) AS user_count
-- FROM list
-- GROUP BY country;
--CROUP BY를 사용하여 country를 기준으로 그룹핑했고, COUNT(*)로 전체 수를 조회함

--6 국가별 평균 나이를 구하시오
-- SELECT country, AVG(age) AS average_age
-- FROM list
-- GROUP BY country;
--GROUP BY를 사용하여 country기준으로 그룹핑 했고, AVG(age)를 사용하여 나이의 평균을 구함 

--8 30세 이상 사람들만 대상으로 국가별 인원 수를 구하세요
-- SELECT country, COUNT(*) AS user_count
-- FROM list
-- WHERE age >= 30
-- GROUP BY country;
--GROUP BY와 WHERE을 사용하 조건에 맞는 대상을 country기준으로 그룹핑했고, count(*)로 전체 인원수를 조회함

--9 캐나다 사람들의 평균 나이를 구하세요
-- SELECT country, AVG(age) AS average_age
-- FROM list
-- WHERE country = 'Canada'
-- GROUP BY country;
--GROUP BY와 WHERE로 조건에 맞는 사람들을 나라를 기준으로 그룹핑했고, AVG(age)로 평균 나이를 구함

--10 25세 이상을 대상으로 국가별 평균 나이를 구하세요
-- SELECT country, AVG(age) AS average_age
-- FROM list
-- WHERE age >= 25
-- GROUP BY country;
--GROUP BY와 WHERE로 조건의 맞는 사람들을 대상으로 그룹핑했고, AVG(age)를 사용하여 평균 나이를 구함

--11 국가별 인원 수를 구하고, 인원이 2명 이상인 국가만 출력하세요
-- SELECT country, COUNT(*) AS total_people
-- FROM list
-- GROUP BY country
-- HAVING total_people >= 2;
-- GROUP BY로 country를 기준으로 그룹핑했고, HAVING으로 조건에 맞는 대상들만 걸러냄

--12 국가별 평균 나이를 구하고, 평균 나이가 28세 이상인 국가만 출력하세요
-- SELECT country, AVG(age) as average_age
-- FROM list
-- GROUP BY country
-- HAVING average_age >= 28;
-- GROUP BY로 country를 기준으로 그룹핑했고, HAVING으로 조건에 맞는 대상들만 걸러냄

--13 국가별 인원 수를 구하고, 인원이 많은 순으로 정렬하세요
-- SELECT country, COUNT(*) as total_people
-- FROM list
-- GROUP BY country
-- ORDER BY total_people DESC;
--GROUP By로 country기준으로 그룹핑했고, ORDER BY를 활용해 인원이 많은 순으로 정렬함

--14 각 사람을 30세 이상 -> 'Senior', 30세 미만 -> 'Junior'로 구분하고 그룹별 인원수를 구하세요
-- SELECT COUNT(*) AS count,
-- CASE WHEN age >=30
--     THEN 'Senior'
--     ELSE 'Junior'
--     END AS age_group
-- FROM list
-- GROUP BY age_group;
--CASE를 활용해 조건에 맞는 대상들끼리 집합을 만들고 GROUP By로 각 집합별로 그룹핑하여 인원수를 측정함

--15 다음을 모두 출력하세요
-- 국가별 인원 수
-- 평균 나이
-- 30세 이상 인원 수
-- 평균 나이 높은 순 정렬
-- 인원 2명 이상만 출력
-- SELECT 
--     country, 
--     COUNT(*) AS total_people, 
--     AVG(age) AS average_age,
-- CASE WHEN age >= 30
--     THEN COUNT(*)
--     END AS 'Senior'
-- FROM list
-- GROUP BY country
-- HAVING total_people >= 2
-- ORDER BY average_age DESC;