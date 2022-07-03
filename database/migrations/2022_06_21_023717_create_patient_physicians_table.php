<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePatientPhysiciansTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('patient_physicians', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedBigInteger('patient_user_id')->comment('The patient who has granted data access to the physician. ');
            $table->unsignedBigInteger('physician_user_id')->index('patient_physicians_wp_users_ID_fk_2')->comment('The physician who has been granted access to the patients data.');
            $table->string('scopes', 2000)->comment('Whether the physician has read access and/or write access to the data.');
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at');
            $table->softDeletes();

            $table->unique(['patient_user_id', 'physician_user_id'], 'patients_patient_user_id_physician_user_id_uindex');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('patient_physicians');
    }
}
