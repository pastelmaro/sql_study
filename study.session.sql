CREATE TABLE users (
    user_id INTEGER PRIMARY KEY,
    name TEXT,
    signup_data DATE
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    order_data DATE,
    amount INTEGER
);

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_name TEXT,
    price INTEGER
);