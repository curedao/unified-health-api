create table global_data.oa_clients
(
    client_id                                 varchar(80)                         not null
        primary key,
    client_secret                             varchar(80)                         not null,
    redirect_uri                              varchar(2000)                       null,
    grant_types                               varchar(80)                         null,
    user_id                                   bigint unsigned                     not null,
    created_at                                timestamp default CURRENT_TIMESTAMP not null,
    updated_at                                timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    icon_url                                  varchar(2083)                       null,
    app_identifier                            varchar(255)                        null,
    deleted_at                                timestamp                           null,
    earliest_measurement_start_at             timestamp                           null,
    latest_measurement_start_at               timestamp                           null,
    number_of_aggregate_correlations          int unsigned                        null comment 'Number of Global Population Studies for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from aggregate_correlations
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_aggregate_correlations = count(grouped.total)
                ]
                ',
    number_of_applications                    int unsigned                        null comment 'Number of Applications for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from applications
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_applications = count(grouped.total)
                ]
                ',
    number_of_oauth_access_tokens             int unsigned                        null comment 'Number of OAuth Access Tokens for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(access_token) as total, client_id
                            from bshaffer_oauth_access_tokens
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_oauth_access_tokens = count(grouped.total)
                ]
                ',
    number_of_oauth_authorization_codes       int unsigned                        null comment 'Number of OAuth Authorization Codes for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(authorization_code) as total, client_id
                            from bshaffer_oauth_authorization_codes
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_oauth_authorization_codes = count(grouped.total)
                ]
                ',
    number_of_oauth_refresh_tokens            int unsigned                        null comment 'Number of OAuth Refresh Tokens for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(refresh_token) as total, client_id
                            from bshaffer_oauth_refresh_tokens
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_oauth_refresh_tokens = count(grouped.total)
                ]
                ',
    number_of_button_clicks                   int unsigned                        null comment 'Number of Button Clicks for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from button_clicks
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_button_clicks = count(grouped.total)
                ]
                ',
    number_of_collaborators                   int unsigned                        null comment 'Number of Collaborators for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from collaborators
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_collaborators = count(grouped.total)
                ]
                ',
    number_of_common_tags                     int unsigned                        null comment 'Number of Common Tags for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from common_tags
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_common_tags = count(grouped.total)
                ]
                ',
    number_of_connections                     int unsigned                        null comment 'Number of Connections for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from connections
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_connections = count(grouped.total)
                ]
                ',
    number_of_connector_imports               int unsigned                        null comment 'Number of Connector Imports for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from connector_imports
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_connector_imports = count(grouped.total)
                ]
                ',
    number_of_connectors                      int unsigned                        null comment 'Number of Connectors for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from connectors
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_connectors = count(grouped.total)
                ]
                ',
    number_of_correlations                    int unsigned                        null comment 'Number of Individual Case Studies for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from correlations
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_correlations = count(grouped.total)
                ]
                ',
    number_of_measurement_exports             int unsigned                        null comment 'Number of Measurement Exports for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from measurement_exports
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_measurement_exports = count(grouped.total)]',
    number_of_measurement_imports             int unsigned                        null comment 'Number of Measurement Imports for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from measurement_imports
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_measurement_imports = count(grouped.total)]',
    number_of_measurements                    int unsigned                        null comment 'Number of Measurements for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from measurements
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_measurements = count(grouped.total)]',
    number_of_sent_emails                     int unsigned                        null comment 'Number of Sent Emails for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from sent_emails
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_sent_emails = count(grouped.total)]',
    number_of_studies                         int unsigned                        null comment 'Number of Studies for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from studies
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_studies = count(grouped.total)]',
    number_of_tracking_reminder_notifications int unsigned                        null comment 'Number of Tracking Reminder Notifications for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from tracking_reminder_notifications
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_tracking_reminder_notifications = count(grouped.total)]',
    number_of_tracking_reminders              int unsigned                        null comment 'Number of Tracking Reminders for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from tracking_reminders
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_tracking_reminders = count(grouped.total)]',
    number_of_user_tags                       int unsigned                        null comment 'Number of User Tags for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from user_tags
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_user_tags = count(grouped.total)]',
    number_of_user_variables                  int unsigned                        null comment 'Number of User Variables for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from user_variables
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_user_variables = count(grouped.total)]',
    number_of_variables                       int unsigned                        null comment 'Number of Variables for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from variables
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_variables = count(grouped.total)]',
    number_of_votes                           int unsigned                        null comment 'Number of Votes for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from votes
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_votes = count(grouped.total)]',
    constraint bshaffer_oauth_clients_user_id_fk
        foreign key (user_id) references global_data.users (id)
)
    comment 'OAuth Clients authorized to read or write user data' charset = utf8;

