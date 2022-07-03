<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeysToWpTermTaxonomyTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('wp_term_taxonomy', function (Blueprint $table) {
            $table->foreign(['term_id'], 'wp_term_taxonomy_wp_terms_term_id_fk')->references(['term_id'])->on('wp_terms')->onUpdate('NO ACTION')->onDelete('NO ACTION');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('wp_term_taxonomy', function (Blueprint $table) {
            $table->dropForeign('wp_term_taxonomy_wp_terms_term_id_fk');
        });
    }
}
