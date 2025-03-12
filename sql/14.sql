/*
 * Create a report that shows the total revenue per month and year.
 *
 * HINT:
 * This query is very similar to the previous problem,
 * but requires an additional JOIN.
 */



SELECT
    EXTRACT (YEAR FROM rental_date) as "Year",
    EXTRACT (MONTH FROM rental_date) as "Month",
    SUM (payment.amount) as "Total Revenue"
FROM rental
JOIN payment USING (rental_id)
GROUP BY
    ROLLUP (EXTRACT (YEAR FROM rental_date), EXTRACT (MONTH FROM rental_date)
    )
ORDER BY "Year", "Month";
