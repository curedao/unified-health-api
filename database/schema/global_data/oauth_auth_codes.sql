create table global_data.oauth_auth_codes
(
    id         varchar(100) null,
    user_id    bigint       null,
    client_id  int          null,
    scopes     text         null,
    revoked    tinyint      null,
    expires_at datetime     null
);

