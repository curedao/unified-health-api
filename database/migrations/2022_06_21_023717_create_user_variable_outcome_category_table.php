<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUserVariableOutcomeCategoryTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('user_variable_outcome_category', function (Blueprint $table) {
            $table->integer('id', true);
            $table->unsignedInteger('user_variable_id');
            $table->unsignedInteger('variable_id')->index('user_variable_outcome_category_variables_id_fk');
            $table->unsignedTinyInteger('variable_category_id')->index('user_variable_outcome_category_variable_categories_id_fk');
            $table->unsignedInteger('number_of_outcome_user_variables');
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at');
            $table->softDeletes();

            $table->unique(['user_variable_id', 'variable_category_id'], 'user_variable_id_variable_category_id_uindex');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('user_variable_outcome_category');
    }
}
