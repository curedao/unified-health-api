create table qm_connector_requests
(
    id                    int(11) unsigned auto_increment
        primary key,
    connector_id          int(11) unsigned                    not null,
    user_id               bigint unsigned                     not null,
    connection_id         int(11) unsigned                    null,
    connector_import_id   int unsigned                        not null,
    method                varchar(10)                         not null,
    code                  int                                 not null,
    uri                   varchar(2083)                       not null,
    response_body         mediumtext                          null,
    request_body          text                                null,
    request_headers       text                                not null,
    created_at            timestamp default CURRENT_TIMESTAMP not null,
    updated_at            timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at            timestamp                           null,
    content_type          varchar(100)                        null,
    imported_data_from_at timestamp                           null comment 'Earliest data that we''ve requested from this data source ',
    constraint connector_requests_connections_id_fk
        foreign key (connection_id) references qm_connections (id),
    constraint connector_requests_connector_imports_id_fk
        foreign key (connector_import_id) references qm_connector_imports (id),
    constraint connector_requests_connectors_id_fk
        foreign key (connector_id) references qm_connectors (id),
    constraint connector_requests_users_id_fk
        foreign key (user_id) references users (id)
)
    comment 'An API request made to an HTTP endpoint during import from a data source.' charset = latin1;

