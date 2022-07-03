<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateStudiesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('studies', function (Blueprint $table) {
            $table->string('id', 80)->primary()->comment('Study id which should match OAuth client id');
            $table->string('type', 20)->comment('The type of study may be population, individual, or cohort study');
            $table->unsignedInteger('cause_variable_id')->index('cause_variable_id')->comment('variable ID of the cause variable for which the user desires correlations');
            $table->unsignedInteger('effect_variable_id')->index('effect_variable_id')->comment('variable ID of the effect variable for which the user desires correlations');
            $table->unsignedBigInteger('user_id');
            $table->timestamp('created_at')->useCurrent();
            $table->softDeletes();
            $table->text('analysis_parameters')->nullable()->comment('Additional parameters for the study such as experiment_end_time, experiment_start_time, cause_variable_filling_value, effect_variable_filling_value');
            $table->longText('user_study_text')->nullable()->comment('Overrides auto-generated study text');
            $table->text('user_title')->nullable();
            $table->string('study_status', 20)->default('publish');
            $table->string('comment_status', 20)->default('open');
            $table->string('study_password', 20)->nullable();
            $table->text('study_images')->nullable()->comment('Provided images will override the auto-generated images');
            $table->timestamp('updated_at');
            $table->string('client_id')->nullable()->index('studies_client_id_fk');
            $table->timestamp('published_at')->nullable();
            $table->integer('wp_post_id')->nullable();
            $table->timestamp('newest_data_at')->nullable();
            $table->timestamp('analysis_requested_at')->nullable();
            $table->string('reason_for_analysis')->nullable();
            $table->timestamp('analysis_ended_at')->nullable();
            $table->timestamp('analysis_started_at')->nullable();
            $table->string('internal_error_message')->nullable();
            $table->string('user_error_message')->nullable();
            $table->string('status', 25)->nullable();
            $table->timestamp('analysis_settings_modified_at')->nullable();
            $table->boolean('is_public')->comment('Indicates whether the study is private or should be publicly displayed.');
            $table->integer('sort_order');
            $table->string('slug', 200)->nullable()->unique('studies_slug_uindex')->comment('The slug is the part of a URL that identifies a page in human-readable keywords.');

            $table->unique(['user_id', 'cause_variable_id', 'effect_variable_id', 'type'], 'user_cause_effect_type');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('studies');
    }
}
