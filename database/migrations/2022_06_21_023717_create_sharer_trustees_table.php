<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateSharerTrusteesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('sharer_trustees', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedBigInteger('sharer_user_id')->comment('The sharer who has granted data access to the trustee. ');
            $table->unsignedBigInteger('trustee_user_id')->index('sharer_trustees_wp_users_ID_fk_2')->comment('The trustee who has been granted access to the sharer data.');
            $table->string('scopes', 2000)->comment('Whether the trustee has read access and/or write access to the data.');
            $table->enum('relationship_type', ['patient-physician', 'student-teacher', 'child-parent', 'friend']);
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at');
            $table->softDeletes();

            $table->unique(['sharer_user_id', 'trustee_user_id'], 'sharer_user_id_trustee_user_id_uindex');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('sharer_trustees');
    }
}
