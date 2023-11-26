select 'redirect' as component, '/login.sql' as link -- redirect to the login page if the user is not logged in
where not exists (
    select true from session
    where
        sqlpage.cookie('session_token') = id and
        created_at > CURRENT_TIMESTAMP - INTERVAL '1 day' and
        username = 'admin' -- only allow the admin user to create new accounts
);

insert into user_account (username, password_hash)
select :Username, sqlpage.hash_password(:Password)
where :Username is not null and :Password is not null and :Password = :Password_confirm
returning
    'redirect' as component,
    '/' as link;

select 'form' as component, 'Create an account' as title, 'create_account.sql' as action;
select 'text' as type, 'Username' as name, true as required;
select 'password' as type, 'Password' as name, true as required;
select 'password' as type, 'Password_confirm' as name, 'Confirm password' AS label, true as required;

