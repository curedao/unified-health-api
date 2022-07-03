<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateWpTermRelationshipsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('wp_term_relationships', function (Blueprint $table) {
            $table->unsignedBigInteger('object_id')->comment('The ID of the post object.');
            $table->unsignedBigInteger('term_taxonomy_id')->index('term_taxonomy_id')->comment('The ID of the term / taxonomy pair.');
            $table->integer('term_order')->nullable()->comment('Allow ordering of terms for an object, not fully used.');
            $table->timestamp('updated_at');
            $table->timestamp('created_at')->useCurrent();
            $table->softDeletes();
            $table->string('client_id')->nullable();

            $table->primary(['object_id', 'term_taxonomy_id']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('wp_term_relationships');
    }
}
