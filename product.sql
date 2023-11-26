select 'shell' as component, 'Bébé arrive !' as title;

create temporary table if not exists current_product(title text, description text, link text, image_url text, price money, created_at timestamp);
delete from current_product;
insert into current_product select title, description, link, image_url, price, created_at from products where id = $id::int;

select 'datagrid' as component, title
from current_product;

select 'Ajouté le' as title, to_char(created_at, 'DD / MM') as description
from current_product;

select 
    'Prix' as title,
    format('%s €', price::decimal) as description
from current_product;
select 
    'Acheter en ligne' as title,
    regexp_substr(link, '[^/]+', 1, 2)  as description,
    link,
    'blue'  as color,
    'world' as icon
from current_product;

set reserved_by = (
    select name from reservation
    where product_id = $id::int and canceled_at is null
    order by created_at desc
    limit 1
);
select 'Statut' as title,
    CASE $reserved_by IS NULL
        WHEN TRUE THEN 'Disponible'
        ELSE format('Réservé par %s', $reserved_by)
    END as description,
    CASE $reserved_by IS NULL
        WHEN TRUE THEN 'green'
        ELSE 'yellow'
    END as color,
    CASE $reserved_by IS NULL
        WHEN TRUE THEN 'check'
        ELSE 'user'
    END as icon;

select 'button' as component;
select
    'Annuler la réservation de ' || $reserved_by as title,
    'cancel_reservation.sql?id='||$id as link,
    'trash' as icon,
    'red' as color
where $reserved_by is not null;

select 'form' as component, 'Réserver' as title, 'Réserver' as validate, 'reservation.sql?id='||$id as action;
select 'text' as type, 'Nom' as name, true as required,
       'Si vous voulez offrir ce produit, renseignez votre nom ici pour le réserver.' as description;