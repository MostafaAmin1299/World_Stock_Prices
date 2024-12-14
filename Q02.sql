DROP VIEW IF EXISTS q2_stability_score_rank;

CREATE OR REPLACE VIEW q2_stability_score_rank AS
SELECT 
    ticker, 
    brand_name, 
    industry_tag,
	TO_CHAR(DATE_TRUNC('year', date), 'YYYY') AS year,
    CAST(ROUND(1 / (STDDEV(close) * (1 + AVG(volume))), 12) AS NUMERIC(20, 12)) AS stability_score,
    RANK() OVER (
        PARTITION BY industry_tag 
        ORDER BY CAST(ROUND(1 / (STDDEV(close) * (1 + AVG(volume))), 12) AS NUMERIC(20, 12)) DESC
    ) AS rank
FROM 
    stock_data
WHERE 
    volume IS NOT NULL
GROUP BY 
    ticker, 
    brand_name, 
    industry_tag,
	year
ORDER BY 
    industry_tag,
	rank;
