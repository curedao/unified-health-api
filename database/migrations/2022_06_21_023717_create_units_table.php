<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUnitsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('units', function (Blueprint $table) {
            $table->smallIncrements('id');
            $table->string('name', 64)->unique('name_UNIQUE')->comment('Unit name');
            $table->string('abbreviated_name', 16)->unique('abbr_name_UNIQUE')->comment('Unit abbreviation');
            $table->unsignedTinyInteger('unit_category_id')->index('fk_unitCategory')->comment('Unit category ID');
            $table->double('minimum_value')->nullable()->comment('The minimum value for a single measurement. ');
            $table->double('maximum_value')->nullable()->comment('The maximum value for a single measurement');
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at');
            $table->softDeletes();
            $table->enum('filling_type', ['zero', 'none', 'interpolation', 'value'])->comment('The filling type specifies how periods of missing data should be treated. ');
            $table->unsignedInteger('number_of_outcome_population_studies')->nullable()->comment('Number of Global Population Studies for this Cause Unit.
                [Formula: 
                    update units
                        left join (
                            select count(id) as total, cause_unit_id
                            from aggregate_correlations
                            group by cause_unit_id
                        )
                        as grouped on units.id = grouped.cause_unit_id
                    set units.number_of_outcome_population_studies = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_common_tags_where_tag_variable_unit')->nullable()->comment('Number of Common Tags for this Tag Variable Unit.
                [Formula: 
                    update units
                        left join (
                            select count(id) as total, tag_variable_unit_id
                            from common_tags
                            group by tag_variable_unit_id
                        )
                        as grouped on units.id = grouped.tag_variable_unit_id
                    set units.number_of_common_tags_where_tag_variable_unit = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_common_tags_where_tagged_variable_unit')->nullable()->comment('Number of Common Tags for this Tagged Variable Unit.
                [Formula: 
                    update units
                        left join (
                            select count(id) as total, tagged_variable_unit_id
                            from common_tags
                            group by tagged_variable_unit_id
                        )
                        as grouped on units.id = grouped.tagged_variable_unit_id
                    set units.number_of_common_tags_where_tagged_variable_unit = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_outcome_case_studies')->nullable()->comment('Number of Individual Case Studies for this Cause Unit.
                [Formula: 
                    update units
                        left join (
                            select count(id) as total, cause_unit_id
                            from correlations
                            group by cause_unit_id
                        )
                        as grouped on units.id = grouped.cause_unit_id
                    set units.number_of_outcome_case_studies = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_measurements')->nullable()->comment('Number of Measurements for this Unit.
                    [Formula: update units
                        left join (
                            select count(id) as total, unit_id
                            from measurements
                            group by unit_id
                        )
                        as grouped on units.id = grouped.unit_id
                    set units.number_of_measurements = count(grouped.total)]');
            $table->unsignedInteger('number_of_user_variables_where_default_unit')->nullable()->comment('Number of User Variables for this Default Unit.
                    [Formula: update units
                        left join (
                            select count(id) as total, default_unit_id
                            from user_variables
                            group by default_unit_id
                        )
                        as grouped on units.id = grouped.default_unit_id
                    set units.number_of_user_variables_where_default_unit = count(grouped.total)]');
            $table->unsignedInteger('number_of_variable_categories_where_default_unit')->nullable()->comment('Number of Variable Categories for this Default Unit.
                    [Formula: update units
                        left join (
                            select count(id) as total, default_unit_id
                            from variable_categories
                            group by default_unit_id
                        )
                        as grouped on units.id = grouped.default_unit_id
                    set units.number_of_variable_categories_where_default_unit = count(grouped.total)]');
            $table->unsignedInteger('number_of_variables_where_default_unit')->nullable()->comment('Number of Variables for this Default Unit.
                    [Formula: update units
                        left join (
                            select count(id) as total, default_unit_id
                            from variables
                            group by default_unit_id
                        )
                        as grouped on units.id = grouped.default_unit_id
                    set units.number_of_variables_where_default_unit = count(grouped.total)]');
            $table->boolean('advanced')->comment('Advanced units are rarely used and should generally be hidden or at the bottom of selector lists');
            $table->boolean('manual_tracking')->comment('Include manual tracking units in selector when manually recording a measurement. ');
            $table->float('filling_value', 10, 0)->nullable()->comment('The filling value is substituted used when data is missing if the filling type is set to value.');
            $table->enum('scale', ['nominal', 'interval', 'ratio', 'ordinal'])->comment('
Ordinal is used to simply depict the order of variables and not the difference between each of the variables. Ordinal scales are generally used to depict non-mathematical ideas such as frequency, satisfaction, happiness, a degree of pain etc.

Ratio Scale not only produces the order of variables but also makes the difference between variables known along with information on the value of true zero.

Interval scale contains all the properties of ordinal scale, in addition to which, it offers a calculation of the difference between variables. The main characteristic of this scale is the equidistant difference between objects. Interval has no pre-decided starting point or a true zero value.

Nominal, also called the categorical variable scale, is defined as a scale used for labeling variables into distinct classifications and doesn’t involve a quantitative value or order.
');
            $table->text('conversion_steps')->nullable()->comment('An array of mathematical operations, each containing a operation and value field to apply to the value in the current unit to convert it to the default unit for the unit category. ');
            $table->double('maximum_daily_value')->nullable()->comment('The maximum aggregated measurement value over a single day.');
            $table->integer('sort_order');
            $table->string('slug', 200)->nullable()->unique('units_slug_uindex')->comment('The slug is the part of a URL that identifies a page in human-readable keywords.');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('units');
    }
}
