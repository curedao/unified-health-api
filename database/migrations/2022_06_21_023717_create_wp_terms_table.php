<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateWpTermsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('wp_terms', function (Blueprint $table) {
            $table->bigIncrements('term_id')->comment('Unique number assigned to each term.');
            $table->string('name', 200)->nullable()->index('name')->comment('The name of the term.');
            $table->string('slug', 200)->nullable()->index('slug')->comment('The URL friendly slug of the name.');
            $table->bigInteger('term_group')->nullable()->comment('Ability for themes or plugins to group terms together to use aliases. Not populated by WordPress core itself.');
            $table->timestamp('updated_at');
            $table->timestamp('created_at')->useCurrent();
            $table->softDeletes();
            $table->string('client_id')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('wp_terms');
    }
}
