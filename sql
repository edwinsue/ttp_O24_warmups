--Finding the average payment amount
SELECT 
ROUND(AVG (amount),2) 
FROM payment

--AVG of payment amounts = 4.20

SELECT
ROUND(STDDEV_POP(amount),2)
FROM payment

--STDDEV of payment amounts = 2.37

WITH transaction_handled_per_employee AS (
	SELECT
	staff_id,
	COUNT(payment_id) AS total_transaction_handled_by_this_employee
	FROM payment
	GROUP BY staff_id
)

SELECT
ROUND(STDDEV_POP(total_transaction_handled_by_this_employee),2) AS STDDEV
FROM transaction_handled_per_employee

--STDDEV of employee purchases = 6.00

WITH avg_lifetime_purchase_by_customer AS (
	SELECT 
	customer_id,
	ROUND(AVG(amount),2) AS avg_lifetime_purchase
	FROM payment
	GROUP BY customer_id
	ORDER BY avg_lifetime_purchase DESC
)

SELECT
ROUND(STDDEV_POP(avg_lifetime_purchase),2)
FROM avg_lifetime_purchase_by_customer

--STDDEV of customer payment = 0.49 (customer 187 (high) and 288 (low) are the most "unpredictable" as their
--lifetime amounts are 2.89 standard deviations away from the average customer spending)

WITH rental_by_customer AS (
	SELECT
	customer_id,
	COUNT(rental_id) AS total_rental_by_customer
	FROM payment
	GROUP BY customer_id
)

SELECT
ROUND(AVG(total_rental_by_customer),2) AS GENERAL_AVG,
ROUND(STDDEV_POP(total_rental_by_customer),2) AS STD_DEV
FROM rental_by_customer

--I would say our customer base rents more or less the same number of videos individually (a standard deviation of 5 rentals from customer to customer is pretty "reliable")