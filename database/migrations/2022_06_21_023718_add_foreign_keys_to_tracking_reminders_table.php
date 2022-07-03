<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeysToTrackingRemindersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('tracking_reminders', function (Blueprint $table) {
            $table->foreign(['client_id'], 'tracking_reminders_client_id_fk')->references(['client_id'])->on('oa_clients')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['user_id'], 'tracking_reminders_user_id_fk')->references(['ID'])->on('wp_users')->onUpdate('CASCADE')->onDelete('CASCADE');
            $table->foreign(['user_id', 'variable_id'], 'tracking_reminders_user_variables_user_id_variable_id_fk')->references(['user_id', 'variable_id'])->on('user_variables')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['user_variable_id'], 'tracking_reminders_user_variables_user_variable_id_fk')->references(['id'])->on('user_variables')->onUpdate('CASCADE')->onDelete('CASCADE');
            $table->foreign(['variable_id'], 'tracking_reminders_variables_id_fk')->references(['id'])->on('variables')->onUpdate('NO ACTION')->onDelete('NO ACTION');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('tracking_reminders', function (Blueprint $table) {
            $table->dropForeign('tracking_reminders_client_id_fk');
            $table->dropForeign('tracking_reminders_user_id_fk');
            $table->dropForeign('tracking_reminders_user_variables_user_id_variable_id_fk');
            $table->dropForeign('tracking_reminders_user_variables_user_variable_id_fk');
            $table->dropForeign('tracking_reminders_variables_id_fk');
        });
    }
}
