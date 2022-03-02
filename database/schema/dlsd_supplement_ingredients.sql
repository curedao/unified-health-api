create table dlsd_supplement_ingredients
(
    Ingredient_Name             varchar(255) not null,
    Primary_Ingredient_Group_ID int          null,
    synonyms                    text         null,
    Total_Number_of_Labels      int          null,
    Count_of_Labels_in_NHANES   int          null,
    All_Ingredient_Group_ID     int          null,
    Sample_DSLD_IDs             text         null,
    Sample_DSLD_IDs_in_NHANES   text         null,
    id                          int unsigned auto_increment
        primary key
);

