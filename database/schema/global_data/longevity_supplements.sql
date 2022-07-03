create table global_data.longevity_supplements
(
    id                int auto_increment
        primary key,
    category          text null,
    rxnorm_code       text null,
    name_short        text null,
    name_long         text null,
    application_route text null,
    description       text null,
    `references`      text null
);

