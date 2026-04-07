<?php

namespace Database\Seeders\Bread;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ProductTypeBreadSeeder extends Seeder
{
    public function run()
    {
        DB::table('data_types')->updateOrInsert(
            ['slug' => 'product-type'],
            array (
  'name' => 'product_type',
  'slug' => 'product-type',
  'display_name_singular' => 'Product Type',
  'display_name_plural' => 'Product Types',
  'icon' => NULL,
  'model_name' => 'App\\Models\\ProductType',
  'policy_name' => NULL,
  'controller' => 'App\\Http\\Controllers\\ProductTypeController',
  'description' => NULL,
  'generate_permissions' => 1,
  'server_side' => 1,
  'details' => '{"order_column":"created_at","order_display_column":null,"order_direction":"desc","default_search_key":null,"scope":null}',
  'created_at' => '2024-09-30 08:12:49',
  'updated_at' => '2025-02-18 16:19:10',
)
        );

        DB::table('data_rows')->where('data_type_id', 12)->delete();

        DB::table('data_rows')->insert(array (
  'data_type_id' => 12,
  'field' => 'id',
  'type' => 'text',
  'display_name' => 'Id',
  'required' => 1,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 1,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 12,
  'field' => 'status',
  'type' => 'checkbox',
  'display_name' => 'Status',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 0,
  'details' => '{"on":"Enabled","off":"Disabled","checked":false}',
  'order' => 4,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 12,
  'field' => 'created_at',
  'type' => 'timestamp',
  'display_name' => 'Created Date',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 5,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 12,
  'field' => 'updated_at',
  'type' => 'timestamp',
  'display_name' => 'Updated Datetime',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 6,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 12,
  'field' => 'name',
  'type' => 'text',
  'display_name' => 'Category',
  'required' => 1,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"validation":{"rule":"required"}}',
  'order' => 2,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 12,
  'field' => 'created_by',
  'type' => 'text',
  'display_name' => 'Created By',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 6,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 12,
  'field' => 'updated_by',
  'type' => 'text',
  'display_name' => 'Updated By',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 7,
));

    }
}
