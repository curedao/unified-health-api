create table qm_units
(
    id                                               smallint unsigned auto_increment
        primary key,
    name                                             varchar(64)                                      not null comment 'Unit name',
    abbreviated_name                                 varchar(16)                                      not null comment 'Unit abbreviation',
    unit_category_id                                 tinyint unsigned                                 not null comment 'Unit category ID',
    minimum_value                                    double                                           null comment 'The minimum value for a single measurement. ',
    maximum_value                                    double                                           null comment 'The maximum value for a single measurement',
    created_at                                       timestamp default CURRENT_TIMESTAMP              not null,
    updated_at                                       timestamp default CURRENT_TIMESTAMP              not null on update CURRENT_TIMESTAMP,
    deleted_at                                       timestamp                                        null,
    filling_type                                     enum ('zero', 'none', 'interpolation', 'value')  not null comment 'The filling type specifies how periods of missing data should be treated. ',
    number_of_outcome_population_studies             int unsigned                                     null comment 'Number of Global Population Studies for this Cause Unit.
                [Formula:
                    update units
                        left join (
                            select count(id) as total, cause_unit_id
                            from aggregate_correlations
                            group by cause_unit_id
                        )
                        as grouped on units.id = grouped.cause_unit_id
                    set units.number_of_outcome_population_studies = count(grouped.total)
                ]
                ',
    number_of_common_tags_where_tag_variable_unit    int unsigned                                     null comment 'Number of Common Tags for this Tag Variable Unit.
                [Formula:
                    update units
                        left join (
                            select count(id) as total, tag_variable_unit_id
                            from common_tags
                            group by tag_variable_unit_id
                        )
                        as grouped on units.id = grouped.tag_variable_unit_id
                    set units.number_of_common_tags_where_tag_variable_unit = count(grouped.total)
                ]
                ',
    number_of_common_tags_where_tagged_variable_unit int unsigned                                     null comment 'Number of Common Tags for this Tagged Variable Unit.
                [Formula:
                    update units
                        left join (
                            select count(id) as total, tagged_variable_unit_id
                            from common_tags
                            group by tagged_variable_unit_id
                        )
                        as grouped on units.id = grouped.tagged_variable_unit_id
                    set units.number_of_common_tags_where_tagged_variable_unit = count(grouped.total)
                ]
                ',
    number_of_outcome_case_studies                   int unsigned                                     null comment 'Number of Individual Case Studies for this Cause Unit.
                [Formula:
                    update units
                        left join (
                            select count(id) as total, cause_unit_id
                            from correlations
                            group by cause_unit_id
                        )
                        as grouped on units.id = grouped.cause_unit_id
                    set units.number_of_outcome_case_studies = count(grouped.total)
                ]
                ',
    number_of_measurements                           int unsigned                                     null comment 'Number of Measurements for this Unit.
                    [Formula: update units
                        left join (
                            select count(id) as total, unit_id
                            from measurements
                            group by unit_id
                        )
                        as grouped on units.id = grouped.unit_id
                    set units.number_of_measurements = count(grouped.total)]',
    number_of_user_variables_where_default_unit      int unsigned                                     null comment 'Number of User Variables for this Default Unit.
                    [Formula: update units
                        left join (
                            select count(id) as total, default_unit_id
                            from user_variables
                            group by default_unit_id
                        )
                        as grouped on units.id = grouped.default_unit_id
                    set units.number_of_user_variables_where_default_unit = count(grouped.total)]',
    number_of_variable_categories_where_default_unit int unsigned                                     null comment 'Number of Variable Categories for this Default Unit.
                    [Formula: update units
                        left join (
                            select count(id) as total, default_unit_id
                            from variable_categories
                            group by default_unit_id
                        )
                        as grouped on units.id = grouped.default_unit_id
                    set units.number_of_variable_categories_where_default_unit = count(grouped.total)]',
    number_of_variables_where_default_unit           int unsigned                                     null comment 'Number of Variables for this Default Unit.
                    [Formula: update units
                        left join (
                            select count(id) as total, default_unit_id
                            from variables
                            group by default_unit_id
                        )
                        as grouped on units.id = grouped.default_unit_id
                    set units.number_of_variables_where_default_unit = count(grouped.total)]',
    advanced                                         tinyint(1)                                       not null comment 'Advanced units are rarely used and should generally be hidden or at the bottom of selector lists',
    manual_tracking                                  tinyint(1)                                       not null comment 'Include manual tracking units in selector when manually recording a measurement. ',
    filling_value                                    float                                            null comment 'The filling value is substituted used when data is missing if the filling type is set to value.',
    scale                                            enum ('nominal', 'interval', 'ratio', 'ordinal') not null comment '
Ordinal is used to simply depict the order of variables and not the difference between each of the variables. Ordinal scales are generally used to depict non-mathematical ideas such as frequency, satisfaction, happiness, a degree of pain etc.

Ratio Scale not only produces the order of variables but also makes the difference between variables known along with information on the value of true zero.

Interval scale contains all the properties of ordinal scale, in addition to which, it offers a calculation of the difference between variables. The main characteristic of this scale is the equidistant difference between objects. Interval has no pre-decided starting point or a true zero value.

Nominal, also called the categorical variable scale, is defined as a scale used for labeling variables into distinct classifications and doesn’t involve a quantitative value or order.
',
    conversion_steps                                 text                                             null comment 'An array of mathematical operations, each containing a operation and value field to apply to the value in the current unit to convert it to the default unit for the unit category. ',
    maximum_daily_value                              double                                           null comment 'The maximum aggregated measurement value over a single day.',
    sort_order                                       int                                              not null,
    slug                                             varchar(200)                                     null comment 'The slug is the part of a URL that identifies a page in human-readable keywords.',
    constraint abbr_name_UNIQUE
        unique (abbreviated_name),
    constraint name_UNIQUE
        unique (name),
    constraint units_slug_uindex
        unique (slug)
)
    comment 'Units of measurement' charset = utf8;

create index fk_unitCategory
    on qm_units (unit_category_id);

