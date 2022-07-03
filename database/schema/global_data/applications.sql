create table global_data.applications
(
    id                                int unsigned auto_increment
        primary key,
    organization_id                   int unsigned                         null,
    client_id                         varchar(80)                          not null,
    app_display_name                  varchar(255)                         not null,
    app_description                   varchar(255)                         null,
    long_description                  text                                 null,
    user_id                           bigint unsigned                      not null,
    icon_url                          varchar(2083)                        null,
    text_logo                         varchar(2083)                        null,
    splash_screen                     varchar(2083)                        null,
    homepage_url                      varchar(255)                         null,
    app_type                          varchar(32)                          null,
    app_design                        mediumtext                           null,
    created_at                        timestamp  default CURRENT_TIMESTAMP not null,
    updated_at                        timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at                        timestamp                            null,
    enabled                           tinyint    default 1                 not null,
    stripe_active                     tinyint    default 0                 not null,
    stripe_id                         varchar(255)                         null,
    stripe_subscription               varchar(255)                         null,
    stripe_plan                       varchar(100)                         null,
    last_four                         varchar(4)                           null,
    trial_ends_at                     timestamp                            null,
    subscription_ends_at              timestamp                            null,
    company_name                      varchar(100)                         null,
    country                           varchar(100)                         null,
    address                           varchar(255)                         null,
    state                             varchar(100)                         null,
    city                              varchar(100)                         null,
    zip                               varchar(10)                          null,
    plan_id                           int                                  null,
    exceeding_call_count              int        default 0                 not null,
    exceeding_call_charge             decimal(16, 2)                       null,
    study                             tinyint    default 0                 not null,
    billing_enabled                   tinyint    default 1                 not null,
    outcome_variable_id               int unsigned                         null,
    predictor_variable_id             int unsigned                         null,
    physician                         tinyint    default 0                 not null,
    additional_settings               text                                 null comment 'Additional non-design settings for your application.',
    app_status                        text                                 null comment 'The current build status for the iOS app, Android app, and Chrome extension.',
    build_enabled                     tinyint(1) default 0                 not null,
    wp_post_id                        bigint unsigned                      null,
    number_of_collaborators_where_app int unsigned                         null comment 'Number of Collaborators for this App.
                [Formula:
                    update applications
                        left join (
                            select count(id) as total, app_id
                            from collaborators
                            group by app_id
                        )
                        as grouped on applications.id = grouped.app_id
                    set applications.number_of_collaborators_where_app = count(grouped.total)
                ]
                ',
    is_public                         tinyint(1)                           null,
    sort_order                        int                                  not null,
    slug                              varchar(200)                         null comment 'The slug is the part of a URL that identifies a page in human-readable keywords.',
    constraint applications_client_id_unique
        unique (client_id),
    constraint applications_slug_uindex
        unique (slug),
    constraint applications_client_id_fk
        foreign key (client_id) references global_data.oa_clients (client_id),
    constraint applications_outcome_variable_id_fk
        foreign key (outcome_variable_id) references global_data.global_variables (id),
    constraint applications_predictor_variable_id_fk
        foreign key (predictor_variable_id) references global_data.global_variables (id),
    constraint applications_user_id_fk
        foreign key (user_id) references global_data.users (id),
    constraint applications_wp_posts_ID_fk
        foreign key (wp_post_id) references global_data.wp_posts (ID)
)
    comment 'Settings for applications created by the no-code QuantiModo app builder at https://builder.quantimo.do.  '
    charset = utf8;

