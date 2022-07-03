<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateLightsailInstancesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('lightsail_instances', function (Blueprint $table) {
            $table->increments('id')->comment('Automatically generated unique id for the lightsail instance');
            $table->string('client_id', 80)->nullable()->index('lightsail_instances_client_id_fk')->comment('The ID for the API client that created the record');
            $table->timestamp('created_at')->useCurrent()->comment('The time the record was originally created');
            $table->softDeletes()->comment('The time the record was deleted');
            $table->timestamp('updated_at')->comment('The time the record was last modified');
            $table->unsignedBigInteger('user_id')->index('lightsail_instances_wp_users_ID_fk')->comment('The QuantiModo user ID for the owner of the record');
            $table->string('name')->comment('Example: cc-wp');
            $table->string('arn')->comment('Example: arn:aws:lightsail:us-east-1:335072289018:Instance/14eb6cec-1c74-429a-96f5-8f8f5e5fbbc1');
            $table->string('support_code')->comment('Example: 102336889266/i-005d61af88d99927e');
            $table->string('external_created_at')->comment('Example: 2021-03-22T01:47:10+00:00');
            $table->longText('location')->comment('Example: {availabilityZone:us-east-1a,regionName:us-east-1}');
            $table->string('resource_type')->comment('Example: Instance');
            $table->longText('tags')->comment('Example: [{key:wordpress},{key:HEALTH_CHECK_URL,value:https://CrowdsourcingCures.org}]');
            $table->string('blueprint_id')->comment('Example: wordpress');
            $table->string('blueprint_name')->comment('Example: WordPress');
            $table->string('bundle_id')->comment('Example: micro_2_0');
            $table->longText('add_ons')->comment('Example: [{name:AutoSnapshot,status:Enabled,snapshotTimeOfDay:00:00}]');
            $table->boolean('is_static_ip')->comment('Example: 1');
            $table->string('private_ip_address')->comment('Example: 172.26.7.226');
            $table->string('public_ip_address')->comment('Example: 3.224.6.200');
            $table->longText('ipv6_addresses')->comment('Example: [2600:1f18:1ae:1700:c92e:b66f:52cd:5f01]');
            $table->string('ip_address_type')->comment('Example: dualstack');
            $table->longText('hardware')->comment('Example: {cpuCount:1,disks:[{createdAt:2021-03-22T01:47:10+00:00,sizeInGb:40,isSystemDisk:true,iops:120,path:/dev/xvda,attachedTo:cc-wp,attachmentState:attached}],ramSizeInGb:1}');
            $table->longText('networking')->comment('Example: {monthlyTransfer:{gbPerMonthAllocated:2048},ports:[{fromPort:80,toPort:80,protocol:tcp,accessFrom:Anywhere (0.0.0.0/0),accessType:public,commonName:,accessDirection:inbound,cidrs:[0.0.0.0/0],ipv6Cidrs:[],cidrListAliases:[]},{fromPort:8000,toPort:8000,protocol:tcp,accessFrom:Custom,accessType:public,commonName:,accessDirection:inbound,cidrs:[24.178.226.180/32],ipv6Cidrs:[],cidrListAliases:[]},{fromPort:7777,toPort:7777,protocol:tcp,accessFrom:Custom,accessType:public,commonName:,accessDirection:inbound,cidrs:[24.178.226.180/32],ipv6Cidrs:[],cidrListAliases:[]},{fromPort:6379,toPort:6379,protocol:tcp,accessFrom:Custom,accessType:public,commonName:,accessDirection:inbound,cidrs:[24.178.226.180/32],ipv6Cidrs:[],cidrListAliases:[]},{fromPort:888,toPort:888,protocol:tcp,accessFrom:Custom,accessType:public,commonName:,accessDirection:inbound,cidrs:[24.178.226.180/32],ipv6Cidrs:[],cidrListAliases:[]},{fromPort:20,toPort:20,protocol:tcp,accessFrom:Custom,accessType:public,commonName:,accessDirection:inbound,c');
            $table->longText('state')->comment('Example: {code:16,name:running}');
            $table->string('username')->comment('Example: bitnami');
            $table->string('ssh_key_name')->comment('Example: qm-aws-20160528');
            $table->longText('jenkins_labels')->comment('Example: []');
            $table->string('computer')->comment('Example: ');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('lightsail_instances');
    }
}
