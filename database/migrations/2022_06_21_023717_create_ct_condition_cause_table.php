<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCtConditionCauseTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('ct_condition_cause', function (Blueprint $table) {
            $table->integer('id', true);
            $table->integer('condition_id')->index('ct_condition_cause_ct_conditions_id_condition_fk');
            $table->integer('cause_id');
            $table->unsignedInteger('condition_variable_id')->index('ct_condition_cause_variables_id_condition_fk');
            $table->unsignedInteger('cause_variable_id');
            $table->integer('votes_percent');
            $table->timestamp('updated_at');
            $table->timestamp('created_at')->useCurrent();
            $table->softDeletes();

            $table->unique(['cause_id', 'condition_id'], 'ct_condition_cause_cause_id_condition_id_uindex');
            $table->unique(['cause_variable_id', 'condition_variable_id'], 'ct_condition_cause_cause_uindex');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('ct_condition_cause');
    }
}
