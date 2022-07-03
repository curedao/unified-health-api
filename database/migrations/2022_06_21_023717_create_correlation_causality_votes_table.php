<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCorrelationCausalityVotesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('correlation_causality_votes', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('cause_variable_id')->index('correlation_causality_votes_cause_variables_id_fk');
            $table->unsignedInteger('effect_variable_id')->index('correlation_causality_votes_effect_variables_id_fk');
            $table->integer('correlation_id')->nullable()->index('correlation_causality_votes_correlations_id_fk');
            $table->integer('aggregate_correlation_id')->nullable()->index('correlation_causality_votes_aggregate_correlations_id_fk');
            $table->unsignedBigInteger('user_id');
            $table->integer('vote')->comment('The opinion of the data owner on whether or not there is a plausible
                                mechanism of action by which the predictor variable could influence the outcome variable.');
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at');
            $table->softDeletes();
            $table->string('client_id', 80)->nullable()->index('correlation_causality_votes_client_id_fk');
            $table->boolean('is_public')->nullable();

            $table->unique(['user_id', 'cause_variable_id', 'effect_variable_id'], 'correlation_causality_votes_user_cause_effect_uindex');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('correlation_causality_votes');
    }
}
