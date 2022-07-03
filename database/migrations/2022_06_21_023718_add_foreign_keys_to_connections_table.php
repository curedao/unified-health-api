<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeysToConnectionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('connections', function (Blueprint $table) {
            $table->foreign(['client_id'], 'connections_client_id_fk')->references(['client_id'])->on('oa_clients')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['connector_id'], 'connections_connectors_id_fk')->references(['id'])->on('connectors')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['user_id'], 'connections_user_id_fk')->references(['ID'])->on('wp_users')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['wp_post_id'], 'connections_wp_posts_ID_fk')->references(['ID'])->on('wp_posts')->onUpdate('NO ACTION')->onDelete('NO ACTION');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('connections', function (Blueprint $table) {
            $table->dropForeign('connections_client_id_fk');
            $table->dropForeign('connections_connectors_id_fk');
            $table->dropForeign('connections_user_id_fk');
            $table->dropForeign('connections_wp_posts_ID_fk');
        });
    }
}
