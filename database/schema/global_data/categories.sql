create table global_data.categories
(
    id         int          null,
    parent_id  int          null,
    `order`    int          null,
    name       varchar(191) null,
    slug       varchar(191) null,
    created_at timestamp    null,
    updated_at timestamp    null
);

