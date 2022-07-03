<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateWpTermmetaTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('wp_termmeta', function (Blueprint $table) {
            $table->bigIncrements('meta_id');
            $table->unsignedBigInteger('term_id')->default(0)->index('term_id');
            $table->string('meta_key')->nullable()->index('meta_key');
            $table->longText('meta_value')->nullable();
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
        Schema::dropIfExists('wp_termmeta');
    }
}
