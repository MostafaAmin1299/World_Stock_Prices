DROP VIEW IF EXISTS q3_avg_price_volume_score;
CREATE OR REPLACE VIEW q3_avg_price_volume_score 
AS
WITH computed_scores AS (
    SELECT 
        ticker,
        brand_name,
        industry_tag,
        country,
        date,
        ((close - open) / NULLIF(open, 0)) AS price_change_ratio,
        ((volume - LAG(volume, 1) OVER (PARTITION BY ticker ORDER BY date)) / 
          NULLIF(LAG(volume, 1) OVER (PARTITION BY ticker ORDER BY date), 0)) AS volume_change_ratio
    FROM stock_data
)
SELECT 
    ticker,
    brand_name,
    industry_tag,
    country,
    AVG(price_change_ratio * volume_change_ratio) AS avg_score
FROM computed_scores
WHERE price_change_ratio IS NOT NULL 
  AND volume_change_ratio IS NOT NULL
GROUP BY ticker, brand_name, industry_tag, country
ORDER BY avg_score DESC;
