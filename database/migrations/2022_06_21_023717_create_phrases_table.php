<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePhrasesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('phrases', function (Blueprint $table) {
            $table->string('client_id', 80)->index('phrases_client_id_fk');
            $table->timestamp('created_at')->useCurrent();
            $table->softDeletes();
            $table->integer('id', true);
            $table->string('image', 100)->nullable();
            $table->text('text');
            $table->string('title', 80)->nullable();
            $table->string('type', 80);
            $table->timestamp('updated_at');
            $table->string('url', 100)->nullable();
            $table->unsignedBigInteger('user_id')->index('phrases_user_id_fk');
            $table->integer('responding_to_phrase_id')->nullable();
            $table->integer('response_phrase_id')->nullable();
            $table->text('recipient_user_ids')->nullable();
            $table->integer('number_of_times_heard')->nullable();
            $table->double('interpretative_confidence')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('phrases');
    }
}
