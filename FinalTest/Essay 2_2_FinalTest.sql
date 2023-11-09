DELETE FROM raw_users
WHERE user_id IN (
  SELECT user_id
  FROM raw_users
  GROUP BY user_id
  HAVING COUNT(*) > 1
);

INSERT INTO dim_user 
SELECT DISTINCT ON (user_id) user_id, user_name, country
FROM raw_users
WHERE NOT EXISTS (
  SELECT user_id 
  FROM dim_user
  WHERE dim_user.user_id = raw_users.user_id
);