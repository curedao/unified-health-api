create table global_data.menu_items
(
    id         int          null,
    menu_id    int          null,
    title      varchar(191) null,
    url        varchar(191) null,
    target     varchar(191) null,
    icon_class varchar(191) null,
    color      varchar(191) null,
    parent_id  int          null,
    `order`    int          null,
    created_at timestamp    null,
    updated_at timestamp    null,
    route      varchar(191) null,
    parameters text         null
);

