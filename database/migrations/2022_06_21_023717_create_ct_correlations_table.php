<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCtCorrelationsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('ct_correlations', function (Blueprint $table) {
            $table->integer('id', true);
            $table->integer('user_id');
            $table->float('correlation_coefficient', 10, 4)->nullable();
            $table->unsignedInteger('cause_variable_id')->index('cause');
            $table->unsignedInteger('effect_variable_id')->index('effect');
            $table->integer('onset_delay')->nullable();
            $table->integer('duration_of_action')->nullable();
            $table->integer('number_of_pairs')->nullable();
            $table->double('value_predicting_high_outcome')->nullable();
            $table->double('value_predicting_low_outcome')->nullable();
            $table->double('optimal_pearson_product')->nullable();
            $table->float('vote', 3, 1)->nullable()->default(0.5);
            $table->float('statistical_significance', 10, 4)->nullable();
            $table->integer('cause_unit_id')->nullable();
            $table->integer('cause_changes')->nullable();
            $table->integer('effect_changes')->nullable();
            $table->double('qm_score')->nullable();
            $table->text('error')->nullable();
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at');
            $table->softDeletes();

            $table->unique(['user_id', 'cause_variable_id', 'effect_variable_id'], 'user');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('ct_correlations');
    }
}
