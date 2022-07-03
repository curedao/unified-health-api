<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateConnectorsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('connectors', function (Blueprint $table) {
            $table->increments('id')->comment('Connector ID number');
            $table->string('name', 30)->comment('Lowercase system name for the data source');
            $table->string('display_name', 30)->comment('Pretty display name for the data source');
            $table->string('image', 2083)->comment('URL to the image of the connector logo');
            $table->string('get_it_url', 2083)->nullable()->comment('URL to a site where one can get this device or application');
            $table->text('short_description')->comment('Short description of the service (such as the categories it tracks)');
            $table->longText('long_description')->comment('Longer paragraph description of the data provider');
            $table->boolean('enabled')->default(true)->comment('Set to 1 if the connector should be returned when listing connectors');
            $table->boolean('oauth')->default(false)->comment('Set to 1 if the connector uses OAuth authentication as opposed to username/password');
            $table->boolean('qm_client')->nullable()->default(false)->comment('Whether its a connector or one of our clients');
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at');
            $table->string('client_id', 80)->nullable()->index('connectors_client_id_fk');
            $table->softDeletes();
            $table->unsignedBigInteger('wp_post_id')->nullable()->index('connectors_wp_posts_ID_fk');
            $table->unsignedInteger('number_of_connections')->nullable()->comment('Number of Connections for this Connector.
                [Formula: 
                    update connectors
                        left join (
                            select count(id) as total, connector_id
                            from connections
                            group by connector_id
                        )
                        as grouped on connectors.id = grouped.connector_id
                    set connectors.number_of_connections = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_connector_imports')->nullable()->comment('Number of Connector Imports for this Connector.
                [Formula: 
                    update connectors
                        left join (
                            select count(id) as total, connector_id
                            from connector_imports
                            group by connector_id
                        )
                        as grouped on connectors.id = grouped.connector_id
                    set connectors.number_of_connector_imports = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_connector_requests')->nullable()->comment('Number of Connector Requests for this Connector.
                [Formula: 
                    update connectors
                        left join (
                            select count(id) as total, connector_id
                            from connector_requests
                            group by connector_id
                        )
                        as grouped on connectors.id = grouped.connector_id
                    set connectors.number_of_connector_requests = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_measurements')->nullable()->comment('Number of Measurements for this Connector.
                    [Formula: update connectors
                        left join (
                            select count(id) as total, connector_id
                            from measurements
                            group by connector_id
                        )
                        as grouped on connectors.id = grouped.connector_id
                    set connectors.number_of_measurements = count(grouped.total)]');
            $table->boolean('is_public')->nullable();
            $table->integer('sort_order');
            $table->string('slug', 200)->nullable()->unique('connectors_slug_uindex')->comment('The slug is the part of a URL that identifies a page in human-readable keywords.');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('connectors');
    }
}
