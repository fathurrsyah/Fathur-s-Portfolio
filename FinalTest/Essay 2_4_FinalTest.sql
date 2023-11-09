INSERT INTO fact_post_performance
SELECT
  nextval('performance_seq'),
  p.post_id,
  d.date_id,

  COUNT(l.like_id) AS likes  
FROM raw_posts p
LEFT JOIN raw_likes l ON p.post_id = l.post_id
LEFT JOIN dim_date d ON d.date = p.post_date
-- LEFT JOIN raw_views v ON v.post_id = p.post_id
GROUP BY p.post_id, d.date_id
ORDER BY d.date;