create table global_data.global_variable_child_parent
(
    id                        int unsigned auto_increment
        primary key,
    child_global_variable_id  int unsigned                        not null comment 'This is the id of the variable being tagged with an ingredient or something.',
    parent_global_variable_id int unsigned                        not null comment 'This is the id of the ingredient variable whose value is determined based on the value of the tagged variable.',
    client_id                 varchar(80)                         null,
    created_at                timestamp default CURRENT_TIMESTAMP not null,
    updated_at                timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at                timestamp                           null,
    constraint UK_tag_tagged
        unique (child_global_variable_id, parent_global_variable_id),
    constraint common_tags_client_id_fk_copy
        foreign key (client_id) references global_data.oa_clients (client_id),
    constraint common_tags_tag_variable_id_variables_id_fk_copy
        foreign key (parent_global_variable_id) references global_data.global_variables (id),
    constraint common_tags_tagged_variable_id_variables_id_fk_copy
        foreign key (child_global_variable_id) references global_data.global_variables (id)
)
    comment 'Variable tags are used to infer the user intake of the different ingredients by just entering the foods. The inferred intake levels will then be used to determine the effects of different nutrients on the user during analysis.'
    charset = utf8;

create index common_tags_client_id_fk
    on global_data.global_variable_child_parent (client_id);

create index common_tags_tag_variable_id_variables_id_fk
    on global_data.global_variable_child_parent (parent_global_variable_id);

