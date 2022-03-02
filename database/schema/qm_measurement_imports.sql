create table qm_measurement_imports
(
    id                     int unsigned auto_increment
        primary key,
    user_id                bigint unsigned                       not null,
    file                   varchar(255)                          not null,
    created_at             timestamp   default CURRENT_TIMESTAMP not null,
    updated_at             timestamp   default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    status                 varchar(25) default 'WAITING'         not null,
    error_message          text                                  null,
    source_name            varchar(80)                           null comment 'Name of the application or device',
    deleted_at             timestamp                             null,
    client_id              varchar(255)                          null,
    import_started_at      timestamp                             null,
    import_ended_at        timestamp                             null,
    reason_for_import      varchar(255)                          null,
    user_error_message     varchar(255)                          null,
    internal_error_message varchar(255)                          null,
    constraint measurement_imports_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint measurement_imports_user_id_fk
        foreign key (user_id) references users (id)
)
    comment 'Spreadsheet import records.' charset = utf8;

