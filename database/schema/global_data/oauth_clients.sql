create table global_data.oauth_clients
(
    id                     int          null,
    user_id                bigint       null,
    name                   varchar(255) null,
    secret                 varchar(100) null,
    redirect               text         null,
    personal_access_client tinyint      null,
    password_client        tinyint      null,
    revoked                tinyint      null,
    created_at             timestamp    null,
    updated_at             timestamp    null
);

