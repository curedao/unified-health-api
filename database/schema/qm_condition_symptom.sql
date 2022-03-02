create table qm_condition_symptom
(
    id                    int auto_increment
        primary key,
    condition_variable_id int unsigned                        not null,
    condition_id          int                                 not null,
    symptom_variable_id   int unsigned                        not null,
    symptom_id            int                                 not null,
    votes                 int                                 not null,
    extreme               int                                 null,
    severe                int                                 null,
    moderate              int                                 null,
    mild                  int                                 null,
    minimal               int                                 null,
    no_symptoms           int                                 null,
    updated_at            timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at            timestamp                           null,
    created_at            timestamp default CURRENT_TIMESTAMP not null,
    constraint ct_condition_symptom_condition_uindex
        unique (condition_variable_id, symptom_variable_id),
    constraint ct_condition_symptom_variable_id_uindex
        unique (symptom_variable_id, condition_variable_id),
    constraint ct_condition_symptom_conditions_fk
        foreign key (condition_id) references qm_conditions (id),
    constraint ct_condition_symptom_symptoms_fk
        foreign key (symptom_id) references qm_symptoms (id),
    constraint ct_condition_symptom_variables_condition_fk
        foreign key (condition_variable_id) references qm_variables (id),
    constraint ct_condition_symptom_variables_symptom_fk
        foreign key (symptom_variable_id) references qm_variables (id)
)
    comment 'User self-reported conditions and related symptoms' charset = utf8;

