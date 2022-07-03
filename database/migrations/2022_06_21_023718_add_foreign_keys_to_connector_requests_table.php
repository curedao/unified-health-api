<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeysToConnectorRequestsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('connector_requests', function (Blueprint $table) {
            $table->foreign(['connection_id'], 'connector_requests_connections_id_fk')->references(['id'])->on('connections')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['connector_id'], 'connector_requests_connectors_id_fk')->references(['id'])->on('connectors')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['connector_import_id'], 'connector_requests_connector_imports_id_fk')->references(['id'])->on('connector_imports')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['user_id'], 'connector_requests_wp_users_ID_fk')->references(['ID'])->on('wp_users')->onUpdate('NO ACTION')->onDelete('NO ACTION');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('connector_requests', function (Blueprint $table) {
            $table->dropForeign('connector_requests_connections_id_fk');
            $table->dropForeign('connector_requests_connectors_id_fk');
            $table->dropForeign('connector_requests_connector_imports_id_fk');
            $table->dropForeign('connector_requests_wp_users_ID_fk');
        });
    }
}
