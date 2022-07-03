<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateWpUsermetaTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('wp_usermeta', function (Blueprint $table) {
            $table->bigIncrements('umeta_id')->comment('Unique number assigned to each row of the table.');
            $table->unsignedBigInteger('user_id')->nullable()->default(0)->index('user_id')->comment('ID of the related user.');
            $table->string('meta_key')->nullable()->index('meta_key')->comment('An identifying key for the piece of data.');
            $table->longText('meta_value')->nullable()->comment('The actual piece of data.');
            $table->timestamp('updated_at');
            $table->timestamp('created_at')->useCurrent();
            $table->softDeletes();
            $table->string('client_id')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('wp_usermeta');
    }
}
