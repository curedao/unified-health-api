<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeysToWpPostmetaTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('wp_postmeta', function (Blueprint $table) {
            $table->foreign(['post_id'], 'wp_postmeta_wp_posts_ID_fk')->references(['ID'])->on('wp_posts')->onUpdate('CASCADE')->onDelete('CASCADE');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('wp_postmeta', function (Blueprint $table) {
            $table->dropForeign('wp_postmeta_wp_posts_ID_fk');
        });
    }
}
