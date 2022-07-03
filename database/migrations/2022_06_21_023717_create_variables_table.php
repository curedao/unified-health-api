<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateVariablesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('variables', function (Blueprint $table) {
            $table->increments('id');
            $table->string('name', 125)->unique('name_UNIQUE')->comment('User-defined variable display name');
            $table->integer('number_of_user_variables')->default(0)->comment('Number of variables');
            $table->unsignedTinyInteger('variable_category_id')->comment('Variable category ID');
            $table->unsignedSmallInteger('default_unit_id')->index('fk_variableDefaultUnit')->comment('ID of the default unit for the variable');
            $table->double('default_value')->nullable();
            $table->boolean('cause_only')->nullable()->comment('A value of 1 indicates that this variable is generally a cause in a causal relationship.  An example of a causeOnly variable would be a variable such as Cloud Cover which would generally not be influenced by the behaviour of the user');
            $table->string('client_id', 80)->nullable()->index('variables_client_id_fk');
            $table->enum('combination_operation', ['SUM', 'MEAN'])->nullable()->comment('How to combine values of this variable (for instance, to see a summary of the values over a month) SUM or MEAN');
            $table->string('common_alias', 125)->nullable();
            $table->timestamp('created_at')->useCurrent();
            $table->text('description')->nullable();
            $table->unsignedInteger('duration_of_action')->nullable()->comment('How long the effect of a measurement in this variable lasts');
            $table->double('filling_value')->nullable()->default(-1)->comment('Value for replacing null measurements');
            $table->string('image_url', 2083)->nullable();
            $table->string('informational_url', 2083)->nullable();
            $table->string('ion_icon', 40)->nullable();
            $table->double('kurtosis')->nullable()->comment('Kurtosis');
            $table->double('maximum_allowed_value')->nullable()->comment('Maximum reasonable value for a single measurement for this variable in the default unit. ');
            $table->double('maximum_recorded_value')->nullable()->comment('Maximum recorded value of this variable');
            $table->double('mean')->nullable()->comment('Mean');
            $table->double('median')->nullable()->comment('Median');
            $table->double('minimum_allowed_value')->nullable()->comment('Minimum reasonable value for this variable (uses default unit)');
            $table->double('minimum_recorded_value')->nullable()->comment('Minimum recorded value of this variable');
            $table->unsignedInteger('number_of_aggregate_correlations_as_cause')->nullable()->comment('Number of aggregate correlations for which this variable is the cause variable');
            $table->integer('most_common_original_unit_id')->nullable()->comment('Most common Unit ID');
            $table->double('most_common_value')->nullable()->comment('Most common value');
            $table->unsignedInteger('number_of_aggregate_correlations_as_effect')->nullable()->comment('Number of aggregate correlations for which this variable is the effect variable');
            $table->integer('number_of_unique_values')->nullable()->comment('Number of unique values');
            $table->unsignedInteger('onset_delay')->nullable()->comment('How long it takes for a measurement in this variable to take effect');
            $table->boolean('outcome')->nullable()->comment('Outcome variables (those with `outcome` == 1) are variables for which a human would generally want to identify the influencing factors.  These include symptoms of illness, physique, mood, cognitive performance, etc.  Generally correlation calculations are only performed on outcome variables.');
            $table->unsignedInteger('parent_id')->nullable()->comment('ID of the parent variable if this variable has any parent');
            $table->double('price')->nullable()->comment('Price');
            $table->string('product_url', 2083)->nullable()->comment('Product URL');
            $table->double('second_most_common_value')->nullable();
            $table->double('skewness')->nullable()->comment('Skewness');
            $table->double('standard_deviation')->nullable()->comment('Standard Deviation');
            $table->string('status', 25)->default('WAITING')->comment('status');
            $table->double('third_most_common_value')->nullable();
            $table->timestamp('updated_at');
            $table->double('variance')->nullable()->comment('Variance');
            $table->unsignedInteger('most_common_connector_id')->nullable();
            $table->string('synonyms', 600)->nullable()->comment('The primary variable name and any synonyms for it. This field should be used for non-specific variable searches.');
            $table->string('wikipedia_url', 2083)->nullable();
            $table->string('brand_name', 125)->nullable();
            $table->enum('valence', ['positive', 'negative', 'neutral'])->nullable();
            $table->string('wikipedia_title', 100)->nullable();
            $table->integer('number_of_tracking_reminders')->nullable();
            $table->string('upc_12')->nullable();
            $table->string('upc_14')->nullable();
            $table->unsignedInteger('number_common_tagged_by')->nullable();
            $table->unsignedInteger('number_of_common_tags')->nullable();
            $table->softDeletes();
            $table->string('most_common_source_name')->nullable();
            $table->text('data_sources_count')->nullable()->comment('Array of connector or client measurement data source names as key with number of users as value');
            $table->string('optimal_value_message', 500)->nullable();
            $table->unsignedInteger('best_cause_variable_id')->nullable()->index('variables_best_cause_variable_id_fk');
            $table->unsignedInteger('best_effect_variable_id')->nullable()->index('variables_best_effect_variable_id_fk');
            $table->double('common_maximum_allowed_daily_value')->nullable();
            $table->double('common_minimum_allowed_daily_value')->nullable();
            $table->double('common_minimum_allowed_non_zero_value')->nullable();
            $table->integer('minimum_allowed_seconds_between_measurements')->nullable();
            $table->integer('average_seconds_between_measurements')->nullable();
            $table->integer('median_seconds_between_measurements')->nullable();
            $table->unsignedInteger('number_of_raw_measurements_with_tags_joins_children')->nullable();
            $table->text('additional_meta_data')->nullable();
            $table->boolean('manual_tracking')->nullable();
            $table->timestamp('analysis_settings_modified_at')->nullable();
            $table->timestamp('newest_data_at')->nullable();
            $table->timestamp('analysis_requested_at')->nullable();
            $table->string('reason_for_analysis')->nullable();
            $table->timestamp('analysis_started_at')->nullable();
            $table->timestamp('analysis_ended_at')->nullable()->index();
            $table->text('user_error_message')->nullable();
            $table->text('internal_error_message')->nullable();
            $table->timestamp('latest_tagged_measurement_start_at')->nullable();
            $table->timestamp('earliest_tagged_measurement_start_at')->nullable();
            $table->timestamp('latest_non_tagged_measurement_start_at')->nullable();
            $table->timestamp('earliest_non_tagged_measurement_start_at')->nullable();
            $table->unsignedBigInteger('wp_post_id')->nullable()->index('variables_wp_posts_ID_fk');
            $table->integer('number_of_soft_deleted_measurements')->nullable()->comment('Formula: update variables v 
                inner join (
                    select measurements.variable_id, count(measurements.id) as number_of_soft_deleted_measurements 
                    from measurements
                    where measurements.deleted_at is not null
                    group by measurements.variable_id
                    ) m on v.id = m.variable_id
                set v.number_of_soft_deleted_measurements = m.number_of_soft_deleted_measurements
            ');
            $table->json('charts')->nullable();
            $table->unsignedBigInteger('creator_user_id');
            $table->integer('best_aggregate_correlation_id')->nullable()->index('variables_aggregate_correlations_id_fk');
            $table->enum('filling_type', ['zero', 'none', 'interpolation', 'value'])->nullable();
            $table->unsignedInteger('number_of_outcome_population_studies')->nullable()->comment('Number of Global Population Studies for this Cause Variable.
                [Formula: 
                    update variables
                        left join (
                            select count(id) as total, cause_variable_id
                            from aggregate_correlations
                            group by cause_variable_id
                        )
                        as grouped on variables.id = grouped.cause_variable_id
                    set variables.number_of_outcome_population_studies = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_predictor_population_studies')->nullable()->comment('Number of Global Population Studies for this Effect Variable.
                [Formula: 
                    update variables
                        left join (
                            select count(id) as total, effect_variable_id
                            from aggregate_correlations
                            group by effect_variable_id
                        )
                        as grouped on variables.id = grouped.effect_variable_id
                    set variables.number_of_predictor_population_studies = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_applications_where_outcome_variable')->nullable()->comment('Number of Applications for this Outcome Variable.
                [Formula: 
                    update variables
                        left join (
                            select count(id) as total, outcome_variable_id
                            from applications
                            group by outcome_variable_id
                        )
                        as grouped on variables.id = grouped.outcome_variable_id
                    set variables.number_of_applications_where_outcome_variable = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_applications_where_predictor_variable')->nullable()->comment('Number of Applications for this Predictor Variable.
                [Formula: 
                    update variables
                        left join (
                            select count(id) as total, predictor_variable_id
                            from applications
                            group by predictor_variable_id
                        )
                        as grouped on variables.id = grouped.predictor_variable_id
                    set variables.number_of_applications_where_predictor_variable = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_common_tags_where_tag_variable')->nullable()->comment('Number of Common Tags for this Tag Variable.
                [Formula: 
                    update variables
                        left join (
                            select count(id) as total, tag_variable_id
                            from common_tags
                            group by tag_variable_id
                        )
                        as grouped on variables.id = grouped.tag_variable_id
                    set variables.number_of_common_tags_where_tag_variable = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_common_tags_where_tagged_variable')->nullable()->comment('Number of Common Tags for this Tagged Variable.
                [Formula: 
                    update variables
                        left join (
                            select count(id) as total, tagged_variable_id
                            from common_tags
                            group by tagged_variable_id
                        )
                        as grouped on variables.id = grouped.tagged_variable_id
                    set variables.number_of_common_tags_where_tagged_variable = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_outcome_case_studies')->nullable()->comment('Number of Individual Case Studies for this Cause Variable.
                [Formula: 
                    update variables
                        left join (
                            select count(id) as total, cause_variable_id
                            from correlations
                            group by cause_variable_id
                        )
                        as grouped on variables.id = grouped.cause_variable_id
                    set variables.number_of_outcome_case_studies = count(grouped.total)
                ]
                ');
            $table->unsignedInteger('number_of_measurements')->nullable()->comment('Number of Measurements for this Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, variable_id
                            from measurements
                            group by variable_id
                        )
                        as grouped on variables.id = grouped.variable_id
                    set variables.number_of_measurements = count(grouped.total)]');
            $table->unsignedInteger('number_of_predictor_case_studies')->nullable()->comment('Number of Individual Case Studies for this Effect Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, effect_variable_id
                            from correlations
                            group by effect_variable_id
                        )
                        as grouped on variables.id = grouped.effect_variable_id
                    set variables.number_of_predictor_case_studies = count(grouped.total)]');
            $table->unsignedInteger('number_of_studies_where_cause_variable')->nullable()->comment('Number of Studies for this Cause Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, cause_variable_id
                            from studies
                            group by cause_variable_id
                        )
                        as grouped on variables.id = grouped.cause_variable_id
                    set variables.number_of_studies_where_cause_variable = count(grouped.total)]');
            $table->unsignedInteger('number_of_studies_where_effect_variable')->nullable()->comment('Number of Studies for this Effect Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, effect_variable_id
                            from studies
                            group by effect_variable_id
                        )
                        as grouped on variables.id = grouped.effect_variable_id
                    set variables.number_of_studies_where_effect_variable = count(grouped.total)]');
            $table->unsignedInteger('number_of_tracking_reminder_notifications')->nullable()->comment('Number of Tracking Reminder Notifications for this Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, variable_id
                            from tracking_reminder_notifications
                            group by variable_id
                        )
                        as grouped on variables.id = grouped.variable_id
                    set variables.number_of_tracking_reminder_notifications = count(grouped.total)]');
            $table->unsignedInteger('number_of_user_tags_where_tag_variable')->nullable()->comment('Number of User Tags for this Tag Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, tag_variable_id
                            from user_tags
                            group by tag_variable_id
                        )
                        as grouped on variables.id = grouped.tag_variable_id
                    set variables.number_of_user_tags_where_tag_variable = count(grouped.total)]');
            $table->unsignedInteger('number_of_user_tags_where_tagged_variable')->nullable()->comment('Number of User Tags for this Tagged Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, tagged_variable_id
                            from user_tags
                            group by tagged_variable_id
                        )
                        as grouped on variables.id = grouped.tagged_variable_id
                    set variables.number_of_user_tags_where_tagged_variable = count(grouped.total)]');
            $table->unsignedInteger('number_of_variables_where_best_cause_variable')->nullable()->comment('Number of Variables for this Best Cause Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, best_cause_variable_id
                            from variables
                            group by best_cause_variable_id
                        )
                        as grouped on variables.id = grouped.best_cause_variable_id
                    set variables.number_of_variables_where_best_cause_variable = count(grouped.total)]');
            $table->unsignedInteger('number_of_variables_where_best_effect_variable')->nullable()->comment('Number of Variables for this Best Effect Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, best_effect_variable_id
                            from variables
                            group by best_effect_variable_id
                        )
                        as grouped on variables.id = grouped.best_effect_variable_id
                    set variables.number_of_variables_where_best_effect_variable = count(grouped.total)]');
            $table->unsignedInteger('number_of_votes_where_cause_variable')->nullable()->comment('Number of Votes for this Cause Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, cause_variable_id
                            from votes
                            group by cause_variable_id
                        )
                        as grouped on variables.id = grouped.cause_variable_id
                    set variables.number_of_votes_where_cause_variable = count(grouped.total)]');
            $table->unsignedInteger('number_of_votes_where_effect_variable')->nullable()->comment('Number of Votes for this Effect Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, effect_variable_id
                            from votes
                            group by effect_variable_id
                        )
                        as grouped on variables.id = grouped.effect_variable_id
                    set variables.number_of_votes_where_effect_variable = count(grouped.total)]');
            $table->unsignedInteger('number_of_users_where_primary_outcome_variable')->nullable()->comment('Number of Users for this Primary Outcome Variable.
                    [Formula: update variables
                        left join (
                            select count(ID) as total, primary_outcome_variable_id
                            from wp_users
                            group by primary_outcome_variable_id
                        )
                        as grouped on variables.id = grouped.primary_outcome_variable_id
                    set variables.number_of_users_where_primary_outcome_variable = count(grouped.total)]');
            $table->string('deletion_reason', 280)->nullable()->comment('The reason the variable was deleted.');
            $table->double('maximum_allowed_daily_value')->nullable()->comment('The maximum allowed value in the default unit for measurements aggregated over a single day. ');
            $table->integer('record_size_in_kb')->nullable();
            $table->integer('number_of_common_joined_variables')->nullable()->comment('Joined variables are duplicate variables measuring the same thing. ');
            $table->integer('number_of_common_ingredients')->nullable()->comment('Measurements for this variable can be used to synthetically generate ingredient measurements. ');
            $table->integer('number_of_common_foods')->nullable()->comment('Measurements for this ingredient variable can be synthetically generate by food measurements. ');
            $table->integer('number_of_common_children')->nullable()->comment('Measurements for this parent category variable can be synthetically generated by measurements from its child variables. ');
            $table->integer('number_of_common_parents')->nullable()->comment('Measurements for this parent category variable can be synthetically generated by measurements from its child variables. ');
            $table->integer('number_of_user_joined_variables')->nullable()->comment('Joined variables are duplicate variables measuring the same thing. This only includes ones created by users. ');
            $table->integer('number_of_user_ingredients')->nullable()->comment('Measurements for this variable can be used to synthetically generate ingredient measurements. This only includes ones created by users. ');
            $table->integer('number_of_user_foods')->nullable()->comment('Measurements for this ingredient variable can be synthetically generate by food measurements. This only includes ones created by users. ');
            $table->integer('number_of_user_children')->nullable()->comment('Measurements for this parent category variable can be synthetically generated by measurements from its child variables. This only includes ones created by users. ');
            $table->integer('number_of_user_parents')->nullable()->comment('Measurements for this parent category variable can be synthetically generated by measurements from its child variables. This only includes ones created by users. ');
            $table->boolean('is_public')->nullable();
            $table->integer('sort_order');
            $table->string('slug', 200)->nullable()->unique('variables_slug_uindex')->comment('The slug is the part of a URL that identifies a page in human-readable keywords.');
            $table->boolean('is_goal')->nullable()->comment('The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  The foods you eat are not generally an objective end in themselves. ');
            $table->boolean('controllable')->nullable()->comment('You can control the foods you eat directly. However, symptom severity or weather is not directly controllable. ');
            $table->boolean('boring')->nullable()->comment('The variable is boring if the average person would not be interested in its causes or effects. ');
            $table->unsignedInteger('canonical_variable_id')->nullable()->comment('If a variable duplicates another but with a different name, set the canonical variable id to match the variable with the more appropriate name.  Then only the canonical variable will be displayed and all data for the duplicate variable will be included when fetching data for the canonical variable. ');
            $table->boolean('predictor')->nullable()->comment('predictor is true if the variable is a factor that could influence an outcome of interest');
            $table->string('source_url', 2083)->nullable()->comment('URL for the website related to the database containing the info that was used to create this variable such as https://world.openfoodfacts.org or https://dsld.od.nih.gov/dsld ');

            $table->index(['variable_category_id', 'default_unit_id', 'name', 'number_of_user_variables', 'id'], 'IDX_cat_unit_public_name');
            $table->index(['name', 'number_of_user_variables'], 'variables_public_name_number_of_user_variables_index');
            $table->index(['deleted_at', 'synonyms', 'number_of_user_variables'], 'public_deleted_at_synonyms_number_of_user_variables_index');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('variables');
    }
}
