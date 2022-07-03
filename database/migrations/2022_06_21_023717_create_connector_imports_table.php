<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateConnectorImportsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('connector_imports', function (Blueprint $table) {
            $table->increments('id');
            $table->string('client_id', 80)->nullable()->index('connector_imports_client_id_fk');
            $table->unsignedInteger('connection_id')->nullable();
            $table->unsignedInteger('connector_id');
            $table->timestamp('created_at')->useCurrent();
            $table->softDeletes();
            $table->timestamp('earliest_measurement_at')->nullable();
            $table->timestamp('import_ended_at')->nullable();
            $table->timestamp('import_started_at')->nullable();
            $table->text('internal_error_message')->nullable();
            $table->timestamp('latest_measurement_at')->nullable();
            $table->unsignedInteger('number_of_measurements')->default(0);
            $table->string('reason_for_import')->nullable();
            $table->boolean('success')->nullable()->default(true);
            $table->timestamp('updated_at');
            $table->text('user_error_message')->nullable();
            $table->unsignedBigInteger('user_id');
            $table->json('additional_meta_data')->nullable();
            $table->unsignedInteger('number_of_connector_requests')->nullable()->comment('Number of Connector Requests for this Connector Import.
                [Formula: 
                    update connector_imports
                        left join (
                            select count(id) as total, connector_import_id
                            from connector_requests
                            group by connector_import_id
                        )
                        as grouped on connector_imports.id = grouped.connector_import_id
                    set connector_imports.number_of_connector_requests = count(grouped.total)
                ]
                ');
            $table->timestamp('imported_data_from_at')->nullable()->comment('Earliest data that we\'ve requested from this data source ');
            $table->timestamp('imported_data_end_at')->nullable()->comment('Most recent data that we\'ve requested from this data source ');
            $table->text('credentials')->nullable()->comment('Encrypted user credentials for accessing third party data');
            $table->timestamp('connector_requests')->nullable()->comment('Most recent data that we\'ve requested from this data source ');

            $table->unique(['connection_id', 'created_at'], 'connector_imports_connection_id_created_at_uindex');
            $table->unique(['connector_id', 'user_id', 'created_at'], 'connector_imports_connector_id_user_id_created_at_uindex');
            $table->index(['user_id', 'connector_id'], 'IDX_connector_imports_user_connector');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('connector_imports');
    }
}
