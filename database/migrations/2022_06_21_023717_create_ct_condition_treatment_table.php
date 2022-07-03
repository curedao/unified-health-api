<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCtConditionTreatmentTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('ct_condition_treatment', function (Blueprint $table) {
            $table->integer('id', true);
            $table->integer('condition_id')->index('ct_condition_treatment_conditions_id_fk');
            $table->integer('treatment_id');
            $table->unsignedInteger('condition_variable_id')->nullable()->index('ct_condition_treatment_variables_id_fk_2');
            $table->unsignedInteger('treatment_variable_id');
            $table->integer('major_improvement')->default(0);
            $table->integer('moderate_improvement')->default(0);
            $table->integer('no_effect')->default(0);
            $table->integer('worse')->default(0);
            $table->integer('much_worse')->default(0);
            $table->integer('popularity')->default(0);
            $table->integer('average_effect')->default(0);
            $table->timestamp('updated_at');
            $table->timestamp('created_at')->useCurrent();
            $table->softDeletes();

            $table->unique(['treatment_id', 'condition_id'], 'treatment_id_condition_id_uindex');
            $table->unique(['treatment_variable_id', 'condition_variable_id'], 'treatment_variable_id_condition_variable_id_uindex');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('ct_condition_treatment');
    }
}
