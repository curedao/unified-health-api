<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeysToCohortStudiesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('cohort_studies', function (Blueprint $table) {
            $table->foreign(['cause_variable_id'], 'cohort_studies_cause_variable_id_variables_id_fk')->references(['id'])->on('variables')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['client_id'], 'cohort_studies_client_id_fk')->references(['client_id'])->on('oa_clients')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['effect_variable_id'], 'cohort_studies_effect_variable_id_variables_id_fk')->references(['id'])->on('variables')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['user_id'], 'cohort_studies_user_id_fk')->references(['ID'])->on('wp_users')->onUpdate('NO ACTION')->onDelete('NO ACTION');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('cohort_studies', function (Blueprint $table) {
            $table->dropForeign('cohort_studies_cause_variable_id_variables_id_fk');
            $table->dropForeign('cohort_studies_client_id_fk');
            $table->dropForeign('cohort_studies_effect_variable_id_variables_id_fk');
            $table->dropForeign('cohort_studies_user_id_fk');
        });
    }
}
