create table qm_treatment_side_effect
(
    id                      int auto_increment
        primary key,
    treatment_variable_id   int unsigned                        not null,
    side_effect_variable_id int unsigned                        not null,
    treatment_id            int                                 not null,
    side_effect_id          int                                 not null,
    votes_percent           int                                 not null,
    updated_at              timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at              timestamp default CURRENT_TIMESTAMP not null,
    deleted_at              timestamp                           null,
    constraint treatment_id_side_effect_id_uindex
        unique (treatment_id, side_effect_id),
    constraint treatment_variable_id_side_effect_variable_id_uindex
        unique (treatment_variable_id, side_effect_variable_id),
    constraint side_effect_variables_id_fk
        foreign key (side_effect_variable_id) references qm_variables (id),
    constraint treatment_side_effect_side_effects_id_fk
        foreign key (side_effect_id) references qm_side_effects (id),
    constraint treatment_side_effect_treatments_id_fk
        foreign key (treatment_id) references qm_treatments (id),
    constraint treatment_variables_id_fk
        foreign key (treatment_variable_id) references qm_variables (id)
)
    comment 'User self-reported treatments and side-effects' charset = utf8;

