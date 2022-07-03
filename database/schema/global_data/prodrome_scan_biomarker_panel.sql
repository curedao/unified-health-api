create table global_data.prodrome_scan_biomarker_panel
(
    slug                    text null,
    type                    text null,
    subtype                 text null,
    classification          text null,
    name_long               text null,
    name_long_prodrome_scan text null,
    unit                    text null,
    default_value           text null,
    description             text null,
    `references`            text null,
    id                      int auto_increment
        primary key
);

