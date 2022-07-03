create table global_data.wp_posts
(
    ID                    bigint unsigned auto_increment comment 'Unique number assigned to each post.'
        primary key,
    post_author           bigint unsigned                         null comment 'The user ID who created it.',
    post_date             timestamp default CURRENT_TIMESTAMP     not null on update CURRENT_TIMESTAMP comment 'Time and date of creation.',
    post_date_gmt         timestamp default '0000-00-00 00:00:00' not null comment 'GMT time and date of creation. The GMT time and date is stored so there is no dependency on a site’s timezone in the future.',
    post_content          longtext                                null comment 'Holds all the content for the post, including HTML, shortcodes and other content.',
    post_title            text                                    null comment 'Title of the post.',
    post_excerpt          text                                    null comment 'Custom intro or short version of the content.',
    post_status           varchar(20)                             null comment 'Status of the post, e.g. ‘draft’, ‘pending’, ‘private’, ‘publish’. Also a great WordPress <a href="https://poststatus.com/" target="_blank">news site</a>.',
    comment_status        varchar(20)                             null comment 'If comments are allowed.',
    ping_status           varchar(20)                             null comment 'If the post allows <a href="http://codex.wordpress.org/Introduction_to_Blogging#Pingbacks" target="_blank">ping and trackbacks</a>.',
    post_password         varchar(255)                            null comment 'Optional password used to view the post.',
    post_name             varchar(200)                            null comment 'URL friendly slug of the post title.',
    to_ping               text                                    null comment 'A list of URLs WordPress should send pingbacks to when updated.',
    pinged                text                                    null comment 'A list of URLs WordPress has sent pingbacks to when updated.',
    post_modified         timestamp default '0000-00-00 00:00:00' not null comment 'Time and date of last modification.',
    post_modified_gmt     timestamp default '0000-00-00 00:00:00' not null comment 'GMT time and date of last modification.',
    post_content_filtered longtext                                null comment 'Used by plugins to cache a version of post_content typically passed through the ‘the_content’ filter. Not used by WordPress core itself.',
    post_parent           bigint unsigned                         null comment 'Used to create a relationship between this post and another when this post is a revision, attachment or another type.',
    guid                  varchar(255)                            null comment 'Global Unique Identifier, the permanent URL to the post, not the permalink version.',
    menu_order            int                                     null comment 'Holds the display number for pages and other non-post types.',
    post_type             varchar(20)                             null comment 'The content type identifier.',
    post_mime_type        varchar(100)                            null comment 'Only used for attachments, the MIME type of the uploaded file.',
    comment_count         bigint                                  null comment 'Total number of comments, pingbacks and trackbacks.',
    updated_at            timestamp default CURRENT_TIMESTAMP     not null on update CURRENT_TIMESTAMP,
    created_at            timestamp default CURRENT_TIMESTAMP     not null,
    deleted_at            timestamp                               null,
    client_id             varchar(255)                            null,
    record_size_in_kb     int                                     null,
    constraint wp_posts_wp_users_ID_fk
        foreign key (post_author) references global_data.users (id)
)
    comment 'Stores various types of content including posts, pages, menu items, media attachments and any custom post types.'
    charset = utf8;

create index idx_wp_posts_post_author_post_modified_deleted_at
    on global_data.wp_posts (post_author, post_modified, deleted_at);

create index post_author
    on global_data.wp_posts (post_author);

create index post_name
    on global_data.wp_posts (post_name(191));

create index post_parent
    on global_data.wp_posts (post_parent);

create index type_status_date
    on global_data.wp_posts (post_type, post_status, post_date, ID);

create index wp_posts_post_modified_index
    on global_data.wp_posts (post_modified);

