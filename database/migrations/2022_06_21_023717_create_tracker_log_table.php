<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTrackerLogTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('tracker_log', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('session_id')->nullable()->index();
            $table->unsignedBigInteger('path_id')->nullable()->index();
            $table->unsignedBigInteger('query_id')->nullable()->index();
            $table->string('method', 10)->index();
            $table->unsignedBigInteger('route_path_id')->nullable()->index();
            $table->boolean('is_ajax');
            $table->boolean('is_secure');
            $table->boolean('is_json');
            $table->boolean('wants_json');
            $table->unsignedBigInteger('error_id')->nullable()->index();
            $table->timestamp('created_at')->useCurrent()->index();
            $table->timestamp('updated_at')->index();
            $table->string('client_id')->nullable()->index('tracker_log_client_id_fk');
            $table->unsignedBigInteger('user_id')->index('tracker_log_user_id_fk');
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('tracker_log');
    }
}
