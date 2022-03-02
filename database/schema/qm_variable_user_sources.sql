create table qm_variable_user_sources
(
    user_id                       bigint unsigned                     not null,
    variable_id                   int unsigned                        not null comment 'ID of variable',
    timestamp                     int unsigned                        null comment 'Time that this measurement occurred

Uses epoch minute (epoch time divided by 60)',
    earliest_measurement_time     int unsigned                        null comment 'Earliest measurement time',
    latest_measurement_time       int unsigned                        null comment 'Latest measurement time',
    created_at                    timestamp default CURRENT_TIMESTAMP not null,
    updated_at                    timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at                    timestamp                           null,
    data_source_name              varchar(80)                         not null,
    number_of_raw_measurements    int                                 null,
    client_id                     varchar(255)                        null,
    id                            int auto_increment
        primary key,
    user_variable_id              int unsigned                        not null,
    earliest_measurement_start_at timestamp                           null,
    latest_measurement_start_at   timestamp                           null,
    constraint user
        unique (user_id, variable_id, data_source_name),
    constraint variable_user_sources_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint variable_user_sources_user_id_fk
        foreign key (user_id) references users (id),
    constraint variable_user_sources_user_variables_user_id_variable_id_fk
        foreign key (user_id, variable_id) references qm_user_variables (user_id, variable_id),
    constraint variable_user_sources_user_variables_user_variable_id_fk
        foreign key (user_variable_id) references qm_user_variables (id)
            on update cascade on delete cascade,
    constraint variable_user_sources_variable_id_fk
        foreign key (variable_id) references qm_variables (id)
)
    comment 'Information about variable data obtained from specific data sources for specific users.' charset = utf8;

create index variable_user_sources_user_variables_variable_id_user_id_fk
    on qm_variable_user_sources (variable_id, user_id);

