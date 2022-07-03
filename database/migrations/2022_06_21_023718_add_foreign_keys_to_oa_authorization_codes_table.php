<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeysToOaAuthorizationCodesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('oa_authorization_codes', function (Blueprint $table) {
            $table->foreign(['client_id'], 'bshaffer_oauth_authorization_codes_client_id_fk')->references(['client_id'])->on('oa_clients')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['user_id'], 'bshaffer_oauth_authorization_codes_user_id_fk')->references(['ID'])->on('wp_users')->onUpdate('NO ACTION')->onDelete('NO ACTION');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('oa_authorization_codes', function (Blueprint $table) {
            $table->dropForeign('bshaffer_oauth_authorization_codes_client_id_fk');
            $table->dropForeign('bshaffer_oauth_authorization_codes_user_id_fk');
        });
    }
}
