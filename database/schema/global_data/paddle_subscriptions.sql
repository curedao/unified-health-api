create table global_data.paddle_subscriptions
(
    id              bigint       null,
    subscription_id int          null,
    plan_id         int          null,
    user_id         int          null,
    status          varchar(191) null,
    update_url      varchar(191) null,
    cancel_url      varchar(191) null,
    cancelled_at    datetime     null,
    created_at      timestamp    null,
    updated_at      timestamp    null
);

