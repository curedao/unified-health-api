<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUserTagsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('user_tags', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('tagged_variable_id')->comment('This is the id of the variable being tagged with an ingredient or something.');
            $table->unsignedInteger('tag_variable_id')->index('fk_conversionUnit')->comment('This is the id of the ingredient variable whose value is determined based on the value of the tagged variable.');
            $table->double('conversion_factor')->comment('Number by which we multiply the tagged variable\'s value to obtain the tag variable\'s value');
            $table->unsignedBigInteger('user_id')->index('user_tags_user_id_fk');
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at');
            $table->string('client_id', 80)->nullable()->index('user_tags_client_id_fk');
            $table->softDeletes();
            $table->unsignedInteger('tagged_user_variable_id')->nullable()->index('user_tags_tagged_user_variable_id_fk');
            $table->unsignedInteger('tag_user_variable_id')->nullable()->index('user_tags_tag_user_variable_id_fk');

            $table->unique(['tagged_variable_id', 'tag_variable_id', 'user_id'], 'UK_user_tag_tagged');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('user_tags');
    }
}
