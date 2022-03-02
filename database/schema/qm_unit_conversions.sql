create table qm_unit_conversions
(
    unit_id     int unsigned                        not null,
    step_number tinyint unsigned                    not null comment 'step in the conversion process',
    operation   tinyint unsigned                    not null comment '0 is add and 1 is multiply',
    value       double                              not null comment 'number used in the operation',
    created_at  timestamp default CURRENT_TIMESTAMP not null,
    updated_at  timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at  timestamp                           null,
    id          int(10) auto_increment
        primary key,
    constraint qm_unit_conversions_unit_id_step_number_uindex
        unique (unit_id, step_number)
)
    comment 'Unit conversion formulas.' charset = utf8;

