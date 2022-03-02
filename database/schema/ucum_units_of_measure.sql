create table ucum_units_of_measure
(
    Code             text null,
    Descriptive_Name text null,
    Code_System      text null,
    Definition       text null,
    Date_Created     text null,
    Synonym          text null,
    Status           text null,
    Kind_of_Quantity text null,
    Date_Revised     text null,
    ConceptID        text null,
    Dimension        text null,
    id               int unsigned auto_increment
        primary key
);

