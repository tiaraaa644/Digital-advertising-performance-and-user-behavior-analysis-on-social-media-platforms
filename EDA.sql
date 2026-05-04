SELECT 
    c.name AS campaign_name,
    c.total_budget,
    COUNT(*) AS total_purchase
FROM dataset_social_media.ad_events ae
JOIN dataset_social_media.ads a 
    ON ae.ad_id = a.ad_id
JOIN dataset_social_media.campaigns c 
    ON a.campaign_id = c.campaign_id
WHERE ae.event_type = 'Purchase'
GROUP BY c.name, c.total_budget
ORDER BY total_purchase DESC;

SELECT 
    u.age_group,
    COUNT(*) AS total_purchase
FROM dataset_social_media.ad_events ae
JOIN dataset_social_media.users u 
    ON ae.user_id = u.user_id
WHERE ae.event_type = 'Purchase'
GROUP BY u.age_group
ORDER BY total_purchase DESC;

SELECT 
    ad_id,
    COUNT(CASE WHEN event_type = 'Impression' THEN 1 END) AS impressions,
    COUNT(CASE WHEN event_type = 'Purchase' THEN 1 END) AS purchases,
    ROUND(
        COUNT(CASE WHEN event_type = 'Purchase' THEN 1 END) * 100.0 /
        NULLIF(COUNT(CASE WHEN event_type = 'Impression' THEN 1 END), 0),
    2) AS conversion_rate_percent
FROM dataset_social_media.ad_events
GROUP BY ad_id
ORDER BY conversion_rate_percent DESC;


--1. Which advertisements generate the highest user engagement and purchases?
SELECT 
    ad_id,
    COUNT(CASE WHEN event_type = 'Impression' THEN 1 END) AS impressions,
    COUNT(CASE WHEN event_type = 'Like' THEN 1 END) AS likes,
    COUNT(CASE WHEN event_type = 'Share' THEN 1 END) AS shares,
    COUNT(CASE WHEN event_type = 'Purchase' THEN 1 END) AS purchases
FROM dataset_social_media.ad_events
GROUP BY ad_id
ORDER BY purchases DESC;


--2. Which advertisements have the highest conversion rates?
SELECT 
    ad_id,
    COUNT(CASE WHEN event_type = 'Impression' THEN 1 END) AS impressions,
    COUNT(CASE WHEN event_type = 'Purchase' THEN 1 END) AS purchases,
    ROUND(
        COUNT(CASE WHEN event_type = 'Purchase' THEN 1 END) * 100.0 /
        NULLIF(COUNT(CASE WHEN event_type = 'Impression' THEN 1 END), 0),
    2) AS conversion_rate_percent
FROM dataset_social_media.ad_events
GROUP BY ad_id
ORDER BY conversion_rate_percent DESC;


--3. Are advertisements being targeted to users with matching interests?
SELECT 
    u.user_id,
    u.interests,
    a.ad_id,
    a.target_interests,

    CASE 
        WHEN 
            (LOWER(u.interests) LIKE '%gaming%' AND LOWER(a.target_interests) LIKE '%gaming%')
            OR (LOWER(u.interests) LIKE '%food%' AND LOWER(a.target_interests) LIKE '%food%')
            OR (LOWER(u.interests) LIKE '%health%' AND LOWER(a.target_interests) LIKE '%health%')
            OR (LOWER(u.interests) LIKE '%finance%' AND LOWER(a.target_interests) LIKE '%finance%')
            OR (LOWER(u.interests) LIKE '%fashion%' AND LOWER(a.target_interests) LIKE '%fashion%')
            OR (LOWER(u.interests) LIKE '%travel%' AND LOWER(a.target_interests) LIKE '%travel%')
            OR (LOWER(u.interests) LIKE '%photography%' AND LOWER(a.target_interests) LIKE '%photography%')
            OR (LOWER(u.interests) LIKE '%lifestyle%' AND LOWER(a.target_interests) LIKE '%lifestyle%')
            OR (LOWER(u.interests) LIKE '%technology%' AND LOWER(a.target_interests) LIKE '%technology%')
        THEN 'MATCH'
        ELSE 'NOT MATCH'
    END AS targeting_result
    
    
--4. When are users most active?
SELECT 
    day_of_week,
    time_of_day,
    COUNT(*) AS total_interactions
FROM dataset_social_media.ad_events
GROUP BY day_of_week, time_of_day
ORDER BY total_interactions DESC;

--5. Which demographic groups are most active?
SELECT 
    u.user_gender,
    u.age_group,
    u.country,
    COUNT(e.event_id) AS total_interactions
FROM dataset_social_media.users u
JOIN dataset_social_media.ad_events e 
    ON u.user_id = e.user_id
GROUP BY u.user_gender, u.age_group, u.country
ORDER BY total_interactions DESC;

--6. Which campaigns are most efficient?
SELECT 
    c.campaign_id,
    c.name,
    c.total_budget,
    
    COUNT(CASE WHEN e.event_type = 'Purchase' THEN 1 END) AS purchases,

    ROUND(
        COUNT(CASE WHEN e.event_type = 'Purchase' THEN 1 END) * 1.0 
        / NULLIF(c.total_budget, 0),
    6) AS efficiency_score

FROM dataset_social_media.campaigns c
JOIN dataset_social_media.ads a 
    ON c.campaign_id = a.campaign_id
JOIN dataset_social_media.ad_events e 
    ON a.ad_id = e.ad_id

GROUP BY c.campaign_id, c.name, c.total_budget
ORDER BY efficiency_score DESC;


