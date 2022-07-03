create table global_data.api_connections
(
    id                                int(11) unsigned auto_increment
        primary key,
    client_id                         varchar(80)                         null,
    user_id                           bigint unsigned                     not null,
    connector_id                      int(11) unsigned                    not null comment 'The id for the connector data source for which the connection is connected',
    connect_status                    varchar(32)                         not null comment 'Indicates whether a connector is currently connected to a service for a user.',
    connect_error                     text                                null comment 'Error message if there is a problem with authorizing this connection.',
    update_requested_at               timestamp                           null,
    update_status                     varchar(32)                         not null comment 'Indicates whether a connector is currently updated.',
    update_error                      text                                null comment 'Indicates if there was an error during the update.',
    last_successful_updated_at        timestamp                           null,
    created_at                        timestamp default CURRENT_TIMESTAMP not null,
    updated_at                        timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at                        timestamp                           null,
    total_measurements_in_last_update int(10)                             null,
    user_message                      varchar(255)                        null,
    latest_measurement_at             timestamp                           null,
    import_started_at                 timestamp                           null,
    import_ended_at                   timestamp                           null,
    reason_for_import                 varchar(255)                        null,
    user_error_message                text                                null,
    internal_error_message            text                                null,
    wp_post_id                        bigint unsigned                     null,
    number_of_connector_imports       int unsigned                        null comment 'Number of Connector Imports for this Connection.
                [Formula:
                    update connections
                        left join (
                            select count(id) as total, connection_id
                            from connector_imports
                            group by connection_id
                        )
                        as grouped on connections.id = grouped.connection_id
                    set connections.number_of_connector_imports = count(grouped.total)
                ]
                ',
    number_of_connector_requests      int unsigned                        null comment 'Number of Connector Requests for this Connection.
                [Formula:
                    update connections
                        left join (
                            select count(id) as total, connection_id
                            from connector_requests
                            group by connection_id
                        )
                        as grouped on connections.id = grouped.connection_id
                    set connections.number_of_connector_requests = count(grouped.total)
                ]
                ',
    credentials                       text                                null comment 'Encrypted user credentials for accessing third party data',
    imported_data_from_at             timestamp                           null comment 'Earliest data that we''ve requested from this data source ',
    imported_data_end_at              timestamp                           null comment 'Most recent data that we''ve requested from this data source ',
    number_of_measurements            int unsigned                        null comment 'Number of Measurements for this Connection.
                    [Formula: update connections
                        left join (
                            select count(id) as total, connection_id
                            from measurements
                            group by connection_id
                        )
                        as grouped on connections.id = grouped.connection_id
                    set connections.number_of_measurements = count(grouped.total)]',
    is_public                         tinyint(1)                          null,
    slug                              varchar(200)                        null comment 'The slug is the part of a URL that identifies a page in human-readable keywords.',
    meta                              text                                null comment 'Additional meta data instructions for import, such as a list of repositories the Github connector should import from. ',
    constraint UX_userId_connectorId
        unique (user_id, connector_id),
    constraint connections_slug_uindex
        unique (slug),
    constraint connections_client_id_fk
        foreign key (client_id) references global_data.oa_clients (client_id),
    constraint connections_connectors_id_fk
        foreign key (connector_id) references global_data.api_connectors (id),
    constraint connections_user_id_fk
        foreign key (user_id) references global_data.users (id),
    constraint connections_wp_posts_ID_fk
        foreign key (wp_post_id) references global_data.wp_posts (ID)
)
    comment 'Connections to 3rd party data sources that we can import from for a given user.' charset = utf8;

create index IDX_status
    on global_data.api_connections (connect_status);

create index status
    on global_data.api_connections (update_status);

create index status_update_requested
    on global_data.api_connections (update_requested_at, update_status);

