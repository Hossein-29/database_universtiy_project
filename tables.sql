-- command to run this on your local database
-- cd directory_of_this_file
-- psql -d database_name < tables.sql

DROP TABLE IF EXISTS contains_badge;
DROP TABLE IF EXISTS badges;
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS wallets;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS admins;


CREATE TABLE admins(
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    username VARCHAR(50),
    access_level INTEGER
);


CREATE TABLE users(
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    province VARCHAR(50),
    city VARCHAR(50),
    email VARCHAR(50),
    phone VARCHAR(50)
);


CREATE TABLE wallets(
    id SERIAL PRIMARY KEY,
    amount INT DEFAULT 0,
    FOREIGN KEY(id) REFERENCES users(id) ON DELETE CASCADE
);


CREATE TABLE payments(
    id SERIAL PRIMARY KEY,
    amount INTEGER,
    user_id INTEGER,
    FOREIGN KEY(user_id) REFERENCES users(id)
);


CREATE TABLE categories(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    parent_id INTEGER,
    FOREIGN KEY(parent_id) REFERENCES categories(id) ON DELETE SET NULL
);
ALTER TABLE categories DROP CONSTRAINT categories_parent_id_fkey;


CREATE TABLE products(
    id SERIAL PRIMARY KEY,
    title VARCHAR(50) NOT NULL,
    category_id INT,
    city VARCHAR(50),
    province VARCHAR(50),
    created_at TIMESTAMP DEFAULT NOW(),
    description VARCHAR(100),
    state VARCHAR(50),
    user_id INT,
    FOREIGN KEY(user_id) REFERENCES  users(id) ON DELETE CASCADE
);


CREATE TABLE comments(
    id SERIAL PRIMARY KEY,
    user_id INTEGER NULL,
    product_id INTEGER NOT NULL,
    sent_at TIMESTAMP DEFAULT NOW(),
    text VARCHAR(200) NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE CASCADE
);


CREATE TABLE badges(
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    weight INT NOT NULL,
    price INTEGER NOT NULL
);


CREATE TABLE contains_badge(
    badge_id INT,
    product_id INT,
    FOREIGN KEY(badge_id) REFERENCES badges(id) ON DELETE CASCADE,
    FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE CASCADE
);