<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;

class ExportVoyagerSeeder extends Command
{
    protected $signature = 'export:voyager';
    protected $description = 'Export Voyager tables (menus, menu_items, permissions, roles, permission_role) into individual seeder files';

    public function handle()
    {
        $tables = ['menus', 'menu_items', 'permissions', 'roles', 'permission_role'];

        foreach ($tables as $table) {
            $this->info("Exporting table: $table");

            $data = DB::table($table)->get();

            if ($data->isEmpty()) {
                $this->info("No data found for table: $table");
                continue;
            }

            $className = str_replace(' ', '', ucwords(str_replace('_', ' ', $table))) . 'Seeder';

            $seederContent = "<?php\n\nnamespace Database\\Seeders\\Bread;\n\nuse Illuminate\\Database\\Seeder;\nuse Illuminate\\Support\\Facades\\DB;\n\n";
            $seederContent .= "class $className extends Seeder\n{
    public function run()
    {
";

            // Use upsert for permissions, roles, permission_role tables only
            $upsertTables = ['permissions', 'roles', 'permission_role'];

            // Check if the current table is in the upsert list
            if (in_array($table, $upsertTables)) {
                foreach ($data as $row) {
                    $rowData = json_decode(json_encode($row), true);
                    $seederContent .= "        DB::table('$table')->updateOrInsert(\n";
                    
                    // Handle different table structures
                    if ($table === 'permission_role') {
                        $seederContent .= "            ['permission_id' => " . $rowData['permission_id'] . ", 'role_id' => " . $rowData['role_id'] . "],\n";
                    } else {
                        $seederContent .= "            ['id' => " . $rowData['id'] . "],\n";
                    }
                    
                    $seederContent .= "            " . var_export($rowData, true) . "\n";
                    $seederContent .= "        );\n";
                }
            } else {
                // Use truncate for menus and menu_items
                $seederContent .= "        DB::statement('SET FOREIGN_KEY_CHECKS=0;');\n";
                $seederContent .= "        DB::table('$table')->truncate();\n";
                $seederContent .= "        DB::statement('SET FOREIGN_KEY_CHECKS=1;');\n\n";

                foreach ($data as $row) {
                    $seederContent .= "        DB::table('$table')->insert(" . var_export(json_decode(json_encode($row), true), true) . ");\n";
                }
            }

            $seederContent .= "    }\n}\n";

            $seederPath = database_path("seeders/bread/" . $className . ".php");

            if (!File::exists(database_path('seeders/bread'))) {
                File::makeDirectory(database_path('seeders/bread'), 0755, true);
            }

            File::put($seederPath, $seederContent);

            $this->info("✅ Seeder exported successfully! Check {$seederPath}");
        }
    }
}
