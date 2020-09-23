-- Описвние базы и функции приведено в файле db
CREATE OR REPLACE FUNCTION select_orders_by_item_name(order_items_name varchar) 
RETURNS TABLE(order_id int, customer varchar, items_count bigint) AS $$

SELECT oi.order_id, o.customer, count(oi.name) AS items_count
FROM orders o
JOIN order_items oi ON o.row_id = oi.order_id

WHERE oi.name = order_items_name
GROUP BY oi.order_id, o.customer, oi.name

$$ LANGUAGE SQL;

SELECT * FROM select_orders_by_item_name('Стулья');