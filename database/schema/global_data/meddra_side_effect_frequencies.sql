create table global_data.meddra_side_effect_frequencies
(
    STITCH_compound_id_flat                      varchar(50) null,
    STITCH_compound_id_stereo                    varchar(50) null,
    UMLS_concept_id_as_it_was_found_on_the_label varchar(50) null,
    placebo                                      varchar(50) null,
    description_of_the_frequency                 double      null,
    a_lower_bound_on_the_frequency               double      null,
    an_upper_bound_on_the_frequency              double      null,
    MedDRA_concept_type                          varchar(50) null,
    UMLS_concept_id_for_MedDRA_term              varchar(50) null,
    side_effect_name                             varchar(50) null,
    id                                           int unsigned auto_increment
        primary key
)
    comment 'Frequency of side effects from the Medical Dictionary for Regulatory Activities' charset = latin1;

