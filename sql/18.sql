/*
 * Compute the total revenue for each film.
 * The output should include another new column "revenue percent" that shows the percent of total revenue that comes from the current film and all previous films.
 * That is, the "revenue percent" column is 100*"total revenue"/sum(revenue)
 *
 * HINT:
 * The `to_char` function can be used to achieve the correct formatting of your percentage.
 * See: <https://www.postgresql.org/docs/current/functions-formatting.html#FUNCTIONS-FORMATTING-EXAMPLES-TABLE>
 */



SELECT 
    cumulative_revenue_data.rank, 
    cumulative_revenue_data.title, 
    cumulative_revenue_data.revenue, 
    cumulative_revenue_data."total revenue", 
    TO_CHAR((100 * cumulative_revenue_data."total revenue" / SUM(cumulative_revenue_data.revenue) OVER ()), 'FM900.00') AS "percent revenue"
FROM (
    SELECT 
        film_revenue_data.rank, 
        film_revenue_data.title, 
        film_revenue_data.revenue,
        SUM(film_revenue_data.revenue) OVER (ORDER BY film_revenue_data.revenue DESC, film_revenue_data.rank) AS "total revenue"
    FROM (
        SELECT 
            RANK() OVER (ORDER BY COALESCE(SUM(payment.amount), 0.00) DESC) AS rank,
            title, 
            COALESCE(SUM(payment.amount), 0.00) AS revenue
        FROM film
        LEFT JOIN inventory USING (film_id)
        LEFT JOIN rental USING (inventory_id)
        LEFT JOIN payment USING (rental_id)
        GROUP BY film_id, title
        ORDER BY revenue DESC, title
    ) AS film_revenue_data
    GROUP BY film_revenue_data.rank, film_revenue_data.title, film_revenue_data.revenue
    ORDER BY film_revenue_data.rank, film_revenue_data.title
) AS cumulative_revenue_data;

