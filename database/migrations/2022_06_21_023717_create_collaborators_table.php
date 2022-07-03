<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCollaboratorsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('collaborators', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedBigInteger('user_id');
            $table->unsignedInteger('app_id')->index('collaborators_applications_id_fk');
            $table->enum('type', ['owner', 'collaborator'])->default('collaborator');
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at');
            $table->softDeletes();
            $table->string('client_id', 80)->nullable()->index('collaborators_client_id_fk');

            $table->unique(['user_id', 'client_id'], 'collaborators_user_client_index');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('collaborators');
    }
}
