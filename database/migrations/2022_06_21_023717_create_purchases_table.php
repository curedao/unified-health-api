<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePurchasesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('purchases', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('subscriber_user_id');
            $table->unsignedBigInteger('referrer_user_id')->nullable();
            $table->timestamp('updated_at');
            $table->timestamp('created_at')->useCurrent();
            $table->enum('subscription_provider', ['stripe', 'apple', 'google']);
            $table->string('last_four', 4)->nullable();
            $table->string('product_id', 100);
            $table->string('subscription_provider_transaction_id', 100)->nullable();
            $table->string('coupon', 100)->nullable();
            $table->string('client_id', 80)->nullable()->index('purchases_client_id_fk');
            $table->date('refunded_at')->nullable();
            $table->softDeletes();

            $table->unique(['subscriber_user_id', 'referrer_user_id'], 'subscriber_referrer');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('purchases');
    }
}
