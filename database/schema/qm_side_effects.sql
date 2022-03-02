create table qm_side_effects
(
    id                   int auto_increment
        primary key,
    name                 varchar(100)                        not null,
    variable_id          int unsigned                        not null,
    updated_at           timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at           timestamp default CURRENT_TIMESTAMP not null,
    deleted_at           timestamp                           null,
    number_of_treatments int unsigned                        not null,
    constraint ct_side_effects_variable_id_uindex
        unique (variable_id),
    constraint seName
        unique (name),
    constraint ct_side_effects_variables_id_fk
        foreign key (variable_id) references qm_variables (id)
)
    comment 'User self-reported side effect names' charset = utf8;

