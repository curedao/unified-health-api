<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateOaAuthorizationCodesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('oa_authorization_codes', function (Blueprint $table) {
            $table->string('authorization_code', 40)->primary();
            $table->string('client_id', 80)->index('bshaffer_oauth_authorization_codes_client_id_fk');
            $table->unsignedBigInteger('user_id')->index('bshaffer_oauth_authorization_codes_user_id_fk');
            $table->string('redirect_uri', 2000)->nullable();
            $table->timestamp('expires')->nullable();
            $table->string('scope', 2000)->nullable();
            $table->timestamp('updated_at');
            $table->timestamp('created_at')->useCurrent();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('oa_authorization_codes');
    }
}
