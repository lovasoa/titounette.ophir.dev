select 'shell' as component,
    'Bébé arrive !' as title,
    (
        case when sqlpage.cookie('session_token') is null then 'login'
        else 'logout' end
    ) as menu_item;

select 'text' as component,
    sqlpage.read_file_as_text('welcome.md') as contents_md;

select 'card' as component;
with products_info as (
        select *, 
        (select name from reservation where product_id = products.id and canceled_at is null) as reserved_by,
        id = $created_id::int as is_created
        from products
)
select title, description, image_url as top_image,
       price::decimal::text || ' €' || coalesce(' (réservé par ' || reserved_by || ')', '') as footer,
       case when is_created then 'check' when reserved_by is not null then 'user' end as icon,
       case when is_created then 'green' when reserved_by is not null then 'azure' end as color,
       'product.sql?id='||id as link
from products_info
order by created_at desc;

select 'button' as component;
select
    'Ajouter une nouvelle idée cadeau' as title,
    'upload_form.sql' as link,
    'plus' as icon,
    'secondary' as color;
