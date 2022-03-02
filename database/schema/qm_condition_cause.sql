create table qm_condition_cause
(
    id                    int auto_increment
        primary key,
    condition_id          int                                 not null,
    cause_id              int                                 not null,
    condition_variable_id int unsigned                        not null,
    cause_variable_id     int unsigned                        not null,
    votes_percent         int                                 not null,
    updated_at            timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at            timestamp default CURRENT_TIMESTAMP not null,
    deleted_at            timestamp                           null,
    constraint ct_condition_cause_cause_id_condition_id_uindex
        unique (cause_id, condition_id),
    constraint ct_condition_cause_cause_uindex
        unique (cause_variable_id, condition_variable_id),
    constraint ct_condition_cause_ct_causes_cause_fk
        foreign key (cause_id) references qm_causes (id),
    constraint ct_condition_cause_ct_conditions_id_condition_fk
        foreign key (condition_id) references qm_conditions (id),
    constraint ct_condition_cause_variables_id_condition_fk
        foreign key (condition_variable_id) references qm_variables (id),
    constraint ct_condition_cause_variables_id_fk
        foreign key (cause_variable_id) references qm_variables (id)
)
    comment 'User self-reported conditions and causes' charset = utf8;

