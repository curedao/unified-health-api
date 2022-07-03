create table global_data.notifications
(
    id              char(36)     null,
    type            varchar(191) null,
    notifiable_id   int          null,
    notifiable_type varchar(191) null,
    data            text         null,
    read_at         datetime     null,
    created_at      timestamp    null,
    updated_at      timestamp    null
);

