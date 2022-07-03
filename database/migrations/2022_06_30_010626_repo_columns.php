<?php

use App\Storage\DB\Writable;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class RepoColumns extends Migration
{
    public function up()
    {
        Schema::table('github_repositories', function (Blueprint $table) {
            $table->string('description')->nullable()->default(null)->change();
            $table->string('mirror_url')->nullable()->default(null)->change();
            $table->string('license')->nullable()->default(null)->change();
            $table->boolean('web_commit_signoff_required')->nullable()->default(null);
        });
    }
}
