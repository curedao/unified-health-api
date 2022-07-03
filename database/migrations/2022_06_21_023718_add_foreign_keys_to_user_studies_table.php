<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeysToUserStudiesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('user_studies', function (Blueprint $table) {
            $table->foreign(['cause_user_variable_id'], 'user_studies_cause_user_variables_id_fk')->references(['id'])->on('user_variables')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['cause_variable_id'], 'user_studies_cause_variables_id_fk')->references(['id'])->on('variables')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['correlation_id'], 'user_studies_correlations_id_fk')->references(['id'])->on('correlations')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['effect_user_variable_id'], 'user_studies_effect_user_variables_id_fk')->references(['id'])->on('user_variables')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['effect_variable_id'], 'user_studies_effect_variables_id_fk')->references(['id'])->on('variables')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['user_id'], 'user_studies_user_id_fk')->references(['ID'])->on('wp_users')->onUpdate('NO ACTION')->onDelete('NO ACTION');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('user_studies', function (Blueprint $table) {
            $table->dropForeign('user_studies_cause_user_variables_id_fk');
            $table->dropForeign('user_studies_cause_variables_id_fk');
            $table->dropForeign('user_studies_correlations_id_fk');
            $table->dropForeign('user_studies_effect_user_variables_id_fk');
            $table->dropForeign('user_studies_effect_variables_id_fk');
            $table->dropForeign('user_studies_user_id_fk');
        });
    }
}
