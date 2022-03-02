create table qm_user_variables
(
    id                                                   int unsigned auto_increment
        primary key,
    parent_id                                            int unsigned                             null comment 'ID of the parent variable if this variable has any parent',
    client_id                                            varchar(80)                              null,
    user_id                                              bigint unsigned                          not null,
    variable_id                                          int unsigned                             not null comment 'ID of variable',
    default_unit_id                                      smallint unsigned                        null comment 'ID of unit to use for this variable',
    minimum_allowed_value                                double                                   null comment 'Minimum reasonable value for this variable (uses default unit)',
    maximum_allowed_value                                double                                   null comment 'Maximum reasonable value for this variable (uses default unit)',
    filling_value                                        double       default -1                  null comment 'Value for replacing null measurements',
    join_with                                            int unsigned                             null comment 'The Variable this Variable should be joined with. If the variable is joined with some other variable then it is not shown to user in the list of variables',
    onset_delay                                          int unsigned                             null comment 'How long it takes for a measurement in this variable to take effect',
    duration_of_action                                   int unsigned                             null comment 'Estimated duration of time following the onset delay in which a stimulus produces a perceivable effect',
    variable_category_id                                 tinyint unsigned                         null comment 'ID of variable category',
    cause_only                                           tinyint(1)                               null comment 'A value of 1 indicates that this variable is generally a cause in a causal relationship.  An example of a causeOnly variable would be a variable such as Cloud Cover which would generally not be influenced by the behaviour of the user',
    filling_type                                         enum ('value', 'none')                   null comment '0 -> No filling, 1 -> Use filling-value',
    number_of_processed_daily_measurements               int                                      null comment 'Number of processed measurements',
    measurements_at_last_analysis                        int unsigned default 0                   not null comment 'Number of measurements at last analysis',
    last_unit_id                                         smallint unsigned                        null comment 'ID of last Unit',
    last_original_unit_id                                smallint unsigned                        null comment 'ID of last original Unit',
    `last_value`                                         double                                   null comment 'Last Value',
    last_original_value                                  double unsigned                          null comment 'Last original value which is stored',
    number_of_correlations                               int                                      null comment 'Number of correlations for this variable',
    status                                               varchar(25)                              null,
    standard_deviation                                   double                                   null comment 'Standard deviation',
    variance                                             double                                   null comment 'Variance',
    minimum_recorded_value                               double                                   null comment 'Minimum recorded value of this variable',
    maximum_recorded_value                               double                                   null comment 'Maximum recorded value of this variable',
    mean                                                 double                                   null comment 'Mean',
    median                                               double                                   null comment 'Median',
    most_common_original_unit_id                         int                                      null comment 'Most common Unit ID',
    most_common_value                                    double                                   null comment 'Most common value',
    number_of_unique_daily_values                        int                                      null comment 'Number of unique daily values',
    number_of_unique_values                              int                                      null comment 'Number of unique values',
    number_of_changes                                    int                                      null comment 'Number of changes',
    skewness                                             double                                   null comment 'Skewness',
    kurtosis                                             double                                   null comment 'Kurtosis',
    latitude                                             double                                   null,
    longitude                                            double                                   null,
    location                                             varchar(255)                             null,
    created_at                                           timestamp    default CURRENT_TIMESTAMP   not null,
    updated_at                                           timestamp    default CURRENT_TIMESTAMP   not null on update CURRENT_TIMESTAMP,
    outcome                                              tinyint(1)                               null comment 'Outcome variables (those with `outcome` == 1) are variables for which a human would generally want to identify the influencing factors.  These include symptoms of illness, physique, mood, cognitive performance, etc.  Generally correlation calculations are only performed on outcome variables',
    data_sources_count                                   text                                     null comment 'Array of connector or client measurement data source names as key and number of measurements as value',
    earliest_filling_time                                int                                      null comment 'Earliest filling time',
    latest_filling_time                                  int                                      null comment 'Latest filling time',
    last_processed_daily_value                           double                                   null comment 'Last value for user after daily aggregation and filling',
    outcome_of_interest                                  tinyint(1)   default 0                   null,
    predictor_of_interest                                tinyint(1)   default 0                   null,
    experiment_start_time                                timestamp                                null,
    experiment_end_time                                  timestamp                                null,
    description                                          text                                     null,
    alias                                                varchar(125)                             null,
    deleted_at                                           timestamp                                null,
    second_to_last_value                                 double                                   null,
    third_to_last_value                                  double                                   null,
    number_of_user_correlations_as_effect                int unsigned                             null comment 'Number of user correlations for which this variable is the effect variable',
    number_of_user_correlations_as_cause                 int unsigned                             null comment 'Number of user correlations for which this variable is the cause variable',
    combination_operation                                enum ('SUM', 'MEAN')                     null comment 'How to combine values of this variable (for instance, to see a summary of the values over a month) SUM or MEAN',
    informational_url                                    varchar(2000)                            null comment 'Wikipedia url',
    most_common_connector_id                             int unsigned                             null,
    valence                                              enum ('positive', 'negative', 'neutral') null,
    wikipedia_title                                      varchar(100)                             null,
    number_of_tracking_reminders                         int                                      not null,
    number_of_raw_measurements_with_tags_joins_children  int unsigned                             null,
    most_common_source_name                              varchar(255)                             null,
    optimal_value_message                                varchar(500)                             null,
    best_cause_variable_id                               int(10)                                  null,
    best_effect_variable_id                              int(10)                                  null,
    user_maximum_allowed_daily_value                     double                                   null,
    user_minimum_allowed_daily_value                     double                                   null,
    user_minimum_allowed_non_zero_value                  double                                   null,
    minimum_allowed_seconds_between_measurements         int                                      null,
    average_seconds_between_measurements                 int                                      null,
    median_seconds_between_measurements                  int                                      null,
    last_correlated_at                                   timestamp                                null,
    number_of_measurements_with_tags_at_last_correlation int                                      null,
    analysis_settings_modified_at                        timestamp                                null,
    newest_data_at                                       timestamp                                null,
    analysis_requested_at                                timestamp                                null,
    reason_for_analysis                                  varchar(255)                             null,
    analysis_started_at                                  timestamp                                null,
    analysis_ended_at                                    timestamp                                null,
    user_error_message                                   text                                     null,
    internal_error_message                               text                                     null,
    earliest_source_measurement_start_at                 timestamp                                null,
    latest_source_measurement_start_at                   timestamp                                null,
    latest_tagged_measurement_start_at                   timestamp                                null,
    earliest_tagged_measurement_start_at                 timestamp                                null,
    latest_non_tagged_measurement_start_at               timestamp                                null,
    earliest_non_tagged_measurement_start_at             timestamp                                null,
    wp_post_id                                           bigint unsigned                          null,
    number_of_soft_deleted_measurements                  int                                      null comment 'Formula: update user_variables v
                inner join (
                    select measurements.user_variable_id, count(measurements.id) as number_of_soft_deleted_measurements
                    from measurements
                    where measurements.deleted_at is not null
                    group by measurements.user_variable_id
                    ) m on v.id = m.user_variable_id
                set v.number_of_soft_deleted_measurements = m.number_of_soft_deleted_measurements
            ',
    best_user_correlation_id                             int                                      null,
    number_of_measurements                               int unsigned                             null comment 'Number of Measurements for this User Variable.
                    [Formula: update user_variables
                        left join (
                            select count(id) as total, user_variable_id
                            from measurements
                            group by user_variable_id
                        )
                        as grouped on user_variables.id = grouped.user_variable_id
                    set user_variables.number_of_measurements = count(grouped.total)]',
    number_of_tracking_reminder_notifications            int unsigned                             null comment 'Number of Tracking Reminder Notifications for this User Variable.
                    [Formula: update user_variables
                        left join (
                            select count(id) as total, user_variable_id
                            from tracking_reminder_notifications
                            group by user_variable_id
                        )
                        as grouped on user_variables.id = grouped.user_variable_id
                    set user_variables.number_of_tracking_reminder_notifications = count(grouped.total)]',
    deletion_reason                                      varchar(280)                             null comment 'The reason the variable was deleted.',
    record_size_in_kb                                    int                                      null,
    number_of_common_tags                                int                                      null comment 'Number of categories, joined variables, or ingredients for this variable that use this variables measurements to generate synthetically derived measurements. ',
    number_common_tagged_by                              int                                      null comment 'Number of children, joined variables or foods that this use has measurements for which are to be used to generate synthetic measurements for this variable. ',
    number_of_common_joined_variables                    int                                      null comment 'Joined variables are duplicate variables measuring the same thing. ',
    number_of_common_ingredients                         int                                      null comment 'Measurements for this variable can be used to synthetically generate ingredient measurements. ',
    number_of_common_foods                               int                                      null comment 'Measurements for this ingredient variable can be synthetically generate by food measurements. ',
    number_of_common_children                            int                                      null comment 'Measurements for this parent category variable can be synthetically generated by measurements from its child variables. ',
    number_of_common_parents                             int                                      null comment 'Measurements for this parent category variable can be synthetically generated by measurements from its child variables. ',
    number_of_user_tags                                  int                                      null comment 'Number of categories, joined variables, or ingredients for this variable that use this variables measurements to generate synthetically derived measurements. This only includes ones created by the user. ',
    number_user_tagged_by                                int                                      null comment 'Number of children, joined variables or foods that this use has measurements for which are to be used to generate synthetic measurements for this variable. This only includes ones created by the user. ',
    number_of_user_joined_variables                      int                                      null comment 'Joined variables are duplicate variables measuring the same thing. This only includes ones created by the user. ',
    number_of_user_ingredients                           int                                      null comment 'Measurements for this variable can be used to synthetically generate ingredient measurements. This only includes ones created by the user. ',
    number_of_user_foods                                 int                                      null comment 'Measurements for this ingredient variable can be synthetically generate by food measurements. This only includes ones created by the user. ',
    number_of_user_children                              int                                      null comment 'Measurements for this parent category variable can be synthetically generated by measurements from its child variables. This only includes ones created by the user. ',
    number_of_user_parents                               int                                      null comment 'Measurements for this parent category variable can be synthetically generated by measurements from its child variables. This only includes ones created by the user. ',
    is_public                                            tinyint(1)                               null,
    is_goal                                              tinyint(1)                               null comment 'The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  The foods you eat are not generally an objective end in themselves. ',
    controllable                                         tinyint(1)                               null comment 'You can control the foods you eat directly. However, symptom severity or weather is not directly controllable. ',
    boring                                               tinyint(1)                               null comment 'The user variable is boring if the owner would not be interested in its causes or effects. ',
    slug                                                 varchar(200)                             null comment 'The slug is the part of a URL that identifies a page in human-readable keywords.',
    predictor                                            tinyint(1)                               null comment 'predictor is true if the variable is a factor that could influence an outcome of interest',
    constraint user_id
        unique (user_id, variable_id),
    constraint user_variables_slug_uindex
        unique (slug),
    constraint user_variables_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint user_variables_correlations_qm_score_fk
        foreign key (best_user_correlation_id) references qm_correlations (id)
            on delete set null,
    constraint user_variables_default_unit_id_fk
        foreign key (default_unit_id) references qm_units (id),
    constraint user_variables_last_unit_id_fk
        foreign key (last_unit_id) references qm_units (id),
    constraint user_variables_user_id_fk
        foreign key (user_id) references users (id),
    constraint user_variables_variable_category_id_fk
        foreign key (variable_category_id) references qm_variable_categories (id),
    constraint user_variables_variables_id_fk
        foreign key (variable_id) references qm_variables (id)
)
    comment 'Variable statistics, analysis settings, and overviews with data visualizations and likely outcomes or predictors based on data for a specific individual'
    charset = utf8;

create index fk_variableSettings
    on qm_user_variables (variable_id);

create index user_variables_analysis_started_at_index
    on qm_user_variables (analysis_started_at);

create index user_variables_user_id_latest_tagged_measurement_time_index
    on qm_user_variables (user_id);

create index variables_analysis_ended_at_index
    on qm_user_variables (analysis_ended_at);

