/*
 * List the name of all actors who have appeared in a movie that has the 'Behind the Scenes' special_feature
 */



SELECT DISTINCT (first_name || ' ' || last_name) AS "Actor Name"
FROM actor
JOIN film_actor USING (actor_id)
JOIN film USING (film_id)
CROSS JOIN unnest(special_features) AS feature
WHERE feature = 'Behind the Scenes'
ORDER BY "Actor Name";
