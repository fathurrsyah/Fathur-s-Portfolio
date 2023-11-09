CREATE SEQUENCE fact_seq;

CREATE TABLE fact_daily_posts (
  id SERIAL PRIMARY KEY,
  user_id INT NOT NULL,
  date_id INT NOT NULL,
  posts_count INT NOT NULL,
  
  FOREIGN KEY (user_id) REFERENCES dim_user(user_id),
  FOREIGN KEY (date_id) REFERENCES dim_date(date_id)
);

INSERT INTO fact_daily_posts
SELECT 
  nextval('fact_seq'),
  p.user_id,
  d.date_id,
  COUNT(p.post_id) AS posts_count
FROM raw_posts p
JOIN dim_date d ON d.date = p.post_date
GROUP BY p.user_id, d.date_id
ORDER BY d.date_id;