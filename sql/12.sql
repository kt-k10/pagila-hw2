/*
 * List the title of all movies that have both the 'Behind the Scenes' and the 'Trailers' special_feature
 *
 * HINT:
 * Create a select statement that lists the titles of all tables with the 'Behind the Scenes' special_feature.
 * Create a select statement that lists the titles of all tables with the 'Trailers' special_feature.
 * Inner join the queries above.
 */


SELECT bts.title
FROM (
    SELECT title, film_id
    FROM film
    CROSS JOIN unnest(special_features) AS special_feature
    WHERE special_feature = 'Behind the Scenes'
) AS bts
INNER JOIN (
    SELECT title, film_id
    FROM film
    CROSS JOIN unnest(special_features) AS special_feature
    WHERE special_feature = 'Trailers'
) AS t USING (film_id)
ORDER BY bts.title;

