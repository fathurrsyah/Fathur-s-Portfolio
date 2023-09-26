SELECT DISTINCT num
FROM (
  SELECT num,
         LAG(num) OVER (ORDER BY id) AS prev_num,
         LEAD(num) OVER (ORDER BY id) AS next_num
  FROM input_table
) AS subquery
WHERE num = prev_num AND num = next_num
ORDER BY num;
