<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDeviceTokensTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('device_tokens', function (Blueprint $table) {
            $table->string('device_token')->primary();
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at');
            $table->softDeletes();
            $table->unsignedBigInteger('user_id')->index('index_user_id');
            $table->unsignedInteger('number_of_waiting_tracking_reminder_notifications')->nullable()->comment('Number of notifications waiting in the reminder inbox');
            $table->timestamp('last_notified_at')->nullable();
            $table->string('platform');
            $table->unsignedInteger('number_of_new_tracking_reminder_notifications')->nullable()->comment('Number of notifications that have come due since last notification');
            $table->unsignedInteger('number_of_notifications_last_sent')->nullable()->comment('Number of notifications that were sent at last_notified_at batch');
            $table->string('error_message')->nullable();
            $table->timestamp('last_checked_at')->nullable();
            $table->timestamp('received_at')->nullable();
            $table->string('server_ip')->nullable();
            $table->string('server_hostname')->nullable();
            $table->string('client_id')->nullable()->index('device_tokens_client_id_fk');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('device_tokens');
    }
}
