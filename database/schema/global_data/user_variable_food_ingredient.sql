create table global_data.user_variable_food_ingredient
(
    id                               int unsigned auto_increment
        primary key,
    food_user_variable_id            int unsigned                        not null comment 'This is the id of the food or composite user variable being tagged with an ingredient.',
    ingredient_user_variable_id      int unsigned                        not null comment 'This is the id of the ingredient user variable whose value is inferred based on the value of the food or composite user variable.',
    number_of_data_points            int(10)                             null comment 'The number of data points used to estimate the mean ingredient concentration from testing.',
    standard_error                   float                               null comment 'Measure of variability of the
mean value as a function of the number of data points.',
    ingredient_user_variable_unit_id smallint unsigned                   null comment 'The id for the unit of the tag (ingredient) user variable.',
    food_user_variable_unit_id       smallint unsigned                   null comment 'The unit id for the food or composite user variable to be tagged.',
    conversion_factor                double                              not null comment 'Number by which we multiply the food or composite user variable''s value to obtain the ingredient user variable''s value',
    client_id                        varchar(80)                         null,
    created_at                       timestamp default CURRENT_TIMESTAMP not null,
    updated_at                       timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at                       timestamp                           null,
    constraint UK_tag_tagged
        unique (food_user_variable_id, ingredient_user_variable_id),
    constraint user_variable_child_parent_client_id_fk
        foreign key (client_id) references global_data.oa_clients (client_id),
    constraint user_variable_food_variable_id_variables_id_fk
        foreign key (food_user_variable_id) references global_data.user_variables (id),
    constraint user_variable_food_variable_unit_id_fk
        foreign key (food_user_variable_unit_id) references global_data.units (id),
    constraint user_variable_ingredient_variable_id_variables_id_fk
        foreign key (ingredient_user_variable_id) references global_data.user_variables (id),
    constraint user_variable_ingredient_variable_unit_id_fk
        foreign key (ingredient_user_variable_unit_id) references global_data.units (id)
)
    comment 'Infer the intake of the different
ingredients by just entering the foods. The inferred intake levels will then be used to determine the effects of different nutrients on the user during analysis.'
    charset = utf8;

create index user_variable_food_ingredient_client_id_fk
    on global_data.user_variable_food_ingredient (client_id);

create index user_variable_food_ingredient_tag_variable_id_variables_id_fk
    on global_data.user_variable_food_ingredient (ingredient_user_variable_id);

create index user_variable_food_ingredient_tag_variable_unit_id_fk
    on global_data.user_variable_food_ingredient (ingredient_user_variable_unit_id);

create index user_variable_food_ingredient_tagged_variable_unit_id_fk
    on global_data.user_variable_food_ingredient (food_user_variable_unit_id);

