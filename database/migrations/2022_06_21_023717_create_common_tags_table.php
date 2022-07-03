<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCommonTagsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('common_tags', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('tagged_variable_id')->comment('This is the id of the variable being tagged with an ingredient or something.');
            $table->unsignedInteger('tag_variable_id')->index('common_tags_tag_variable_id_variables_id_fk')->comment('This is the id of the ingredient variable whose value is determined based on the value of the tagged variable.');
            $table->integer('number_of_data_points')->nullable()->comment('The number of data points used to estimate the mean. ');
            $table->float('standard_error', 10, 0)->nullable()->comment('Measure of variability of the 
mean value as a function of the number of data points.');
            $table->unsignedSmallInteger('tag_variable_unit_id')->nullable()->index('common_tags_tag_variable_unit_id_fk')->comment('The id for the unit of the tag (ingredient) variable.');
            $table->unsignedSmallInteger('tagged_variable_unit_id')->nullable()->index('common_tags_tagged_variable_unit_id_fk')->comment('The unit for the source variable to be tagged.');
            $table->double('conversion_factor')->comment('Number by which we multiply the tagged variable\'s value to obtain the tag variable\'s value');
            $table->string('client_id', 80)->nullable()->index('common_tags_client_id_fk');
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at');
            $table->softDeletes();

            $table->unique(['tagged_variable_id', 'tag_variable_id'], 'UK_tag_tagged');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('common_tags');
    }
}
