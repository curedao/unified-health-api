<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeysToChildParentsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('child_parents', function (Blueprint $table) {
            $table->foreign(['child_user_id'], 'child_parents_wp_users_ID_fk')->references(['ID'])->on('wp_users')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['parent_user_id'], 'child_parents_wp_users_ID_fk_2')->references(['ID'])->on('wp_users')->onUpdate('NO ACTION')->onDelete('NO ACTION');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('child_parents', function (Blueprint $table) {
            $table->dropForeign('child_parents_wp_users_ID_fk');
            $table->dropForeign('child_parents_wp_users_ID_fk_2');
        });
    }
}
