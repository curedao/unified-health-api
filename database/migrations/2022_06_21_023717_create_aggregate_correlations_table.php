<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAggregateCorrelationsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('aggregate_correlations', function (Blueprint $table) {
            $table->integer('id', true);
            $table->float('forward_pearson_correlation_coefficient', 10, 4)->comment('Pearson correlation coefficient between cause and effect measurements');
            $table->integer('onset_delay')->comment('User estimated or default time after cause measurement before a perceivable effect is observed');
            $table->integer('duration_of_action')->comment('Time over which the cause is expected to produce a perceivable effect following the onset delay');
            $table->integer('number_of_pairs')->comment('Number of points that went into the correlation calculation');
            $table->double('value_predicting_high_outcome')->comment('cause value that predicts an above average effect value (in default unit for cause variable)');
            $table->double('value_predicting_low_outcome')->comment('cause value that predicts a below average effect value (in default unit for cause variable)');
            $table->double('optimal_pearson_product')->comment('Optimal Pearson Product');
            $table->float('average_vote', 3, 1)->nullable()->default(0.5)->comment('The average opinion on the causal plausibility of a relationship.');
            $table->integer('number_of_users')->comment('Number of Users by which correlation is aggregated');
            $table->integer('number_of_correlations')->comment('Number of Correlations by which correlation is aggregated');
            $table->float('statistical_significance', 10, 4)->comment('A function of the effect size and sample size');
            $table->unsignedSmallInteger('cause_unit_id')->nullable()->index('aggregate_correlations_cause_unit_id_fk')->comment('Unit ID of Cause');
            $table->integer('cause_changes')->comment('The number of times the cause measurement value was different from the one preceding it.');
            $table->integer('effect_changes')->comment('The number of times the effect measurement value was different from the one preceding it.');
            $table->double('aggregate_qm_score')->comment('A number representative of the relative importance of the relationship based on the strength, usefulness, and plausible causality.  The higher the number, the greater the perceived importance.  This value can be used for sorting relationships by importance. ');
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at');
            $table->string('status', 25)->comment('Whether the correlation is being analyzed, needs to be analyzed, or is up to date already.');
            $table->double('reverse_pearson_correlation_coefficient')->comment('Correlation when cause and effect are reversed. For any causal relationship, the forward correlation should exceed the reverse correlation');
            $table->double('predictive_pearson_correlation_coefficient')->comment('Pearson correlation coefficient of cause and effect values lagged by the onset delay and grouped based on the duration of action. ');
            $table->string('data_source_name')->nullable();
            $table->integer('predicts_high_effect_change')->comment('The percent change in the outcome typically seen when the predictor value is closer to the predictsHighEffect value. ');
            $table->integer('predicts_low_effect_change')->comment('The percent change in the outcome from average typically seen when the predictor value is closer to the predictsHighEffect value.');
            $table->double('p_value')->comment('The measure of statistical significance. A value less than 0.05 means that a correlation is statistically significant or consistent enough that it is unlikely to be a coincidence.');
            $table->double('t_value')->comment('Function of correlation and number of samples.');
            $table->double('critical_t_value')->comment('Value of t from lookup table which t must exceed for significance.');
            $table->double('confidence_interval')->comment('A margin of error around the effect size.  Wider confidence intervals reflect greater uncertainty about the true value of the correlation.');
            $table->softDeletes();
            $table->double('average_effect')->comment('The average effect variable measurement value used in analysis in the common unit. ');
            $table->double('average_effect_following_high_cause')->comment('The average effect variable measurement value following an above average cause value (in the common unit). ');
            $table->double('average_effect_following_low_cause')->comment('The average effect variable measurement value following a below average cause value (in the common unit). ');
            $table->double('average_daily_low_cause')->comment('The average of below average cause values (in the common unit). ');
            $table->double('average_daily_high_cause')->comment('The average of above average cause values (in the common unit). ');
            $table->double('population_trait_pearson_correlation_coefficient')->nullable()->comment('The pearson correlation of pairs which each consist of the average cause value and the average effect value for a given user. ');
            $table->double('grouped_cause_value_closest_to_value_predicting_low_outcome')->comment('A realistic daily value (not a fraction from averaging) that typically precedes below average outcome values. ');
            $table->double('grouped_cause_value_closest_to_value_predicting_high_outcome')->comment('A realistic daily value (not a fraction from averaging) that typically precedes below average outcome values. ');
            $table->string('client_id')->nullable()->index('aggregate_correlations_client_id_fk');
            $table->timestamp('published_at')->nullable();
            $table->unsignedBigInteger('wp_post_id')->nullable()->index('aggregate_correlations_wp_posts_ID_fk');
            $table->unsignedTinyInteger('cause_variable_category_id')->index('aggregate_correlations_cause_variable_category_id_fk');
            $table->unsignedTinyInteger('effect_variable_category_id')->index('aggregate_correlations_effect_variable_category_id_fk');
            $table->boolean('interesting_variable_category_pair')->comment('True if the combination of cause and effect variable categories are generally interesting.  For instance, treatment cause variables paired with symptom effect variables are interesting. ');
            $table->timestamp('newest_data_at')->nullable();
            $table->timestamp('analysis_requested_at')->nullable();
            $table->string('reason_for_analysis')->comment('The reason analysis was requested.');
            $table->timestamp('analysis_started_at')->nullable()->default(null);
            $table->timestamp('analysis_ended_at')->nullable();
            $table->text('user_error_message')->nullable();
            $table->text('internal_error_message')->nullable();
            $table->unsignedInteger('cause_variable_id');
            $table->unsignedInteger('effect_variable_id')->index();
            $table->float('cause_baseline_average_per_day', 10, 0)->comment('Predictor Average at Baseline (The average low non-treatment value of the predictor per day)');
            $table->float('cause_baseline_average_per_duration_of_action', 10, 0)->comment('Predictor Average at Baseline (The average low non-treatment value of the predictor per duration of action)');
            $table->float('cause_treatment_average_per_day', 10, 0)->comment('Predictor Average During Treatment (The average high value of the predictor per day considered to be the treatment dosage)');
            $table->float('cause_treatment_average_per_duration_of_action', 10, 0)->comment('Predictor Average During Treatment (The average high value of the predictor per duration of action considered to be the treatment dosage)');
            $table->float('effect_baseline_average', 10, 0)->comment('Outcome Average at Baseline (The normal value for the outcome seen without treatment during the previous duration of action time span)');
            $table->float('effect_baseline_relative_standard_deviation', 10, 0)->comment('Outcome Average at Baseline (The average value seen for the outcome without treatment during the previous duration of action time span)');
            $table->float('effect_baseline_standard_deviation', 10, 0)->comment('Outcome Relative Standard Deviation at Baseline (How much the outcome value normally fluctuates without treatment during the previous duration of action time span)');
            $table->float('effect_follow_up_average', 10, 0)->comment('Outcome Average at Follow-Up (The average value seen for the outcome during the duration of action following the onset delay of the treatment)');
            $table->float('effect_follow_up_percent_change_from_baseline', 10, 0)->comment('Outcome Average at Follow-Up (The average value seen for the outcome during the duration of action following the onset delay of the treatment)');
            $table->float('z_score', 10, 0)->comment('The absolute value of the change over duration of action following the onset delay of treatment divided by the baseline outcome relative standard deviation. A.K.A The number of standard deviations from the mean. A zScore > 2 means pValue < 0.05 and is typically considered statistically significant.');
            $table->json('charts');
            $table->unsignedInteger('number_of_variables_where_best_aggregate_correlation')->comment('Number of Variables for this Best Aggregate Correlation.');
            $table->string('deletion_reason', 280)->nullable()->comment('The reason the variable was deleted.');
            $table->integer('record_size_in_kb')->nullable();
            $table->boolean('is_public');
            $table->string('slug', 200)->nullable()->unique('aggregate_correlations_slug_uindex')->comment('The slug is the part of a URL that identifies a page in human-readable keywords.');
            $table->boolean('boring')->nullable()->comment('The relationship is boring if it is obvious, the predictor is not controllable, or the outcome is not a goal, the relationship could not be causal, or the confidence is low.  ');
            $table->boolean('outcome_is_a_goal')->nullable()->comment('The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  The foods you eat are not generally an objective end in themselves. ');
            $table->boolean('predictor_is_controllable')->nullable()->comment('The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  Symptom severity is not directly controllable. ');
            $table->boolean('plausibly_causal')->nullable()->comment('The effect of aspirin on headaches is plausibly causal. The effect of aspirin on precipitation does not have a plausible causal relationship. ');
            $table->boolean('obvious')->nullable()->comment('The effect of aspirin on headaches is obvious. The effect of aspirin on productivity is not obvious. ');
            $table->integer('number_of_up_votes')->comment('Number of people who feel this relationship is plausible and useful. ');
            $table->integer('number_of_down_votes')->comment('Number of people who feel this relationship is implausible or not useful. ');
            $table->enum('strength_level', ['VERY STRONG', 'STRONG', 'MODERATE', 'WEAK', 'VERY WEAK'])->comment('Strength level describes magnitude of the change in outcome observed following changes in the predictor. ');
            $table->enum('confidence_level', ['HIGH', 'MEDIUM', 'LOW'])->comment('Describes the confidence that the strength level will remain consist in the future.  The more data there is, the lesser the chance that the findings are a spurious correlation. ');
            $table->enum('relationship', ['POSITIVE', 'NEGATIVE', 'NONE'])->comment('If higher predictor values generally precede HIGHER outcome values, the relationship is considered POSITIVE.  If higher predictor values generally precede LOWER outcome values, the relationship is considered NEGATIVE. ');

            $table->unique(['cause_variable_id', 'effect_variable_id'], 'aggregate_correlations_pk');
            $table->unique(['cause_variable_id', 'effect_variable_id'], 'cause_variable_id_effect_variable_id_uindex');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('aggregate_correlations');
    }
}
