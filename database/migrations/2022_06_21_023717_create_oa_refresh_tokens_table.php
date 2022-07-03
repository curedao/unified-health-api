<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateOaRefreshTokensTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('oa_refresh_tokens', function (Blueprint $table) {
            $table->string('refresh_token', 40)->primary();
            $table->string('client_id', 80)->index('refresh_tokens_client_id_fk');
            $table->unsignedBigInteger('user_id')->index('bshaffer_oauth_refresh_tokens_user_id_fk');
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
        Schema::dropIfExists('oa_refresh_tokens');
    }
}
