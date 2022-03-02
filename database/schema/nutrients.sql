create table nutrients
(
    slug          text null,
    category      text null,
    name_long     text null,
    unit          text null,
    default_value text null,
    description   text null,
    id            int unsigned auto_increment
        primary key
);

