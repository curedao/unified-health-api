<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeysToUserVariablePredictorCategoryTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('user_variable_predictor_category', function (Blueprint $table) {
            $table->foreign(['user_variable_id'], 'user_variable_predictor_category_user_variables_id_fk')->references(['id'])->on('user_variables')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['variable_id'], 'user_variable_predictor_category_variables_id_fk')->references(['id'])->on('variables')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['variable_category_id'], 'user_variable_predictor_category_variable_categories_id_fk')->references(['id'])->on('variable_categories')->onUpdate('NO ACTION')->onDelete('NO ACTION');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('user_variable_predictor_category', function (Blueprint $table) {
            $table->dropForeign('user_variable_predictor_category_user_variables_id_fk');
            $table->dropForeign('user_variable_predictor_category_variables_id_fk');
            $table->dropForeign('user_variable_predictor_category_variable_categories_id_fk');
        });
    }
}
