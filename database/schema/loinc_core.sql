create table loinc_core
(
    LOINC_NUM                 text   null,
    COMPONENT                 text   null,
    PROPERTY                  text   null,
    TIME_ASPCT                text   null,
    `SYSTEM`                  text   null,
    SCALE_TYP                 text   null,
    METHOD_TYP                text   null,
    CLASS                     text   null,
    CLASSTYPE                 int    null,
    LONG_COMMON_NAME          text   null,
    SHORTNAME                 text   null,
    EXTERNAL_COPYRIGHT_NOTICE text   null,
    STATUS                    text   null,
    VersionFirstReleased      text   null,
    VersionLastChanged        double null,
    id                        int auto_increment
        primary key
);

