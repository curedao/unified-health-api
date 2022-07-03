create table global_data.wp_term_taxonomy
(
    term_taxonomy_id bigint unsigned auto_increment comment 'Unique number assigned to each row of the table.'
        primary key,
    term_id          bigint unsigned                     null comment 'The ID of the related term.',
    taxonomy         varchar(32)                         null comment 'The slug of the taxonomy. This can be the <a href="http://codex.wordpress.org/Taxonomies#Default_Taxonomies" target="_blank">built in taxonomies</a> or any taxonomy registered using <a href="http://codex.wordpress.org/Function_Reference/register_taxonomy" target="_blank">register_taxonomy()</a>.',
    description      longtext                            null comment 'Description of the term in this taxonomy.',
    parent           bigint unsigned                     null comment 'ID of a parent term. Used for hierarchical taxonomies like Categories.',
    count            bigint                              null comment 'Number of post objects assigned the term for this taxonomy.',
    updated_at       timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at       timestamp default CURRENT_TIMESTAMP not null,
    deleted_at       timestamp                           null,
    client_id        varchar(255)                        null,
    constraint term_id_taxonomy
        unique (term_id, taxonomy),
    constraint wp_term_taxonomy_wp_terms_term_id_fk
        foreign key (term_id) references global_data.wp_terms (term_id)
)
    comment 'Terms that are stored in wp_terms don’t exist yet as a ‘Category’ and as ‘Tags’ unless they are given context. Each term is assigned a taxonomy using this table.'
    charset = utf8;

create index taxonomy
    on global_data.wp_term_taxonomy (taxonomy);

