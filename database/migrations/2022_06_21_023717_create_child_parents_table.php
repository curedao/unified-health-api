<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateChildParentsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('child_parents', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedBigInteger('child_user_id')->comment('The child who has granted data access to the parent. ');
            $table->unsignedBigInteger('parent_user_id')->index('child_parents_wp_users_ID_fk_2')->comment('The parent who has been granted access to the child data.');
            $table->string('scopes', 2000)->comment('Whether the parent has read access and/or write access to the data.');
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at');
            $table->softDeletes();

            $table->unique(['child_user_id', 'parent_user_id'], 'child_user_id_parent_user_id_uindex');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('child_parents');
    }
}
