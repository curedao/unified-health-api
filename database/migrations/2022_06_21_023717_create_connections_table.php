<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateConnectionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('connections', function (Blueprint $table) {
            $table->increments('id');
            $table->string('client_id', 80)->nullable()->index('connections_client_id_fk');
            $table->unsignedBigInteger('user_id');
            $table->unsignedInteger('connector_id')->index('connections_connectors_id_fk')->comment('The id for the connector data source for which the connection is connected');
            $table->string('connect_status', 32)->index('IDX_status')->comment('Indicates whether a connector is currently connected to a service for a user.');
            $table->text('connect_error')->nullable()->comment('Error message if there is a problem with authorizing this connection.');
            $table->timestamp('update_requested_at')->nullable();
            $table->string('update_status', 32)->index('status')->comment('Indicates whether a connector is currently updated.');
            $table->text('update_error')->nullable()->comment('Indicates if there was an error during the update.');
            $table->timestamp('last_successful_updated_at')->nullable();
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at');
            $table->softDeletes();
            $table->integer('total_measurements_in_last_update')->nullable();
            $table->string('user_message')->nullable();
            $table->timestamp('latest_measurement_at')->nullable();
            $table->timestamp('import_started_at')->nullable();
            $table->timestamp('import_ended_at')->nullable();
            $table->string('reason_for_import')->nullable();
            $table->text('user_error_message')->nullable();
            $table->text('internal_error_message')->nullable();
            $table->unsignedBigInteger('wp_post_id')->nullable()->index('connections_wp_posts_ID_fk');
            $table->unsignedInteger('number_of_connector_imports')->nullable()->comment('Number of Connector Imports for this Connection.
                [Formula: 
                    update connections
                        left join (
                            select count(id) as total, connection_id
                            from connector_imports
                            group by connection_id
                        )
                        as grouped on connections.id = grouped.connection_id
                    set connections.number_of_connector_imports = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_connector_requests')->nullable()->comment('Number of Connector Requests for this Connection.
                [Formula: 
                    update connections
                        left join (
                            select count(id) as total, connection_id
                            from connector_requests
                            group by connection_id
                        )
                        as grouped on connections.id = grouped.connection_id
                    set connections.number_of_connector_requests = count(grouped.total)
                ]
                ');
            $table->text('credentials')->nullable()->comment('Encrypted user credentials for accessing third party data');
            $table->timestamp('imported_data_from_at')->nullable()->comment('Earliest data that we\'ve requested from this data source ');
            $table->timestamp('imported_data_end_at')->nullable()->comment('Most recent data that we\'ve requested from this data source ');
            $table->unsignedInteger('number_of_measurements')->nullable()->comment('Number of Measurements for this Connection.
                    [Formula: update connections
                        left join (
                            select count(id) as total, connection_id
                            from measurements
                            group by connection_id
                        )
                        as grouped on connections.id = grouped.connection_id
                    set connections.number_of_measurements = count(grouped.total)]');
            $table->boolean('is_public')->nullable();
            $table->string('slug', 200)->nullable()->unique('connections_slug_uindex')->comment('The slug is the part of a URL that identifies a page in human-readable keywords.');
            $table->text('meta')->nullable()->comment('Additional meta data instructions for import, such as a list of repositories the Github connector should import from. ');

            $table->index(['update_requested_at', 'update_status'], 'status_update_requested');
            $table->unique(['user_id', 'connector_id'], 'UX_userId_connectorId');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('connections');
    }
}
