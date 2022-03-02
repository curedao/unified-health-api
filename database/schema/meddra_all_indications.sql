create table meddra_all_indications
(
    STITCH_compound_id_flat                      varchar(55)                         null,
    UMLS_concept_id_as_it_was_found_on_the_label varchar(55)                         null,
    method_of_detection                          varchar(55)                         null,
    concept_name                                 varchar(55)                         null,
    MedDRA_concept_type                          varchar(55)                         null,
    UMLS_concept_id_for_MedDRA_term              varchar(55)                         null,
    MedDRA_concept_name                          varchar(55)                         null,
    compound_name                                varchar(255)                        null,
    compound_variable_id                         int(10)                             null,
    condition_variable_id                        int(10)                             null,
    updated_at                                   timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at                                   timestamp default CURRENT_TIMESTAMP not null,
    deleted_at                                   timestamp                           null,
    id                                           int unsigned auto_increment
        primary key
)
    comment 'Conditions treated by specific medications from the Medical Dictionary for Regulatory Activities'
    charset = utf8;

create index id
    on meddra_all_indications (STITCH_compound_id_flat);

