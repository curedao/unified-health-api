<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeysToThirdPartyCorrelationsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('third_party_correlations', function (Blueprint $table) {
            $table->foreign(['cause_id'], 'third_party_correlations_cause_variables_id_fk')->references(['id'])->on('variables')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['cause_variable_category_id'], 'third_party_correlations_cause_variable_category_id_fk')->references(['id'])->on('variable_categories')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['client_id'], 'third_party_correlations_client_id_fk')->references(['client_id'])->on('oa_clients')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['effect_id'], 'third_party_correlations_effect_variables_id_fk')->references(['id'])->on('variables')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['effect_variable_category_id'], 'third_party_correlations_effect_variable_category_id_fk')->references(['id'])->on('variable_categories')->onUpdate('NO ACTION')->onDelete('NO ACTION');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('third_party_correlations', function (Blueprint $table) {
            $table->dropForeign('third_party_correlations_cause_variables_id_fk');
            $table->dropForeign('third_party_correlations_cause_variable_category_id_fk');
            $table->dropForeign('third_party_correlations_client_id_fk');
            $table->dropForeign('third_party_correlations_effect_variables_id_fk');
            $table->dropForeign('third_party_correlations_effect_variable_category_id_fk');
        });
    }
}
