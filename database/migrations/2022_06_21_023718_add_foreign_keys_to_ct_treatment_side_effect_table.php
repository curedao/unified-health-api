<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeysToCtTreatmentSideEffectTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('ct_treatment_side_effect', function (Blueprint $table) {
            $table->foreign(['side_effect_variable_id'], 'side_effect_variables_id_fk')->references(['id'])->on('variables')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['side_effect_id'], 'treatment_side_effect_side_effects_id_fk')->references(['id'])->on('ct_side_effects')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['treatment_id'], 'treatment_side_effect_treatments_id_fk')->references(['id'])->on('ct_treatments')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['treatment_variable_id'], 'treatment_variables_id_fk')->references(['id'])->on('variables')->onUpdate('NO ACTION')->onDelete('NO ACTION');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('ct_treatment_side_effect', function (Blueprint $table) {
            $table->dropForeign('side_effect_variables_id_fk');
            $table->dropForeign('treatment_side_effect_side_effects_id_fk');
            $table->dropForeign('treatment_side_effect_treatments_id_fk');
            $table->dropForeign('treatment_variables_id_fk');
        });
    }
}
