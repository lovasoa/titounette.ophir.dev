update reservation set canceled_at = current_timestamp where product_id = $id::int;
select 'redirect' as component, 'product.sql?id='||$id as link;