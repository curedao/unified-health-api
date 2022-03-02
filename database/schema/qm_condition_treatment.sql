create table qm_condition_treatment
(
    id                    int auto_increment
        primary key,
    condition_id          int                                 not null,
    treatment_id          int                                 not null,
    condition_variable_id int unsigned                        null,
    treatment_variable_id int unsigned                        not null,
    major_improvement     int       default 0                 not null,
    moderate_improvement  int       default 0                 not null,
    no_effect             int       default 0                 not null,
    worse                 int       default 0                 not null,
    much_worse            int       default 0                 not null,
    popularity            int       default 0                 not null,
    average_effect        int       default 0                 not null,
    updated_at            timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at            timestamp default CURRENT_TIMESTAMP not null,
    deleted_at            timestamp                           null,
    constraint treatment_id_condition_id_uindex
        unique (treatment_id, condition_id),
    constraint treatment_variable_id_condition_variable_id_uindex
        unique (treatment_variable_id, condition_variable_id),
    constraint ct_condition_treatment_conditions_id_fk
        foreign key (condition_id) references qm_conditions (id),
    constraint ct_condition_treatment_ct_treatments_fk
        foreign key (treatment_id) references qm_treatments (id),
    constraint ct_condition_treatment_variables_id_fk
        foreign key (treatment_variable_id) references qm_variables (id),
    constraint ct_condition_treatment_variables_id_fk_2
        foreign key (condition_variable_id) references qm_variables (id)
)
    comment 'Conditions and related treatments' charset = utf8;

