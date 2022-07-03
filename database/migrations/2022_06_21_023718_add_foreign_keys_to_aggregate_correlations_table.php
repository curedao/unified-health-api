<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeysToAggregateCorrelationsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('aggregate_correlations', function (Blueprint $table) {
            $table->foreign(['cause_unit_id'], 'aggregate_correlations_cause_unit_id_fk')->references(['id'])->on('units')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['cause_variable_id'], 'aggregate_correlations_cause_variables_id_fk')->references(['id'])->on('variables')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['cause_variable_category_id'], 'aggregate_correlations_cause_variable_category_id_fk')->references(['id'])->on('variable_categories')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['client_id'], 'aggregate_correlations_client_id_fk')->references(['client_id'])->on('oa_clients')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['effect_variable_id'], 'aggregate_correlations_effect_variables_id_fk')->references(['id'])->on('variables')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['effect_variable_category_id'], 'aggregate_correlations_effect_variable_category_id_fk')->references(['id'])->on('variable_categories')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['wp_post_id'], 'aggregate_correlations_wp_posts_ID_fk')->references(['ID'])->on('wp_posts')->onUpdate('CASCADE')->onDelete('SET NULL');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('aggregate_correlations', function (Blueprint $table) {
            $table->dropForeign('aggregate_correlations_cause_unit_id_fk');
            $table->dropForeign('aggregate_correlations_cause_variables_id_fk');
            $table->dropForeign('aggregate_correlations_cause_variable_category_id_fk');
            $table->dropForeign('aggregate_correlations_client_id_fk');
            $table->dropForeign('aggregate_correlations_effect_variables_id_fk');
            $table->dropForeign('aggregate_correlations_effect_variable_category_id_fk');
            $table->dropForeign('aggregate_correlations_wp_posts_ID_fk');
        });
    }
}
