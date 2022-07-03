<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateWpPostmetaTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('wp_postmeta', function (Blueprint $table) {
            $table->bigIncrements('meta_id')->comment('Unique number assigned to each row of the table.');
            $table->unsignedBigInteger('post_id')->nullable()->default(0)->index('post_id')->comment('The ID of the post the data relates to.');
            $table->string('meta_key')->nullable()->index('meta_key')->comment('An identifying key for the piece of data.');
            $table->longText('meta_value')->nullable()->comment('The actual piece of data.');
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
        Schema::dropIfExists('wp_postmeta');
    }
}
