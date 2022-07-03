create table global_data.oauth_access_tokens
(
    id         varchar(100) null,
    user_id    bigint       null,
    client_id  int unsigned null,
    name       varchar(255) null,
    scopes     text         null,
    revoked    tinyint      null,
    created_at timestamp    null,
    updated_at timestamp    null,
    expires_at datetime     null
);

