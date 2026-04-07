<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\File;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        // Define the prioritized seeders
        $orderedSeeders = [
            'RolesSeeder',
            'PermissionsSeeder',
            'PermissionRoleSeeder',
            'MenusSeeder',
            'MenuItemsSeeder',
        ];

        // Call prioritized seeders first
        foreach ($orderedSeeders as $seeder) {
            $className = "Database\\Seeders\\bread\\$seeder";
            $this->call($className);
        }

        // Get all other seeders from the directory, excluding the already executed ones
        $breadSeeders = File::files(database_path('seeders/bread'));

        foreach ($breadSeeders as $seeder) {
            $seederName = pathinfo($seeder, PATHINFO_FILENAME);

            // Skip already executed seeders
            if (in_array($seederName, $orderedSeeders)) {
                continue;
            }

            $className = "Database\\Seeders\\bread\\$seederName";
            $this->call($className);
        }

        // Add more seeders here if needed
    }
}
