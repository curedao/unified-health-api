<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTrackingReminderNotificationsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('tracking_reminder_notifications', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('tracking_reminder_id')->index('tracking_reminder_notifications_tracking_reminders_id_fk');
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at');
            $table->softDeletes();
            $table->unsignedBigInteger('user_id')->index('tracking_reminder_notifications_user_id_fk');
            $table->timestamp('notified_at')->nullable()->comment('UTC time when the notification was sent.');
            $table->timestamp('received_at')->nullable();
            $table->string('client_id')->nullable()->index('tracking_reminder_notifications_client_id_fk');
            $table->unsignedInteger('variable_id')->index('tracking_reminder_notifications_variable_id_fk');
            $table->timestamp('notify_at')->nullable()->default(null)->comment('UTC time at which user should be notified.');
            $table->unsignedInteger('user_variable_id')->index('tracking_reminder_notifications_user_variables_id_fk');

            $table->unique(['notify_at', 'tracking_reminder_id'], 'notify_at_tracking_reminder_id_uindex');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('tracking_reminder_notifications');
    }
}
