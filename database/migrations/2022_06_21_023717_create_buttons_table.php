<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateButtonsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('buttons', function (Blueprint $table) {
            $table->string('accessibility_text', 100)->nullable();
            $table->string('action', 20)->nullable();
            $table->string('additional_information', 20)->nullable();
            $table->string('client_id', 80)->index('buttons_client_id_fk');
            $table->string('color', 20)->nullable();
            $table->string('confirmation_text', 100)->nullable();
            $table->timestamp('created_at')->useCurrent();
            $table->softDeletes();
            $table->string('function_name', 20)->nullable();
            $table->text('function_parameters')->nullable();
            $table->string('html', 200)->nullable();
            $table->string('element_id', 80);
            $table->string('image', 100)->nullable();
            $table->text('input_fields')->nullable();
            $table->string('ion_icon', 20)->nullable();
            $table->string('link', 100)->nullable();
            $table->string('state_name', 20)->nullable();
            $table->text('state_params')->nullable();
            $table->string('success_alert_body', 200)->nullable();
            $table->string('success_alert_title', 80)->nullable();
            $table->string('success_toast_text', 80)->nullable();
            $table->string('text', 80)->nullable();
            $table->string('title', 80)->nullable();
            $table->string('tooltip', 80)->nullable();
            $table->string('type', 80);
            $table->timestamp('updated_at');
            $table->unsignedBigInteger('user_id')->index('buttons_user_id_fk');
            $table->integer('id', true)->unique('buttons_id_uindex');
            $table->string('slug', 200)->nullable()->unique('buttons_slug_uindex')->comment('The slug is the part of a URL that identifies a page in human-readable keywords.');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('buttons');
    }
}
