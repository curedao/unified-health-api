<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateOaClientsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('oa_clients', function (Blueprint $table) {
            $table->string('client_id', 80)->primary();
            $table->string('client_secret', 80);
            $table->string('redirect_uri', 2000)->nullable();
            $table->string('grant_types', 80)->nullable();
            $table->unsignedBigInteger('user_id')->index('bshaffer_oauth_clients_user_id_fk');
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at');
            $table->string('icon_url', 2083)->nullable();
            $table->string('app_identifier')->nullable();
            $table->softDeletes();
            $table->timestamp('earliest_measurement_start_at')->nullable();
            $table->timestamp('latest_measurement_start_at')->nullable();
            $table->unsignedInteger('number_of_aggregate_correlations')->nullable()->comment('Number of Global Population Studies for this Client.
                [Formula: 
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from aggregate_correlations
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_aggregate_correlations = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_applications')->nullable()->comment('Number of Applications for this Client.
                [Formula: 
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from applications
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_applications = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_oauth_access_tokens')->nullable()->comment('Number of OAuth Access Tokens for this Client.
                [Formula: 
                    update bshaffer_oauth_clients
                        left join (
                            select count(access_token) as total, client_id
                            from bshaffer_oauth_access_tokens
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_oauth_access_tokens = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_oauth_authorization_codes')->nullable()->comment('Number of OAuth Authorization Codes for this Client.
                [Formula: 
                    update bshaffer_oauth_clients
                        left join (
                            select count(authorization_code) as total, client_id
                            from bshaffer_oauth_authorization_codes
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_oauth_authorization_codes = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_oauth_refresh_tokens')->nullable()->comment('Number of OAuth Refresh Tokens for this Client.
                [Formula: 
                    update bshaffer_oauth_clients
                        left join (
                            select count(refresh_token) as total, client_id
                            from bshaffer_oauth_refresh_tokens
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_oauth_refresh_tokens = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_button_clicks')->nullable()->comment('Number of Button Clicks for this Client.
                [Formula: 
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from button_clicks
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_button_clicks = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_collaborators')->nullable()->comment('Number of Collaborators for this Client.
                [Formula: 
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from collaborators
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_collaborators = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_common_tags')->nullable()->comment('Number of Common Tags for this Client.
                [Formula: 
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from common_tags
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_common_tags = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_connections')->nullable()->comment('Number of Connections for this Client.
                [Formula: 
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from connections
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_connections = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_connector_imports')->nullable()->comment('Number of Connector Imports for this Client.
                [Formula: 
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from connector_imports
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_connector_imports = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_connectors')->nullable()->comment('Number of Connectors for this Client.
                [Formula: 
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from connectors
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_connectors = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_correlations')->nullable()->comment('Number of Individual Case Studies for this Client.
                [Formula: 
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from correlations
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_correlations = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_measurement_exports')->nullable()->comment('Number of Measurement Exports for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from measurement_exports
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_measurement_exports = count(grouped.total)]');
            $table->unsignedInteger('number_of_measurement_imports')->nullable()->comment('Number of Measurement Imports for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from measurement_imports
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_measurement_imports = count(grouped.total)]');
            $table->unsignedInteger('number_of_measurements')->nullable()->comment('Number of Measurements for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from measurements
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_measurements = count(grouped.total)]');
            $table->unsignedInteger('number_of_sent_emails')->nullable()->comment('Number of Sent Emails for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from sent_emails
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_sent_emails = count(grouped.total)]');
            $table->unsignedInteger('number_of_studies')->nullable()->comment('Number of Studies for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from studies
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_studies = count(grouped.total)]');
            $table->unsignedInteger('number_of_tracking_reminder_notifications')->nullable()->comment('Number of Tracking Reminder Notifications for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from tracking_reminder_notifications
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_tracking_reminder_notifications = count(grouped.total)]');
            $table->unsignedInteger('number_of_tracking_reminders')->nullable()->comment('Number of Tracking Reminders for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from tracking_reminders
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_tracking_reminders = count(grouped.total)]');
            $table->unsignedInteger('number_of_user_tags')->nullable()->comment('Number of User Tags for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from user_tags
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_user_tags = count(grouped.total)]');
            $table->unsignedInteger('number_of_user_variables')->nullable()->comment('Number of User Variables for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from user_variables
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_user_variables = count(grouped.total)]');
            $table->unsignedInteger('number_of_variables')->nullable()->comment('Number of Variables for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from variables
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_variables = count(grouped.total)]');
            $table->unsignedInteger('number_of_votes')->nullable()->comment('Number of Votes for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from votes
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_votes = count(grouped.total)]');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('oa_clients');
    }
}
