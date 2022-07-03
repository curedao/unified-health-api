create table global_data.user_variable_clients
(
    id                      int auto_increment
        primary key,
    client_id               varchar(80)                         not null,
    created_at              timestamp default CURRENT_TIMESTAMP not null,
    deleted_at              timestamp                           null,
    earliest_measurement_at timestamp                           null comment 'Earliest measurement time for this variable and client',
    latest_measurement_at   timestamp                           null comment 'Earliest measurement time for this variable and client',
    number_of_measurements  int unsigned                        null,
    updated_at              timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    user_id                 bigint unsigned                     not null,
    user_variable_id        int(11) unsigned                    not null,
    variable_id             int(11) unsigned                    not null comment 'Id of variable',
    constraint user
        unique (user_id, variable_id, client_id),
    constraint user_variable_clients_client_id_fk
        foreign key (client_id) references global_data.oa_clients (client_id),
    constraint user_variable_clients_user_id_fk
        foreign key (user_id) references global_data.users (id),
    constraint user_variable_clients_user_variables_user_variable_id_fk
        foreign key (user_variable_id) references global_data.user_variables (id),
    constraint user_variable_clients_variable_id_fk
        foreign key (variable_id) references global_data.global_variables (id)
)
    comment 'Information about variable data obtained from specific data sources for specific users.' charset = utf8;

