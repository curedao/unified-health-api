<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMeasurementImportsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('measurement_imports', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedBigInteger('user_id')->index('measurement_imports_user_id_fk');
            $table->string('file');
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at');
            $table->string('status', 25)->default('WAITING');
            $table->text('error_message');
            $table->string('source_name', 80)->nullable()->comment('Name of the application or device');
            $table->softDeletes();
            $table->string('client_id')->nullable()->index('measurement_imports_client_id_fk');
            $table->timestamp('import_started_at')->nullable();
            $table->timestamp('import_ended_at')->nullable();
            $table->string('reason_for_import')->nullable();
            $table->string('user_error_message')->nullable();
            $table->string('internal_error_message')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('measurement_imports');
    }
}
