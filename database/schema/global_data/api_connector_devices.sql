create table global_data.api_connector_devices
(
    id                int auto_increment
        primary key,
    name              tinytext      null,
    display_name      tinytext      null,
    image             varchar(2083) null,
    get_it_url        varchar(2083) null,
    short_description mediumtext    null,
    long_description  longtext      null,
    enabled           tinyint       null,
    oauth             tinyint       null,
    qm_client         tinyint       null,
    created_at        timestamp     null,
    updated_at        timestamp     null,
    client_id         tinytext      null,
    deleted_at        timestamp     null,
    is_parent         tinyint       null
)
    comment 'Various devices whose data may be obtained from a given connector''s API' charset = utf8;

