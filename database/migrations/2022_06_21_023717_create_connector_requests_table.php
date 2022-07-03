<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateConnectorRequestsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('connector_requests', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('connector_id')->index('connector_requests_connectors_id_fk');
            $table->unsignedBigInteger('user_id')->index('connector_requests_wp_users_ID_fk');
            $table->unsignedInteger('connection_id')->nullable()->index('connector_requests_connections_id_fk');
            $table->unsignedInteger('connector_import_id')->index('connector_requests_connector_imports_id_fk');
            $table->string('method', 10);
            $table->integer('code');
            $table->string('uri', 2083);
            $table->mediumText('response_body')->nullable();
            $table->text('request_body')->nullable();
            $table->text('request_headers');
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at');
            $table->softDeletes();
            $table->string('content_type', 100)->nullable();
            $table->timestamp('imported_data_from_at')->nullable()->comment('Earliest data that we\'ve requested from this data source ');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('connector_requests');
    }
}
