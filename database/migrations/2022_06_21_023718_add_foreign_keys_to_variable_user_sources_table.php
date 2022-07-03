<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeysToVariableUserSourcesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('variable_user_sources', function (Blueprint $table) {
            $table->foreign(['client_id'], 'variable_user_sources_client_id_fk')->references(['client_id'])->on('oa_clients')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['user_id'], 'variable_user_sources_user_id_fk')->references(['ID'])->on('wp_users')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['user_id', 'variable_id'], 'variable_user_sources_user_variables_user_id_variable_id_fk')->references(['user_id', 'variable_id'])->on('user_variables')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['user_variable_id'], 'variable_user_sources_user_variables_user_variable_id_fk')->references(['id'])->on('user_variables')->onUpdate('CASCADE')->onDelete('CASCADE');
            $table->foreign(['variable_id'], 'variable_user_sources_variable_id_fk')->references(['id'])->on('variables')->onUpdate('NO ACTION')->onDelete('NO ACTION');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('variable_user_sources', function (Blueprint $table) {
            $table->dropForeign('variable_user_sources_client_id_fk');
            $table->dropForeign('variable_user_sources_user_id_fk');
            $table->dropForeign('variable_user_sources_user_variables_user_id_variable_id_fk');
            $table->dropForeign('variable_user_sources_user_variables_user_variable_id_fk');
            $table->dropForeign('variable_user_sources_variable_id_fk');
        });
    }
}
