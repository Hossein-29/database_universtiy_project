-- command to run this on your local database
-- cd directory_of_this_file
-- psql -d database_name < tables.sql


DROP TABLE IF EXISTS admins;
CREATE TABLE admins(
    id INT Auto_Increment PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    username VARCHAR(50),
    access_level INTEGER
);

DROP TABLE IF EXISTS users;
CREATE TABLE users(
    id INT Auto_Increment PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    province VARCHAR(50),
    city VARCHAR(50),
    email VARCHAR(50),
    phone VARCHAR(50)
);

DROP TABLE IF EXISTS wallets;
CREATE TABLE wallets(
    id INT Auto_Increment PRIMARY KEY,
    amount INT DEFAULT 0,
    FOREIGN KEY(id) REFERENCES users(id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS payments;
CREATE TABLE payments(
    id INT Auto_Increment PRIMARY KEY,
    amount INTEGER,
    user_id INTEGER,
    FOREIGN KEY(user_id) REFERENCES users(id)
);
DROP TABLE IF EXISTS categories;
CREATE TABLE categories(
    id INT Auto_Increment PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    parent_id INTEGER,
    FOREIGN KEY(parent_id) REFERENCES categories(id) ON DELETE SET NULL
);

DROP TABLE IF EXISTS products;
CREATE TABLE products(
    id INT Auto_Increment PRIMARY KEY,
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

DROP TABLE IF EXISTS comments;
CREATE TABLE comments(
    id INT Auto_Increment PRIMARY KEY,
    user_id INTEGER NULL,
    product_id INTEGER NOT NULL,
    sent_at TIMESTAMP DEFAULT NOW(),
    text VARCHAR(200) NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS badges;
CREATE TABLE badges(
    id INT Auto_Increment PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    weight INT NOT NULL,
    price INTEGER NOT NULL
);

DROP TABLE IF EXISTS contains_badge;
CREATE TABLE contains_badge(
    badge_id INT,
    product_id INT,
    FOREIGN KEY(badge_id) REFERENCES badges(id) ON DELETE CASCADE,
    FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE CASCADE
);




