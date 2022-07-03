<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMeasurementsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('measurements', function (Blueprint $table) {
            $table->bigInteger('id', true);
            $table->unsignedBigInteger('user_id');
            $table->string('client_id', 80)->nullable()->index('measurements_client_id_fk');
            $table->unsignedInteger('connector_id')->nullable()->index('measurements_connectors_id_fk')->comment('The id for the connector data source from which the measurement was obtained');
            $table->unsignedInteger('variable_id')->comment('ID of the variable for which we are creating the measurement records');
            $table->unsignedInteger('start_time')->index()->comment('Start time for the measurement event in ISO 8601');
            $table->double('value')->comment('The value of the measurement after conversion to the default unit for that variable');
            $table->unsignedSmallInteger('unit_id')->index('fk_measurementUnits')->comment('The default unit for the variable');
            $table->double('original_value')->comment('Value of measurement as originally posted (before conversion to default unit)');
            $table->unsignedSmallInteger('original_unit_id')->index('measurements_original_unit_id_fk')->comment('Unit id of measurement as originally submitted');
            $table->integer('duration')->nullable()->comment('Duration of the event being measurement in seconds');
            $table->text('note')->nullable()->comment('An optional note the user may include with their measurement');
            $table->double('latitude')->nullable()->comment('Latitude at which the measurement was taken');
            $table->double('longitude')->nullable()->comment('Longitude at which the measurement was taken');
            $table->string('location')->nullable()->comment('location');
            $table->timestamp('created_at')->nullable()->default(null)->comment('Time at which this measurement was originally stored');
            $table->timestamp('updated_at')->comment('Time at which this measurement was last updated');
            $table->text('error')->nullable()->comment('An error message if there is a problem with the measurement');
            $table->unsignedTinyInteger('variable_category_id')->index('measurements_variable_category_id_fk')->comment('Variable category ID');
            $table->dateTime('deleted_at')->nullable();
            $table->string('source_name', 80)->nullable()->comment('Name of the application or device');
            $table->unsignedInteger('user_variable_id')->index('measurements_user_variables_user_variable_id_fk');
            $table->timestamp('start_at')->nullable()->default(null);
            $table->unsignedInteger('connection_id')->nullable()->index('measurements_connections_id_fk');
            $table->unsignedInteger('connector_import_id')->nullable()->index('measurements_connector_imports_id_fk');
            $table->string('deletion_reason', 280)->nullable()->comment('The reason the variable was deleted.');
            $table->timestamp('original_start_at')->nullable()->default(null);

            $table->index(['variable_id', 'value', 'start_time']);
            $table->index(['variable_id', 'start_time']);
            $table->index(['variable_id', 'user_id'], 'measurements_user_variables_variable_id_user_id_fk');
            $table->index(['user_id', 'variable_category_id', 'start_time']);
            $table->unique(['user_id', 'variable_id', 'start_time'], 'measurements_pk');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('measurements');
    }
}
