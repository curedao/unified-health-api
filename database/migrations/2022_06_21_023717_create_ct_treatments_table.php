<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCtTreatmentsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('ct_treatments', function (Blueprint $table) {
            $table->integer('id', true);
            $table->string('name', 100)->unique('treName');
            $table->unsignedInteger('variable_id')->index('ct_treatments_variables_id_fk');
            $table->timestamp('updated_at');
            $table->timestamp('created_at')->useCurrent();
            $table->softDeletes();
            $table->unsignedInteger('number_of_conditions')->nullable();
            $table->unsignedInteger('number_of_side_effects');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('ct_treatments');
    }
}
