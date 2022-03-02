create table qm_unit_categories
(
    id            tinyint unsigned auto_increment
        primary key,
    name          varchar(64)                          not null comment 'Unit category name',
    created_at    timestamp  default CURRENT_TIMESTAMP not null,
    updated_at    timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    can_be_summed tinyint(1) default 1                 not null,
    deleted_at    timestamp                            null,
    sort_order    int                                  not null
)
    comment 'Category for the unit of measurement' charset = utf8;

