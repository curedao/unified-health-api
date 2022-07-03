<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCtConditionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('ct_conditions', function (Blueprint $table) {
            $table->integer('id', true);
            $table->string('name', 100)->unique('conName');
            $table->unsignedInteger('variable_id')->unique('ct_conditions_variable_id_uindex');
            $table->timestamp('updated_at');
            $table->timestamp('created_at')->useCurrent();
            $table->softDeletes();
            $table->unsignedInteger('number_of_treatments');
            $table->unsignedInteger('number_of_symptoms')->nullable();
            $table->unsignedInteger('number_of_causes');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('ct_conditions');
    }
}
