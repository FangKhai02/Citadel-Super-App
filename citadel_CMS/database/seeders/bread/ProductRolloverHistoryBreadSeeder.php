<?php

namespace Database\Seeders\Bread;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ProductRolloverHistoryBreadSeeder extends Seeder
{
    public function run()
    {
        DB::table('data_types')->updateOrInsert(
            ['slug' => 'product-rollover-history'],
            array (
  'id' => 41,
  'name' => 'product_rollover_history',
  'slug' => 'product-rollover-history',
  'display_name_singular' => 'Product Rollover History',
  'display_name_plural' => 'Product Rollover Histories',
  'icon' => NULL,
  'model_name' => 'App\\Models\\ProductRolloverHistory',
  'policy_name' => NULL,
  'controller' => 'App\\Http\\Controllers\\ProductRolloverHistoryController',
  'description' => NULL,
  'generate_permissions' => 1,
  'server_side' => 1,
  'details' => '{"order_column":null,"order_display_column":null,"order_direction":"asc","default_search_key":null,"scope":null}',
  'created_at' => '2025-02-28 11:57:22',
  'updated_at' => '2025-03-11 14:08:17',
)
        );

        DB::table('data_rows')->where('data_type_id', 41)->delete();

        DB::table('data_rows')->insert(array (
  'data_type_id' => 41,
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
  'data_type_id' => 41,
  'field' => 'product_order_id',
  'type' => 'text',
  'display_name' => 'Product Order Id',
  'required' => 1,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 12,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 41,
  'field' => 'amount',
  'type' => 'text',
  'display_name' => 'Amount',
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
  'data_type_id' => 41,
  'field' => 'status',
  'type' => 'text',
  'display_name' => 'Status',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 15,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 41,
  'field' => 'status_checker',
  'type' => 'text',
  'display_name' => 'Status Checker',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 16,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 41,
  'field' => 'remark_checker',
  'type' => 'text',
  'display_name' => 'Remark Checker',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 17,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 41,
  'field' => 'checked_by',
  'type' => 'text',
  'display_name' => 'Checked By',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 18,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 41,
  'field' => 'checker_updated_at',
  'type' => 'timestamp',
  'display_name' => 'Checker Updated At',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 19,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 41,
  'field' => 'status_approver',
  'type' => 'text',
  'display_name' => 'Status Approver',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 20,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 41,
  'field' => 'remark_approver',
  'type' => 'text',
  'display_name' => 'Remark Approver',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 21,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 41,
  'field' => 'approved_by',
  'type' => 'text',
  'display_name' => 'Approved By',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 22,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 41,
  'field' => 'approver_updated_at',
  'type' => 'timestamp',
  'display_name' => 'Approver Updated At',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 23,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 41,
  'field' => 'agreement_key',
  'type' => 'text',
  'display_name' => 'Agreement Key',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 24,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 41,
  'field' => 'agreement_date',
  'type' => 'text',
  'display_name' => 'Agreement Date',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 25,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 41,
  'field' => 'created_at',
  'type' => 'timestamp',
  'display_name' => 'Created At',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 26,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 41,
  'field' => 'created_by',
  'type' => 'text',
  'display_name' => 'Created By',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 27,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 41,
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
  'order' => 28,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 41,
  'field' => 'product_rollover_history_hasone_product_rollover_history_relationship',
  'type' => 'relationship',
  'display_name' => 'Client',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\ProductRolloverHistory","table":"product_rollover_history","type":"hasOne","column":"id","key":"id","label":"client_name","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 2,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 41,
  'field' => 'product_rollover_history_hasone_product_rollover_history_relationship_1',
  'type' => 'relationship',
  'display_name' => 'Agreement',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\ProductRolloverHistory","table":"product_rollover_history","type":"hasOne","column":"id","key":"id","label":"agreement_number","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 10,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 41,
  'field' => 'product_rollover_history_hasone_product_rollover_history_relationship_2',
  'type' => 'relationship',
  'display_name' => 'Permanent Address',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\ProductRolloverHistory","table":"product_rollover_history","type":"hasOne","column":"id","key":"id","label":"permanent_address","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 7,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 41,
  'field' => 'product_rollover_history_hasone_product_rollover_history_relationship_3',
  'type' => 'relationship',
  'display_name' => 'Mobile Number',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\ProductRolloverHistory","table":"product_rollover_history","type":"hasOne","column":"id","key":"id","label":"mobile_number","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 8,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 41,
  'field' => 'product_rollover_history_hasone_product_rollover_history_relationship_4',
  'type' => 'relationship',
  'display_name' => 'Email Address',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\ProductRolloverHistory","table":"product_rollover_history","type":"hasOne","column":"id","key":"id","label":"email_address","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 9,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 41,
  'field' => 'product_rollover_history_hasone_product_rollover_history_relationship_5',
  'type' => 'relationship',
  'display_name' => 'Client ID Number',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\ProductRolloverHistory","table":"product_rollover_history","type":"hasOne","column":"id","key":"id","label":"id_number","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 5,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 41,
  'field' => 'product_rollover_history_hasone_product_rollover_history_relationship_6',
  'type' => 'relationship',
  'display_name' => 'Product Name',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\ProductRolloverHistory","table":"product_rollover_history","type":"hasOne","column":"id","key":"id","label":"product_name","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 11,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 41,
  'field' => 'product_rollover_history_hasone_product_rollover_history_relationship_7',
  'type' => 'relationship',
  'display_name' => 'Created By',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\ProductRolloverHistory","table":"product_rollover_history","type":"hasOne","column":"id","key":"id","label":"created_by_email","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 29,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 41,
  'field' => 'product_rollover_history_hasone_product_rollover_history_relationship_8',
  'type' => 'relationship',
  'display_name' => 'Client Digital ID',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\ProductRolloverHistory","table":"product_rollover_history","type":"hasOne","column":"id","key":"id","label":"client_digital_id","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 4,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 41,
  'field' => 'product_rollover_history_hasone_product_order_relationship',
  'type' => 'relationship',
  'display_name' => 'Order Reference Number',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\ProductOrder","table":"product_order","type":"belongsTo","column":"product_order_id","key":"id","label":"order_reference_number","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 3,
));

    }
}
