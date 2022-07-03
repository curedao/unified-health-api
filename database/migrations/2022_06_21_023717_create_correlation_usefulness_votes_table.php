<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCorrelationUsefulnessVotesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('correlation_usefulness_votes', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('cause_variable_id')->index('correlation_usefulness_votes_cause_variables_id_fk');
            $table->unsignedInteger('effect_variable_id')->index('correlation_usefulness_votes_effect_variables_id_fk');
            $table->integer('correlation_id')->nullable()->index('correlation_usefulness_votes_correlations_id_fk');
            $table->integer('aggregate_correlation_id')->nullable()->index('correlation_usefulness_votes_aggregate_correlations_id_fk');
            $table->unsignedBigInteger('user_id');
            $table->integer('vote')->comment('The opinion of the data owner on whether or not knowledge of this 
                    relationship is useful in helping them improve an outcome of interest. 
                    -1 corresponds to a down vote. 1 corresponds to an up vote. 0 corresponds to removal of a 
                    previous vote.  null corresponds to never having voted before.');
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at');
            $table->softDeletes();
            $table->string('client_id', 80)->nullable()->index('correlation_usefulness_votes_client_id_fk');
            $table->boolean('is_public')->nullable();

            $table->unique(['user_id', 'cause_variable_id', 'effect_variable_id'], 'correlation_usefulness_votes_user_cause_effect_uindex');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('correlation_usefulness_votes');
    }
}
