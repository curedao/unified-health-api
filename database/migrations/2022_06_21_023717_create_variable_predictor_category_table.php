<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateVariablePredictorCategoryTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('variable_predictor_category', function (Blueprint $table) {
            $table->integer('id', true);
            $table->unsignedInteger('variable_id');
            $table->unsignedTinyInteger('variable_category_id')->index('variable_predictor_category_variable_categories_id_fk');
            $table->unsignedInteger('number_of_predictor_variables');
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at');
            $table->softDeletes();

            $table->unique(['variable_id', 'variable_category_id'], 'variable_id_variable_category_id_uindex');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('variable_predictor_category');
    }
}
