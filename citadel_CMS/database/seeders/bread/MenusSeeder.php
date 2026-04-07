<?php

namespace Database\Seeders\Bread;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class MenusSeeder extends Seeder
{
    public function run()
    {
        DB::statement('SET FOREIGN_KEY_CHECKS=0;');
        DB::table('menus')->truncate();
        DB::statement('SET FOREIGN_KEY_CHECKS=1;');

        DB::table('menus')->insert(array (
  'id' => 1,
  'name' => 'admin',
  'created_at' => '2024-09-26 03:11:15',
  'updated_at' => '2024-09-26 03:11:15',
));
    }
}
