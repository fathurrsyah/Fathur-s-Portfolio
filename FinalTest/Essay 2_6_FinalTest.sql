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