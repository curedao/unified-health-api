create table dsld_supplement_products
(
    DSLD_ID               int    null,
    Brand_Name            text   null,
    Product_Name          text   null,
    Net_Contents          double null,
    Net_Content_Unit      text   null,
    Serving_Size_Quantity int    null,
    Serving_Size_Unit     text   null,
    Product_Type          text   null,
    Supplement_Form       text   null,
    Dietary_Claims        text   null,
    Intended_Target_Group text   null,
    `Database`            text   null,
    Tracking_History      text   null,
    Date                  text   null,
    id                    int unsigned auto_increment
        primary key
);

