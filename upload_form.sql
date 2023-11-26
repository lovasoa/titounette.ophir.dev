select 'redirect' as component, '/login.sql' as link -- redirect to the login page if the user is not logged in
where not exists (
    select true
    from session
    where 
        sqlpage.cookie('session_token') = id and
        created_at > CURRENT_TIMESTAMP - INTERVAL '1 day' -- require the user to log in again after 1 day
); 

select 'form' as component, 'Nouveau produit' as title, 'upload.sql' as action, 'Ajouter' as validate;
select 'text' as type, 'Nom' as name, 'Nom du produit' as label, true as required, 'Biberon du futur' as placeholder;
select 'textarea' as type, 'Description' as name;
select 'file' as type, 'Image' as name, 'image/*' as accept;
select 'number' as type, 'Prix' as name, true as required, '0.00' as placeholder, 0.01 as step, 0 as min;
select 'url' as type, 'Lien' as name, true as required, 'https://www.amazon.fr/biberon-du-futur' as placeholder;