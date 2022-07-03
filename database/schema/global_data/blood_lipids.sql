create table global_data.blood_lipids
(
    slug           text null,
    type           text null,
    subtype        text null,
    classification text null,
    name_short     text null,
    name_long      text null,
    unit           text null,
    default_value  text null,
    description    text null,
    `references`   text null,
    range_min      text null,
    range_max      text null,
    id             int unsigned auto_increment
        primary key
);

