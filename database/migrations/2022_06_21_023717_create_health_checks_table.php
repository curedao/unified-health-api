<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateHealthChecksTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('health_checks', function (Blueprint $table) {
            $table->increments('id');
            $table->string('resource_name');
            $table->string('resource_slug')->index();
            $table->string('target_name');
            $table->string('target_slug')->index();
            $table->string('target_display');
            $table->boolean('healthy');
            $table->text('error_message')->nullable();
            $table->double('runtime', 8, 2);
            $table->string('value')->nullable();
            $table->string('value_human')->nullable();
            $table->timestamp('created_at')->index();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('health_checks');
    }
}
