create table global_data.global_study_causality_votes
(
    id                       int(11) unsigned auto_increment
        primary key,
    cause_variable_id        int(11) unsigned                    not null,
    effect_variable_id       int(11) unsigned                    not null,
    correlation_id           int                                 null,
    aggregate_correlation_id int                                 null,
    user_id                  bigint unsigned                     not null,
    vote                     int                                 not null comment 'The opinion of the data owner on whether or not there is a plausible
                                mechanism of action by which the predictor variable could influence the outcome variable.',
    created_at               timestamp default CURRENT_TIMESTAMP not null,
    updated_at               timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at               timestamp                           null,
    client_id                varchar(80) charset utf8            null,
    is_public                tinyint(1)                          null,
    constraint correlation_causality_votes_user_cause_effect_uindex
        unique (user_id, cause_variable_id, effect_variable_id),
    constraint correlation_causality_votes_aggregate_correlations_id_fk
        foreign key (aggregate_correlation_id) references global_data.global_study_results (id),
    constraint correlation_causality_votes_cause_variables_id_fk
        foreign key (cause_variable_id) references global_data.global_variables (id),
    constraint correlation_causality_votes_client_id_fk
        foreign key (client_id) references global_data.oa_clients (client_id),
    constraint correlation_causality_votes_correlations_id_fk
        foreign key (correlation_id) references global_data.user_study_results (id),
    constraint correlation_causality_votes_effect_variables_id_fk
        foreign key (effect_variable_id) references global_data.global_variables (id),
    constraint correlation_causality_votes_wp_users_ID_fk
        foreign key (user_id) references global_data.users (id)
)
    comment 'The opinion of the data owner on whether or not there is a plausible mechanism of action by which the predictor variable could influence the outcome variable.'
    charset = latin1;

