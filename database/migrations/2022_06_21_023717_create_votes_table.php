<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateVotesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('votes', function (Blueprint $table) {
            $table->integer('id', true);
            $table->string('client_id', 80)->nullable()->index('votes_client_id_fk');
            $table->unsignedBigInteger('user_id');
            $table->integer('value')->comment('Value of Vote');
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at');
            $table->softDeletes();
            $table->unsignedInteger('cause_variable_id')->index();
            $table->unsignedInteger('effect_variable_id')->index();
            $table->integer('correlation_id')->nullable()->index('votes_correlations_id_fk');
            $table->integer('aggregate_correlation_id')->nullable()->index('votes_aggregate_correlations_id_fk');
            $table->boolean('is_public')->nullable();

            $table->unique(['user_id', 'cause_variable_id', 'effect_variable_id'], 'votes_user_id_cause_variable_id_effect_variable_id_uindex');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('votes');
    }
}
