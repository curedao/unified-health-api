<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCardsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('cards', function (Blueprint $table) {
            $table->text('action_sheet_buttons')->nullable();
            $table->string('avatar', 100)->nullable();
            $table->string('avatar_circular', 100)->nullable();
            $table->string('background_color', 20)->nullable();
            $table->text('buttons')->nullable();
            $table->string('client_id', 80)->index('cards_client_id_fk');
            $table->text('content')->nullable();
            $table->timestamp('created_at')->useCurrent();
            $table->softDeletes();
            $table->string('header_title', 100)->nullable();
            $table->text('html')->nullable();
            $table->text('html_content')->nullable();
            $table->string('element_id', 80);
            $table->string('image', 100)->nullable();
            $table->text('input_fields')->nullable();
            $table->string('intent_name', 80)->nullable();
            $table->string('ion_icon', 20)->nullable();
            $table->string('link', 2083)->nullable()->comment('Link field is deprecated due to ambiguity.  Please use url field instead.');
            $table->text('parameters')->nullable();
            $table->text('sharing_body')->nullable();
            $table->text('sharing_buttons')->nullable();
            $table->string('sharing_title', 80)->nullable();
            $table->string('sub_header', 80)->nullable();
            $table->string('sub_title', 80)->nullable();
            $table->string('title', 80)->nullable();
            $table->string('type', 80);
            $table->timestamp('updated_at');
            $table->unsignedBigInteger('user_id')->index('cards_user_id_fk');
            $table->string('url', 2083)->nullable()->comment('URL to go to when the card is clicked');
            $table->integer('id')->primary();
            $table->string('slug', 200)->nullable()->unique('cards_slug_uindex')->comment('The slug is the part of a URL that identifies a page in human-readable keywords.');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('cards');
    }
}
