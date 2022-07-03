create table global_data.api_keys
(
    id           int          null,
    user_id      int          null,
    name         varchar(191) null,
    `key`        varchar(60)  null,
    last_used_at datetime     null,
    created_at   timestamp    null,
    updated_at   timestamp    null
);

