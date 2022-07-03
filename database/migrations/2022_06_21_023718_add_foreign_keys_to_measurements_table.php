<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeysToMeasurementsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('measurements', function (Blueprint $table) {
            $table->foreign(['client_id'], 'measurements_client_id_fk')->references(['client_id'])->on('oa_clients')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['connection_id'], 'measurements_connections_id_fk')->references(['id'])->on('connections')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['connector_id'], 'measurements_connectors_id_fk')->references(['id'])->on('connectors')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['connector_import_id'], 'measurements_connector_imports_id_fk')->references(['id'])->on('connector_imports')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['original_unit_id'], 'measurements_original_unit_id_fk')->references(['id'])->on('units')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['unit_id'], 'measurements_unit_id_fk')->references(['id'])->on('units')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['user_id'], 'measurements_user_id_fk')->references(['ID'])->on('wp_users')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['user_variable_id'], 'measurements_user_variables_user_variable_id_fk')->references(['id'])->on('user_variables')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['variable_id'], 'measurements_variables_id_fk')->references(['id'])->on('variables')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['variable_category_id'], 'measurements_variable_category_id_fk')->references(['id'])->on('variable_categories')->onUpdate('NO ACTION')->onDelete('NO ACTION');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('measurements', function (Blueprint $table) {
            $table->dropForeign('measurements_client_id_fk');
            $table->dropForeign('measurements_connections_id_fk');
            $table->dropForeign('measurements_connectors_id_fk');
            $table->dropForeign('measurements_connector_imports_id_fk');
            $table->dropForeign('measurements_original_unit_id_fk');
            $table->dropForeign('measurements_unit_id_fk');
            $table->dropForeign('measurements_user_id_fk');
            $table->dropForeign('measurements_user_variables_user_variable_id_fk');
            $table->dropForeign('measurements_variables_id_fk');
            $table->dropForeign('measurements_variable_category_id_fk');
        });
    }
}
