create table qm_source_platforms
(
    id         smallint(5) auto_increment
        primary key,
    name       varchar(32)                         not null,
    created_at timestamp default CURRENT_TIMESTAMP not null,
    updated_at timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at timestamp                           null,
    client_id  varchar(255)                        null,
    constraint source_platforms_client_id_fk
        foreign key (client_id) references oa_clients (client_id)
)
    charset = utf8;

