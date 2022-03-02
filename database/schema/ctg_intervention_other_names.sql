create table ctg_intervention_other_names
(
    id              int           not null
        primary key,
    nct_id          varchar(4369) null,
    intervention_id int           null,
    name            varchar(4369) null
)
    comment 'Terms or phrases that are synonymous with an intervention. (Each row is linked to one of the interventions associated with the study.)'
    charset = latin1;

