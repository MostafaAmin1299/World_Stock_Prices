DROP VIEW IF EXISTS q6_volume_by_industry;

CREATE OR REPLACE VIEW q6_volume_by_industry AS
SELECT 
    industry_tag,
    date,
    country,
    SUM(volume) AS total_volume
FROM 
    stock_data
GROUP BY 
    industry_tag, 
    date, 
    country
ORDER BY 
    industry_tag, 
    date;
