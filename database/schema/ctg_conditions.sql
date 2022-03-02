create table ctg_conditions
(
    id            int           not null
        primary key,
    nct_id        varchar(4369) null,
    name          varchar(4369) null,
    downcase_name varchar(4369) null,
    variable_id   int unsigned  null,
    constraint ctg_conditions_variable_id_uindex
        unique (variable_id),
    constraint ctg_conditions_variables_id_fk
        foreign key (variable_id) references qm_variables (id)
)
    comment 'Conditions from clinicaltrials.gov' charset = latin1;

