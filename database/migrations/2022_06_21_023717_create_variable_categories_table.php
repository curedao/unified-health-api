<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateVariableCategoriesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('variable_categories', function (Blueprint $table) {
            $table->tinyIncrements('id');
            $table->string('name', 64)->comment('Name of the category');
            $table->double('filling_value')->nullable()->comment('Value for replacing null measurements');
            $table->double('maximum_allowed_value')->nullable()->comment('Maximum recorded value of this category');
            $table->double('minimum_allowed_value')->nullable()->comment('Minimum recorded value of this category');
            $table->unsignedInteger('duration_of_action')->default(86400)->comment('How long the effect of a measurement in this variable lasts');
            $table->unsignedInteger('onset_delay')->default(0)->comment('How long it takes for a measurement in this variable to take effect');
            $table->enum('combination_operation', ['SUM', 'MEAN'])->default('SUM')->comment('How to combine values of this variable (for instance, to see a summary of the values over a month) SUM or MEAN');
            $table->boolean('cause_only')->default(false)->comment('A value of 1 indicates that this category is generally a cause in a causal relationship.  An example of a causeOnly category would be a category such as Work which would generally not be influenced by the behaviour of the user');
            $table->boolean('outcome')->nullable();
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at');
            $table->text('image_url')->nullable()->comment('Image URL');
            $table->unsignedSmallInteger('default_unit_id')->nullable()->default(12)->index('variable_categories_default_unit_id_fk')->comment('ID of the default unit for the category');
            $table->softDeletes();
            $table->boolean('manual_tracking')->default(false)->comment('Should we include in manual tracking searches?');
            $table->integer('minimum_allowed_seconds_between_measurements')->nullable();
            $table->integer('average_seconds_between_measurements')->nullable();
            $table->integer('median_seconds_between_measurements')->nullable();
            $table->unsignedBigInteger('wp_post_id')->nullable()->index('variable_categories_wp_posts_ID_fk');
            $table->enum('filling_type', ['zero', 'none', 'interpolation', 'value'])->nullable();
            $table->unsignedInteger('number_of_outcome_population_studies')->nullable()->comment('Number of Global Population Studies for this Cause Variable Category.
                [Formula: 
                    update variable_categories
                        left join (
                            select count(id) as total, cause_variable_category_id
                            from aggregate_correlations
                            group by cause_variable_category_id
                        )
                        as grouped on variable_categories.id = grouped.cause_variable_category_id
                    set variable_categories.number_of_outcome_population_studies = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_predictor_population_studies')->nullable()->comment('Number of Global Population Studies for this Effect Variable Category.
                [Formula: 
                    update variable_categories
                        left join (
                            select count(id) as total, effect_variable_category_id
                            from aggregate_correlations
                            group by effect_variable_category_id
                        )
                        as grouped on variable_categories.id = grouped.effect_variable_category_id
                    set variable_categories.number_of_predictor_population_studies = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_outcome_case_studies')->nullable()->comment('Number of Individual Case Studies for this Cause Variable Category.
                [Formula: 
                    update variable_categories
                        left join (
                            select count(id) as total, cause_variable_category_id
                            from correlations
                            group by cause_variable_category_id
                        )
                        as grouped on variable_categories.id = grouped.cause_variable_category_id
                    set variable_categories.number_of_outcome_case_studies = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_predictor_case_studies')->nullable()->comment('Number of Individual Case Studies for this Effect Variable Category.
                [Formula: 
                    update variable_categories
                        left join (
                            select count(id) as total, effect_variable_category_id
                            from correlations
                            group by effect_variable_category_id
                        )
                        as grouped on variable_categories.id = grouped.effect_variable_category_id
                    set variable_categories.number_of_predictor_case_studies = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_measurements')->nullable()->comment('Number of Measurements for this Variable Category.
                    [Formula: update variable_categories
                        left join (
                            select count(id) as total, variable_category_id
                            from measurements
                            group by variable_category_id
                        )
                        as grouped on variable_categories.id = grouped.variable_category_id
                    set variable_categories.number_of_measurements = count(grouped.total)]');
            $table->unsignedInteger('number_of_user_variables')->nullable()->comment('Number of User Variables for this Variable Category.
                    [Formula: update variable_categories
                        left join (
                            select count(id) as total, variable_category_id
                            from user_variables
                            group by variable_category_id
                        )
                        as grouped on variable_categories.id = grouped.variable_category_id
                    set variable_categories.number_of_user_variables = count(grouped.total)]');
            $table->unsignedInteger('number_of_variables')->nullable()->comment('Number of Variables for this Variable Category.
                    [Formula: update variable_categories
                        left join (
                            select count(id) as total, variable_category_id
                            from variables
                            group by variable_category_id
                        )
                        as grouped on variable_categories.id = grouped.variable_category_id
                    set variable_categories.number_of_variables = count(grouped.total)]');
            $table->boolean('is_public')->nullable();
            $table->string('synonyms', 600)->comment('The primary name and any synonyms for it. This field should be used for non-specific searches.');
            $table->string('amazon_product_category', 100)->comment('The Amazon equivalent product category.');
            $table->boolean('boring')->nullable()->comment('If boring, the category should be hidden by default.');
            $table->boolean('effect_only')->nullable()->comment('effect_only is true if people would never be interested in the effects of most variables in the category.');
            $table->boolean('predictor')->nullable()->comment('Predictor is true if people would like to know the effects of most variables in the category.');
            $table->string('font_awesome', 100)->nullable();
            $table->string('ion_icon', 100)->nullable();
            $table->string('more_info')->nullable()->comment('More information displayed when the user is adding reminders and going through the onboarding process. ');
            $table->enum('valence', ['positive', 'negative', 'neutral'])->comment('Set the valence positive if more is better for all the variables in the category, negative if more is bad, and neutral if none of the variables have such a valence. Valence is null if there is not a consistent valence for all variables in the category. ');
            $table->string('name_singular')->comment('The singular version of the name.');
            $table->integer('sort_order');
            $table->string('slug', 200)->nullable()->unique('variable_categories_slug_uindex')->comment('The slug is the part of a URL that identifies a page in human-readable keywords.');
            $table->enum('is_goal', ['ALWAYS', 'SOMETIMES', 'NEVER'])->comment('The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  The foods you eat are not generally an objective end in themselves. ');
            $table->enum('controllable', ['ALWAYS', 'SOMETIMES', 'NEVER'])->comment('The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  Symptom severity is not directly controllable. ');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('variable_categories');
    }
}
