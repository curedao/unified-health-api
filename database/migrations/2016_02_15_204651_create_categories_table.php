<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use TCG\Voyager\Models\Page;

class CreateCategoriesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if(!Schema::hasTable('posts')){
            // Create table for storing roles
            Schema::create('posts', function (Blueprint $table) {
                $table->increments('id');
                $table->integer('author_id');
                $table->integer('category_id')->nullable();
                $table->string('title');
                $table->string('seo_title')->nullable();
                $table->text('excerpt');
                $table->text('body');
                $table->string('image')->nullable();
                $table->string('slug')->unique();
                $table->text('meta_description');
                $table->text('meta_keywords');
                $table->enum('status', ['PUBLISHED', 'DRAFT', 'PENDING'])->default('DRAFT');
                $table->boolean('featured')->default(0);
                $table->timestamps();

                //$table->foreign('author_id')->references('id')->on('users');
            });
        }

        if(!Schema::hasTable('pages')){
            // Create table for storing roles
            Schema::create('pages', function (Blueprint $table) {
                $table->increments('id');
                $table->integer('author_id');
                $table->string('title');
                $table->text('excerpt')->nullable();
                $table->text('body')->nullable();
                $table->string('image')->nullable();
                $table->string('slug')->unique();
                $table->text('meta_description')->nullable();
                $table->text('meta_keywords')->nullable();
                $table->enum('status', Page::$statuses)->default(Page::STATUS_INACTIVE);
                $table->timestamps();
            });
        }
        // Create table for storing categories
        Schema::create('categories', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('parent_id')->unsigned()->nullable()->default(null);
            $table->foreign('parent_id')->references('id')->on('categories')->onUpdate('cascade')->onDelete('set null');
            $table->integer('order')->default(1);
            $table->string('name');
            $table->string('slug')->unique();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::drop('categories');
    }
}
