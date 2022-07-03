create table global_data.intuitive_causes
(
    id                   int auto_increment
        primary key,
    name                 varchar(100)                        not null,
    variable_id          int unsigned                        not null,
    updated_at           timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at           timestamp default CURRENT_TIMESTAMP not null,
    deleted_at           timestamp                           null,
    number_of_conditions int unsigned                        not null,
    constraint causeName
        unique (name),
    constraint ct_causes_variable_id_uindex
        unique (variable_id),
    constraint ct_causes_variables_id_fk
        foreign key (variable_id) references global_data.global_variables (id)
)
    comment 'User self-reported causes of illness' charset = utf8;

