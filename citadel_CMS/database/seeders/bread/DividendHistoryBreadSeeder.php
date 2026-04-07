<?php

namespace Database\Seeders\Bread;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class DividendHistoryBreadSeeder extends Seeder
{
    public function run()
    {
        DB::table('data_types')->updateOrInsert(
            ['slug' => 'dividend-history'],
            array (
  'id' => 28,
  'name' => 'product_dividend_history',
  'slug' => 'dividend-history',
  'display_name_singular' => 'Profit Sharing Management',
  'display_name_plural' => 'Profit Sharing Files Management',
  'icon' => NULL,
  'model_name' => 'App\\Models\\ProductDividendHistory',
  'policy_name' => NULL,
  'controller' => 'App\\Http\\Controllers\\ProductDividendHistoryController',
  'description' => NULL,
  'generate_permissions' => 1,
  'server_side' => 1,
  'details' => '{"order_column":null,"order_display_column":null,"order_direction":"asc","default_search_key":null,"scope":null}',
  'created_at' => '2024-12-17 11:38:55',
  'updated_at' => '2025-08-19 13:38:33',
)
        );

        DB::table('data_rows')->where('data_type_id', 28)->delete();

        DB::table('data_rows')->insert(array (
  'data_type_id' => 28,
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
  'data_type_id' => 28,
  'field' => 'dividend_csv_key',
  'type' => 'file',
  'display_name' => 'Profit Sharing File',
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
  'data_type_id' => 28,
  'field' => 'status_checker',
  'type' => 'text',
  'display_name' => 'Status Checker',
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
  'data_type_id' => 28,
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
  'order' => 5,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 28,
  'field' => 'status_approver',
  'type' => 'text',
  'display_name' => 'Status Approver',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 6,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 28,
  'field' => 'remarks_approver',
  'type' => 'text',
  'display_name' => 'Remarks Approver',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 1,
  'details' => '{}',
  'order' => 7,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 28,
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
  'data_type_id' => 28,
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
  'data_type_id' => 28,
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
  'data_type_id' => 28,
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
  'data_type_id' => 28,
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
  'data_type_id' => 28,
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
  'data_type_id' => 28,
  'field' => 'generated_bank_file',
  'type' => 'checkbox',
  'display_name' => 'Generated Bank File',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"on":"TRUE","off":"FALSE","checked":false}',
  'order' => 13,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 28,
  'field' => 'csv_file_name',
  'type' => 'text',
  'display_name' => 'Profit Sharing File Name',
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
  'data_type_id' => 28,
  'field' => 'bank_result_csv',
  'type' => 'file',
  'display_name' => 'Bank Result File',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{}',
  'order' => 15,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 28,
  'field' => 'updated_bank_result',
  'type' => 'checkbox',
  'display_name' => 'Updated Bank Result',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"on":"TRUE","off":"FALSE","checked":false}',
  'order' => 16,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 28,
  'field' => 'updated_dividend_csv_key',
  'type' => 'text',
  'display_name' => 'Updated Dividend Csv Key',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 4,
));

    }
}
