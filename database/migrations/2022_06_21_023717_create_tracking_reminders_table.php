<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTrackingRemindersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('tracking_reminders', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedBigInteger('user_id');
            $table->string('client_id', 80)->index('tracking_reminders_client_id_fk');
            $table->unsignedInteger('variable_id')->comment('Id for the variable to be tracked');
            $table->double('default_value')->nullable()->comment('Default value to use for the measurement when tracking');
            $table->time('reminder_start_time')->default('00:00:00')->comment('LOCAL TIME: Earliest time of day at which reminders should appear');
            $table->time('reminder_end_time')->nullable()->comment('LOCAL TIME: Latest time of day at which reminders should appear');
            $table->string('reminder_sound', 125)->nullable()->comment('String identifier for the sound to accompany the reminder');
            $table->integer('reminder_frequency')->nullable()->comment('Number of seconds between one reminder and the next');
            $table->boolean('pop_up')->nullable()->comment('True if the reminders should appear as a popup notification');
            $table->boolean('sms')->nullable()->comment('True if the reminders should be delivered via SMS');
            $table->boolean('email')->nullable()->comment('True if the reminders should be delivered via email');
            $table->boolean('notification_bar')->nullable()->comment('True if the reminders should appear in the notification bar');
            $table->timestamp('last_tracked')->nullable();
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at');
            $table->date('start_tracking_date')->nullable()->comment('Earliest date on which the user should be reminded to track in YYYY-MM-DD format');
            $table->date('stop_tracking_date')->nullable()->comment('Latest date on which the user should be reminded to track  in YYYY-MM-DD format');
            $table->text('instructions')->nullable();
            $table->softDeletes();
            $table->string('image_url', 2083)->nullable();
            $table->unsignedInteger('user_variable_id')->index('tracking_reminders_user_variables_user_variable_id_fk');
            $table->timestamp('latest_tracking_reminder_notification_notify_at')->nullable();
            $table->unsignedInteger('number_of_tracking_reminder_notifications')->nullable()->comment('Number of Tracking Reminder Notifications for this Tracking Reminder.
                    [Formula: update tracking_reminders
                        left join (
                            select count(id) as total, tracking_reminder_id
                            from tracking_reminder_notifications
                            group by tracking_reminder_id
                        )
                        as grouped on tracking_reminders.id = grouped.tracking_reminder_id
                    set tracking_reminders.number_of_tracking_reminder_notifications = count(grouped.total)]');

            $table->index(['variable_id', 'user_id'], 'tracking_reminders_user_variables_variable_id_user_id_fk');
            $table->unique(['user_id', 'variable_id', 'reminder_start_time', 'reminder_frequency'], 'UK_user_var_time_freq');
            $table->index(['user_id', 'client_id'], 'user_client');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('tracking_reminders');
    }
}
