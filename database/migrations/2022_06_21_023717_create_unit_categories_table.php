<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUnitCategoriesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('unit_categories', function (Blueprint $table) {
            $table->tinyIncrements('id');
            $table->string('name', 64)->unique('name_UNIQUE')->comment('Unit category name');
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at');
            $table->boolean('can_be_summed')->default(true);
            $table->softDeletes();
            $table->integer('sort_order');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('unit_categories');
    }
}
