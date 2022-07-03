<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeysToOaRefreshTokensTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('oa_refresh_tokens', function (Blueprint $table) {
            $table->foreign(['client_id'], 'bshaffer_oauth_refresh_tokens_client_id_fk')->references(['client_id'])->on('oa_clients')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['user_id'], 'bshaffer_oauth_refresh_tokens_user_id_fk')->references(['ID'])->on('wp_users')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['client_id'], 'refresh_tokens_client_id_fk')->references(['client_id'])->on('oa_clients')->onUpdate('NO ACTION')->onDelete('NO ACTION');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('oa_refresh_tokens', function (Blueprint $table) {
            $table->dropForeign('bshaffer_oauth_refresh_tokens_client_id_fk');
            $table->dropForeign('bshaffer_oauth_refresh_tokens_user_id_fk');
            $table->dropForeign('refresh_tokens_client_id_fk');
        });
    }
}
