create table reservation (
    id serial primary key,
    name text not null,
    product_id int not null references products(id),
    created_at timestamp not null default current_timestamp
);