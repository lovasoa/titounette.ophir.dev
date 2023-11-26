-- important: we do not accept file uploads from unauthenticated users
select 'redirect' as component, '/login.sql' as link -- redirect to the login page if the user is not logged in
where not exists (
    select true from session
    where
        sqlpage.cookie('session_token') = id and
        created_at > CURRENT_TIMESTAMP - INTERVAL '1 DAY' -- require the user to log in again after 1 day
);

insert into products (title, description, price, link, image_url)
values (
    :Nom,
    :Description,
    :Prix::money,
    :Lien,
    sqlpage.read_file_as_data_url(sqlpage.uploaded_file_path('Image'))
)
ON CONFLICT DO NOTHING
returning 'redirect' as component,
          format('/?created_id=%s', id) as link;

-- If the insert failed, warn the user
select 'alert' as component,
    'red' as color,
    'alert-triangle' as icon,
    'Failed to upload image' as title,
    'Peut-être que la photo est trop grosse ? Pas besoin de mettre du Ultra HD, c''est bibi qui paye pour l''hébergement.' as description
;