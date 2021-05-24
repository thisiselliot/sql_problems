DROP TABLE IF EXISTS sales_amount_table;
DROP TABLE IF EXISTS exchange_rate_table;

CREATE TABLE sales_amount_table (
    sales_date   VARCHAR (30),
    sales_amount INT,
    currency     VARCHAR (30) 
);
CREATE TABLE exchange_rate_table (
    source_currency      VARCHAR(30),
    target_currency      VARCHAR(30),
    exchange_rate        NUMERIC(18,2),
    effective_start_date VARCHAR(30)
);

INSERT INTO sales_amount_table (sales_date,
                                sales_amount,
                                currency)
VALUES
  ('2020-01-01', 500, 'INR'),
  ('2020-01-01', 100, 'GDP'),
  ('2020-01-02', 1000, 'INR'),
  ('2020-01-02', 500, 'GDP'),
  ('2020-01-03', 500, 'INR'),
  ('2020-01-17', 200, 'GDP');  
INSERT INTO exchange_rate_table (source_currency,
                                 target_currency,
                                 exchange_rate,
                                 effective_start_date)
VALUES
  ('INR', 'USD', 0.14, '2019-12-31'),
  ('INR', 'USD', 0.15, '2020-01-02'),
  ('GDP', 'USD', 1.32, '2019-12-20'),
  ('GDP', 'USD', 1.3, '2020-01-01'),
  ('GDP', 'USD', 1.35, '2020-01-16');

SELECT
  sales_date,
  SUM(sales_amount * (SELECT exchange_rate
                       FROM exchange_rate_table
                       WHERE source_currency = currency
                       AND effective_start_date <= sales_date
                       ORDER BY effective_start_date DESC
                       LIMIT 1)) AS total_sales_USD
FROM sales_amount_table
GROUP BY sales_date;