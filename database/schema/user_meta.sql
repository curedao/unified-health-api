create table user_meta
(
    id   bigint unsigned auto_increment comment 'Unique number assigned to each row of the table.'
        primary key,
    user_id    bigint unsigned                     null comment 'ID of the related user.',
    meta_key   varchar(255)                        null comment 'An identifying key for the piece of data.',
    meta_value longtext                            null comment 'The actual piece of data.',
    updated_at timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    deleted_at timestamp                           null,
    client_id  varchar(255)                        null,
    constraint user_meta_users_id_fk
        foreign key (user_id) references users (id)
)
    comment 'This table stores any further information related to the users. You will see other user profile fields for a user in the dashboard that are stored here.'
    charset = utf8;

create index meta_key
    on user_meta (meta_key);

create index user_id
    on user_meta (user_id);

