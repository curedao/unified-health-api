<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeysToCorrelationsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('correlations', function (Blueprint $table) {
            $table->foreign(['aggregate_correlation_id'], 'correlations_aggregate_correlations_id_fk')->references(['id'])->on('aggregate_correlations')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['cause_unit_id'], 'correlations_cause_unit_id_fk')->references(['id'])->on('units')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['cause_variable_category_id'], 'correlations_cause_variable_category_id_fk')->references(['id'])->on('variable_categories')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['cause_variable_id'], 'correlations_cause_variable_id_fk')->references(['id'])->on('variables')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['client_id'], 'correlations_client_id_fk')->references(['client_id'])->on('oa_clients')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['effect_variable_category_id'], 'correlations_effect_variable_category_id_fk')->references(['id'])->on('variable_categories')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['effect_variable_id'], 'correlations_effect_variable_id_fk')->references(['id'])->on('variables')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['user_id'], 'correlations_user_id_fk')->references(['ID'])->on('wp_users')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['cause_user_variable_id'], 'correlations_user_variables_cause_user_variable_id_fk')->references(['id'])->on('user_variables')->onUpdate('CASCADE')->onDelete('CASCADE');
            $table->foreign(['effect_user_variable_id'], 'correlations_user_variables_effect_user_variable_id_fk')->references(['id'])->on('user_variables')->onUpdate('CASCADE')->onDelete('CASCADE');
            $table->foreign(['wp_post_id'], 'correlations_wp_posts_ID_fk')->references(['ID'])->on('wp_posts')->onUpdate('CASCADE')->onDelete('SET NULL');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('correlations', function (Blueprint $table) {
            $table->dropForeign('correlations_aggregate_correlations_id_fk');
            $table->dropForeign('correlations_cause_unit_id_fk');
            $table->dropForeign('correlations_cause_variable_category_id_fk');
            $table->dropForeign('correlations_cause_variable_id_fk');
            $table->dropForeign('correlations_client_id_fk');
            $table->dropForeign('correlations_effect_variable_category_id_fk');
            $table->dropForeign('correlations_effect_variable_id_fk');
            $table->dropForeign('correlations_user_id_fk');
            $table->dropForeign('correlations_user_variables_cause_user_variable_id_fk');
            $table->dropForeign('correlations_user_variables_effect_user_variable_id_fk');
            $table->dropForeign('correlations_wp_posts_ID_fk');
        });
    }
}
