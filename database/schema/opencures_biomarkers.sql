create table opencures_biomarkers
(
    slug          varchar(34)  null,
    apple_mapping varchar(12)  null,
    category      varchar(12)  null,
    name_long     varchar(40)  null,
    unit          varchar(13)  null,
    default_value varchar(1)   null,
    description   text         null,
    references_0  varchar(161) null,
    references_1  varchar(67)  null,
    id            int unsigned auto_increment
        primary key
);

