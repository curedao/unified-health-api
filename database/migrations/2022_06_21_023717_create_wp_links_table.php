<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateWpLinksTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('wp_links', function (Blueprint $table) {
            $table->bigIncrements('link_id')->comment('Unique number assigned to each row of the table.');
            $table->string('link_url', 760)->unique('wp_links_link_url_uindex')->comment('Unique universal resource locator for the link.');
            $table->string('link_name')->nullable()->comment('Name of the link.');
            $table->string('link_image')->nullable()->comment('URL of an image related to the link.');
            $table->string('link_target', 25)->nullable()->comment('The target frame for the link. e.g. _blank, _top, _none.');
            $table->string('link_description')->nullable()->comment('Description of the link.');
            $table->string('link_visible', 20)->nullable()->default('Y')->index('link_visible')->comment('Control if the link is public or private.');
            $table->unsignedBigInteger('link_owner')->nullable()->default(1)->index('wp_links_wp_users_ID_fk')->comment('ID of user who created the link.');
            $table->integer('link_rating')->nullable()->default(0)->comment('Add a rating between 0-10 for the link.');
            $table->dateTime('link_updated')->nullable()->default(null);
            $table->string('link_rel')->nullable()->comment('Relationship of link.');
            $table->mediumText('link_notes')->nullable()->comment('Notes about the link.');
            $table->string('link_rss')->default('');
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
        Schema::dropIfExists('wp_links');
    }
}
