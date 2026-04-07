<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;

class ExportBreadSeeder extends Command
{
    protected $signature = 'export:bread {slug}';
    protected $description = 'Export BREAD configuration into a seeder file';

    public function handle()
    {
        $slug = $this->argument('slug');
        $dataType = DB::table('data_types')->where('slug', $slug)->first();

        if (!$dataType) {
            $this->error("No BREAD configuration found for slug: $slug");
            return;
        }

        $dataRows = DB::table('data_rows')->where('data_type_id', $dataType->id)->get();
        $className = str_replace(' ', '', ucwords(str_replace('-', ' ', $slug)));

        // Remove 'id' to avoid insert conflicts
        $dataTypeArray = json_decode(json_encode($dataType), true);
//        unset($dataTypeArray['id']);

        $seederContent = "<?php\n\nnamespace Database\\Seeders\\Bread;\n\nuse Illuminate\\Database\\Seeder;\nuse Illuminate\\Support\\Facades\\DB;\n\n";
        $seederContent .= "class " . $className . "BreadSeeder extends Seeder\n{\n    public function run()\n    {\n";

        $seederContent .= "        DB::table('data_types')->updateOrInsert(\n            ['slug' => '$slug'],\n            " . var_export($dataTypeArray, true) . "\n        );\n\n";

        $seederContent .= "        DB::table('data_rows')->where('data_type_id', {$dataType->id})->delete();\n\n";

        foreach ($dataRows as $row) {
            $rowArray = json_decode(json_encode($row), true);
            unset($rowArray['id']); // Remove 'id' to prevent duplication issues

            $seederContent .= "        DB::table('data_rows')->insert(" . var_export($rowArray, true) . ");\n\n";
        }

        $seederContent .= "    }\n}\n";

        $seederPath = database_path("seeders/bread/" . $className . "BreadSeeder.php");

        // Ensure the directory exists
        File::ensureDirectoryExists(database_path('seeders/bread'));
        File::put($seederPath, $seederContent);

        $this->info("✅ Seeder exported successfully! Check {$seederPath}");
    }
}
