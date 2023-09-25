--Create database
CREATE DATABASE node_35
--Use database
USE node_35;
--Create table user 
CREATE TABLE user(user_id INT PRIMARY KEY AUTO_INCREMENT, full_name VARCHAR(50),email VARCHAR(30), password VARCHAR(50))
--Insert value user
INSERT INTO user (full_name, email, password)
VALUES
  ('John Doe', 'john@example.com', 'password123'),
  ('Alice Smith', 'alice@example.com', 'securepass'),
  ('Bob Johnson', 'bob@example.com', 'secret'),
  ('Eve Brown', 'eve@example.com', 'mypassword'),
  ('Charlie Wilson', 'charlie@example.com', '123456');
--Create restaurant
CREATE TABLE restaurant(res_id INT PRIMARY KEY AUTO_INCREMENT,res_name VARCHAR(30),image VARCHAR(250),description VARCHAR(250))
--Insert value restaurant
INSERT INTO restaurant (res_name, image, description)
VALUES
  ('Restaurant A', 'image_a.jpg', 'A cozy place with a variety of cuisines.'),
  ('Restaurant B', 'image_b.jpg', 'Modern dining experience with a view.'),
  ('Restaurant C', 'image_c.jpg', 'Traditional dishes in a historic setting.'),
  ('Restaurant D', 'image_d.jpg', 'Family-friendly atmosphere and tasty food.'),
  ('Restaurant E', 'image_e.jpg', 'Gourmet dining for special occasions.');

--Create food_type
CREATE TABLE food_type(type_id INT PRIMARY KEY AUTO_INCREMENT,type_name VARCHAR(200)) 
--Insert value for food_type
INSERT INTO food_type (type_name)
VALUES
  ('Italian'),
  ('Japanese'),
  ('Mexican'),
  ('Indian'),
  ('Chinese');

--Create food
CREATE TABLE food(food_id INT PRIMARY KEY AUTO_INCREMENT,food_name VARCHAR(50),image VARCHAR(250),price FLOAT,description VARCHAR(200),type_id INT, FOREIGN KEY(type_id) REFERENCES food_type(type_id))
--Insert value for food
INSERT INTO food (food_name, image, price, description, type_id)
VALUES
  ('Spaghetti Carbonara', 'spaghetti.jpg', 12.99, 'Creamy Italian pasta dish', 1),
  ('Sushi Platter', 'sushi.jpg', 24.99, 'Assorted sushi rolls', 2),
  ('Taco Salad', 'taco.jpg', 8.99, 'Mexican salad with seasoned beef', 3),
  ('Chicken Tikka Masala', 'chicken.jpg', 14.99, 'Indian chicken curry', 4),
  ('General Tso Chicken', 'general_tso.jpg', 11.99, 'Chinese spicy chicken dish', 5);

--Create sub_food
CREATE TABLE sub_food(sub_id INT PRIMARY KEY AUTO_INCREMENT,sub_name VARCHAR(50),sub_price FLOAT,food_id INT,FOREIGN KEY(food_id) REFERENCES food(food_id))

--Insert value for sub_food
INSERT INTO sub_food (sub_name, sub_price, food_id)
VALUES
  ('Garlic Bread', 3.99, 1),
  ('Miso Soup', 2.49, 2),
  ('Guacamole', 1.99, 3),
  ('Naan Bread', 2.99, 4),
  ('Egg Drop Soup', 2.49, 5);

--Create like_res
CREATE TABLE like_res(like_res_id INT PRIMARY KEY AUTO_INCREMENT,user_id INT,FOREIGN KEY(user_id) REFERENCES user(user_id),res_id INT,FOREIGN KEY(res_id) REFERENCES restaurant(res_id),date_like DATETIME)

