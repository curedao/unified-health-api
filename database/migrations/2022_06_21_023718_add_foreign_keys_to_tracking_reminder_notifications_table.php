<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeysToTrackingReminderNotificationsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('tracking_reminder_notifications', function (Blueprint $table) {
            $table->foreign(['client_id'], 'tracking_reminder_notifications_client_id_fk')->references(['client_id'])->on('oa_clients')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['tracking_reminder_id'], 'tracking_reminder_notifications_tracking_reminders_id_fk')->references(['id'])->on('tracking_reminders')->onUpdate('CASCADE')->onDelete('CASCADE');
            $table->foreign(['user_id'], 'tracking_reminder_notifications_user_id_fk')->references(['ID'])->on('wp_users')->onUpdate('NO ACTION')->onDelete('CASCADE');
            $table->foreign(['user_variable_id'], 'tracking_reminder_notifications_user_variables_id_fk')->references(['id'])->on('user_variables')->onUpdate('CASCADE')->onDelete('CASCADE');
            $table->foreign(['variable_id'], 'tracking_reminder_notifications_variables_id_fk')->references(['id'])->on('variables')->onUpdate('CASCADE')->onDelete('CASCADE');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('tracking_reminder_notifications', function (Blueprint $table) {
            $table->dropForeign('tracking_reminder_notifications_client_id_fk');
            $table->dropForeign('tracking_reminder_notifications_tracking_reminders_id_fk');
            $table->dropForeign('tracking_reminder_notifications_user_id_fk');
            $table->dropForeign('tracking_reminder_notifications_user_variables_id_fk');
            $table->dropForeign('tracking_reminder_notifications_variables_id_fk');
        });
    }
}
