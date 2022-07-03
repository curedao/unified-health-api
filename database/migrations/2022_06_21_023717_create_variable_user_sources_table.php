<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateVariableUserSourcesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('variable_user_sources', function (Blueprint $table) {
            $table->unsignedBigInteger('user_id');
            $table->unsignedInteger('variable_id')->comment('ID of variable');
            $table->unsignedInteger('timestamp')->nullable()->comment('Time that this measurement occurred

Uses epoch minute (epoch time divided by 60)');
            $table->unsignedInteger('earliest_measurement_time')->nullable()->comment('Earliest measurement time');
            $table->unsignedInteger('latest_measurement_time')->nullable()->comment('Latest measurement time');
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at');
            $table->softDeletes();
            $table->string('data_source_name', 80);
            $table->integer('number_of_raw_measurements')->nullable();
            $table->string('client_id')->nullable()->index('variable_user_sources_client_id_fk');
            $table->integer('id', true);
            $table->unsignedInteger('user_variable_id')->index('variable_user_sources_user_variables_user_variable_id_fk');
            $table->timestamp('earliest_measurement_start_at')->nullable();
            $table->timestamp('latest_measurement_start_at')->nullable();

            $table->unique(['user_id', 'variable_id', 'data_source_name'], 'user');
            $table->index(['variable_id', 'user_id'], 'variable_user_sources_user_variables_variable_id_user_id_fk');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('variable_user_sources');
    }
}
