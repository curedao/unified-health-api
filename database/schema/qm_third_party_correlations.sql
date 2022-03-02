create table qm_third_party_correlations
(
    cause_id                                                     int unsigned                        not null comment 'variable ID of the cause variable for which the user desires correlations',
    effect_id                                                    int unsigned                        not null comment 'variable ID of the effect variable for which the user desires correlations',
    qm_score                                                     double                              null comment 'QM Score',
    forward_pearson_correlation_coefficient                      float(10, 4)                        null comment 'Pearson correlation coefficient between cause and effect measurements',
    value_predicting_high_outcome                                double                              null comment 'cause value that predicts an above average effect value (in default unit for cause variable)',
    value_predicting_low_outcome                                 double                              null comment 'cause value that predicts a below average effect value (in default unit for cause variable)',
    predicts_high_effect_change                                  int(5)                              null comment 'The percent change in the outcome typically seen when the predictor value is closer to the predictsHighEffect value. ',
    predicts_low_effect_change                                   int(5)                              null comment 'The percent change in the outcome from average typically seen when the predictor value is closer to the predictsHighEffect value.',
    average_effect                                               double                              null,
    average_effect_following_high_cause                          double                              null,
    average_effect_following_low_cause                           double                              null,
    average_daily_low_cause                                      double                              null,
    average_daily_high_cause                                     double                              null,
    average_forward_pearson_correlation_over_onset_delays        float                               null,
    average_reverse_pearson_correlation_over_onset_delays        float                               null,
    cause_changes                                                int                                 null comment 'Cause changes',
    cause_filling_value                                          double                              null,
    cause_number_of_processed_daily_measurements                 int                                 not null,
    cause_number_of_raw_measurements                             int                                 not null,
    cause_unit_id                                                int                                 null comment 'Unit ID of Cause',
    confidence_interval                                          double                              null comment 'A margin of error around the effect size.  Wider confidence intervals reflect greater uncertainty about the Ã¢â‚¬Å“trueÃ¢â‚¬Â value of the correlation.',
    critical_t_value                                             double                              null comment 'Value of t from lookup table which t must exceed for significance.',
    created_at                                                   timestamp default CURRENT_TIMESTAMP not null,
    data_source_name                                             varchar(255)                        null,
    deleted_at                                                   timestamp                           null,
    duration_of_action                                           int                                 null comment 'Time over which the cause is expected to produce a perceivable effect following the onset delay',
    effect_changes                                               int                                 null comment 'Effect changes',
    effect_filling_value                                         double                              null,
    effect_number_of_processed_daily_measurements                int                                 not null,
    effect_number_of_raw_measurements                            int                                 not null,
    error                                                        text                                null,
    forward_spearman_correlation_coefficient                     float                               null,
    id                                                           int auto_increment
        primary key,
    number_of_days                                               int                                 not null,
    number_of_pairs                                              int                                 null comment 'Number of points that went into the correlation calculation',
    onset_delay                                                  int                                 null comment 'User estimated or default time after cause measurement before a perceivable effect is observed',
    onset_delay_with_strongest_pearson_correlation               int(10)                             null,
    optimal_pearson_product                                      double                              null comment 'Optimal Pearson Product',
    p_value                                                      double                              null comment 'The measure of statistical significance. A value less than 0.05 means that a correlation is statistically significant or consistent enough that it is unlikely to be a coincidence.',
    pearson_correlation_with_no_onset_delay                      float                               null,
    predictive_pearson_correlation_coefficient                   double                              null comment 'Predictive Pearson Correlation Coefficient',
    reverse_pearson_correlation_coefficient                      double                              null comment 'Correlation when cause and effect are reversed. For any causal relationship, the forward correlation should exceed the reverse correlation',
    statistical_significance                                     float(10, 4)                        null comment 'A function of the effect size and sample size',
    strongest_pearson_correlation_coefficient                    float                               null,
    t_value                                                      double                              null comment 'Function of correlation and number of samples.',
    updated_at                                                   timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    user_id                                                      bigint unsigned                     not null,
    grouped_cause_value_closest_to_value_predicting_low_outcome  double                              null,
    grouped_cause_value_closest_to_value_predicting_high_outcome double                              null,
    client_id                                                    varchar(255)                        null,
    published_at                                                 timestamp                           null,
    wp_post_id                                                   int                                 null,
    status                                                       varchar(25)                         null,
    cause_variable_category_id                                   tinyint unsigned                    null,
    effect_variable_category_id                                  tinyint unsigned                    null,
    interesting_variable_category_pair                           tinyint(1)                          null,
    cause_variable_id                                            int unsigned                        null,
    effect_variable_id                                           int unsigned                        null,
    constraint user_cause_effect
        unique (user_id, cause_id, effect_id),
    constraint third_party_correlations_cause_variable_category_id_fk
        foreign key (cause_variable_category_id) references qm_variable_categories (id),
    constraint third_party_correlations_cause_variables_id_fk
        foreign key (cause_id) references qm_variables (id),
    constraint third_party_correlations_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint third_party_correlations_effect_variable_category_id_fk
        foreign key (effect_variable_category_id) references qm_variable_categories (id),
    constraint third_party_correlations_effect_variables_id_fk
        foreign key (effect_id) references qm_variables (id)
)
    comment 'Stores Calculated Correlation Coefficients' charset = utf8;

create index cause
    on qm_third_party_correlations (cause_id);

create index effect
    on qm_third_party_correlations (effect_id);

