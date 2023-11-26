insert into reservation (product_id, name)
select $id::int, :Nom
where :Nom is not null
returning
    'redirect' as component,
    'product.sql?id='||$id as link;