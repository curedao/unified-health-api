create table global_data.blood_test_reference_ranges
(
    Test              varchar(59)  null,
    Normal_Range_Low  float        null,
    Normal_Range_High float        null,
    Ideal_Range_Low   float        null,
    Ideal_Range_High  float        null,
    Unit              varchar(255) null,
    Abreviation       varchar(255) null,
    Age_Variance      varchar(1)   null,
    Category          varchar(35)  null,
    Wikipedia         varchar(999) null,
    Short_Description text         null,
    AwesomeList       varchar(1)   null,
    Notes             time         null,
    Source1           varchar(255) null,
    Source1_URL       varchar(255) null,
    Source2           varchar(255) null,
    Source2_URL       varchar(255) null
);

