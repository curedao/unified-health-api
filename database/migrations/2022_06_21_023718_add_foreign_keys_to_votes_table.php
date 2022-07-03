<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeysToVotesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('votes', function (Blueprint $table) {
            $table->foreign(['aggregate_correlation_id'], 'votes_aggregate_correlations_id_fk')->references(['id'])->on('aggregate_correlations')->onUpdate('NO ACTION')->onDelete('SET NULL');
            $table->foreign(['cause_variable_id'], 'votes_cause_variable_id_fk')->references(['id'])->on('variables')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['client_id'], 'votes_client_id_fk')->references(['client_id'])->on('oa_clients')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['correlation_id'], 'votes_correlations_id_fk')->references(['id'])->on('correlations')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['effect_variable_id'], 'votes_effect_variable_id_fk_2')->references(['id'])->on('variables')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['user_id'], 'votes_user_id_fk')->references(['ID'])->on('wp_users')->onUpdate('NO ACTION')->onDelete('NO ACTION');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('votes', function (Blueprint $table) {
            $table->dropForeign('votes_aggregate_correlations_id_fk');
            $table->dropForeign('votes_cause_variable_id_fk');
            $table->dropForeign('votes_client_id_fk');
            $table->dropForeign('votes_correlations_id_fk');
            $table->dropForeign('votes_effect_variable_id_fk_2');
            $table->dropForeign('votes_user_id_fk');
        });
    }
}
