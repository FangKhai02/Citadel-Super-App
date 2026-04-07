<?php

namespace Database\Seeders\Bread;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ProductAgreementScheduleBreadSeeder extends Seeder
{
    public function run()
    {
        DB::table('data_types')->updateOrInsert(
            ['slug' => 'product-agreement-schedule'],
            array (
  'name' => 'product_agreement_schedule',
  'slug' => 'product-agreement-schedule',
  'display_name_singular' => 'Agreement Date Management',
  'display_name_plural' => 'Agreement Date Management',
  'icon' => NULL,
  'model_name' => 'App\\Models\\ProductAgreementSchedule',
  'policy_name' => NULL,
  'controller' => 'App\\Http\\Controllers\\ProductAgreementScheduleController',
  'description' => NULL,
  'generate_permissions' => 1,
  'server_side' => 1,
  'details' => '{"order_column":"approval_due_date","order_display_column":null,"order_direction":"asc","default_search_key":null,"scope":null}',
  'created_at' => '2024-12-27 16:11:35',
  'updated_at' => '2025-02-17 17:26:22',
)
        );

        DB::table('data_rows')->where('data_type_id', 30)->delete();

        DB::table('data_rows')->insert(array (
  'data_type_id' => 30,
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
  'data_type_id' => 30,
  'field' => 'submission_due_date',
  'type' => 'date',
  'display_name' => 'Submission Due Date',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"validation":{"rule":"required"}}',
  'order' => 3,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 30,
  'field' => 'approval_due_date',
  'type' => 'date',
  'display_name' => 'Approval Due Date',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"validation":{"rule":"required"}}',
  'order' => 4,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 30,
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
  'data_type_id' => 30,
  'field' => 'updated_at',
  'type' => 'timestamp',
  'display_name' => 'Updated Date',
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
  'data_type_id' => 30,
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
  'order' => 7,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 30,
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
  'order' => 8,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 30,
  'field' => 'product_agreement_schedule_belongstomany_product_relationship',
  'type' => 'relationship',
  'display_name' => 'Trust category',
  'required' => 1,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"model":"App\\\\Models\\\\ProductType","table":"product_type","type":"belongsToMany","column":"id","key":"id","label":"name","pivot_table":"product_agreement_schedule_pivot","pivot":"1","taggable":"0"}',
  'order' => 2,
));

    }
}
