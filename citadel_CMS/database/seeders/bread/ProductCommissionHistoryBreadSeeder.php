<?php

namespace Database\Seeders\Bread;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ProductCommissionHistoryBreadSeeder extends Seeder
{
    public function run()
    {
        DB::table('data_types')->updateOrInsert(
            ['slug' => 'product-commission-history'],
            array (
  'id' => 29,
  'name' => 'product_commission_history',
  'slug' => 'product-commission-history',
  'display_name_singular' => 'Commission File Management',
  'display_name_plural' => 'Commission Files Management',
  'icon' => NULL,
  'model_name' => 'App\\Models\\ProductCommissionHistory',
  'policy_name' => NULL,
  'controller' => 'App\\Http\\Controllers\\ProductCommissionHistoryController',
  'description' => NULL,
  'generate_permissions' => 1,
  'server_side' => 1,
  'details' => '{"order_column":null,"order_display_column":null,"order_direction":"asc","default_search_key":null,"scope":null}',
  'created_at' => '2024-12-17 14:08:24',
  'updated_at' => '2025-03-26 09:13:55',
)
        );

        DB::table('data_rows')->where('data_type_id', 29)->delete();

        DB::table('data_rows')->insert(array (
  'data_type_id' => 29,
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
  'data_type_id' => 29,
  'field' => 'commission_file_id',
  'type' => 'text',
  'display_name' => 'Commission File Name',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 2,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 29,
  'field' => 'commission_csv_key',
  'type' => 'file',
  'display_name' => 'Commission File',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 3,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 29,
  'field' => 'status_checker',
  'type' => 'text',
  'display_name' => 'Status Checker',
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
  'data_type_id' => 29,
  'field' => 'remarks_checker',
  'type' => 'text',
  'display_name' => 'Remarks Checker',
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
  'data_type_id' => 29,
  'field' => 'status_approver',
  'type' => 'text',
  'display_name' => 'Status Approver',
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
  'data_type_id' => 29,
  'field' => 'remarks_approver',
  'type' => 'text',
  'display_name' => 'Remarks Approver',
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
  'data_type_id' => 29,
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
  'order' => 9,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 29,
  'field' => 'updated_at',
  'type' => 'timestamp',
  'display_name' => 'Updated At',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 10,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 29,
  'field' => 'checked_at',
  'type' => 'timestamp',
  'display_name' => 'Checked At',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 11,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 29,
  'field' => 'approved_at',
  'type' => 'timestamp',
  'display_name' => 'Approved At',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 12,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 29,
  'field' => 'checked_by',
  'type' => 'text',
  'display_name' => 'Checked By',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 13,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 29,
  'field' => 'approved_by',
  'type' => 'text',
  'display_name' => 'Approved By',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 14,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 29,
  'field' => 'product_commission_history_hasone_product_commission_history_relationship_1',
  'type' => 'relationship',
  'display_name' => 'Status',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\ProductCommissionHistory","table":"product_commission_history","type":"hasOne","column":"id","key":"id","label":"approve_status","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 4,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 29,
  'field' => 'generated_bank_file',
  'type' => 'text',
  'display_name' => 'Generated Bank File',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 14,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 29,
  'field' => 'bank_result_csv',
  'type' => 'file',
  'display_name' => 'Bank Result File',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 0,
  'details' => '{}',
  'order' => 15,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 29,
  'field' => 'updated_bank_result',
  'type' => 'text',
  'display_name' => 'Updated Bank Result',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 16,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 29,
  'field' => 'agency_type',
  'type' => 'text',
  'display_name' => 'Agency Type',
  'required' => 1,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 2,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 29,
  'field' => 'updated_commission_csv_key',
  'type' => 'text',
  'display_name' => 'Updated Commission Csv Key',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 5,
));

    }
}
