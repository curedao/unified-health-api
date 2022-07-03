create table global_data.measurements
(
    id                   bigint auto_increment
        primary key,
    user_id              bigint unsigned                     not null comment 'Unique ID representing the owner of the measurement',
    client_id            varchar(80)                         not null comment 'ID of the client application that sumbitted the measurement on behalf of the user',
    connector_id         int unsigned                        null comment 'The id for the connector data source from which the measurement was obtained',
    variable_id          int unsigned                        not null comment 'ID of the variable for which we are creating the measurement records',
    start_time           int unsigned                        not null comment 'Start time for the measurement event in ISO 8601',
    value                double                              not null comment 'The value of the measurement after conversion to the default unit for that variable',
    unit_id              smallint unsigned                   not null comment 'The default unit for the variable',
    original_value       double                              not null comment 'Value of measurement as originally posted (before conversion to default unit)',
    original_unit_id     smallint unsigned                   not null comment 'Unit id of measurement as originally submitted',
    duration             int(10)                             null comment 'Duration of the event being measurement in seconds',
    note                 text                                null comment 'An optional note the user may include with their measurement',
    latitude             double                              null comment 'Latitude at which the measurement was taken',
    longitude            double                              null comment 'Longitude at which the measurement was taken',
    location             varchar(255)                        null comment 'location',
    created_at           timestamp default CURRENT_TIMESTAMP not null,
    updated_at           timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    error                text                                null comment 'An error message if there is a problem with the measurement',
    variable_category_id tinyint unsigned                    not null comment 'Variable category ID',
    deleted_at           datetime                            null,
    source_name          varchar(80)                         null comment 'Name of the application or device',
    user_variable_id     int unsigned                        not null,
    start_at             timestamp                           not null,
    connection_id        int(11) unsigned                    null,
    connector_import_id  int(11) unsigned                    null,
    deletion_reason      varchar(280)                        null comment 'The reason the variable was deleted.',
    original_start_at    timestamp                           not null,
    constraint measurements_pk
        unique (user_id, variable_id, start_time),
    constraint measurements_client_id_fk
        foreign key (client_id) references global_data.oa_clients (client_id),
    constraint measurements_connections_id_fk
        foreign key (connection_id) references global_data.api_connections (id),
    constraint measurements_connector_imports_id_fk
        foreign key (connector_import_id) references global_data.api_connector_imports (id),
    constraint measurements_connectors_id_fk
        foreign key (connector_id) references global_data.api_connectors (id),
    constraint measurements_original_unit_id_fk
        foreign key (original_unit_id) references global_data.units (id),
    constraint measurements_unit_id_fk
        foreign key (unit_id) references global_data.units (id),
    constraint measurements_user_id_fk
        foreign key (user_id) references global_data.users (id),
    constraint measurements_user_variables_user_variable_id_fk
        foreign key (user_variable_id) references global_data.user_variables (id),
    constraint measurements_variable_category_id_fk
        foreign key (variable_category_id) references global_data.variable_categories (id),
    constraint measurements_variables_id_fk
        foreign key (variable_id) references global_data.global_variables (id)
)
    comment 'Measurements are any value that can be recorded like daily steps, a mood rating, or apples eaten.'
    charset = utf8;

create index measurements_start_time_index
    on global_data.measurements (start_time);

create index measurements_user_id_variable_category_id_start_time_index
    on global_data.measurements (user_id, variable_category_id, start_time);

create index measurements_user_variables_variable_id_user_id_fk
    on global_data.measurements (variable_id, user_id);

create index measurements_variable_id_start_time_index
    on global_data.measurements (variable_id, start_time);

create index measurements_variable_id_value_start_time_index
    on global_data.measurements (variable_id, value, start_time);

