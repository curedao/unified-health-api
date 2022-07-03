create table global_data.user_study_results
(
    id                                                           int auto_increment
        primary key,
    user_id                                                      bigint unsigned                                                 not null,
    cause_variable_id                                            int unsigned                                                    not null,
    effect_variable_id                                           int unsigned                                                    not null,
    qm_score                                                     double                                                          null comment 'A number representative of the relative importance of the relationship based on the strength,
                    usefulness, and plausible causality.  The higher the number, the greater the perceived importance.
                    This value can be used for sorting relationships by importance.  ',
    forward_pearson_correlation_coefficient                      float(10, 4)                                                    null comment 'Pearson correlation coefficient between cause and effect measurements',
    value_predicting_high_outcome                                double                                                          null comment 'cause value that predicts an above average effect value (in default unit for cause variable)',
    value_predicting_low_outcome                                 double                                                          null comment 'cause value that predicts a below average effect value (in default unit for cause variable)',
    predicts_high_effect_change                                  int(5)                                                          null comment 'The percent change in the outcome typically seen when the predictor value is closer to the predictsHighEffect value. ',
    predicts_low_effect_change                                   int(5)                                                          not null comment 'The percent change in the outcome from average typically seen when the predictor value is closer to the predictsHighEffect value.',
    average_effect                                               double                                                          not null comment 'The average effect variable measurement value used in analysis in the common unit. ',
    average_effect_following_high_cause                          double                                                          not null comment 'The average effect variable measurement value following an above average cause value (in the common unit). ',
    average_effect_following_low_cause                           double                                                          not null comment 'The average effect variable measurement value following a below average cause value (in the common unit). ',
    average_daily_low_cause                                      double                                                          not null comment 'The average of below average cause values (in the common unit). ',
    average_daily_high_cause                                     double                                                          not null comment 'The average of above average cause values (in the common unit). ',
    average_forward_pearson_correlation_over_onset_delays        float                                                           null,
    average_reverse_pearson_correlation_over_onset_delays        float                                                           null,
    cause_changes                                                int                                                             not null comment 'The number of times the cause measurement value was different from the one preceding it. ',
    cause_filling_value                                          double                                                          null,
    cause_number_of_processed_daily_measurements                 int                                                             not null,
    cause_number_of_raw_measurements                             int                                                             not null,
    cause_unit_id                                                smallint unsigned                                               null comment 'Unit ID of Cause',
    confidence_interval                                          double                                                          not null comment 'A margin of error around the effect size.  Wider confidence intervals reflect greater uncertainty about the true value of the correlation.',
    critical_t_value                                             double                                                          not null comment 'Value of t from lookup table which t must exceed for significance.',
    created_at                                                   timestamp default CURRENT_TIMESTAMP                             not null,
    data_source_name                                             varchar(255)                                                    null,
    deleted_at                                                   timestamp                                                       null,
    duration_of_action                                           int                                                             not null comment 'Time over which the cause is expected to produce a perceivable effect following the onset delay',
    effect_changes                                               int                                                             not null comment 'The number of times the effect measurement value was different from the one preceding it. ',
    effect_filling_value                                         double                                                          null,
    effect_number_of_processed_daily_measurements                int                                                             not null,
    effect_number_of_raw_measurements                            int                                                             not null,
    forward_spearman_correlation_coefficient                     float                                                           not null comment 'Predictive spearman correlation of the lagged pair data. While the Pearson correlation assesses linear relationships, the Spearman correlation assesses monotonic relationships (whether linear or not).',
    number_of_days                                               int                                                             not null,
    number_of_pairs                                              int                                                             not null comment 'Number of points that went into the correlation calculation',
    onset_delay                                                  int                                                             not null comment 'User estimated or default time after cause measurement before a perceivable effect is observed',
    onset_delay_with_strongest_pearson_correlation               int(10)                                                         null,
    optimal_pearson_product                                      double                                                          null comment 'Optimal Pearson Product',
    p_value                                                      double                                                          null comment 'The measure of statistical significance. A value less than 0.05 means that a correlation is statistically significant or consistent enough that it is unlikely to be a coincidence.',
    pearson_correlation_with_no_onset_delay                      float                                                           null,
    predictive_pearson_correlation_coefficient                   double                                                          null comment 'Predictive Pearson Correlation Coefficient',
    reverse_pearson_correlation_coefficient                      double                                                          null comment 'Correlation when cause and effect are reversed. For any causal relationship, the forward correlation should exceed the reverse correlation',
    statistical_significance                                     float(10, 4)                                                    null comment 'A function of the effect size and sample size',
    strongest_pearson_correlation_coefficient                    float                                                           null,
    t_value                                                      double                                                          null comment 'Function of correlation and number of samples.',
    updated_at                                                   timestamp default CURRENT_TIMESTAMP                             not null on update CURRENT_TIMESTAMP,
    grouped_cause_value_closest_to_value_predicting_low_outcome  double                                                          not null comment 'A realistic daily value (not a fraction from averaging) that typically precedes below average outcome values. ',
    grouped_cause_value_closest_to_value_predicting_high_outcome double                                                          not null comment 'A realistic daily value (not a fraction from averaging) that typically precedes below average outcome values. ',
    client_id                                                    varchar(255)                                                    null,
    published_at                                                 timestamp                                                       null,
    wp_post_id                                                   bigint unsigned                                                 null,
    status                                                       varchar(25)                                                     null,
    cause_variable_category_id                                   tinyint unsigned                                                not null,
    effect_variable_category_id                                  tinyint unsigned                                                not null,
    interesting_variable_category_pair                           tinyint(1)                                                      not null comment 'True if the combination of cause and effect variable categories are generally interesting.  For instance, treatment cause variables paired with symptom effect variables are interesting. ',
    newest_data_at                                               timestamp                                                       null comment 'The time the source data was last updated. This indicated whether the analysis is stale and should be performed again. ',
    analysis_requested_at                                        timestamp                                                       null,
    reason_for_analysis                                          varchar(255)                                                    not null comment 'The reason analysis was requested.',
    analysis_started_at                                          timestamp                                                       not null,
    analysis_ended_at                                            timestamp                                                       null,
    user_error_message                                           text                                                            null,
    internal_error_message                                       text                                                            null,
    cause_user_variable_id                                       int unsigned                                                    not null,
    effect_user_variable_id                                      int unsigned                                                    not null,
    latest_measurement_start_at                                  timestamp                                                       null,
    earliest_measurement_start_at                                timestamp                                                       null,
    cause_baseline_average_per_day                               float                                                           not null comment 'Predictor Average at Baseline (The average low non-treatment value of the predictor per day)',
    cause_baseline_average_per_duration_of_action                float                                                           not null comment 'Predictor Average at Baseline (The average low non-treatment value of the predictor per duration of action)',
    cause_treatment_average_per_day                              float                                                           not null comment 'Predictor Average During Treatment (The average high value of the predictor per day considered to be the treatment dosage)',
    cause_treatment_average_per_duration_of_action               float                                                           not null comment 'Predictor Average During Treatment (The average high value of the predictor per duration of action considered to be the treatment dosage)',
    effect_baseline_average                                      float                                                           null comment 'Outcome Average at Baseline (The normal value for the outcome seen without treatment during the previous duration of action time span)',
    effect_baseline_relative_standard_deviation                  float                                                           not null comment 'Outcome Average at Baseline (The average value seen for the outcome without treatment during the previous duration of action time span)',
    effect_baseline_standard_deviation                           float                                                           null comment 'Outcome Relative Standard Deviation at Baseline (How much the outcome value normally fluctuates without treatment during the previous duration of action time span)',
    effect_follow_up_average                                     float                                                           not null comment 'Outcome Average at Follow-Up (The average value seen for the outcome during the duration of action following the onset delay of the treatment)',
    effect_follow_up_percent_change_from_baseline                float                                                           not null comment 'Outcome Average at Follow-Up (The average value seen for the outcome during the duration of action following the onset delay of the treatment)',
    z_score                                                      float                                                           null comment 'The absolute value of the change over duration of action following the onset delay of treatment divided by the baseline outcome relative standard deviation. A.K.A The number of standard deviations from the mean. A zScore > 2 means pValue < 0.05 and is typically considered statistically significant.',
    experiment_end_at                                            timestamp                                                       not null comment 'The latest data used in the analysis. ',
    experiment_start_at                                          timestamp                                                       not null comment 'The earliest data used in the analysis. ',
    aggregate_correlation_id                                     int                                                             null,
    aggregated_at                                                timestamp                                                       null,
    usefulness_vote                                              int                                                             null comment 'The opinion of the data owner on whether or not knowledge of this relationship is useful.
                        -1 corresponds to a down vote. 1 corresponds to an up vote. 0 corresponds to removal of a
                        previous vote.  null corresponds to never having voted before.',
    causality_vote                                               int                                                             null comment 'The opinion of the data owner on whether or not there is a plausible mechanism of action
                        by which the predictor variable could influence the outcome variable.',
    deletion_reason                                              varchar(280)                                                    null comment 'The reason the variable was deleted.',
    record_size_in_kb                                            int                                                             null,
    correlations_over_durations                                  text                                                            not null comment 'Pearson correlations calculated with various duration of action lengths. This can be used to compare short and long term effects. ',
    correlations_over_delays                                     text                                                            not null comment 'Pearson correlations calculated with various onset delay lags used to identify reversed causality or asses the significant of a correlation with a given lag parameters. ',
    is_public                                                    tinyint(1)                                                      null,
    sort_order                                                   int                                                             not null,
    boring                                                       tinyint(1)                                                      null comment 'The relationship is boring if it is obvious, the predictor is not controllable, the outcome is not a goal, the relationship could not be causal, or the confidence is low. ',
    outcome_is_goal                                              tinyint(1)                                                      null comment 'The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  The foods you eat are not generally an objective end in themselves. ',
    predictor_is_controllable                                    tinyint(1)                                                      null comment 'The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  Symptom severity is not directly controllable. ',
    plausibly_causal                                             tinyint(1)                                                      null comment 'The effect of aspirin on headaches is plausibly causal. The effect of aspirin on precipitation does not have a plausible causal relationship. ',
    obvious                                                      tinyint(1)                                                      null comment 'The effect of aspirin on headaches is obvious. The effect of aspirin on productivity is not obvious. ',
    number_of_up_votes                                           int                                                             not null comment 'Number of people who feel this relationship is plausible and useful. ',
    number_of_down_votes                                         int                                                             not null comment 'Number of people who feel this relationship is implausible or not useful. ',
    strength_level                                               enum ('VERY STRONG', 'STRONG', 'MODERATE', 'WEAK', 'VERY WEAK') not null comment 'Strength level describes magnitude of the change in outcome observed following changes in the predictor. ',
    confidence_level                                             enum ('HIGH', 'MEDIUM', 'LOW')                                  not null comment 'Describes the confidence that the strength level will remain consist in the future.  The more data there is, the lesser the chance that the findings are a spurious correlation. ',
    relationship                                                 enum ('POSITIVE', 'NEGATIVE', 'NONE')                           not null comment 'If higher predictor values generally precede HIGHER outcome values, the relationship is considered POSITIVE.  If higher predictor values generally precede LOWER outcome values, the relationship is considered NEGATIVE. ',
    slug                                                         varchar(200)                                                    null comment 'The slug is the part of a URL that identifies a page in human-readable keywords.',
    constraint correlations_pk
        unique (user_id, cause_variable_id, effect_variable_id),
    constraint correlations_slug_uindex
        unique (slug),
    constraint correlations_user_id_cause_variable_id_effect_variable_id_uindex
        unique (user_id, cause_variable_id, effect_variable_id),
    constraint correlations_aggregate_correlations_id_fk
        foreign key (aggregate_correlation_id) references global_data.global_study_results (id),
    constraint correlations_cause_unit_id_fk
        foreign key (cause_unit_id) references global_data.units (id),
    constraint correlations_cause_variable_category_id_fk
        foreign key (cause_variable_category_id) references global_data.variable_categories (id),
    constraint correlations_cause_variable_id_fk
        foreign key (cause_variable_id) references global_data.global_variables (id),
    constraint correlations_client_id_fk
        foreign key (client_id) references global_data.oa_clients (client_id),
    constraint correlations_effect_variable_category_id_fk
        foreign key (effect_variable_category_id) references global_data.variable_categories (id),
    constraint correlations_effect_variable_id_fk
        foreign key (effect_variable_id) references global_data.global_variables (id),
    constraint correlations_user_id_fk
        foreign key (user_id) references global_data.users (id),
    constraint correlations_user_variables_cause_user_variable_id_fk
        foreign key (cause_user_variable_id) references global_data.user_variables (id)
            on update cascade on delete cascade,
    constraint correlations_user_variables_effect_user_variable_id_fk
        foreign key (effect_user_variable_id) references global_data.user_variables (id)
            on update cascade on delete cascade,
    constraint correlations_wp_posts_ID_fk
        foreign key (wp_post_id) references global_data.wp_posts (ID)
            on update cascade on delete set null
)
    comment 'Examination of the relationship between predictor and outcome variables.  This includes the potential optimal values for a given variable. '
    charset = utf8;

create index correlations_analysis_started_at_index
    on global_data.user_study_results (analysis_started_at);

create index correlations_deleted_at_analysis_ended_at_index
    on global_data.user_study_results (deleted_at, analysis_ended_at);

create index correlations_deleted_at_z_score_index
    on global_data.user_study_results (deleted_at, z_score);

create index correlations_updated_at_index
    on global_data.user_study_results (updated_at);

create index correlations_user_id_deleted_at_qm_score_index
    on global_data.user_study_results (user_id, deleted_at, qm_score);

create index user_id_cause_variable_id_deleted_at_qm_score_index
    on global_data.user_study_results (user_id, cause_variable_id, deleted_at, qm_score);

create index user_id_effect_variable_id_deleted_at_qm_score_index
    on global_data.user_study_results (user_id, effect_variable_id, deleted_at, qm_score);

