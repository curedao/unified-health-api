<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeysToUserTagsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('user_tags', function (Blueprint $table) {
            $table->foreign(['client_id'], 'user_tags_client_id_fk')->references(['client_id'])->on('oa_clients')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['tagged_user_variable_id'], 'user_tags_tagged_user_variable_id_fk')->references(['id'])->on('user_variables')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['tagged_variable_id'], 'user_tags_tagged_variable_id_variables_id_fk')->references(['id'])->on('variables')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['tag_user_variable_id'], 'user_tags_tag_user_variable_id_fk')->references(['id'])->on('user_variables')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['tag_variable_id'], 'user_tags_tag_variable_id_variables_id_fk')->references(['id'])->on('variables')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['user_id'], 'user_tags_user_id_fk')->references(['ID'])->on('wp_users')->onUpdate('NO ACTION')->onDelete('NO ACTION');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('user_tags', function (Blueprint $table) {
            $table->dropForeign('user_tags_client_id_fk');
            $table->dropForeign('user_tags_tagged_user_variable_id_fk');
            $table->dropForeign('user_tags_tagged_variable_id_variables_id_fk');
            $table->dropForeign('user_tags_tag_user_variable_id_fk');
            $table->dropForeign('user_tags_tag_variable_id_variables_id_fk');
            $table->dropForeign('user_tags_user_id_fk');
        });
    }
}
