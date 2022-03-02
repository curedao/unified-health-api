create table qm_tracking_reminders
(
    id                                              int unsigned auto_increment
        primary key,
    user_id                                         bigint unsigned                     not null,
    client_id                                       varchar(80)                         not null,
    variable_id                                     int unsigned                        not null comment 'Id for the variable to be tracked',
    default_value                                   double                              null comment 'Default value to use for the measurement when tracking',
    reminder_start_time                             time      default '00:00:00'        not null comment 'UTC time of day at which reminder notifications should appear in the case of daily or less frequent reminders.  The earliest UTC time at which notifications should appear in the case of intraday repeating reminders. ',
    reminder_end_time                               time                                null comment 'Latest time of day at which reminders should appear',
    reminder_sound                                  varchar(125)                        null comment 'String identifier for the sound to accompany the reminder',
    reminder_frequency                              int                                 null comment 'Number of seconds between one reminder and the next',
    pop_up                                          tinyint(1)                          null comment 'True if the reminders should appear as a popup notification',
    sms                                             tinyint(1)                          null comment 'True if the reminders should be delivered via SMS',
    email                                           tinyint(1)                          null comment 'True if the reminders should be delivered via email',
    notification_bar                                tinyint(1)                          null comment 'True if the reminders should appear in the notification bar',
    last_tracked                                    timestamp                           null,
    created_at                                      timestamp default CURRENT_TIMESTAMP not null,
    updated_at                                      timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    start_tracking_date                             date                                null comment 'Earliest date on which the user should be reminded to track in YYYY-MM-DD format',
    stop_tracking_date                              date                                null comment 'Latest date on which the user should be reminded to track  in YYYY-MM-DD format',
    instructions                                    text                                null,
    deleted_at                                      timestamp                           null,
    image_url                                       varchar(2083)                       null,
    user_variable_id                                int unsigned                        not null,
    latest_tracking_reminder_notification_notify_at timestamp                           null,
    number_of_tracking_reminder_notifications       int unsigned                        null comment 'Number of Tracking Reminder Notifications for this Tracking Reminder.
                    [Formula: update tracking_reminders
                        left join (
                            select count(id) as total, tracking_reminder_id
                            from tracking_reminder_notifications
                            group by tracking_reminder_id
                        )
                        as grouped on tracking_reminders.id = grouped.tracking_reminder_id
                    set tracking_reminders.number_of_tracking_reminder_notifications = count(grouped.total)]',
    constraint UK_user_var_time_freq
        unique (user_id, variable_id, reminder_start_time, reminder_frequency),
    constraint tracking_reminders_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint tracking_reminders_user_id_fk
        foreign key (user_id) references users (id)
            on update cascade on delete cascade,
    constraint tracking_reminders_user_variables_user_id_variable_id_fk
        foreign key (user_id, variable_id) references qm_user_variables (user_id, variable_id),
    constraint tracking_reminders_user_variables_user_variable_id_fk
        foreign key (user_variable_id) references qm_user_variables (id)
            on update cascade on delete cascade,
    constraint tracking_reminders_variables_id_fk
        foreign key (variable_id) references qm_variables (id)
)
    comment 'Manage what variables you want to track and when you want to be reminded.' charset = utf8;

create index tracking_reminders_user_variables_variable_id_user_id_fk
    on qm_tracking_reminders (variable_id, user_id);

create index user_client
    on qm_tracking_reminders (user_id, client_id);

