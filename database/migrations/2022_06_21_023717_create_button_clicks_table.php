<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateButtonClicksTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('button_clicks', function (Blueprint $table) {
            $table->string('card_id', 80);
            $table->string('button_id', 80);
            $table->string('client_id', 80)->index('button_clicks_client_id_fk');
            $table->timestamp('created_at')->useCurrent();
            $table->softDeletes();
            $table->integer('id', true);
            $table->text('input_fields')->nullable();
            $table->string('intent_name', 80)->nullable();
            $table->text('parameters')->nullable();
            $table->timestamp('updated_at');
            $table->unsignedBigInteger('user_id')->index('button_clicks_user_id_fk');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('button_clicks');
    }
}
