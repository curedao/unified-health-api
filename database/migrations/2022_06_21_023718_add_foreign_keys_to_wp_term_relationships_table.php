<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeysToWpTermRelationshipsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('wp_term_relationships', function (Blueprint $table) {
            $table->foreign(['object_id'], 'wp_term_relationships_wp_posts_ID_fk')->references(['ID'])->on('wp_posts')->onUpdate('CASCADE')->onDelete('CASCADE');
            $table->foreign(['term_taxonomy_id'], 'wp_term_relationships_wp_term_taxonomy_term_taxonomy_id_fk')->references(['term_taxonomy_id'])->on('wp_term_taxonomy')->onUpdate('NO ACTION')->onDelete('NO ACTION');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('wp_term_relationships', function (Blueprint $table) {
            $table->dropForeign('wp_term_relationships_wp_posts_ID_fk');
            $table->dropForeign('wp_term_relationships_wp_term_taxonomy_term_taxonomy_id_fk');
        });
    }
}
