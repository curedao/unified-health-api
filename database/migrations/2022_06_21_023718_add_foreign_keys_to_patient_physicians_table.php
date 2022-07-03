<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeysToPatientPhysiciansTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('patient_physicians', function (Blueprint $table) {
            $table->foreign(['patient_user_id'], 'patient_physicians_wp_users_ID_fk')->references(['ID'])->on('wp_users')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['physician_user_id'], 'patient_physicians_wp_users_ID_fk_2')->references(['ID'])->on('wp_users')->onUpdate('NO ACTION')->onDelete('NO ACTION');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('patient_physicians', function (Blueprint $table) {
            $table->dropForeign('patient_physicians_wp_users_ID_fk');
            $table->dropForeign('patient_physicians_wp_users_ID_fk_2');
        });
    }
}
