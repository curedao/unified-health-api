create table global_data.data_types
(
    id                    int          null,
    name                  varchar(191) null,
    slug                  varchar(191) null,
    display_name_singular varchar(191) null,
    display_name_plural   varchar(191) null,
    icon                  varchar(191) null,
    model_name            varchar(191) null,
    policy_name           varchar(191) null,
    controller            varchar(191) null,
    description           varchar(191) null,
    generate_permissions  tinyint      null,
    server_side           tinyint      null,
    details               text         null,
    created_at            timestamp    null,
    updated_at            timestamp    null
);

