<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->bigIncrements('id')->comment('Unique number assigned to each user.');
            $table->string('client_id');
            $table->string('name', 60)->nullable()->unique('name_key')->comment('Unique username for the user.');
            $table->string('email', 320)->nullable()->unique('email')->comment('Email address of the user.');
            $table->string('password')->nullable()->comment('Hash of the user’s password.');
            $table->string('user_url', 100)->default('');
            $table->string('user_activation_key')->nullable()->comment('Used for resetting passwords.');
            $table->string('display_name', 250)->nullable()->index('display_name')->comment('Desired name to be used publicly in the site, can be name, first name or last name defined in wp_usermeta.');
            $table->string('avatar_image', 2083)->nullable();
            $table->string('reg_provider', 25)->nullable()->comment('Registered via');
            $table->string('provider_id')->nullable()->comment('Unique id from provider');
            $table->string('provider_token')->nullable()->comment('Access token from provider');
            $table->rememberToken()->comment('Remember me token');
            $table->timestamp('updated_at');
            $table->timestamp('created_at')->useCurrent();
            $table->string('refresh_token')->nullable()->comment('Refresh token from provider');
            $table->boolean('unsubscribed')->nullable()->default(false)->comment('Indicates whether the use has specified that they want no emails or any form of communication. ');
            $table->string('roles')->nullable()->comment('An array containing all roles possessed by the user.  This indicates whether the use has roles such as administrator, developer, patient, student, researcher or physician. ');
            $table->integer('time_zone_offset')->nullable()->comment('The time-zone offset is the difference, in minutes, between UTC and local time. Note that this means that the offset is positive if the local timezone is behind UTC (i.e. UTC−06:00 Central) and negative if it is ahead.');
            $table->softDeletes();
            $table->time('earliest_reminder_time')->default('07:00:00')->comment('Earliest time of day at which reminders should appear in HH:MM:SS format in user timezone');
            $table->time('latest_reminder_time')->default('21:00:00')->comment('Latest time of day at which reminders should appear in HH:MM:SS format in user timezone');
            $table->boolean('push_notifications_enabled')->nullable()->default(true)->comment('Should we send the user push notifications?');
            $table->boolean('track_location')->nullable()->default(false)->comment('Set to true if the user wants to track their location');
            $table->boolean('combine_notifications')->nullable()->default(false)->comment('Should we combine push notifications or send one for each tracking reminder notification?');
            $table->boolean('send_reminder_notification_emails')->nullable()->default(false)->comment('Should we send reminder notification emails?');
            $table->boolean('send_predictor_emails')->nullable()->default(true)->comment('Should we send predictor emails?');
            $table->boolean('get_preview_builds')->nullable()->default(false)->comment('Should we send preview builds of the mobile application?');
            $table->enum('subscription_provider', ['stripe', 'apple', 'google'])->nullable();
            $table->unsignedBigInteger('last_sms_tracking_reminder_notification_id')->nullable();
            $table->boolean('sms_notifications_enabled')->nullable()->default(false)->comment('Should we send tracking reminder notifications via tex messages?');
            $table->string('phone_verification_code', 25)->nullable();
            $table->string('phone_number', 25)->nullable();
            $table->boolean('has_android_app')->nullable()->default(false);
            $table->boolean('has_ios_app')->nullable()->default(false);
            $table->boolean('has_chrome_extension')->nullable()->default(false);
            $table->unsignedBigInteger('referrer_user_id')->nullable()->index('users_users_id_fk');
            $table->string('address')->nullable();
            $table->string('birthday')->nullable();
            $table->string('country')->nullable();
            $table->string('cover_photo', 2083)->nullable();
            $table->string('currency')->nullable();
            $table->string('first_name')->nullable();
            $table->string('gender')->nullable();
            $table->string('language')->nullable();
            $table->string('last_name')->nullable();
            $table->string('state')->nullable();
            $table->string('tag_line')->nullable();
            $table->string('verified')->nullable();
            $table->string('zip_code')->nullable();
            $table->timestamp('last_login_at')->nullable();
            $table->string('timezone')->nullable();
            $table->integer('number_of_correlations')->nullable();
            $table->integer('number_of_connections')->nullable();
            $table->integer('number_of_tracking_reminders')->nullable();
            $table->integer('number_of_user_variables')->nullable();
            $table->integer('number_of_raw_measurements_with_tags')->nullable();
            $table->integer('number_of_raw_measurements_with_tags_at_last_correlation')->nullable();
            $table->integer('number_of_votes')->nullable();
            $table->integer('number_of_studies')->nullable();
            $table->timestamp('last_correlation_at')->nullable();
            $table->timestamp('last_email_at')->nullable();
            $table->timestamp('last_push_at')->nullable();
            $table->unsignedInteger('primary_outcome_variable_id')->nullable()->index('users_variables_id_fk');
            $table->tinyInteger('spam')->default(0);
            $table->timestamp('analysis_ended_at')->nullable();
            $table->timestamp('analysis_requested_at')->nullable();
            $table->timestamp('analysis_started_at')->nullable();
            $table->text('internal_error_message')->nullable();
            $table->timestamp('newest_data_at')->nullable();
            $table->string('reason_for_analysis')->nullable();
            $table->text('user_error_message')->nullable();
            $table->string('status', 25)->nullable();
            $table->timestamp('analysis_settings_modified_at')->nullable();
            $table->unsignedInteger('number_of_applications')->nullable()->comment('Number of Applications for this User.
                [Formula: 
                    update users
                        left join (
                            select count(id) as total, user_id
                            from applications
                            group by user_id
                        )
                        as grouped on users.id = grouped.user_id
                    set users.number_of_applications = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_oauth_access_tokens')->nullable()->comment('Number of OAuth Access Tokens for this User.
                [Formula: 
                    update users
                        left join (
                            select count(access_token) as total, user_id
                            from oa_access_tokens
                            group by user_id
                        )
                        as grouped on users.id = grouped.user_id
                    set users.number_of_oauth_access_tokens = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_oauth_authorization_codes')->nullable()->comment('Number of OAuth Authorization Codes for this User.
                [Formula: 
                    update users
                        left join (
                            select count(authorization_code) as total, user_id
                            from oa_authorization_codes
                            group by user_id
                        )
                        as grouped on users.id = grouped.user_id
                    set users.number_of_oauth_authorization_codes = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_oauth_clients')->nullable()->comment('Number of OAuth Clients for this User.
                [Formula: 
                    update users
                        left join (
                            select count(client_id) as total, user_id
                            from oa_clients
                            group by user_id
                        )
                        as grouped on users.id = grouped.user_id
                    set users.number_of_oauth_clients = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_oauth_refresh_tokens')->nullable()->comment('Number of OAuth Refresh Tokens for this User.
                [Formula: 
                    update users
                        left join (
                            select count(refresh_token) as total, user_id
                            from oa_refresh_tokens
                            group by user_id
                        )
                        as grouped on users.id = grouped.user_id
                    set users.number_of_oauth_refresh_tokens = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_button_clicks')->nullable()->comment('Number of Button Clicks for this User.
                [Formula: 
                    update users
                        left join (
                            select count(id) as total, user_id
                            from button_clicks
                            group by user_id
                        )
                        as grouped on users.id = grouped.user_id
                    set users.number_of_button_clicks = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_collaborators')->nullable()->comment('Number of Collaborators for this User.
                [Formula: 
                    update users
                        left join (
                            select count(id) as total, user_id
                            from collaborators
                            group by user_id
                        )
                        as grouped on users.id = grouped.user_id
                    set users.number_of_collaborators = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_connector_imports')->nullable()->comment('Number of Connector Imports for this User.
                [Formula: 
                    update users
                        left join (
                            select count(id) as total, user_id
                            from connector_imports
                            group by user_id
                        )
                        as grouped on users.id = grouped.user_id
                    set users.number_of_connector_imports = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_connector_requests')->nullable()->comment('Number of Connector Requests for this User.
                [Formula: 
                    update users
                        left join (
                            select count(id) as total, user_id
                            from connector_requests
                            group by user_id
                        )
                        as grouped on users.id = grouped.user_id
                    set users.number_of_connector_requests = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_measurement_exports')->nullable()->comment('Number of Measurement Exports for this User.
                    [Formula: update users
                        left join (
                            select count(id) as total, user_id
                            from measurement_exports
                            group by user_id
                        )
                        as grouped on users.id = grouped.user_id
                    set users.number_of_measurement_exports = count(grouped.total)]');
            $table->unsignedInteger('number_of_measurement_imports')->nullable()->comment('Number of Measurement Imports for this User.
                    [Formula: update users
                        left join (
                            select count(id) as total, user_id
                            from measurement_imports
                            group by user_id
                        )
                        as grouped on users.id = grouped.user_id
                    set users.number_of_measurement_imports = count(grouped.total)]');
            $table->unsignedInteger('number_of_measurements')->nullable()->comment('Number of Measurements for this User.
                    [Formula: update users
                        left join (
                            select count(id) as total, user_id
                            from measurements
                            group by user_id
                        )
                        as grouped on users.id = grouped.user_id
                    set users.number_of_measurements = count(grouped.total)]');
            $table->unsignedInteger('number_of_sent_emails')->nullable()->comment('Number of Sent Emails for this User.
                    [Formula: update users
                        left join (
                            select count(id) as total, user_id
                            from sent_emails
                            group by user_id
                        )
                        as grouped on users.id = grouped.user_id
                    set users.number_of_sent_emails = count(grouped.total)]');
            $table->unsignedInteger('number_of_subscriptions')->nullable()->comment('Number of Subscriptions for this User.
                    [Formula: update users
                        left join (
                            select count(id) as total, user_id
                            from subscriptions
                            group by user_id
                        )
                        as grouped on users.id = grouped.user_id
                    set users.number_of_subscriptions = count(grouped.total)]');
            $table->unsignedInteger('number_of_tracking_reminder_notifications')->nullable()->comment('Number of Tracking Reminder Notifications for this User.
                    [Formula: update users
                        left join (
                            select count(id) as total, user_id
                            from tracking_reminder_notifications
                            group by user_id
                        )
                        as grouped on users.id = grouped.user_id
                    set users.number_of_tracking_reminder_notifications = count(grouped.total)]');
            $table->unsignedInteger('number_of_user_tags')->nullable()->comment('Number of User Tags for this User.
                    [Formula: update users
                        left join (
                            select count(id) as total, user_id
                            from user_tags
                            group by user_id
                        )
                        as grouped on users.id = grouped.user_id
                    set users.number_of_user_tags = count(grouped.total)]');
            $table->unsignedInteger('number_of_users_where_referrer_user')->nullable();
            $table->boolean('share_all_data')->default(false);
            $table->string('deletion_reason', 280)->nullable()->comment('The reason the user deleted their account.');
            $table->unsignedInteger('number_of_patients');
            $table->boolean('is_public')->nullable();
            $table->integer('sort_order');
            $table->string('slug', 200)->nullable()->unique('users_slug_uindex')->comment('The slug is the part of a URL that identifies a page in human-readable keywords.');
            $table->unsignedInteger('number_of_sharers')->comment('Number of people sharing their data with you.');
            $table->unsignedInteger('number_of_trustees')->comment('Number of people that you are sharing your data with.');
            $table->string('stripe_id')->nullable()->index();
            $table->string('card_brand')->nullable();
            $table->string('card_last_four', 4)->nullable();
            $table->timestamp('trial_ends_at')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('users');
    }
}
