create table global_data.data_rows
(
    id           int          null,
    data_type_id int          null,
    field        varchar(191) null,
    type         varchar(191) null,
    display_name varchar(191) null,
    required     tinyint      null,
    browse       tinyint      null,
    `read`       tinyint      null,
    edit         tinyint      null,
    `add`        tinyint      null,
    `delete`     tinyint      null,
    details      text         null,
    `order`      int          null
);

