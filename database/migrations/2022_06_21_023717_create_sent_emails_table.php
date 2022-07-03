<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateSentEmailsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('sent_emails', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedBigInteger('user_id')->nullable();
            $table->string('type', 100);
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at');
            $table->softDeletes();
            $table->string('client_id')->nullable()->index('sent_emails_client_id_fk');
            $table->string('slug', 100)->nullable();
            $table->string('response', 140)->nullable();
            $table->text('content')->nullable();
            $table->unsignedBigInteger('wp_post_id')->nullable()->index('sent_emails_wp_posts_ID_fk');
            $table->string('email_address')->nullable();
            $table->string('subject', 78)->comment('A Subject Line is the introduction that identifies the emails intent. 
                    This subject line, displayed to the email user or recipient when they look at their list of messages in their inbox, 
                    should tell the recipient what the message is about, what the sender wants to convey.');

            $table->index(['user_id', 'type']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('sent_emails');
    }
}