--Insert value for like_res
INSERT INTO like_res (user_id, res_id, date_like)
VALUES
  (1, 1, '2023-09-24 10:00:00'),
  (2, 2, '2023-09-24 10:15:00'),
  (3, 3, '2023-09-24 10:30:00'),
  (4, 4, '2023-09-24 10:45:00'),
  (5, 5, '2023-09-24 11:00:00'),
  (1, 2, '2023-09-24 11:15:00'),
  (2, 3, '2023-09-24 11:30:00'),
  (3, 4, '2023-09-24 11:45:00'),
  (4, 5, '2023-09-24 12:00:00'),
  (5, 1, '2023-09-24 12:15:00');

--Create rate_res
CREATE TABLE rate_res(rate_res_id INT PRIMARY KEY AUTO_INCREMENT,user_id INT,FOREIGN KEY(user_id) REFERENCES user(user_id),res_id INT,FOREIGN KEY(res_id) REFERENCES restaurant(res_id),amount INT,date_rate DATETIME)

--Insert value for rate_res
INSERT INTO rate_res (user_id, res_id, amount, date_rate)
VALUES
  (1, 1, 4, '2023-09-24 10:00:00'),
  (2, 2, 5, '2023-09-24 10:15:00'),
  (3, 3, 3, '2023-09-24 10:30:00'),
  (4, 4, 4, '2023-09-24 10:45:00'),
  (5, 5, 5, '2023-09-24 11:00:00'),
  (1, 2, 4, '2023-09-24 11:15:00'),
  (2, 3, 5, '2023-09-24 11:30:00'),
  (3, 4, 3, '2023-09-24 11:45:00'),
  (4, 5, 4, '2023-09-24 12:00:00'),
  (5, 1, 5, '2023-09-24 12:15:00');
--Create order
CREATE TABLE orders(oder_id INT PRIMARY KEY AUTO_INCREMENT,user_id INT,FOREIGN KEY(user_id) REFERENCES user(user_id),food_id INT,FOREIGN KEY(food_id) REFERENCES food(food_id),code VARCHAR(50),arr_sub_id VARCHAR(500))
--Insert value for orders
INSERT INTO orders (user_id, food_id, code, arr_sub_id)
VALUES
  (1, 1, 'ORDER123', '1,2,3'),
  (2, 2, 'ORDER456', '4,5'),
  (3, 3, 'ORDER789', '6'),
  (4, 4, 'ORDERABC', '7,8,9'),
  (5, 5, 'ORDERXYZ', '10');
------------Tìm 5 người like nhiều nhà hàng nhất---------
SELECT COUNT(lr.user_id) AS  count_like_user,u.full_name,u.email,lr.user_id
FROM like_res as lr
INNER JOIN user as u on lr.user_id = u.user_id
GROUP BY u.full_name,u.email,lr.user_id
ORDER BY COUNT(lr.user_id) DESC
limit 5
------Tìm 2 nhà hàng có lượt like nhiều nhất----
SELECT COUNT(lr.res_id) AS  count_like_restaurant,r.res_name,r.image,lr.res_id
FROM like_res as lr
INNER JOIN restaurant as r on lr.res_id = r.res_id
GROUP BY r.res_name,r.image,lr.res_id
ORDER BY COUNT(lr.res_id) DESC
limit 2
------Tìm người đã đặt hàng nhiều nhất---
SELECT COUNT(o.user_id) AS count_order_user,o.user_id,u.full_name,u.email
FROM orders as o
INNER JOIN user as u on o.user_id =u.user_id
GROUP BY o.user_id,u.full_name,u.email
ORDER BY COUNT(o.user_id) DESC
LIMIT 1
-------Tìm người dùng không hoạt động trong hệ thống-----
---(không đặt hàng, không like, không đánh giá nhà--
SELECT u.user_id, u.full_name
FROM user u
INNER JOIN like_res AS l ON u.user_id = l.user_id
LEFT JOIN orders AS o ON u.user_id = o.user_id
LEFT JOIN rate_res AS r ON u.user_id = r.user_id
WHERE l.like_res_id IS NULL AND o.oder_id IS NULL AND r.rate_res_id IS NULL;

