create table global_data.global_variables
(
    id                                                  int unsigned auto_increment comment 'Meaningless auto assigned integer for relating to other data. '
        primary key,
    name                                                varchar(125)                                    not null comment '[Admin-Setting] A consumer friendly name for this item. The intent is to provide a test name that health care consumers will recognize.',
    number_of_user_variables                            int         default 0                           not null comment 'Number of variables',
    variable_category_id                                tinyint unsigned                                not null comment 'Variable category ID',
    default_unit_id                                     smallint unsigned                               not null comment 'ID of the default unit for the variable',
    default_value                                       double                                          null comment '[]',
    cause_only                                          tinyint(1)                                      null comment '[Admin-Setting] A value of 1 indicates that this variable is generally a cause in a causal relationship.  An example of a causeOnly variable would be a variable such as Cloud Cover which would generally not be influenced by the behaviour of the user',
    client_id                                           varchar(80)                                     null comment '[Calculated] ID',
    combination_operation                               enum ('SUM', 'MEAN')                            null comment '[Admin-Setting] How to combine values of this variable (for instance, to see a summary of the values over a month) SUM or MEAN',
    common_alias                                        varchar(125)                                    null comment '[Deprecated]',
    created_at                                          timestamp   default CURRENT_TIMESTAMP           not null comment '[db-gen]',
    description                                         text                                            null comment '[]',
    duration_of_action                                  int unsigned                                    null comment 'How long the effect of a measurement in this variable lasts',
    filling_value                                       double      default -1                          null comment 'Value for replacing null measurements',
    image_url                                           varchar(2083)                                   null comment '[]',
    informational_url                                   varchar(2083)                                   null comment '[Admin-Setting] A wikipedia article, for instance',
    ion_icon                                            varchar(40)                                     null comment '[Admin-Setting]',
    kurtosis                                            double                                          null comment 'Kurtosis',
    maximum_allowed_value                               double                                          null comment 'Maximum reasonable value for a single measurement for this variable in the default unit. ',
    maximum_recorded_value                              double                                          null comment 'Maximum recorded value of this variable',
    mean                                                double                                          null comment 'Mean',
    median                                              double                                          null comment 'Median',
    minimum_allowed_value                               double                                          null comment 'Minimum reasonable value for this variable (uses default unit)',
    minimum_recorded_value                              double                                          null comment 'Minimum recorded value of this variable',
    number_of_aggregate_correlations_as_cause           int unsigned                                    null comment 'Number of aggregate correlations for which this variable is the cause variable',
    most_common_original_unit_id                        int                                             null comment 'Most common Unit ID',
    most_common_value                                   double                                          null comment 'Most common value',
    number_of_aggregate_correlations_as_effect          int unsigned                                    null comment 'Number of aggregate correlations for which this variable is the effect variable',
    number_of_unique_values                             int                                             null comment 'Number of unique values',
    onset_delay                                         int unsigned                                    null comment 'How long it takes for a measurement in this variable to take effect',
    outcome                                             tinyint(1)                                      null comment 'Outcome variables (those with `outcome` == 1) are variables for which a human would generally want to identify the influencing factors.  These include symptoms of illness, physique, mood, cognitive performance, etc.  Generally correlation calculations are only performed on outcome variables.',
    parent_id                                           int unsigned                                    null comment 'ID of the parent variable if this variable has any parent',
    price                                               double                                          null comment 'Price',
    product_url                                         varchar(2083)                                   null comment 'Product URL',
    second_most_common_value                            double                                          null comment '[]',
    skewness                                            double                                          null comment '[] Skewness',
    standard_deviation                                  double                                          null comment '[calculated] Standard Deviation',
    status                                              varchar(25) default 'WAITING'                   not null comment 'status',
    third_most_common_value                             double                                          null comment '[]',
    updated_at                                          timestamp   default CURRENT_TIMESTAMP           not null on update CURRENT_TIMESTAMP comment '[]',
    variance                                            double                                          null comment 'Variance',
    most_common_connector_id                            int unsigned                                    null comment '[]',
    synonyms                                            varchar(600)                                    null comment '[admin-edit,public-write] The primary variable name and any synonyms for it. This field should be used for non-specific variable searches.',
    wikipedia_url                                       varchar(2083)                                   null comment '[]',
    brand_name                                          varchar(125)                                    null comment '[Admin-Setting,Imported] Product brand name',
    valence                                             enum ('positive', 'negative', 'neutral')        null comment '[]',
    wikipedia_title                                     varchar(100)                                    null comment '[]',
    number_of_tracking_reminders                        int                                             null comment '[]',
    upc_12                                              varchar(255)                                    null comment '[]',
    upc_14                                              varchar(255)                                    null comment '[]',
    number_common_tagged_by                             int unsigned                                    null comment '[]',
    number_of_common_tags                               int unsigned                                    null comment '[]',
    deleted_at                                          timestamp                                       null comment '[]',
    most_common_source_name                             varchar(255)                                    null comment '[]',
    data_sources_count                                  text                                            null comment 'Array of connector or client measurement data source names as key with number of users as value',
    optimal_value_message                               varchar(500)                                    null comment '[]',
    best_cause_variable_id                              int unsigned                                    null comment '[Calculated] The strongest predictor variable for all users.',
    best_effect_variable_id                             int unsigned                                    null comment '[Calculated] The strongest outcome variable for all users.',
    common_maximum_allowed_daily_value                  double                                          null comment '[validation]',
    common_minimum_allowed_daily_value                  double                                          null comment '[validation]',
    common_minimum_allowed_non_zero_value               double                                          null comment '[validation]',
    minimum_allowed_seconds_between_measurements        int                                             null comment '[]',
    average_seconds_between_measurements                int                                             null comment '[Calculated] Average seconds between measurements for the average user.  Helps identify duplicate or erronous data and spamming of the database.',
    median_seconds_between_measurements                 int                                             null comment '[]',
    number_of_raw_measurements_with_tags_joins_children int unsigned                                    null comment '[]',
    additional_meta_data                                text                                            null comment '[] JSON-encoded additional data that does not fit in any other columns. JSON object',
    manual_tracking                                     tinyint(1)                                      null comment '[]',
    analysis_settings_modified_at                       timestamp                                       null comment '[Internal] When last analysis settings we''re changed.',
    newest_data_at                                      timestamp                                       null comment '[]',
    analysis_requested_at                               timestamp                                       null comment '[Internal] When an analysis was manually triggered.',
    reason_for_analysis                                 varchar(255)                                    null comment '[]',
    analysis_started_at                                 timestamp                                       null comment '[Internal] When the analysis started.',
    analysis_ended_at                                   timestamp                                       null comment '[Internal] When last analysis was completed.',
    user_error_message                                  text                                            null comment '[]',
    internal_error_message                              text                                            null comment '[]',
    latest_tagged_measurement_start_at                  timestamp                                       null comment '[]',
    earliest_tagged_measurement_start_at                timestamp                                       null comment '[]',
    latest_non_tagged_measurement_start_at              timestamp                                       null comment '[]',
    earliest_non_tagged_measurement_start_at            timestamp                                       null comment '[]',
    wp_post_id                                          bigint unsigned                                 null comment '[]',
    number_of_soft_deleted_measurements                 int                                             null comment 'Formula: update variables v
                inner join (
                    select measurements.variable_id, count(measurements.id) as number_of_soft_deleted_measurements
                    from measurements
                    where measurements.deleted_at is not null
                    group by measurements.variable_id
                    ) m on v.id = m.variable_id
                set v.number_of_soft_deleted_measurements = m.number_of_soft_deleted_measurements
            ',
    charts                                              json                                            null comment '[Calculated] Highcharts configuration',
    creator_user_id                                     bigint unsigned                                 not null comment '[api-gen]',
    best_aggregate_correlation_id                       int                                             null comment '[Calculated] The strongest predictor or outcome for all users.',
    filling_type                                        enum ('zero', 'none', 'interpolation', 'value') null comment '[]',
    number_of_outcome_population_studies                int unsigned                                    null comment 'Number of Global Population Studies for this Cause Variable.
                [Formula:
                    update variables
                        left join (
                            select count(id) as total, cause_variable_id
                            from aggregate_correlations
                            group by cause_variable_id
                        )
                        as grouped on variables.id = grouped.cause_variable_id
                    set variables.number_of_outcome_population_studies = count(grouped.total)
                ]
                ',
    number_of_predictor_population_studies              int unsigned                                    null comment 'Number of Global Population Studies for this Effect Variable.
                [Formula:
                    update variables
                        left join (
                            select count(id) as total, effect_variable_id
                            from aggregate_correlations
                            group by effect_variable_id
                        )
                        as grouped on variables.id = grouped.effect_variable_id
                    set variables.number_of_predictor_population_studies = count(grouped.total)
                ]
                ',
    number_of_applications_where_outcome_variable       int unsigned                                    null comment 'Number of Applications for this Outcome Variable.
                [Formula:
                    update variables
                        left join (
                            select count(id) as total, outcome_variable_id
                            from applications
                            group by outcome_variable_id
                        )
                        as grouped on variables.id = grouped.outcome_variable_id
                    set variables.number_of_applications_where_outcome_variable = count(grouped.total)
                ]',
    number_of_applications_where_predictor_variable     int unsigned                                    null comment 'Number of Applications for this Predictor Variable.
                [Formula:
                    update variables
                        left join (
                            select count(id) as total, predictor_variable_id
                            from applications
                            group by predictor_variable_id
                        )
                        as grouped on variables.id = grouped.predictor_variable_id
                    set variables.number_of_applications_where_predictor_variable = count(grouped.total)
                ]
                ',
    number_of_common_tags_where_tag_variable            int unsigned                                    null comment 'Number of Common Tags for this Tag Variable.
                [Formula:
                    update variables
                        left join (
                            select count(id) as total, tag_variable_id
                            from common_tags
                            group by tag_variable_id
                        )
                        as grouped on variables.id = grouped.tag_variable_id
                    set variables.number_of_common_tags_where_tag_variable = count(grouped.total)
                ]
                ',
    number_of_common_tags_where_tagged_variable         int unsigned                                    null comment 'Number of Common Tags for this Tagged Variable.
                [Formula:
                    update variables
                        left join (
                            select count(id) as total, tagged_variable_id
                            from common_tags
                            group by tagged_variable_id
                        )
                        as grouped on variables.id = grouped.tagged_variable_id
                    set variables.number_of_common_tags_where_tagged_variable = count(grouped.total)
                ]
                ',
    number_of_outcome_case_studies                      int unsigned                                    null comment 'Number of Individual Case Studies for this Cause Variable.
                [Formula:
                    update variables
                        left join (
                            select count(id) as total, cause_variable_id
                            from correlations
                            group by cause_variable_id
                        )
                        as grouped on variables.id = grouped.cause_variable_id
                    set variables.number_of_outcome_case_studies = count(grouped.total)
                ]
                ',
    number_of_predictor_case_studies                    int unsigned                                    null comment 'Number of Individual Case Studies for this Effect Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, effect_variable_id
                            from correlations
                            group by effect_variable_id
                        )
                        as grouped on variables.id = grouped.effect_variable_id
                    set variables.number_of_predictor_case_studies = count(grouped.total)]',
    number_of_measurements                              int unsigned                                    null comment 'Number of Measurements for this Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, variable_id
                            from measurements
                            group by variable_id
                        )
                        as grouped on variables.id = grouped.variable_id
                    set variables.number_of_measurements = count(grouped.total)]',
    number_of_studies_where_cause_variable              int unsigned                                    null comment 'Number of Studies for this Cause Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, cause_variable_id
                            from studies
                            group by cause_variable_id
                        )
                        as grouped on variables.id = grouped.cause_variable_id
                    set variables.number_of_studies_where_cause_variable = count(grouped.total)]',
    number_of_studies_where_effect_variable             int unsigned                                    null comment 'Number of Studies for this Effect Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, effect_variable_id
                            from studies
                            group by effect_variable_id
                        )
                        as grouped on variables.id = grouped.effect_variable_id
                    set variables.number_of_studies_where_effect_variable = count(grouped.total)]',
    number_of_tracking_reminder_notifications           int unsigned                                    null comment 'Number of Tracking Reminder Notifications for this Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, variable_id
                            from tracking_reminder_notifications
                            group by variable_id
                        )
                        as grouped on variables.id = grouped.variable_id
                    set variables.number_of_tracking_reminder_notifications = count(grouped.total)]',
    number_of_user_tags_where_tag_variable              int unsigned                                    null comment 'Number of User Tags for this Tag Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, tag_variable_id
                            from user_tags
                            group by tag_variable_id
                        )
                        as grouped on variables.id = grouped.tag_variable_id
                    set variables.number_of_user_tags_where_tag_variable = count(grouped.total)]',
    number_of_user_tags_where_tagged_variable           int unsigned                                    null comment 'Number of User Tags for this Tagged Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, tagged_variable_id
                            from user_tags
                            group by tagged_variable_id
                        )
                        as grouped on variables.id = grouped.tagged_variable_id
                    set variables.number_of_user_tags_where_tagged_variable = count(grouped.total)]',
    number_of_variables_where_best_cause_variable       int unsigned                                    null comment 'Number of Variables for this Best Cause Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, best_cause_variable_id
                            from variables
                            group by best_cause_variable_id
                        )
                        as grouped on variables.id = grouped.best_cause_variable_id
                    set variables.number_of_variables_where_best_cause_variable = count(grouped.total)]',
    number_of_variables_where_best_effect_variable      int unsigned                                    null comment 'Number of Variables for this Best Effect Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, best_effect_variable_id
                            from variables
                            group by best_effect_variable_id
                        )
                        as grouped on variables.id = grouped.best_effect_variable_id
                    set variables.number_of_variables_where_best_effect_variable = count(grouped.total)]',
    number_of_votes_where_cause_variable                int unsigned                                    null comment 'Number of Votes for this Cause Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, cause_variable_id
                            from votes
                            group by cause_variable_id
                        )
                        as grouped on variables.id = grouped.cause_variable_id
                    set variables.number_of_votes_where_cause_variable = count(grouped.total)]',
    number_of_votes_where_effect_variable               int unsigned                                    null comment 'Number of Votes for this Effect Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, effect_variable_id
                            from votes
                            group by effect_variable_id
                        )
                        as grouped on variables.id = grouped.effect_variable_id
                    set variables.number_of_votes_where_effect_variable = count(grouped.total)]',
    number_of_users_where_primary_outcome_variable      int unsigned                                    null comment 'Number of Users for this Primary Outcome Variable.
                    [Formula: update variables
                        left join (
                            select count(ID) as total, primary_outcome_variable_id
                            from wp_users
                            group by primary_outcome_variable_id
                        )
                        as grouped on variables.id = grouped.primary_outcome_variable_id
                    set variables.number_of_users_where_primary_outcome_variable = count(grouped.total)]',
    deletion_reason                                     varchar(280)                                    null comment 'The reason the variable was deleted.',
    maximum_allowed_daily_value                         double                                          null comment 'The maximum allowed value in the default unit for measurements aggregated over a single day. ',
    record_size_in_kb                                   int                                             null comment '[]',
    number_of_common_joined_variables                   int                                             null comment 'Joined variables are duplicate variables measuring the same thing. ',
    number_of_common_ingredients                        int                                             null comment 'Measurements for this variable can be used to synthetically generate ingredient measurements. ',
    number_of_common_foods                              int                                             null comment 'Measurements for this ingredient variable can be synthetically generate by food measurements. ',
    number_of_common_children                           int                                             null comment 'Measurements for this parent category variable can be synthetically generated by measurements from its child variables. ',
    number_of_common_parents                            int                                             null comment 'Measurements for this parent category variable can be synthetically generated by measurements from its child variables. ',
    number_of_user_joined_variables                     int                                             null comment 'Joined variables are duplicate variables measuring the same thing. This only includes ones created by users. ',
    number_of_user_ingredients                          int                                             null comment 'Measurements for this variable can be used to synthetically generate ingredient measurements. This only includes ones created by users. ',
    number_of_user_foods                                int                                             null comment 'Measurements for this ingredient variable can be synthetically generate by food measurements. This only includes ones created by users. ',
    number_of_user_children                             int                                             null comment 'Measurements for this parent category variable can be synthetically generated by measurements from its child variables. This only includes ones created by users. ',
    number_of_user_parents                              int                                             null comment 'Measurements for this parent category variable can be synthetically generated by measurements from its child variables. This only includes ones created by users. ',
    is_public                                           tinyint(1)                                      null comment '[]',
    sort_order                                          int                                             not null comment '[]',
    is_goal                                             tinyint(1)                                      null comment 'The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  The foods you eat are not generally an objective end in themselves. ',
    controllable                                        tinyint(1)                                      null comment 'You can control the foods you eat directly. However, symptom severity or weather is not directly controllable. ',
    boring                                              tinyint(1)                                      null comment '[Admin-Setting] The variable is boring if the average person would not be interested in its causes or effects.',
    slug                                                varchar(200)                                    null comment 'The slug is an identifier in human-readable keywords, used as id for the exchange format and id in document database.',
    canonical_variable_id                               int unsigned                                    null comment '[Admin-Setting] If a variable duplicates another but with a different name, set the canonical variable id to match the variable with the more appropriate name.  Then only the canonical variable will be displayed and all data for the duplicate variable will be included when fetching data for the canonical variable.',
    predictor                                           tinyint(1)                                      null comment 'predictor is true if the variable is a factor that could influence an outcome of interest',
    source_url                                          varchar(2083)                                   null comment '[admin,public-if-null] URL for the website related to the database containing the info that was used to create this variable such as https://world.openfoodfacts.org or https://dsld.od.nih.gov/dsld',
    loinc_core_id                                       int                                             null comment '[]',
    abbreviated_name                                    varchar(100)                                    null comment '[Admin-Setting] Canonical shorter version of the name or scientific abbrevation',
    version_first_released                              varchar(255)                                    null comment 'The CureDAO version number in which the record was first released. For oldest records where the version released number is known, this field will be null.',
    version_last_changed                                varchar(255)                                    null comment 'The CureDAO version number in which the record has last changed. For records that have never been updated after their release, this field will contain the same value as the loinc.VersionFirstReleased field.',
    loinc_id                                            int unsigned                                    null comment '[]',
    rxnorm_id                                           int unsigned                                    null comment '[]',
    snomed_id                                           int unsigned                                    null comment '[]',
    meddra_all_indications_id                           int unsigned                                    null comment '[]',
    meddra_all_side_effects_id                          int unsigned                                    null comment '[]',
    icd10_id                                            int unsigned                                    null comment '[]',
    uniprot_id                                          int unsigned                                    null comment '[]',
    hmdb_id                                             int unsigned                                    null comment '[]',
    gene_ontology_id                                    int unsigned                                    null comment '[]',
    aact_id                                             int unsigned                                    null comment '[]',
    constraint name_UNIQUE
        unique (name),
    constraint variables_slug_uindex
        unique (slug),
    constraint qm_variables_loinc_core_id_fk
        foreign key (loinc_core_id) references global_data.loinc_core (id),
    constraint variables_aggregate_correlations_id_fk
        foreign key (best_aggregate_correlation_id) references global_data.global_study_results (id)
            on delete set null,
    constraint variables_best_cause_variable_id_fk
        foreign key (best_cause_variable_id) references global_data.global_variables (id)
            on delete set null,
    constraint variables_best_effect_variable_id_fk
        foreign key (best_effect_variable_id) references global_data.global_variables (id)
            on delete set null,
    constraint variables_client_id_fk
        foreign key (client_id) references global_data.oa_clients (client_id),
    constraint variables_default_unit_id_fk
        foreign key (default_unit_id) references global_data.units (id),
    constraint variables_variable_category_id_fk
        foreign key (variable_category_id) references global_data.variable_categories (id),
    constraint variables_wp_posts_ID_fk
        foreign key (wp_post_id) references global_data.wp_posts (ID)
            on update cascade on delete set null
)
    comment 'Variable overviews with statistics, analysis settings, and data visualizations and likely outcomes or predictors based on the anonymously aggregated donated data.'
    charset = utf8;

create index IDX_cat_unit_public_name
    on global_data.global_variables (variable_category_id, default_unit_id, name, number_of_user_variables, id);

create index fk_variableDefaultUnit
    on global_data.global_variables (default_unit_id);

create index public_deleted_at_synonyms_number_of_user_variables_index
    on global_data.global_variables (deleted_at, synonyms, number_of_user_variables);

create index variables_analysis_ended_at_index
    on global_data.global_variables (analysis_ended_at);

create index variables_public_name_number_of_user_variables_index
    on global_data.global_variables (name, number_of_user_variables);

