<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateSpreadsheetImportersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('spreadsheet_importers', function (Blueprint $table) {
            $table->increments('id')->comment('Spreadsheet Importer ID number');
            $table->string('name', 30)->comment('Lowercase system name for the data source');
            $table->string('display_name', 30)->comment('Pretty display name for the data source');
            $table->string('image', 2083)->comment('URL to the image of the Spreadsheet Importer logo');
            $table->string('get_it_url', 2083)->nullable()->comment('URL to a site where one can get this device or application');
            $table->text('short_description')->comment('Short description of the service (such as the categories it tracks)');
            $table->longText('long_description')->comment('Longer paragraph description of the data provider');
            $table->boolean('enabled')->default(true)->comment('Set to 1 if the Spreadsheet Importer should be returned when listing Spreadsheet Importers');
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at');
            $table->string('client_id', 80)->nullable()->index('spreadsheet_importers_client_id_fk');
            $table->softDeletes();
            $table->unsignedBigInteger('wp_post_id')->nullable()->index('spreadsheet_importers_wp_posts_ID_fk');
            $table->unsignedInteger('number_of_measurement_imports')->nullable()->comment('Number of Spreadsheet Import Requests for this Spreadsheet Importer.
                            [Formula:
                                update spreadsheet_importers
                                    left join (
                                        select count(id) as total, spreadsheet_importer_id
                                        from spreadsheet_importer_requests
                                        group by spreadsheet_importer_id
                                    )
                                    as grouped on spreadsheet_importers.id = grouped.spreadsheet_importer_id
                                set spreadsheet_importers.number_of_spreadsheet_importer_requests = count(grouped.total)
                            ]
                            ');
            $table->unsignedInteger('number_of_measurements')->nullable()->comment('Number of Measurements for this Spreadsheet Importer.
                                [Formula: update spreadsheet_importers
                                    left join (
                                        select count(id) as total, spreadsheet_importer_id
                                        from measurements
                                        group by spreadsheet_importer_id
                                    )
                                    as grouped on spreadsheet_importers.id = grouped.spreadsheet_importer_id
                                set spreadsheet_importers.number_of_measurements = count(grouped.total)]');
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
        Schema::dropIfExists('spreadsheet_importers');
    }
}
