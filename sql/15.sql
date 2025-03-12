/*
 * Compute the total revenue for each film.
 */


SELECT 
    f.title, 
    COALESCE(SUM(p.amount), 0.00) AS revenue
FROM film f
LEFT JOIN inventory i USING (film_id)
LEFT JOIN rental r USING (inventory_id)
LEFT JOIN payment p USING (rental_id)
GROUP BY f.film_id, f.title
ORDER BY revenue DESC, f.title;

