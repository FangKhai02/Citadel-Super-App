<?php

namespace Database\Seeders\Bread;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class RolesSeeder extends Seeder
{
    public function run()
    {
        DB::table('roles')->updateOrInsert(
            ['id' => 1],
            array (
  'id' => 1,
  'name' => 'admin',
  'display_name' => 'Administrator',
  'created_at' => '2024-09-26 03:11:16',
  'updated_at' => '2024-09-26 03:11:16',
)
        );
        DB::table('roles')->updateOrInsert(
            ['id' => 2],
            array (
  'id' => 2,
  'name' => 'user',
  'display_name' => 'Normal User',
  'created_at' => '2024-09-26 03:11:16',
  'updated_at' => '2024-09-26 03:11:16',
)
        );
    }
}
