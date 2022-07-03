<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeysToCommonTagsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('common_tags', function (Blueprint $table) {
            $table->foreign(['client_id'], 'common_tags_client_id_fk')->references(['client_id'])->on('oa_clients')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['tagged_variable_id'], 'common_tags_tagged_variable_id_variables_id_fk')->references(['id'])->on('variables')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['tagged_variable_unit_id'], 'common_tags_tagged_variable_unit_id_fk')->references(['id'])->on('units')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['tag_variable_id'], 'common_tags_tag_variable_id_variables_id_fk')->references(['id'])->on('variables')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['tag_variable_unit_id'], 'common_tags_tag_variable_unit_id_fk')->references(['id'])->on('units')->onUpdate('NO ACTION')->onDelete('NO ACTION');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('common_tags', function (Blueprint $table) {
            $table->dropForeign('common_tags_client_id_fk');
            $table->dropForeign('common_tags_tagged_variable_id_variables_id_fk');
            $table->dropForeign('common_tags_tagged_variable_unit_id_fk');
            $table->dropForeign('common_tags_tag_variable_id_variables_id_fk');
            $table->dropForeign('common_tags_tag_variable_unit_id_fk');
        });
    }
}
