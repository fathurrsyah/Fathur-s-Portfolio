CREATE TABLE dim_user (
  user_id INT PRIMARY KEY,
  user_name VARCHAR(100),
  country VARCHAR(50)
);

INSERT INTO dim_user
SELECT DISTINCT user_id, user_name, country
FROM raw_users;

CREATE TABLE dim_post (
  post_id INT PRIMARY KEY,
  post_text VARCHAR(500)
);

INSERT INTO dim_post 
SELECT DISTINCT post_id, post_text
FROM raw_posts;

CREATE TABLE dim_date (
  date_id SERIAL PRIMARY KEY,
  date DATE UNIQUE NOT NULL,
  day INT NOT NULL,
  month INT NOT NULL, 
  year INT NOT NULL
);

INSERT INTO dim_date (date, day, month, year)
SELECT DISTINCT post_date, 
  EXTRACT(DAY FROM post_date),
  EXTRACT(MONTH FROM post_date),
  EXTRACT(YEAR FROM post_date)
FROM raw_posts
UNION 
SELECT DISTINCT like_date,
  EXTRACT(DAY FROM like_date),
  EXTRACT(MONTH FROM like_date),
  EXTRACT(YEAR FROM like_date)
FROM raw_likes;