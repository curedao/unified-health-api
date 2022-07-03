create table global_data.user_variable_outcome_category
(
    id                               int auto_increment
        primary key,
    user_variable_id                 int unsigned                        not null,
    variable_id                      int unsigned                        not null,
    variable_category_id             tinyint unsigned                    not null,
    number_of_outcome_user_variables int unsigned                        not null,
    created_at                       timestamp default CURRENT_TIMESTAMP not null,
    updated_at                       timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at                       timestamp                           null,
    constraint user_variable_id_variable_category_id_uindex
        unique (user_variable_id, variable_category_id),
    constraint user_variable_outcome_category_user_variables_id_fk
        foreign key (user_variable_id) references global_data.user_variables (id),
    constraint user_variable_outcome_category_variable_categories_id_fk
        foreign key (variable_category_id) references global_data.variable_categories (id),
    constraint user_variable_outcome_category_variables_id_fk
        foreign key (variable_id) references global_data.global_variables (id)
)
    charset = latin1;

