create table qm_common_tags
(
    id                      int unsigned auto_increment
        primary key,
    tagged_variable_id      int unsigned                        not null comment 'This is the id of the variable being tagged with an ingredient or something.',
    tag_variable_id         int unsigned                        not null comment 'This is the id of the ingredient variable whose value is determined based on the value of the tagged variable.',
    number_of_data_points   int(10)                             null comment 'The number of data points used to estimate the mean. ',
    standard_error          float                               null comment 'Measure of variability of the
mean value as a function of the number of data points.',
    tag_variable_unit_id    smallint unsigned                   null comment 'The id for the unit of the tag (ingredient) variable.',
    tagged_variable_unit_id smallint unsigned                   null comment 'The unit for the source variable to be tagged.',
    conversion_factor       double                              not null comment 'Number by which we multiply the tagged variable''s value to obtain the tag variable''s value',
    client_id               varchar(80)                         null,
    created_at              timestamp default CURRENT_TIMESTAMP not null,
    updated_at              timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at              timestamp                           null,
    constraint UK_tag_tagged
        unique (tagged_variable_id, tag_variable_id),
    constraint common_tags_client_id_fk
        foreign key (client_id) references oa_clients (client_id),
    constraint common_tags_tag_variable_id_variables_id_fk
        foreign key (tag_variable_id) references qm_variables (id),
    constraint common_tags_tag_variable_unit_id_fk
        foreign key (tag_variable_unit_id) references qm_units (id),
    constraint common_tags_tagged_variable_id_variables_id_fk
        foreign key (tagged_variable_id) references qm_variables (id),
    constraint common_tags_tagged_variable_unit_id_fk
        foreign key (tagged_variable_unit_id) references qm_units (id)
)
    comment 'Variable tags are used to infer the user intake of the different ingredients by just entering the foods. The inferred intake levels will then be used to determine the effects of different nutrients on the user during analysis.'
    charset = utf8;

