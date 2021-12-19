<?php

namespace Tests\Voyager\Feature;

use Tests\Voyager\TestCase;

class SeederTest extends TestCase
{
    public function setUp(): void
    {
        parent::setUp();

        $this->install();
    }

    /**
     * Test manually seeding is working.
     */
    public function testVoyagerDatabaseSeederCanBeCalled()
    {
        $exception = null;

        try {
            $this->artisan('db:seed', ['--class' => 'VoyagerDatabaseSeeder']);
        } catch (\Exception $exception) {
        }

        $this->assertNull($exception, 'An exception was thrown');
    }
}
