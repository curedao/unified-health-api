create table global_data.collaborators
(
    id         int unsigned auto_increment
        primary key,
    user_id    bigint unsigned                                          not null,
    app_id     int unsigned                                             not null,
    type       enum ('owner', 'collaborator') default 'collaborator'    not null,
    created_at timestamp                      default CURRENT_TIMESTAMP not null,
    updated_at timestamp                      default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    deleted_at timestamp                                                null,
    client_id  varchar(80)                                              null,
    constraint collaborators_user_client_index
        unique (user_id, client_id),
    constraint collaborators_applications_id_fk
        foreign key (app_id) references global_data.applications (id)
            on update cascade on delete cascade,
    constraint collaborators_client_id_fk
        foreign key (client_id) references global_data.oa_clients (client_id)
            on update cascade on delete cascade,
    constraint collaborators_user_id_fk
        foreign key (user_id) references global_data.users (id)
            on update cascade on delete cascade
)
    comment 'Collaborators authorized to edit applications in the app builder' charset = utf8;

