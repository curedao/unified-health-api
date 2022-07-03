<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeysToCohortStudyStatisticsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('cohort_study_statistics', function (Blueprint $table) {
            $table->foreign(['cause_unit_id'], 'cohort_study_statistics_cause_unit_id_fk')->references(['id'])->on('units')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['cause_variable_id'], 'cohort_study_statistics_cause_variables_id_fk')->references(['id'])->on('variables')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['cause_variable_category_id'], 'cohort_study_statistics_cause_variable_category_id_fk')->references(['id'])->on('variable_categories')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['client_id'], 'cohort_study_statistics_client_id_fk')->references(['client_id'])->on('oa_clients')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['effect_variable_id'], 'cohort_study_statistics_effect_variables_id_fk')->references(['id'])->on('variables')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['effect_variable_category_id'], 'cohort_study_statistics_effect_variable_category_id_fk')->references(['id'])->on('variable_categories')->onUpdate('NO ACTION')->onDelete('NO ACTION');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('cohort_study_statistics', function (Blueprint $table) {
            $table->dropForeign('cohort_study_statistics_cause_unit_id_fk');
            $table->dropForeign('cohort_study_statistics_cause_variables_id_fk');
            $table->dropForeign('cohort_study_statistics_cause_variable_category_id_fk');
            $table->dropForeign('cohort_study_statistics_client_id_fk');
            $table->dropForeign('cohort_study_statistics_effect_variables_id_fk');
            $table->dropForeign('cohort_study_statistics_effect_variable_category_id_fk');
        });
    }
}
