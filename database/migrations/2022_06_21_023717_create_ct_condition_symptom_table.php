<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCtConditionSymptomTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('ct_condition_symptom', function (Blueprint $table) {
            $table->integer('id', true);
            $table->unsignedInteger('condition_variable_id');
            $table->integer('condition_id')->index('ct_condition_symptom_conditions_fk');
            $table->unsignedInteger('symptom_variable_id');
            $table->integer('symptom_id')->index('ct_condition_symptom_symptoms_fk');
            $table->integer('votes');
            $table->integer('extreme')->nullable();
            $table->integer('severe')->nullable();
            $table->integer('moderate')->nullable();
            $table->integer('mild')->nullable();
            $table->integer('minimal')->nullable();
            $table->integer('no_symptoms')->nullable();
            $table->timestamp('updated_at');
            $table->softDeletes();
            $table->timestamp('created_at')->useCurrent();

            $table->unique(['condition_variable_id', 'symptom_variable_id'], 'ct_condition_symptom_condition_uindex');
            $table->unique(['symptom_variable_id', 'condition_variable_id'], 'ct_condition_symptom_variable_id_uindex');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('ct_condition_symptom');
    }
}
