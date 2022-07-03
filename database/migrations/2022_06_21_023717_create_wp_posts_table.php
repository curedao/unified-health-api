<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateWpPostsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('wp_posts', function (Blueprint $table) {
            $table->bigIncrements('ID')->comment('Unique number assigned to each post.');
            $table->unsignedBigInteger('post_author')->nullable()->default(0)->index('post_author')->comment('The user ID who created it.');
            $table->dateTime('post_date')->nullable()->default(null);
            $table->dateTime('post_date_gmt')->nullable()->default(null);
            $table->longText('post_content')->nullable()->comment('Holds all the content for the post, including HTML, shortcodes and other content.');
            $table->text('post_title')->nullable()->comment('Title of the post.');
            $table->text('post_excerpt')->nullable()->comment('Custom intro or short version of the content.');
            $table->string('post_status', 20)->nullable()->default('publish')->comment('Status of the post, e.g. ‘draft’, ‘pending’, ‘private’, ‘publish’. Also a great WordPress <a href="https://poststatus.com/" target="_blank">news site</a>.');
            $table->string('comment_status', 20)->nullable()->default('open')->comment('If comments are allowed.');
            $table->string('ping_status', 20)->nullable()->default('open')->comment('If the post allows <a href="http://codex.wordpress.org/Introduction_to_Blogging#Pingbacks" target="_blank">ping and trackbacks</a>.');
            $table->string('post_password')->nullable()->comment('Optional password used to view the post.');
            $table->string('post_name', 200)->nullable()->index('post_name')->comment('URL friendly slug of the post title.');
            $table->text('to_ping')->nullable()->comment('A list of URLs WordPress should send pingbacks to when updated.');
            $table->text('pinged')->nullable()->comment('A list of URLs WordPress has sent pingbacks to when updated.');
            $table->dateTime('post_modified')->nullable()->default(null)->index();
            $table->dateTime('post_modified_gmt')->nullable()->default(null);
            $table->longText('post_content_filtered')->nullable()->comment('Used by plugins to cache a version of post_content typically passed through the ‘the_content’ filter. Not used by WordPress core itself.');
            $table->unsignedBigInteger('post_parent')->nullable()->default(0)->index('post_parent')->comment('Used to create a relationship between this post and another when this post is a revision, attachment or another type.');
            $table->string('guid')->nullable()->comment('Global Unique Identifier, the permanent URL to the post, not the permalink version.');
            $table->integer('menu_order')->nullable()->default(0)->comment('Holds the display number for pages and other non-post types.');
            $table->string('post_type', 20)->nullable()->default('post')->comment('The content type identifier.');
            $table->string('post_mime_type', 100)->nullable()->comment('Only used for attachments, the MIME type of the uploaded file.');
            $table->bigInteger('comment_count')->nullable()->default(0)->comment('Total number of comments, pingbacks and trackbacks.');
            $table->timestamp('updated_at');
            $table->timestamp('created_at')->useCurrent();
            $table->softDeletes();
            $table->string('client_id')->nullable();
            $table->integer('record_size_in_kb')->nullable();

            $table->index(['post_author', 'post_modified', 'deleted_at'], 'idx_wp_posts_post_author_post_modified_deleted_at');
            $table->index(['post_type', 'post_status', 'post_date', 'ID'], 'type_status_date');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('wp_posts');
    }
}
