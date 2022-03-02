create table qm_aggregate_correlations
(
    id                                                           int auto_increment
        primary key,
    forward_pearson_correlation_coefficient                      float(10, 4)                                                    not null comment 'Pearson correlation coefficient between cause and effect measurements',
    onset_delay                                                  int                                                             not null comment 'User estimated or default time after cause measurement before a perceivable effect is observed',
    duration_of_action                                           int                                                             not null comment 'Time over which the cause is expected to produce a perceivable effect following the onset delay',
    number_of_pairs                                              int                                                             not null comment 'Number of points that went into the correlation calculation',
    value_predicting_high_outcome                                double                                                          not null comment 'cause value that predicts an above average effect value (in default unit for cause variable)',
    value_predicting_low_outcome                                 double                                                          not null comment 'cause value that predicts a below average effect value (in default unit for cause variable)',
    optimal_pearson_product                                      double                                                          not null comment 'Optimal Pearson Product',
    average_vote                                                 float(3, 1) default 0.5                                         null comment 'Vote',
    number_of_users                                              int                                                             not null comment 'Number of Users by which correlation is aggregated',
    number_of_correlations                                       int                                                             not null comment 'Number of Correlations by which correlation is aggregated',
    statistical_significance                                     float(10, 4)                                                    not null comment 'A function of the effect size and sample size',
    cause_unit_id                                                smallint unsigned                                               null comment 'Unit ID of Cause',
    cause_changes                                                int                                                             not null comment 'The number of times the cause measurement value was different from the one preceding it.',
    effect_changes                                               int                                                             not null comment 'The number of times the effect measurement value was different from the one preceding it.',
    aggregate_qm_score                                           double                                                          not null comment 'A number representative of the relative importance of the relationship based on the strength, usefulness, and plausible causality.  The higher the number, the greater the perceived importance.  This value can be used for sorting relationships by importance. ',
    created_at                                                   timestamp   default CURRENT_TIMESTAMP                           not null,
    updated_at                                                   timestamp   default CURRENT_TIMESTAMP                           not null on update CURRENT_TIMESTAMP,
    status                                                       varchar(25)                                                     not null comment 'Whether the correlation is being analyzed, needs to be analyzed, or is up to date already.',
    reverse_pearson_correlation_coefficient                      double                                                          not null comment 'Correlation when cause and effect are reversed. For any causal relationship, the forward correlation should exceed the reverse correlation',
    predictive_pearson_correlation_coefficient                   double                                                          not null comment 'Pearson correlation coefficient of cause and effect values lagged by the onset delay and grouped based on the duration of action. ',
    data_source_name                                             varchar(255)                                                    null,
    predicts_high_effect_change                                  int(5)                                                          not null comment 'The percent change in the outcome typically seen when the predictor value is closer to the predictsHighEffect value. ',
    predicts_low_effect_change                                   int(5)                                                          not null comment 'The percent change in the outcome from average typically seen when the predictor value is closer to the predictsHighEffect value.',
    p_value                                                      double                                                          not null comment 'The measure of statistical significance. A value less than 0.05 means that a correlation is statistically significant or consistent enough that it is unlikely to be a coincidence.',
    t_value                                                      double                                                          not null comment 'Function of correlation and number of samples.',
    critical_t_value                                             double                                                          not null comment 'Value of t from lookup table which t must exceed for significance.',
    confidence_interval                                          double                                                          not null comment 'A margin of error around the effect size.  Wider confidence intervals reflect greater uncertainty about the true value of the correlation.',
    deleted_at                                                   timestamp                                                       null,
    average_effect                                               double                                                          not null comment 'The average effect variable measurement value used in analysis in the common unit. ',
    average_effect_following_high_cause                          double                                                          not null comment 'The average effect variable measurement value following an above average cause value (in the common unit). ',
    average_effect_following_low_cause                           double                                                          not null comment 'The average effect variable measurement value following a below average cause value (in the common unit). ',
    average_daily_low_cause                                      double                                                          not null comment 'The average of below average cause values (in the common unit). ',
    average_daily_high_cause                                     double                                                          not null comment 'The average of above average cause values (in the common unit). ',
    population_trait_pearson_correlation_coefficient             double                                                          null comment 'The pearson correlation of pairs which each consist of the average cause value and the average effect value for a given user. ',
    grouped_cause_value_closest_to_value_predicting_low_outcome  double                                                          not null comment 'A realistic daily value (not a fraction from averaging) that typically precedes below average outcome values. ',
    grouped_cause_value_closest_to_value_predicting_high_outcome double                                                          not null comment 'A realistic daily value (not a fraction from averaging) that typically precedes below average outcome values. ',
    client_id                                                    varchar(255)                                                    null,
    published_at                                                 timestamp                                                       null,
    wp_post_id                                                   bigint unsigned                                                 null,
    cause_variable_category_id                                   tinyint unsigned                                                not null,
    effect_variable_category_id                                  tinyint unsigned                                                not null,
    interesting_variable_category_pair                           tinyint(1)                                                      not null comment 'True if the combination of cause and effect variable categories are generally interesting.  For instance, treatment cause variables paired with symptom effect variables are interesting. ',
    newest_data_at                                               timestamp                                                       null,
    analysis_requested_at                                        timestamp                                                       null,
    reason_for_analysis                                          varchar(255)                                                    not null comment 'The reason analysis was requested.',
    analysis_started_at                                          timestamp                                                       not null,
    analysis_ended_at                                            timestamp                                                       null,
    user_error_message                                           text                                                            null,
    internal_error_message                                       text                                                            null,
    cause_variable_id                                            int unsigned                                                    not null,
    effect_variable_id                                           int unsigned                                                    not null,
    cause_baseline_average_per_day                               float                                                           not null comment 'Predictor Average at Baseline (The average low non-treatment value of the predictor per day)',
    cause_baseline_average_per_duration_of_action                float                                                           not null comment 'Predictor Average at Baseline (The average low non-treatment value of the predictor per duration of action)',
    cause_treatment_average_per_day                              float                                                           not null comment 'Predictor Average During Treatment (The average high value of the predictor per day considered to be the treatment dosage)',
    cause_treatment_average_per_duration_of_action               float                                                           not null comment 'Predictor Average During Treatment (The average high value of the predictor per duration of action considered to be the treatment dosage)',
    effect_baseline_average                                      float                                                           not null comment 'Outcome Average at Baseline (The normal value for the outcome seen without treatment during the previous duration of action time span)',
    effect_baseline_relative_standard_deviation                  float                                                           not null comment 'Outcome Average at Baseline (The average value seen for the outcome without treatment during the previous duration of action time span)',
    effect_baseline_standard_deviation                           float                                                           not null comment 'Outcome Relative Standard Deviation at Baseline (How much the outcome value normally fluctuates without treatment during the previous duration of action time span)',
    effect_follow_up_average                                     float                                                           not null comment 'Outcome Average at Follow-Up (The average value seen for the outcome during the duration of action following the onset delay of the treatment)',
    effect_follow_up_percent_change_from_baseline                float                                                           not null comment 'Outcome Average at Follow-Up (The average value seen for the outcome during the duration of action following the onset delay of the treatment)',
    z_score                                                      float                                                           not null comment 'The absolute value of the change over duration of action following the onset delay of treatment divided by the baseline outcome relative standard deviation. A.K.A The number of standard deviations from the mean. A zScore > 2 means pValue < 0.05 and is typically considered statistically significant.',
    charts                                                       json                                                            not null,
    number_of_variables_where_best_aggregate_correlation         int unsigned                                                    not null comment 'Number of Variables for this Best Aggregate Correlation.
                    [Formula: update aggregate_correlations
                        left join (
                            select count(id) as total, best_aggregate_correlation_id
                            from variables
                            group by best_aggregate_correlation_id
                        )
                        as grouped on aggregate_correlations.id = grouped.best_aggregate_correlation_id
                    set aggregate_correlations.number_of_variables_where_best_aggregate_correlation = count(grouped.total)]',
    deletion_reason                                              varchar(280)                                                    null comment 'The reason the variable was deleted.',
    record_size_in_kb                                            int                                                             null,
    is_public                                                    tinyint(1)                                                      not null,
    boring                                                       tinyint(1)                                                      null comment 'The relationship is boring if it is obvious, the predictor is not controllable, or the outcome is not a goal, the relationship could not be causal, or the confidence is low.  ',
    outcome_is_a_goal                                            tinyint(1)                                                      null comment 'The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  The foods you eat are not generally an objective end in themselves. ',
    predictor_is_controllable                                    tinyint(1)                                                      null comment 'The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  Symptom severity is not directly controllable. ',
    plausibly_causal                                             tinyint(1)                                                      null comment 'The effect of aspirin on headaches is plausibly causal. The effect of aspirin on precipitation does not have a plausible causal relationship. ',
    obvious                                                      tinyint(1)                                                      null comment 'The effect of aspirin on headaches is obvious. The effect of aspirin on productivity is not obvious. ',
    number_of_up_votes                                           int                                                             not null comment 'Number of people who feel this relationship is plausible and useful. ',
    number_of_down_votes                                         int                                                             not null comment 'Number of people who feel this relationship is implausible or not useful. ',
    strength_level                                               enum ('VERY STRONG', 'STRONG', 'MODERATE', 'WEAK', 'VERY WEAK') not null comment 'Strength level describes magnitude of the change in outcome observed following changes in the predictor. ',
    confidence_level                                             enum ('HIGH', 'MEDIUM', 'LOW')                                  not null comment 'Describes the confidence that the strength level will remain consist in the future.  The more data there is, the lesser the chance that the findings are a spurious correlation. ',
    relationship                                                 enum ('POSITIVE', 'NEGATIVE', 'NONE')                           not null comment 'If higher predictor values generally precede HIGHER outcome values, the relationship is considered POSITIVE.  If higher predictor values generally precede LOWER outcome values, the relationship is considered NEGATIVE. ',
    slug                                                         varchar(200)                                                    null comment 'The slug is the part of a URL that identifies a page in human-readable keywords.',
    constraint aggregate_correlations_pk
        unique (cause_variable_id, effect_variable_id),
    constraint aggregate_correlations_slug_uindex
        unique (slug),
    constraint cause_variable_id_effect_variable_id_uindex
        unique (cause_variable_id, effect_variable_id),
    constraint aggregate_correlations_cause_unit_id_fk
        foreign key (cause_unit_id) references qm_units (id),
    constraint aggregate_correlations_cause_variable_category_id_fk
        foreign key (cause_variable_category_id) references qm_variable_categories (id),
    constraint aggregate_correlations_cause_variables_id_fk
        foreign key (cause_variable_id) references qm_variables (id),
    constraint aggregate_correlations_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint aggregate_correlations_effect_variable_category_id_fk
        foreign key (effect_variable_category_id) references qm_variable_categories (id),
    constraint aggregate_correlations_effect_variables_id_fk
        foreign key (effect_variable_id) references qm_variables (id)
)
    comment 'Stores Calculated Aggregated Correlation Coefficients' charset = utf8;

create index aggregate_correlations_effect_variable_id_index
    on qm_aggregate_correlations (effect_variable_id);

