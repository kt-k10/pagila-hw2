/*
 * Count the number of movies that contain each type of special feature.
 * Order the results alphabetically be the special_feature.
 */

SELECT sp.special_features, count(sp.special_features)
FROM film f
CROSS JOIN UNNEST(special_features) AS sp(special_features)
GROUP BY sp.special_features
ORDER BY sp.special_features;


