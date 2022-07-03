<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateThirdPartyCorrelationsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('third_party_correlations', function (Blueprint $table) {
            $table->unsignedInteger('cause_id')->index('cause')->comment('variable ID of the cause variable for which the user desires correlations');
            $table->unsignedInteger('effect_id')->index('effect')->comment('variable ID of the effect variable for which the user desires correlations');
            $table->double('qm_score')->nullable()->comment('QM Score');
            $table->float('forward_pearson_correlation_coefficient', 10, 4)->nullable()->comment('Pearson correlation coefficient between cause and effect measurements');
            $table->double('value_predicting_high_outcome')->nullable()->comment('cause value that predicts an above average effect value (in default unit for cause variable)');
            $table->double('value_predicting_low_outcome')->nullable()->comment('cause value that predicts a below average effect value (in default unit for cause variable)');
            $table->integer('predicts_high_effect_change')->nullable()->comment('The percent change in the outcome typically seen when the predictor value is closer to the predictsHighEffect value. ');
            $table->integer('predicts_low_effect_change')->nullable()->comment('The percent change in the outcome from average typically seen when the predictor value is closer to the predictsHighEffect value.');
            $table->double('average_effect')->nullable();
            $table->double('average_effect_following_high_cause')->nullable();
            $table->double('average_effect_following_low_cause')->nullable();
            $table->double('average_daily_low_cause')->nullable();
            $table->double('average_daily_high_cause')->nullable();
            $table->float('average_forward_pearson_correlation_over_onset_delays', 10, 0)->nullable();
            $table->float('average_reverse_pearson_correlation_over_onset_delays', 10, 0)->nullable();
            $table->integer('cause_changes')->nullable()->comment('Cause changes');
            $table->double('cause_filling_value')->nullable();
            $table->integer('cause_number_of_processed_daily_measurements');
            $table->integer('cause_number_of_raw_measurements');
            $table->integer('cause_unit_id')->nullable()->comment('Unit ID of Cause');
            $table->double('confidence_interval')->nullable()->comment('A margin of error around the effect size.  Wider confidence intervals reflect greater uncertainty about the Ã¢â‚¬Å“trueÃ¢â‚¬Â value of the correlation.');
            $table->double('critical_t_value')->nullable()->comment('Value of t from lookup table which t must exceed for significance.');
            $table->timestamp('created_at')->useCurrent();
            $table->string('data_source_name')->nullable();
            $table->softDeletes();
            $table->integer('duration_of_action')->nullable()->comment('Time over which the cause is expected to produce a perceivable effect following the onset delay');
            $table->integer('effect_changes')->nullable()->comment('Effect changes');
            $table->double('effect_filling_value')->nullable();
            $table->integer('effect_number_of_processed_daily_measurements');
            $table->integer('effect_number_of_raw_measurements');
            $table->text('error')->nullable();
            $table->float('forward_spearman_correlation_coefficient', 10, 0)->nullable();
            $table->integer('id', true);
            $table->integer('number_of_days');
            $table->integer('number_of_pairs')->nullable()->comment('Number of points that went into the correlation calculation');
            $table->integer('onset_delay')->nullable()->comment('User estimated or default time after cause measurement before a perceivable effect is observed');
            $table->integer('onset_delay_with_strongest_pearson_correlation')->nullable();
            $table->double('optimal_pearson_product')->nullable()->comment('Optimal Pearson Product');
            $table->double('p_value')->nullable()->comment('The measure of statistical significance. A value less than 0.05 means that a correlation is statistically significant or consistent enough that it is unlikely to be a coincidence.');
            $table->float('pearson_correlation_with_no_onset_delay', 10, 0)->nullable();
            $table->double('predictive_pearson_correlation_coefficient')->nullable()->comment('Predictive Pearson Correlation Coefficient');
            $table->double('reverse_pearson_correlation_coefficient')->nullable()->comment('Correlation when cause and effect are reversed. For any causal relationship, the forward correlation should exceed the reverse correlation');
            $table->float('statistical_significance', 10, 4)->nullable()->comment('A function of the effect size and sample size');
            $table->float('strongest_pearson_correlation_coefficient', 10, 0)->nullable();
            $table->double('t_value')->nullable()->comment('Function of correlation and number of samples.');
            $table->timestamp('updated_at');
            $table->unsignedBigInteger('user_id');
            $table->double('grouped_cause_value_closest_to_value_predicting_low_outcome')->nullable();
            $table->double('grouped_cause_value_closest_to_value_predicting_high_outcome')->nullable();
            $table->string('client_id')->nullable()->index('third_party_correlations_client_id_fk');
            $table->timestamp('published_at')->nullable();
            $table->integer('wp_post_id')->nullable();
            $table->string('status', 25)->nullable();
            $table->unsignedTinyInteger('cause_variable_category_id')->nullable()->index('third_party_correlations_cause_variable_category_id_fk');
            $table->unsignedTinyInteger('effect_variable_category_id')->nullable()->index('third_party_correlations_effect_variable_category_id_fk');
            $table->boolean('interesting_variable_category_pair')->nullable();
            $table->unsignedInteger('cause_variable_id')->nullable();
            $table->unsignedInteger('effect_variable_id')->nullable();

            $table->unique(['user_id', 'cause_id', 'effect_id'], 'user_cause_effect');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('third_party_correlations');
    }
}
