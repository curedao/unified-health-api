<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCtTreatmentSideEffectTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('ct_treatment_side_effect', function (Blueprint $table) {
            $table->integer('id', true);
            $table->unsignedInteger('treatment_variable_id');
            $table->unsignedInteger('side_effect_variable_id')->index('side_effect_variables_id_fk');
            $table->integer('treatment_id');
            $table->integer('side_effect_id')->index('treatment_side_effect_side_effects_id_fk');
            $table->integer('votes_percent');
            $table->timestamp('updated_at');
            $table->timestamp('created_at')->useCurrent();
            $table->softDeletes();

            $table->unique(['treatment_id', 'side_effect_id'], 'treatment_id_side_effect_id_uindex');
            $table->unique(['treatment_variable_id', 'side_effect_variable_id'], 'treatment_variable_id_side_effect_variable_id_uindex');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('ct_treatment_side_effect');
    }
}
