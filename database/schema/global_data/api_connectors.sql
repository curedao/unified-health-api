create table global_data.api_connectors
(
    id                           int(11) unsigned auto_increment comment 'Connector ID number'
        primary key,
    name                         varchar(30)                          not null comment 'Lowercase system name for the data source',
    display_name                 varchar(30)                          not null comment 'Pretty display name for the data source',
    image                        varchar(2083)                        not null comment 'URL to the image of the connector logo',
    get_it_url                   varchar(2083)                        null comment 'URL to a site where one can get this device or application',
    short_description            text                                 not null comment 'Short description of the service (such as the categories it tracks)',
    long_description             longtext                             not null comment 'Longer paragraph description of the data provider',
    enabled                      tinyint(1) default 1                 not null comment 'Set to 1 if the connector should be returned when listing connectors',
    oauth                        tinyint(1) default 0                 not null comment 'Set to 1 if the connector uses OAuth authentication as opposed to username/password',
    qm_client                    tinyint(1) default 0                 null comment 'Whether its a connector or one of our clients',
    created_at                   timestamp  default CURRENT_TIMESTAMP not null,
    updated_at                   timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    client_id                    varchar(80)                          null,
    deleted_at                   timestamp                            null,
    wp_post_id                   bigint unsigned                      null,
    number_of_connections        int unsigned                         null comment 'Number of Connections for this Connector.
                [Formula:
                    update connectors
                        left join (
                            select count(id) as total, connector_id
                            from connections
                            group by connector_id
                        )
                        as grouped on connectors.id = grouped.connector_id
                    set connectors.number_of_connections = count(grouped.total)
                ]
                ',
    number_of_connector_imports  int unsigned                         null comment 'Number of Connector Imports for this Connector.
                [Formula:
                    update connectors
                        left join (
                            select count(id) as total, connector_id
                            from connector_imports
                            group by connector_id
                        )
                        as grouped on connectors.id = grouped.connector_id
                    set connectors.number_of_connector_imports = count(grouped.total)
                ]
                ',
    number_of_connector_requests int unsigned                         null comment 'Number of Connector Requests for this Connector.
                [Formula:
                    update connectors
                        left join (
                            select count(id) as total, connector_id
                            from connector_requests
                            group by connector_id
                        )
                        as grouped on connectors.id = grouped.connector_id
                    set connectors.number_of_connector_requests = count(grouped.total)
                ]
                ',
    number_of_measurements       int unsigned                         null comment 'Number of Measurements for this Connector.
                    [Formula: update connectors
                        left join (
                            select count(id) as total, connector_id
                            from measurements
                            group by connector_id
                        )
                        as grouped on connectors.id = grouped.connector_id
                    set connectors.number_of_measurements = count(grouped.total)]',
    is_public                    tinyint(1)                           null,
    sort_order                   int                                  not null,
    slug                         varchar(200)                         null comment 'The slug is the part of a URL that identifies a page in human-readable keywords.',
    constraint connectors_slug_uindex
        unique (slug),
    constraint connectors_client_id_fk
        foreign key (client_id) references global_data.oa_clients (client_id),
    constraint connectors_wp_posts_ID_fk
        foreign key (wp_post_id) references global_data.wp_posts (ID)
)
    comment 'A connector pulls data from other data providers using their API or a screenscraper. Returns a list of all available connectors and information about them such as their id, name, whether the user has provided access, logo url, connection instructions, and the update history.'
    charset = utf8;

