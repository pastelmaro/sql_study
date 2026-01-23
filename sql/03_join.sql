--join 배우기
-- CREATE TABLE client_list (
--     id INTEGER PRIMARY KEY,
--     name TEXT,
--     tell INTEGER
-- );

-- CREATE TABLE order_list (
--     id INTEGER PRIMARY KEY,
--     sale INTEGER,
--     goods TEXT
-- );

-- INSERT INTO client_list VALUES
-- (1, "Bob", 1234),
-- (2, "Jym", 0987),
-- (3, "Daniel", 5678);

-- INSERT INTO order_list VALUES
-- (1, 100, "clothes"),
-- (2, 40, "pants"),
-- (4, 25, "camera");

-- SELECT *
-- FROM client_list;
-- SELECT *
-- FROM order_list;

--INNER JOIN
--SELECT 테이블1.열이름, 테이블2.열이름
--FROM 테이블 1
--INNER JOIN 테이블 2
--ON 테이블1.열이름 = 테이블2.열이름
-- SELECT client_list.*, order_list.*
-- FROM client_list
-- INNER JOIN order_list
-- ON client_list.id = order_list.id;
--INNER JOIN은 JOIN으로 간단화 가능


--LEFT JOIN
-- SELECT client_list.*, order_list.*
-- FROM client_list
-- LEFT JOIN order_list
-- ON client_list.id = order_list.id;

--RIGHT JOIN
-- SELECT client_list.*, order_list.*
-- FROM client_list
-- RIGHT JOIN order_list
-- ON client_list.id = order_list.id;

--FULL JOIN
-- SELECT c.*, o.sale, o.goods
-- FROM client_list AS c AS사용으로 가독성++
-- FULL JOIN order_list AS o
-- ON c.id = o.id;

--SQLite는 RIGHT JOIN / FULL JOIN을 지원하지 않음
--대신 LEFT JOIN + UNION으로 대체 가능

--네트워크/메모리 낭비를 줄이기 위해 필요한 것만 조회
-- SELECT c.name, o.goods, o.sale
-- FROM client_list AS c
-- JOIN order_list AS o
-- ON c.id = o.id;

--sale이 50 이상인 고객만 조회(JOIN + WHERE로 필터링)
-- SELECT c.name, o.sale
-- FROM client_list AS c
-- JOIN order_list AS o
-- ON c.id = o.id
-- WHERE o.sale >= 50;

--LEFT JOIN + NULL값 찾기
-- SELECT c.name
-- FROM client_list AS c
-- LEFT JOIN order_list AS o
-- ON c.id = o.id
-- WHERE o.id IS NULL;

--고객별 총 주문 금액
-- SELECT c.name, SUM(o.sale) AS total_order
-- FROM client_list AS c
-- JOIN order_list AS o
-- ON c.id = o.id
-- GROUP BY c.name;

--1 고객과 주문 정보를 INNER JOIN을 이용하여 모든 컬럼을 조회하세요
-- SELECT c.*, o.*
-- FROM client_list AS c
-- JOIN order_list AS o
-- ON c.id = o.id;

--2 고객 이름(name)과 구매 상품(goods)만 조회하세요
-- SELECT c.name, o.goods
-- FROM client_list AS c
-- JOIN order_list AS o
-- ON c.id = o.id;

--3 고객 이름(name)과 구매 금액(sale)을 조회하되 컬럼명을 각각 customer_name, amount로 출력하세요
-- SELECT c.name AS customer_name, o.sale AS amount
-- FROM client_list AS c
-- JOIN order_list AS o
-- ON c.id = o.id;

--4 구매 금액(sale)이 50 이상인 주문만 조회하세요
-- SELECT c.name, o.sale
-- FROM client_list AS c
-- JOIN order_list AS o
-- ON c.id = o.id
-- WHERE o.sale >= 50;

--5 상품명이 "pants"인 주문을 한 고객의 이름을 조회하세요
-- SELECT c.name, o.goods
-- FROM client_list AS c
-- JOIN order_list AS o
-- ON c.id = o.id
-- WHERE o.goods = "pants";

--6 고객의 id가 1번인 사람의 주문 내역만 조회하세요
-- SELECT c.id, c.name, o.goods
-- FROM client_list AS c
-- JOIN order_list AS o
-- ON c.id = o.id
-- WHERE c.id = 1;

--7 모든 고객을 기준으로 주문 정보를 조회하세요(주문 업는 고객도 포함)
-- SELECT c.name, o.*
-- FROM client_list AS c
-- LEFT JOIN order_list AS o
-- ON c.id = o.id;

--8 주문하지 않은 고객만 조회하세요
-- SELECT c.name, o.*
-- FROM client_list AS c
-- LEFT JOIN order_list AS o
-- ON c.id = o.id
-- WHERE o.goods IS NULL;

--9 주문이 없는 고객의 이름과 전화번호(tell)를 조회하세요
-- SELECT c.name, c.tell
-- FROM client_list AS c
-- LEFT JOIN order_list AS o
-- ON c.id = o.id
-- WHERE o.goods IS NULL;

--10 고객별 총 구매 금액을 구하세요
--출력 : name | total_sale
-- SELECT c.name, SUM(o.sale) AS total_sale
-- FROM client_list AS c
-- LEFT JOIN order_list AS o
-- ON c.id = o.id
-- GROUP BY c.name;

--13 총 구매 금액이 100 이상인 고객만 조회하세요
-- SELECT c.name, SUM(o.sale) AS total_sale
-- FROM client_list AS c
-- JOIN order_list AS o
-- ON c.id = o.id
-- GROUP BY c.name
-- HAVING total_sale >= 100;

--14 다음을 한 번에 구하세요
--고객이름
--총 구매 금액
--총 구매 금액 높은 순 정렬
-- SELECT c.name, SUM(o.sale) AS total_sale
-- FROM client_list AS c
-- LEFT JOIN order_list AS o
-- ON c.id = o.id
-- GROUP BY c.name
-- ORDER BY total_sale DESC;