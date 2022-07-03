create table global_data.data_collection_methods
(
    slug         text   null,
    name         text   null,
    error        double null,
    quality      text   null,
    description  text   null,
    `references` text   null,
    biomarkers_0 text   null,
    biomarkers_1 text   null,
    biomarkers_2 text   null,
    biomarkers_3 text   null,
    biomarkers_4 text   null,
    biomarkers_5 text   null,
    biomarkers_6 text   null,
    biomarkers_7 text   null,
    id           int auto_increment
        primary key
);

