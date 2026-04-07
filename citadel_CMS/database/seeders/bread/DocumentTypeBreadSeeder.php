<?php

namespace Database\Seeders\Bread;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class DocumentTypeBreadSeeder extends Seeder
{
    public function run()
    {
        DB::table('data_types')->updateOrInsert(
            ['slug' => 'document-type'],
            array (
  'name' => 'document_type',
  'slug' => 'document-type',
  'display_name_singular' => 'Document Type',
  'display_name_plural' => 'Document Types',
  'icon' => NULL,
  'model_name' => 'App\\Models\\DocumentType',
  'policy_name' => NULL,
  'controller' => 'App\\Http\\Controllers\\DocumentTypeController',
  'description' => NULL,
  'generate_permissions' => 1,
  'server_side' => 1,
  'details' => '{"order_column":"id","order_display_column":null,"order_direction":"desc","default_search_key":null,"scope":null}',
  'created_at' => '2024-09-30 08:39:39',
  'updated_at' => '2025-02-17 14:48:33',
)
        );

        DB::table('data_rows')->where('data_type_id', 14)->delete();

        DB::table('data_rows')->insert(array (
  'data_type_id' => 14,
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
  'data_type_id' => 14,
  'field' => 'name',
  'type' => 'text',
  'display_name' => 'Name',
  'required' => 1,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 0,
  'details' => '{"validation":{"rule":"required"}}',
  'order' => 2,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 14,
  'field' => 'status',
  'type' => 'checkbox',
  'display_name' => 'Status',
  'required' => 1,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 0,
  'details' => '{"on":"Active","off":"Inactive","checked":false}',
  'order' => 3,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 14,
  'field' => 'created_at',
  'type' => 'timestamp',
  'display_name' => 'Created Datetime',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 4,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 14,
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
  'order' => 5,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 14,
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
  'data_type_id' => 14,
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
