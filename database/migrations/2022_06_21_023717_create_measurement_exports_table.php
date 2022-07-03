<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMeasurementExportsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('measurement_exports', function (Blueprint $table) {
            $table->integer('id', true);
            $table->unsignedBigInteger('user_id')->index('measurement_exports_user_id_fk');
            $table->string('client_id')->nullable()->index('measurement_exports_client_id_fk');
            $table->string('status', 32)->comment('Status of Measurement Export');
            $table->enum('type', ['user', 'app'])->default('user')->comment('Whether user\'s measurement export request or app users');
            $table->enum('output_type', ['csv', 'xls', 'pdf'])->default('csv')->comment('Output type of export file');
            $table->string('error_message')->nullable()->comment('Error message');
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at');
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
        Schema::dropIfExists('measurement_exports');
    }
}
