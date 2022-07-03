create table global_data.users
(
    id                                                       bigint unsigned auto_increment comment 'Unique number assigned to each user.'
        primary key,
    client_id                                                varchar(255)                         not null,
    user_login                                               varchar(60)                          null comment 'Unique username for the user.',
    user_email                                               varchar(100)                         null comment 'Email address of the user.',
    email                                                    varchar(320)                         null comment 'Needed for laravel password resets because WP user_email field will not work',
    user_nicename                                            varchar(50)                          null comment 'Display name for the user.',
    user_url                                                 varchar(2083)                        null comment 'URL of the user, e.g. website address.',
    user_registered                                          datetime                             null comment 'Time and date the user registered.',
    user_status                                              int                                  null comment 'Was used in Multisite pre WordPress 3.0 to indicate a spam user.',
    display_name                                             varchar(250)                         null comment 'Desired name to be used publicly in the site, can be user_login, user_nicename, first name or last name defined in wp_usermeta.',
    avatar_image                                             varchar(2083)                        null,
    reg_provider                                             varchar(25)                          null comment 'Registered via',
    provider_id                                              varchar(255)                         null comment 'Unique id from provider',
    provider_token                                           varchar(255)                         null comment 'Access token from provider',
    updated_at                                               timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at                                               timestamp  default CURRENT_TIMESTAMP not null,
    unsubscribed                                             tinyint(1) default 0                 null comment 'Indicates whether the use has specified that they want no emails or any form of communication. ',
    old_user                                                 tinyint(1) default 0                 null,
    stripe_active                                            tinyint(1) default 0                 null,
    stripe_id                                                varchar(255)                         null,
    stripe_subscription                                      varchar(255)                         null,
    stripe_plan                                              varchar(100)                         null,
    trial_ends_at                                            timestamp                            null,
    subscription_ends_at                                     timestamp                            null,
    roles                                                    varchar(255)                         null comment 'An array containing all roles possessed by the user.  This indicates whether the use has roles such as administrator, developer, patient, student, researcher or physician. ',
    time_zone_offset                                         int                                  null comment 'The time-zone offset is the difference, in minutes, between UTC and local time. Note that this means that the offset is positive if the local timezone is behind UTC (i.e. UTC−06:00 Central) and negative if it is ahead.',
    deleted_at                                               timestamp                            null,
    earliest_reminder_time                                   time       default '06:00:00'        not null comment 'Earliest time of day at which reminders should appear in HH:MM:SS format in user timezone',
    latest_reminder_time                                     time       default '22:00:00'        not null comment 'Latest time of day at which reminders should appear in HH:MM:SS format in user timezone',
    push_notifications_enabled                               tinyint(1) default 1                 null comment 'Should we send the user push notifications?',
    track_location                                           tinyint(1) default 0                 null comment 'Set to true if the user wants to track their location',
    combine_notifications                                    tinyint(1) default 0                 null comment 'Should we combine push notifications or send one for each tracking reminder notification?',
    send_reminder_notification_emails                        tinyint(1) default 0                 null comment 'Should we send reminder notification emails?',
    send_predictor_emails                                    tinyint(1) default 1                 null comment 'Should we send predictor emails?',
    get_preview_builds                                       tinyint(1) default 0                 null comment 'Should we send preview builds of the mobile application?',
    subscription_provider                                    enum ('stripe', 'apple', 'google')   null,
    last_sms_tracking_reminder_notification_id               bigint unsigned                      null,
    sms_notifications_enabled                                tinyint(1) default 0                 null comment 'Should we send tracking reminder notifications via tex messages?',
    phone_verification_code                                  varchar(25)                          null,
    phone_number                                             varchar(25)                          null,
    has_android_app                                          tinyint(1) default 0                 null,
    has_ios_app                                              tinyint(1) default 0                 null,
    has_chrome_extension                                     tinyint(1) default 0                 null,
    referrer_user_id                                         bigint unsigned                      null,
    address                                                  varchar(255)                         null,
    birthday                                                 varchar(255)                         null,
    country                                                  varchar(255)                         null,
    cover_photo                                              varchar(2083)                        null,
    currency                                                 varchar(255)                         null,
    first_name                                               varchar(255)                         null,
    gender                                                   varchar(255)                         null,
    language                                                 varchar(255)                         null,
    last_name                                                varchar(255)                         null,
    state                                                    varchar(255)                         null,
    tag_line                                                 varchar(255)                         null,
    verified                                                 varchar(255)                         null,
    zip_code                                                 varchar(255)                         null,
    spam                                                     tinyint(2) default 0                 not null,
    deleted                                                  tinyint(2) default 0                 not null,
    last_login_at                                            timestamp                            null,
    timezone                                                 varchar(255)                         null,
    number_of_correlations                                   int                                  null,
    number_of_connections                                    int                                  null,
    number_of_tracking_reminders                             int                                  null,
    number_of_user_variables                                 int                                  null,
    number_of_raw_measurements_with_tags                     int                                  null,
    number_of_raw_measurements_with_tags_at_last_correlation int                                  null,
    number_of_votes                                          int                                  null,
    number_of_studies                                        int                                  null,
    last_correlation_at                                      timestamp                            null,
    last_email_at                                            timestamp                            null,
    last_push_at                                             timestamp                            null,
    primary_outcome_variable_id                              int unsigned                         null,
    wp_post_id                                               bigint unsigned                      null,
    analysis_ended_at                                        timestamp                            null,
    analysis_requested_at                                    timestamp                            null,
    analysis_started_at                                      timestamp                            null,
    internal_error_message                                   text                                 null,
    newest_data_at                                           timestamp                            null,
    reason_for_analysis                                      varchar(255)                         null,
    user_error_message                                       text                                 null,
    status                                                   varchar(25)                          null,
    analysis_settings_modified_at                            timestamp                            null,
    number_of_applications                                   int unsigned                         null comment 'Number of Applications for this User.
                [Formula:
                    update wp_users
                        left join (
                            select count(id) as total, user_id
                            from applications
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_applications = count(grouped.total)
                ]
                ',
    number_of_oauth_access_tokens                            int unsigned                         null comment 'Number of OAuth Access Tokens for this User.
                [Formula:
                    update wp_users
                        left join (
                            select count(access_token) as total, user_id
                            from bshaffer_oauth_access_tokens
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_oauth_access_tokens = count(grouped.total)
                ]
                ',
    number_of_oauth_authorization_codes                      int unsigned                         null comment 'Number of OAuth Authorization Codes for this User.
                [Formula:
                    update wp_users
                        left join (
                            select count(authorization_code) as total, user_id
                            from bshaffer_oauth_authorization_codes
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_oauth_authorization_codes = count(grouped.total)
                ]
                ',
    number_of_oauth_clients                                  int unsigned                         null comment 'Number of OAuth Clients for this User.
                [Formula:
                    update wp_users
                        left join (
                            select count(client_id) as total, user_id
                            from bshaffer_oauth_clients
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_oauth_clients = count(grouped.total)
                ]
                ',
    number_of_oauth_refresh_tokens                           int unsigned                         null comment 'Number of OAuth Refresh Tokens for this User.
                [Formula:
                    update wp_users
                        left join (
                            select count(refresh_token) as total, user_id
                            from bshaffer_oauth_refresh_tokens
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_oauth_refresh_tokens = count(grouped.total)
                ]
                ',
    number_of_button_clicks                                  int unsigned                         null comment 'Number of Button Clicks for this User.
                [Formula:
                    update wp_users
                        left join (
                            select count(id) as total, user_id
                            from button_clicks
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_button_clicks = count(grouped.total)
                ]
                ',
    number_of_collaborators                                  int unsigned                         null comment 'Number of Collaborators for this User.
                [Formula:
                    update wp_users
                        left join (
                            select count(id) as total, user_id
                            from collaborators
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_collaborators = count(grouped.total)
                ]
                ',
    number_of_connector_imports                              int unsigned                         null comment 'Number of Connector Imports for this User.
                [Formula:
                    update wp_users
                        left join (
                            select count(id) as total, user_id
                            from connector_imports
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_connector_imports = count(grouped.total)
                ]
                ',
    number_of_connector_requests                             int unsigned                         null comment 'Number of Connector Requests for this User.
                [Formula:
                    update wp_users
                        left join (
                            select count(id) as total, user_id
                            from connector_requests
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_connector_requests = count(grouped.total)
                ]
                ',
    number_of_measurement_exports                            int unsigned                         null comment 'Number of Measurement Exports for this User.
                    [Formula: update wp_users
                        left join (
                            select count(id) as total, user_id
                            from measurement_exports
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_measurement_exports = count(grouped.total)]',
    number_of_measurement_imports                            int unsigned                         null comment 'Number of Measurement Imports for this User.
                    [Formula: update wp_users
                        left join (
                            select count(id) as total, user_id
                            from measurement_imports
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_measurement_imports = count(grouped.total)]',
    number_of_measurements                                   int unsigned                         null comment 'Number of Measurements for this User.
                    [Formula: update wp_users
                        left join (
                            select count(id) as total, user_id
                            from measurements
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_measurements = count(grouped.total)]',
    number_of_sent_emails                                    int unsigned                         null comment 'Number of Sent Emails for this User.
                    [Formula: update wp_users
                        left join (
                            select count(id) as total, user_id
                            from sent_emails
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_sent_emails = count(grouped.total)]',
    number_of_subscriptions                                  int unsigned                         null comment 'Number of Subscriptions for this User.
                    [Formula: update wp_users
                        left join (
                            select count(id) as total, user_id
                            from subscriptions
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_subscriptions = count(grouped.total)]',
    number_of_tracking_reminder_notifications                int unsigned                         null comment 'Number of Tracking Reminder Notifications for this User.
                    [Formula: update wp_users
                        left join (
                            select count(id) as total, user_id
                            from tracking_reminder_notifications
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_tracking_reminder_notifications = count(grouped.total)]',
    number_of_user_tags                                      int unsigned                         null comment 'Number of User Tags for this User.
                    [Formula: update wp_users
                        left join (
                            select count(id) as total, user_id
                            from user_tags
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_user_tags = count(grouped.total)]',
    number_of_users_where_referrer_user                      int unsigned                         null comment 'Number of Users for this Referrer User.
                    [Formula: update wp_users
                        left join (
                            select count(ID) as total, referrer_user_id
                            from wp_users
                            group by referrer_user_id
                        )
                        as grouped on wp_users.ID = grouped.referrer_user_id
                    set wp_users.number_of_users_where_referrer_user = count(grouped.total)]',
    share_all_data                                           tinyint(1) default 0                 not null,
    deletion_reason                                          varchar(280)                         null comment 'The reason the user deleted their account.',
    number_of_patients                                       int unsigned                         not null,
    is_public                                                tinyint(1)                           null,
    sort_order                                               int                                  not null,
    number_of_sharers                                        int unsigned                         not null comment 'Number of people sharing their data with you.',
    number_of_trustees                                       int unsigned                         not null comment 'Number of people that you are sharing your data with.',
    slug                                                     varchar(200)                         null comment 'The slug is the part of a URL that identifies a page in human-readable keywords.',
    constraint user_email
        unique (user_email),
    constraint user_login_key
        unique (user_login),
    constraint wp_users_slug_uindex
        unique (slug),
    constraint wp_users_variables_id_fk
        foreign key (primary_outcome_variable_id) references global_data.global_variables (id),
    constraint wp_users_wp_posts_ID_fk
        foreign key (wp_post_id) references global_data.wp_posts (ID)
            on update cascade on delete set null,
    constraint wp_users_wp_users_ID_fk
        foreign key (referrer_user_id) references global_data.users (id)
)
    comment 'General user information and overall statistics' charset = utf8;

create index user_nicename
    on global_data.users (user_nicename);

