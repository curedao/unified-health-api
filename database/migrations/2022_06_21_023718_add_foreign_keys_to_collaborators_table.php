<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeysToCollaboratorsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('collaborators', function (Blueprint $table) {
            $table->foreign(['app_id'], 'collaborators_applications_id_fk')->references(['id'])->on('applications')->onUpdate('CASCADE')->onDelete('CASCADE');
            $table->foreign(['client_id'], 'collaborators_client_id_fk')->references(['client_id'])->on('oa_clients')->onUpdate('CASCADE')->onDelete('CASCADE');
            $table->foreign(['user_id'], 'collaborators_user_id_fk')->references(['ID'])->on('wp_users')->onUpdate('CASCADE')->onDelete('CASCADE');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('collaborators', function (Blueprint $table) {
            $table->dropForeign('collaborators_applications_id_fk');
            $table->dropForeign('collaborators_client_id_fk');
            $table->dropForeign('collaborators_user_id_fk');
        });
    }
}
