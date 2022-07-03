<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUserVariablesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('user_variables', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('parent_id')->nullable()->comment('ID of the parent variable if this variable has any parent');
            $table->string('client_id', 80)->nullable()->index('user_variables_client_id_fk');
            $table->unsignedBigInteger('user_id')->index('user_variables_user_id_latest_tagged_measurement_time_index');
            $table->unsignedInteger('variable_id')->index('fk_variableSettings')->comment('ID of variable');
            $table->unsignedSmallInteger('default_unit_id')->nullable()->index('user_variables_default_unit_id_fk')->comment('ID of unit to use for this variable');
            $table->double('minimum_allowed_value')->nullable()->comment('Minimum reasonable value for this variable (uses default unit)');
            $table->double('maximum_allowed_value')->nullable()->comment('Maximum reasonable value for this variable (uses default unit)');
            $table->double('filling_value')->nullable()->default(-1)->comment('Value for replacing null measurements');
            $table->unsignedInteger('join_with')->nullable()->comment('The Variable this Variable should be joined with. If the variable is joined with some other variable then it is not shown to user in the list of variables');
            $table->unsignedInteger('onset_delay')->nullable()->comment('How long it takes for a measurement in this variable to take effect');
            $table->unsignedInteger('duration_of_action')->nullable()->comment('Estimated duration of time following the onset delay in which a stimulus produces a perceivable effect');
            $table->unsignedTinyInteger('variable_category_id')->nullable()->index('user_variables_variable_category_id_fk')->comment('ID of variable category');
            $table->boolean('cause_only')->nullable()->comment('A value of 1 indicates that this variable is generally a cause in a causal relationship.  An example of a causeOnly variable would be a variable such as Cloud Cover which would generally not be influenced by the behaviour of the user');
            $table->enum('filling_type', ['value', 'none'])->nullable()->comment('0 -> No filling, 1 -> Use filling-value');
            $table->integer('number_of_processed_daily_measurements')->nullable()->comment('Number of processed measurements');
            $table->unsignedInteger('measurements_at_last_analysis')->default(0)->comment('Number of measurements at last analysis');
            $table->unsignedSmallInteger('last_unit_id')->nullable()->index('user_variables_last_unit_id_fk')->comment('ID of last Unit');
            $table->unsignedSmallInteger('last_original_unit_id')->nullable()->comment('ID of last original Unit');
            $table->double('last_value')->nullable()->comment('Last Value');
            $table->double('last_original_value')->unsigned()->nullable()->comment('Last original value which is stored');
            $table->integer('number_of_correlations')->nullable()->comment('Number of correlations for this variable');
            $table->string('status', 25)->nullable();
            $table->double('standard_deviation')->nullable()->comment('Standard deviation');
            $table->double('variance')->nullable()->comment('Variance');
            $table->double('minimum_recorded_value')->nullable()->comment('Minimum recorded value of this variable');
            $table->double('maximum_recorded_value')->nullable()->comment('Maximum recorded value of this variable');
            $table->double('mean')->nullable()->comment('Mean');
            $table->double('median')->nullable()->comment('Median');
            $table->integer('most_common_original_unit_id')->nullable()->comment('Most common Unit ID');
            $table->double('most_common_value')->nullable()->comment('Most common value');
            $table->integer('number_of_unique_daily_values')->nullable()->comment('Number of unique daily values');
            $table->integer('number_of_unique_values')->nullable()->comment('Number of unique values');
            $table->integer('number_of_changes')->nullable()->comment('Number of changes');
            $table->double('skewness')->nullable()->comment('Skewness');
            $table->double('kurtosis')->nullable()->comment('Kurtosis');
            $table->double('latitude')->nullable();
            $table->double('longitude')->nullable();
            $table->string('location')->nullable();
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at');
            $table->boolean('outcome')->nullable()->comment('Outcome variables (those with `outcome` == 1) are variables for which a human would generally want to identify the influencing factors.  These include symptoms of illness, physique, mood, cognitive performance, etc.  Generally correlation calculations are only performed on outcome variables');
            $table->text('data_sources_count')->nullable()->comment('Array of connector or client measurement data source names as key and number of measurements as value');
            $table->integer('earliest_filling_time')->nullable()->comment('Earliest filling time');
            $table->integer('latest_filling_time')->nullable()->comment('Latest filling time');
            $table->double('last_processed_daily_value')->nullable()->comment('Last value for user after daily aggregation and filling');
            $table->boolean('outcome_of_interest')->nullable()->default(false);
            $table->boolean('predictor_of_interest')->nullable()->default(false);
            $table->timestamp('experiment_start_time')->nullable();
            $table->timestamp('experiment_end_time')->nullable();
            $table->text('description')->nullable();
            $table->softDeletes();
            $table->string('alias', 125)->nullable();
            $table->double('second_to_last_value')->nullable();
            $table->double('third_to_last_value')->nullable();
            $table->unsignedInteger('number_of_user_correlations_as_effect')->nullable()->comment('Number of user correlations for which this variable is the effect variable');
            $table->unsignedInteger('number_of_user_correlations_as_cause')->nullable()->comment('Number of user correlations for which this variable is the cause variable');
            $table->enum('combination_operation', ['SUM', 'MEAN'])->nullable()->comment('How to combine values of this variable (for instance, to see a summary of the values over a month) SUM or MEAN');
            $table->string('informational_url', 2000)->nullable()->comment('Wikipedia url');
            $table->unsignedInteger('most_common_connector_id')->nullable();
            $table->enum('valence', ['positive', 'negative', 'neutral'])->nullable();
            $table->string('wikipedia_title', 100)->nullable();
            $table->integer('number_of_tracking_reminders');
            $table->unsignedInteger('number_of_raw_measurements_with_tags_joins_children')->nullable();
            $table->string('most_common_source_name')->nullable();
            $table->string('optimal_value_message', 500)->nullable();
            $table->integer('best_cause_variable_id')->nullable();
            $table->integer('best_effect_variable_id')->nullable();
            $table->double('user_maximum_allowed_daily_value')->nullable();
            $table->double('user_minimum_allowed_daily_value')->nullable();
            $table->double('user_minimum_allowed_non_zero_value')->nullable();
            $table->integer('minimum_allowed_seconds_between_measurements')->nullable();
            $table->integer('average_seconds_between_measurements')->nullable();
            $table->integer('median_seconds_between_measurements')->nullable();
            $table->timestamp('last_correlated_at')->nullable();
            $table->integer('number_of_measurements_with_tags_at_last_correlation')->nullable();
            $table->timestamp('analysis_settings_modified_at')->nullable();
            $table->timestamp('newest_data_at')->nullable();
            $table->timestamp('analysis_requested_at')->nullable();
            $table->string('reason_for_analysis')->nullable();
            $table->timestamp('analysis_started_at')->nullable()->index();
            $table->timestamp('analysis_ended_at')->nullable()->index('variables_analysis_ended_at_index');
            $table->text('user_error_message')->nullable();
            $table->text('internal_error_message')->nullable();
            $table->timestamp('earliest_source_measurement_start_at')->nullable();
            $table->timestamp('latest_source_measurement_start_at')->nullable();
            $table->timestamp('latest_tagged_measurement_start_at')->nullable();
            $table->timestamp('earliest_tagged_measurement_start_at')->nullable();
            $table->timestamp('latest_non_tagged_measurement_start_at')->nullable();
            $table->timestamp('earliest_non_tagged_measurement_start_at')->nullable();
            $table->unsignedBigInteger('wp_post_id')->nullable()->index('user_variables_wp_posts_ID_fk');
            $table->integer('number_of_soft_deleted_measurements')->nullable()->comment('Formula: update user_variables v 
                inner join (
                    select measurements.user_variable_id, count(measurements.id) as number_of_soft_deleted_measurements 
                    from measurements
                    where measurements.deleted_at is not null
                    group by measurements.user_variable_id
                    ) m on v.id = m.user_variable_id
                set v.number_of_soft_deleted_measurements = m.number_of_soft_deleted_measurements
            ');
            $table->integer('best_user_correlation_id')->nullable()->index('user_variables_correlations_qm_score_fk');
            $table->unsignedInteger('number_of_measurements')->nullable()->comment('Number of Measurements for this User Variable.
                    [Formula: update user_variables
                        left join (
                            select count(id) as total, user_variable_id
                            from measurements
                            group by user_variable_id
                        )
                        as grouped on user_variables.id = grouped.user_variable_id
                    set user_variables.number_of_measurements = count(grouped.total)]');
            $table->unsignedInteger('number_of_tracking_reminder_notifications')->nullable()->comment('Number of Tracking Reminder Notifications for this User Variable.
                    [Formula: update user_variables
                        left join (
                            select count(id) as total, user_variable_id
                            from tracking_reminder_notifications
                            group by user_variable_id
                        )
                        as grouped on user_variables.id = grouped.user_variable_id
                    set user_variables.number_of_tracking_reminder_notifications = count(grouped.total)]');
            $table->string('deletion_reason', 280)->nullable()->comment('The reason the variable was deleted.');
            $table->integer('record_size_in_kb')->nullable();
            $table->integer('number_of_common_tags')->nullable()->comment('Number of categories, joined variables, or ingredients for this variable that use this variables measurements to generate synthetically derived measurements. ');
            $table->integer('number_common_tagged_by')->nullable()->comment('Number of children, joined variables or foods that this use has measurements for which are to be used to generate synthetic measurements for this variable. ');
            $table->integer('number_of_common_joined_variables')->nullable()->comment('Joined variables are duplicate variables measuring the same thing. ');
            $table->integer('number_of_common_ingredients')->nullable()->comment('Measurements for this variable can be used to synthetically generate ingredient measurements. ');
            $table->integer('number_of_common_foods')->nullable()->comment('Measurements for this ingredient variable can be synthetically generate by food measurements. ');
            $table->integer('number_of_common_children')->nullable()->comment('Measurements for this parent category variable can be synthetically generated by measurements from its child variables. ');
            $table->integer('number_of_common_parents')->nullable()->comment('Measurements for this parent category variable can be synthetically generated by measurements from its child variables. ');
            $table->integer('number_of_user_tags')->nullable()->comment('Number of categories, joined variables, or ingredients for this variable that use this variables measurements to generate synthetically derived measurements. This only includes ones created by the user. ');
            $table->integer('number_user_tagged_by')->nullable()->comment('Number of children, joined variables or foods that this use has measurements for which are to be used to generate synthetic measurements for this variable. This only includes ones created by the user. ');
            $table->integer('number_of_user_joined_variables')->nullable()->comment('Joined variables are duplicate variables measuring the same thing. This only includes ones created by the user. ');
            $table->integer('number_of_user_ingredients')->nullable()->comment('Measurements for this variable can be used to synthetically generate ingredient measurements. This only includes ones created by the user. ');
            $table->integer('number_of_user_foods')->nullable()->comment('Measurements for this ingredient variable can be synthetically generate by food measurements. This only includes ones created by the user. ');
            $table->integer('number_of_user_children')->nullable()->comment('Measurements for this parent category variable can be synthetically generated by measurements from its child variables. This only includes ones created by the user. ');
            $table->integer('number_of_user_parents')->nullable()->comment('Measurements for this parent category variable can be synthetically generated by measurements from its child variables. This only includes ones created by the user. ');
            $table->boolean('is_public')->nullable();
            $table->string('slug', 200)->nullable()->unique('user_variables_slug_uindex')->comment('The slug is the part of a URL that identifies a page in human-readable keywords.');
            $table->boolean('is_goal')->nullable()->comment('The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  The foods you eat are not generally an objective end in themselves. ');
            $table->boolean('controllable')->nullable()->comment('You can control the foods you eat directly. However, symptom severity or weather is not directly controllable. ');
            $table->boolean('boring')->nullable()->comment('The user variable is boring if the owner would not be interested in its causes or effects. ');
            $table->boolean('predictor')->nullable()->comment('predictor is true if the variable is a factor that could influence an outcome of interest');

            $table->unique(['user_id', 'variable_id'], 'user_id');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('user_variables');
    }
}
