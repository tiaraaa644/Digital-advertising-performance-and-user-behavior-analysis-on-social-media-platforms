SELECT * FROM dataset_social_media.users LIMIT 10;
SELECT * FROM dataset_social_media.ads LIMIT 10;
SELECT * FROM dataset_social_media.campaigns LIMIT 10;
SELECT * FROM dataset_social_media.ad_events LIMIT 10;

-- data cleaning
SELECT *
FROM dataset_social_media.users
WHERE user_id IS NULL
   OR user_gender IS NULL
   OR user_age IS NULL;

SELECT *
FROM dataset_social_media.ads
WHERE ad_id IS NULL
   OR campaign_id IS NULL;

SELECT *
FROM dataset_social_media.campaigns
WHERE campaign_id IS NULL
   OR total_budget IS NULL;


--duplikat
SELECT *
FROM dataset_social_media.ad_events
WHERE user_id IS NULL
   OR ad_id IS NULL
   OR event_type IS NULL;

SELECT user_id, COUNT(*)
FROM dataset_social_media.users
GROUP BY user_id
HAVING COUNT(*) > 1;

SELECT ad_id, COUNT(*)
FROM dataset_social_media.ads
GROUP BY ad_id
HAVING COUNT(*) > 1;

SELECT campaign_id, COUNT(*)
FROM dataset_social_media.campaigns
GROUP BY campaign_id
HAVING COUNT(*) > 1;

SELECT event_id, COUNT(*)
FROM dataset_social_media.ad_events
GROUP BY event_id
HAVING COUNT(*) > 1;

--cek format tanggal
SELECT timestamp
FROM dataset_social_media.ad_events
LIMIT 10;

SELECT DISTINCT event_type
FROM dataset_social_media.ad_events;

SELECT DISTINCT user_gender
FROM dataset_social_media.users;

SELECT ae.event_type, COUNT(*) AS total
FROM dataset_social_media.ad_events ae
JOIN dataset_social_media.users u ON ae.user_id = u.user_id
JOIN dataset_social_media.ads a ON ae.ad_id = a.ad_id
JOIN dataset_social_media.campaigns c ON a.campaign_id = c.campaign_id
GROUP BY ae.event_type
ORDER BY total DESC;






