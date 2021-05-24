DROP TABLE IF EXISTS a;
DROP TABLE IF EXISTS b;

CREATE TABLE a (
    start_date VARCHAR (30),
    end_date   VARCHAR (30) 
);
CREATE TABLE b (
    date         VARCHAR(30),
    num_visitors INT
);

INSERT INTO a (start_date, end_date)
VALUES
  ('2020-01-01', '2020-01-05'),
  ('2020-01-04', '2020-01-10'),
  ('2020-01-06', '2020-01-11');  
INSERT INTO b (date, num_visitors)
VALUES
  ('2020-01-01', 53),
  ('2020-01-02', 32),
  ('2020-01-03', 84),
  ('2020-01-04', 63),
  ('2020-01-05', 92),
  ('2020-01-06', 81),
  ('2020-01-07', 52),
  ('2020-01-08', 111),
  ('2020-01-09', 113),
  ('2020-01-10', 29),
  ('2020-01-11', 116);

SELECT
  start_date,
  end_date,
  (SELECT SUM(CASE
                WHEN date
                BETWEEN start_date AND end_date
                THEN num_visitors
                END)
  FROM b) AS total_visitors
FROM a
ORDER BY total_visitors DESC
LIMIT 1;

SELECT
  start_date,
  end_date,
  (SELECT SUM(num_visitors)
  FROM b
  WHERE date BETWEEN start_date AND end_date) AS total_visitors
FROM a
ORDER BY total_visitors DESC
LIMIT 1;