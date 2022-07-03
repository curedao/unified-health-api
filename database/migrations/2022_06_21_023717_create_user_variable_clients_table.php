<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUserVariableClientsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('user_variable_clients', function (Blueprint $table) {
            $table->integer('id', true);
            $table->string('client_id', 80)->index('user_variable_clients_client_id_fk');
            $table->timestamp('created_at')->useCurrent();
            $table->softDeletes();
            $table->timestamp('earliest_measurement_at')->nullable()->comment('Earliest measurement time for this variable and client');
            $table->timestamp('latest_measurement_at')->nullable()->comment('Earliest measurement time for this variable and client');
            $table->unsignedInteger('number_of_measurements')->nullable();
            $table->timestamp('updated_at');
            $table->unsignedBigInteger('user_id');
            $table->unsignedInteger('user_variable_id')->index('user_variable_clients_user_variables_user_variable_id_fk');
            $table->unsignedInteger('variable_id')->index('user_variable_clients_variable_id_fk')->comment('Id of variable');

            $table->unique(['user_id', 'variable_id', 'client_id'], 'user');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('user_variable_clients');
    }
}
