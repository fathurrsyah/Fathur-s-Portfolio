CREATE SEQUENCE performance_seq;

CREATE TABLE fact_post_performance (
  performance_id SERIAL PRIMARY KEY,
  post_id INT NOT NULL,
  date_id INT NOT NULL,
  views INT,
  likes INT,

  FOREIGN KEY (post_id) REFERENCES dim_post(post_id),
  FOREIGN KEY (date_id) REFERENCES dim_date(date_id)
);

INSERT INTO fact_post_performance
SELECT 
  nextval('performance_seq'),
  p.post_id,
  d.date_id,
  -- views logic
  COUNT(l.like_id) AS likes
FROM raw_posts p
LEFT JOIN raw_likes l ON l.post_id = p.post_id 
LEFT JOIN dim_date d ON d.date = p.post_date
GROUP BY p.post_id, d.date_id;