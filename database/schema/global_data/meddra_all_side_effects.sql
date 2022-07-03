create table global_data.meddra_all_side_effects
(
    STITCH_compound_id_flat                      varchar(255) null,
    STITCH_compound_id_stereo                    varchar(255) null,
    UMLS_concept_id_as_it_was_found_on_the_label varchar(255) null,
    MedDRA_concept_type                          varchar(255) null,
    UMLS_concept_id_for_MedDRA_term              varchar(255) null,
    side_effect_name                             varchar(255) null,
    id                                           int unsigned auto_increment
        primary key
)
    comment 'Side effects from the Medical Dictionary for Regulatory Activities' charset = latin1;

