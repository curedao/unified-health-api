<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateWpTermTaxonomyTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('wp_term_taxonomy', function (Blueprint $table) {
            $table->bigIncrements('term_taxonomy_id')->comment('Unique number assigned to each row of the table.');
            $table->unsignedBigInteger('term_id')->nullable()->comment('The ID of the related term.');
            $table->string('taxonomy', 32)->nullable()->index('taxonomy')->comment('The slug of the taxonomy. This can be the <a href="http://codex.wordpress.org/Taxonomies#Default_Taxonomies" target="_blank">built in taxonomies</a> or any taxonomy registered using <a href="http://codex.wordpress.org/Function_Reference/register_taxonomy" target="_blank">register_taxonomy()</a>.');
            $table->longText('description')->nullable()->comment('Description of the term in this taxonomy.');
            $table->unsignedBigInteger('parent')->nullable()->comment('ID of a parent term. Used for hierarchical taxonomies like Categories.');
            $table->bigInteger('count')->nullable()->comment('Number of post objects assigned the term for this taxonomy.');
            $table->timestamp('updated_at');
            $table->timestamp('created_at')->useCurrent();
            $table->softDeletes();
            $table->string('client_id')->nullable();

            $table->unique(['term_id', 'taxonomy'], 'term_id_taxonomy');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('wp_term_taxonomy');
    }
}
