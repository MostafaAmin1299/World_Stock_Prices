DROP VIEW IF EXISTS q1_stock_performance_summary;

CREATE OR REPLACE VIEW q1_stock_performance_summary AS
SELECT 
    ticker,
    brand_name,
    industry_tag,
	TO_CHAR(DATE_TRUNC('month', date), 'YYYY-MM') AS year_month,
	TO_CHAR(DATE_TRUNC('year', date), 'YYYY') AS year,
    country,
    MAX(close - open) AS max_gain,
    SUM(volume) AS total_volume,
    AVG(close - open) AS avg_gain,
    RANK() OVER (
        PARTITION BY industry_tag 
        ORDER BY MAX(close - open) DESC
    ) AS rank_in_industry_with_max_gain
FROM 
    stock_data
GROUP BY 
    ticker, 
    brand_name, 
    industry_tag, 
    country,
	year_month,
	year
ORDER BY 
    industry_tag, 
	rank_in_industry_with_max_gain, 
	year_month;
