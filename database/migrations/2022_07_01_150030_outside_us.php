<?php

use App\Storage\DB\Writable;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\Schema;

class OutsideUs extends Migration
{
    public function up()
    {
        Schema::getConnection()->statement("alter table connectors
    add available_outside_us int null;
");
    }
}
