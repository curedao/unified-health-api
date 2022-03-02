create table ctg_interventions
(
    id                int auto_increment
        primary key,
    nct_id            varchar(4369) null,
    intervention_type varchar(4369) null,
    name              varchar(4369) null,
    description       text          null,
    variable_id       int unsigned  null,
    constraint ctg_interventions_variable_id_uindex
        unique (variable_id),
    constraint ctg_interventions_variables_id_fk
        foreign key (variable_id) references qm_variables (id)
)
    comment 'Interventions from clinicaltrials.gov' charset = latin1;

