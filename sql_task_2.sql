-- Описвние базы и функции приведено в файле db
CREATE OR REPLACE FUNCTION calculate_total_price_for_orders_group(_row_id int) RETURNS bigint AS $$
	WITH RECURSIVE r AS (

		SELECT orders.row_id, orders.parent_id, orders.customer
		FROM orders
		WHERE orders.row_id = _row_id


		UNION 

		SELECT orders.row_id, orders.parent_id, orders.customer
		FROM orders
		JOIN r ON orders.parent_id = r.row_id
	)

	SELECT SUM(price) FROM r
	JOIN order_items ON order_items.order_id = r.row_id
	--GROUP BY customer

$$ LANGUAGE SQL;

SELECT calculate_total_price_for_orders_group (3) AS total_price;