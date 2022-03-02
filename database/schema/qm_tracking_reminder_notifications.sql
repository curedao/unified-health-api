create table qm_tracking_reminder_notifications
(
    id                   int unsigned auto_increment
        primary key,
    tracking_reminder_id int unsigned                        not null,
    created_at           timestamp default CURRENT_TIMESTAMP not null,
    updated_at           timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at           timestamp                           null,
    user_id              bigint unsigned                     not null,
    notified_at          timestamp                           null,
    received_at          timestamp                           null,
    client_id            varchar(255)                        null,
    variable_id          int unsigned                        not null,
    notify_at            timestamp                           not null,
    user_variable_id     int unsigned                        not null,
    constraint notify_at_tracking_reminder_id_uindex
        unique (notify_at, tracking_reminder_id),
    constraint tracking_reminder_notifications_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint tracking_reminder_notifications_tracking_reminders_id_fk
        foreign key (tracking_reminder_id) references qm_tracking_reminders (id)
            on update cascade on delete cascade,
    constraint tracking_reminder_notifications_user_id_fk
        foreign key (user_id) references users (id)
            on delete cascade,
    constraint tracking_reminder_notifications_user_variables_id_fk
        foreign key (user_variable_id) references qm_user_variables (id)
            on update cascade on delete cascade,
    constraint tracking_reminder_notifications_variables_id_fk
        foreign key (variable_id) references qm_variables (id)
            on update cascade on delete cascade
)
    charset = utf8;

