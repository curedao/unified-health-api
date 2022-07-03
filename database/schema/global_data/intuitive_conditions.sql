create table global_data.intuitive_conditions
(
    id                   int auto_increment
        primary key,
    name                 varchar(100)                        not null,
    variable_id          int unsigned                        not null,
    updated_at           timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at           timestamp default CURRENT_TIMESTAMP not null,
    deleted_at           timestamp                           null,
    number_of_treatments int unsigned                        not null,
    number_of_symptoms   int unsigned                        null,
    number_of_causes     int unsigned                        not null,
    constraint conName
        unique (name),
    constraint ct_conditions_variable_id_uindex
        unique (variable_id),
    constraint ct_conditions_variables_id_fk
        foreign key (variable_id) references global_data.global_variables (id)
)
    comment 'User self-reported condition names' charset = utf8;

