DROP VIEW IF EXISTS q5_avg_daily_volatility_by_month;

CREATE OR REPLACE VIEW q5_avg_daily_volatility_by_month AS
SELECT 
    ticker,
    brand_name,
    TO_CHAR(date, 'YYYY-MM') AS year_month,
    AVG(((high - low) / NULLIF(open, 0)) * 100) AS daily_volatility
FROM 
    stock_data
GROUP BY 
    ticker, 
    brand_name, 
    year_month
ORDER BY 
    ticker, 
    year_month;
