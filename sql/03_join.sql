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