<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateGithubRepositoriesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('github_repositories', function (Blueprint $table) {
            $table->unsignedInteger('id')->unique('github_repositories_id_uindex')->comment('Automatically generated unique id for the github repository');
            $table->string('client_id', 80)->nullable()->index('github_repositories_oa_clients_client_id_fk')->comment('The ID for the API client that created the record');
            $table->timestamp('created_at')->useCurrent()->comment('The time the record was originally created');
            $table->softDeletes()->comment('The time the record was deleted');
            $table->timestamp('updated_at')->comment('The time the record was last modified');
            $table->unsignedBigInteger('user_id')->index('github_repositories_wp_users_ID_fk')->comment('The QuantiModo user ID for the owner of the record');
            $table->integer('github_repository_id')->unique('github_repositories_github_repository_id_uindex')->comment('Github repository id Example: 158861117');
            $table->string('node_id')->comment('Example: MDEwOlJlcG9zaXRvcnkxNTg4NjExMTc=');
            $table->string('name')->unique('github_repositories_name_uindex')->comment('Example: qm-api');
            $table->string('full_name')->comment('Example: mikepsinn/qm-api');
            $table->boolean('private')->comment('Example: 1');
            $table->longText('owner')->comment('Example: {login:mikepsinn,id:2808553,node_id:MDQ6VXNlcjI4MDg1NTM=,avatar_url:https://avatars.githubusercontent.com/u/2808553?v=4,gravatar_id:,url:https://api.github.com/users/mikepsinn,html_url:https://github.com/mikepsinn,followers_url:https://api.github.com/users/mikepsinn/followers,following_url:https://api.github.com/users/mikepsinn/following{/other_user},gists_url:https://api.github.com/users/mikepsinn/gists{/gist_id},starred_url:https://api.github.com/users/mikepsinn/starred{/owner}{/repo},subscriptions_url:https://api.github.com/users/mikepsinn/subscriptions,organizations_url:https://api.github.com/users/mikepsinn/orgs,repos_url:https://api.github.com/users/mikepsinn/repos,events_url:https://api.github.com/users/mikepsinn/events{/privacy},received_events_url:https://api.github.com/users/mikepsinn/received_events,type:User,site_admin:false}');
            $table->string('html_url')->unique('github_repositories_html_url_uindex')->comment('Example: https://github.com/mikepsinn/qm-api');
            $table->string('description')->comment('Example: I\'m a description');
            $table->boolean('fork')->comment('Example: ');
            $table->string('url')->unique('github_repositories_url_uindex')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api');
            $table->string('forks_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/forks');
            $table->string('keys_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/keys{/key_id}');
            $table->string('collaborators_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/collaborators{/collaborator}');
            $table->string('teams_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/teams');
            $table->string('hooks_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/hooks');
            $table->string('issue_events_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/issues/events{/number}');
            $table->string('events_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/events');
            $table->string('assignees_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/assignees{/user}');
            $table->string('branches_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/branches{/branch}');
            $table->string('tags_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/tags');
            $table->string('blobs_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/git/blobs{/sha}');
            $table->string('git_tags_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/git/tags{/sha}');
            $table->string('git_refs_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/git/refs{/sha}');
            $table->string('trees_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/git/trees{/sha}');
            $table->string('statuses_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/statuses/{sha}');
            $table->string('languages_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/languages');
            $table->string('stargazers_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/stargazers');
            $table->string('contributors_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/contributors');
            $table->string('subscribers_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/subscribers');
            $table->string('subscription_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/subscription');
            $table->string('commits_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/commits{/sha}');
            $table->string('git_commits_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/git/commits{/sha}');
            $table->string('comments_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/comments{/number}');
            $table->string('issue_comment_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/issues/comments{/number}');
            $table->string('contents_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/contents/{+path}');
            $table->string('compare_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/compare/{base}...{head}');
            $table->string('merges_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/merges');
            $table->string('archive_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/{archive_format}{/ref}');
            $table->string('downloads_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/downloads');
            $table->string('issues_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/issues{/number}');
            $table->string('pulls_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/pulls{/number}');
            $table->string('milestones_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/milestones{/number}');
            $table->string('notifications_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/notifications{?since,all,participating}');
            $table->string('labels_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/labels{/name}');
            $table->string('releases_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/releases{/id}');
            $table->string('deployments_url')->comment('Example: https://api.github.com/repos/mikepsinn/qm-api/deployments');
            $table->string('pushed_at')->comment('Example: 2021-10-24T00:07:07Z');
            $table->string('git_url')->unique('github_repositories_git_url_uindex')->comment('Example: git://github.com/mikepsinn/qm-api.git');
            $table->string('ssh_url')->unique('github_repositories_ssh_url_uindex')->comment('Example: git@github.com:mikepsinn/qm-api.git');
            $table->string('clone_url')->comment('Example: https://github.com/mikepsinn/qm-api.git');
            $table->string('svn_url')->comment('Example: https://github.com/mikepsinn/qm-api');
            $table->string('homepage')->nullable()->comment('Example: https://quantimo.do');
            $table->integer('size')->comment('Example: 178451');
            $table->integer('stargazers_count')->comment('Example: 2');
            $table->integer('watchers_count')->comment('Example: 2');
            $table->string('language')->comment('Example: PHP');
            $table->boolean('has_issues')->comment('Example: 1');
            $table->boolean('has_projects')->comment('Example: 1');
            $table->boolean('has_downloads')->comment('Example: 1');
            $table->boolean('has_wiki')->comment('Example: 1');
            $table->boolean('has_pages')->comment('Example: ');
            $table->integer('forks_count')->comment('Example: 0');
            $table->boolean('archived')->comment('Example: ');
            $table->boolean('disabled')->comment('Example: ');
            $table->integer('open_issues_count')->comment('Example: 89');
            $table->boolean('allow_forking')->comment('Example: 1');
            $table->boolean('is_template')->comment('Example: ');
            $table->longText('topics')->comment('Example: [digital-health,health,healthcare-data]');
            $table->string('visibility')->comment('Example: private');
            $table->integer('forks')->comment('Example: 0');
            $table->integer('open_issues')->comment('Example: 89');
            $table->integer('watchers')->comment('Example: 2');
            $table->string('default_branch')->comment('Example: develop');
            $table->longText('permissions')->comment('Example: {admin:true,maintain:true,push:true,triage:true,pull:true}');
            $table->string('temp_clone_token')->comment('Example: AAVNV2SECRETYTBOS7ZI');
            $table->boolean('allow_squash_merge')->comment('Example: 1');
            $table->boolean('allow_merge_commit')->comment('Example: 1');
            $table->boolean('allow_rebase_merge')->comment('Example: 1');
            $table->boolean('allow_auto_merge')->comment('Example: ');
            $table->boolean('delete_branch_on_merge')->comment('Example: ');
            $table->integer('network_count')->comment('Example: 0');
            $table->integer('subscribers_count')->comment('Example: 0');
            $table->integer('score')->nullable()->comment('Example: 0');
            $table->string('mirror_url')->nullable()->comment('Example: git@github.com:mikepsinn/qm-api.git');
            $table->string('license', 100)->nullable()->comment('GPL-3.0');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('github_repositories');
    }
}
