create table global_data.variable_categories
(
    id                                           tinyint unsigned auto_increment
        primary key,
    name                                         varchar(64)                                     not null comment 'Name of the category',
    filling_value                                double                                          null comment 'Value for replacing null measurements',
    maximum_allowed_value                        double                                          null comment 'Maximum recorded value of this category',
    minimum_allowed_value                        double                                          null comment 'Minimum recorded value of this category',
    duration_of_action                           int unsigned         default 86400              not null comment 'How long the effect of a measurement in this variable lasts',
    onset_delay                                  int unsigned         default 0                  not null comment 'How long it takes for a measurement in this variable to take effect',
    combination_operation                        enum ('SUM', 'MEAN') default 'SUM'              not null comment 'How to combine values of this variable (for instance, to see a summary of the values over a month) SUM or MEAN',
    cause_only                                   tinyint(1)           default 0                  not null comment 'A value of 1 indicates that this category is generally a cause in a causal relationship.  An example of a causeOnly category would be a category such as Work which would generally not be influenced by the behaviour of the user',
    outcome                                      tinyint(1)                                      null,
    created_at                                   timestamp            default CURRENT_TIMESTAMP  not null,
    updated_at                                   timestamp            default CURRENT_TIMESTAMP  not null on update CURRENT_TIMESTAMP,
    image_url                                    tinytext                                        null comment 'Image URL',
    default_unit_id                              smallint unsigned    default 12                 null comment 'ID of the default unit for the category',
    deleted_at                                   timestamp                                       null,
    manual_tracking                              tinyint(1)           default 0                  not null comment 'Should we include in manual tracking searches?',
    minimum_allowed_seconds_between_measurements int                                             null,
    average_seconds_between_measurements         int                                             null,
    median_seconds_between_measurements          int                                             null,
    wp_post_id                                   bigint unsigned                                 null,
    filling_type                                 enum ('zero', 'none', 'interpolation', 'value') null,
    number_of_outcome_population_studies         int unsigned                                    null comment 'Number of Global Population Studies for this Cause Variable Category.
                [Formula:
                    update variable_categories
                        left join (
                            select count(id) as total, cause_variable_category_id
                            from aggregate_correlations
                            group by cause_variable_category_id
                        )
                        as grouped on variable_categories.id = grouped.cause_variable_category_id
                    set variable_categories.number_of_outcome_population_studies = count(grouped.total)
                ]
                ',
    number_of_predictor_population_studies       int unsigned                                    null comment 'Number of Global Population Studies for this Effect Variable Category.
                [Formula:
                    update variable_categories
                        left join (
                            select count(id) as total, effect_variable_category_id
                            from aggregate_correlations
                            group by effect_variable_category_id
                        )
                        as grouped on variable_categories.id = grouped.effect_variable_category_id
                    set variable_categories.number_of_predictor_population_studies = count(grouped.total)
                ]
                ',
    number_of_outcome_case_studies               int unsigned                                    null comment 'Number of Individual Case Studies for this Cause Variable Category.
                [Formula:
                    update variable_categories
                        left join (
                            select count(id) as total, cause_variable_category_id
                            from correlations
                            group by cause_variable_category_id
                        )
                        as grouped on variable_categories.id = grouped.cause_variable_category_id
                    set variable_categories.number_of_outcome_case_studies = count(grouped.total)
                ]
                ',
    number_of_predictor_case_studies             int unsigned                                    null comment 'Number of Individual Case Studies for this Effect Variable Category.
                [Formula:
                    update variable_categories
                        left join (
                            select count(id) as total, effect_variable_category_id
                            from correlations
                            group by effect_variable_category_id
                        )
                        as grouped on variable_categories.id = grouped.effect_variable_category_id
                    set variable_categories.number_of_predictor_case_studies = count(grouped.total)
                ]
                ',
    number_of_measurements                       int unsigned                                    null comment 'Number of Measurements for this Variable Category.
                    [Formula: update variable_categories
                        left join (
                            select count(id) as total, variable_category_id
                            from measurements
                            group by variable_category_id
                        )
                        as grouped on variable_categories.id = grouped.variable_category_id
                    set variable_categories.number_of_measurements = count(grouped.total)]',
    number_of_user_variables                     int unsigned                                    null comment 'Number of User Variables for this Variable Category.
                    [Formula: update variable_categories
                        left join (
                            select count(id) as total, variable_category_id
                            from user_variables
                            group by variable_category_id
                        )
                        as grouped on variable_categories.id = grouped.variable_category_id
                    set variable_categories.number_of_user_variables = count(grouped.total)]',
    number_of_variables                          int unsigned                                    null comment 'Number of Variables for this Variable Category.
                    [Formula: update variable_categories
                        left join (
                            select count(id) as total, variable_category_id
                            from variables
                            group by variable_category_id
                        )
                        as grouped on variable_categories.id = grouped.variable_category_id
                    set variable_categories.number_of_variables = count(grouped.total)]',
    is_public                                    tinyint(1)                                      null,
    synonyms                                     varchar(600)                                    not null comment 'The primary name and any synonyms for it. This field should be used for non-specific searches.',
    amazon_product_category                      varchar(100)                                    not null comment 'The Amazon equivalent product category.',
    boring                                       tinyint(1)                                      null comment 'If boring, the category should be hidden by default.',
    effect_only                                  tinyint(1)                                      null comment 'effect_only is true if people would never be interested in the effects of most variables in the category.',
    predictor                                    tinyint(1)                                      null comment 'Predictor is true if people would like to know the effects of most variables in the category.',
    font_awesome                                 varchar(100)                                    null,
    ion_icon                                     varchar(100)                                    null,
    more_info                                    varchar(255)                                    null comment 'More information displayed when the user is adding reminders and going through the onboarding process. ',
    valence                                      enum ('positive', 'negative', 'neutral')        not null comment 'Set the valence positive if more is better for all the variables in the category, negative if more is bad, and neutral if none of the variables have such a valence. Valence is null if there is not a consistent valence for all variables in the category. ',
    name_singular                                varchar(255)                                    not null comment 'The singular version of the name.',
    sort_order                                   int                                             not null,
    is_goal                                      enum ('ALWAYS', 'SOMETIMES', 'NEVER')           not null comment 'The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  The foods you eat are not generally an objective end in themselves. ',
    controllable                                 enum ('ALWAYS', 'SOMETIMES', 'NEVER')           not null comment 'The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  Symptom severity is not directly controllable. ',
    slug                                         varchar(200)                                    null comment 'The slug is the part of a URL that identifies a page in human-readable keywords.',
    constraint variable_categories_slug_uindex
        unique (slug),
    constraint variable_categories_default_unit_id_fk
        foreign key (default_unit_id) references global_data.units (id),
    constraint variable_categories_wp_posts_ID_fk
        foreign key (wp_post_id) references global_data.wp_posts (ID)
)
    comment 'Categories of of trackable variables include Treatments, Emotions, Symptoms, and Foods.' charset = utf8;

