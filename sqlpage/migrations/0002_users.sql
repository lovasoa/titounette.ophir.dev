create table user_account (
    username text primary key,
    password_hash text not null
);

create table session (
    id text primary key,
    username text not null references user_account(username),
    created_at timestamp not null default current_timestamp
);

-- Creates an initial user with the username `admin` and the password `admin` (hashed using sqlpage.hash_password('admin'))
insert into user_account (username, password_hash)
values ('admin', '$argon2id$v=19$m=19456,t=2,p=1$4lu3hSvaqXK0dMCPZLOIPg$PUFJSB6L3J5eZ33z9WX7y0nOH6KawV2FdW0abMuPE7o');