create table global_data.variable_predictor_category
(
    id                            int auto_increment
        primary key,
    variable_id                   int unsigned                        not null,
    variable_category_id          tinyint unsigned                    not null,
    number_of_predictor_variables int unsigned                        not null,
    created_at                    timestamp default CURRENT_TIMESTAMP not null,
    updated_at                    timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at                    timestamp                           null,
    constraint variable_id_variable_category_id_uindex
        unique (variable_id, variable_category_id),
    constraint variable_predictor_category_variable_categories_id_fk
        foreign key (variable_category_id) references global_data.variable_categories (id),
    constraint variable_predictor_category_variables_id_fk
        foreign key (variable_id) references global_data.global_variables (id)
)
    charset = latin1;

