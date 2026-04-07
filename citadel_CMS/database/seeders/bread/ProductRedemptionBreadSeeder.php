<?php

namespace Database\Seeders\Bread;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ProductRedemptionBreadSeeder extends Seeder
{
    public function run()
    {
        DB::table('data_types')->updateOrInsert(
            ['slug' => 'product-redemption'],
            array (
  'id' => 42,
  'name' => 'product_redemption',
  'slug' => 'product-redemption',
  'display_name_singular' => 'Product Redemption Management',
  'display_name_plural' => 'Product Redemptions Management',
  'icon' => NULL,
  'model_name' => 'App\\Models\\ProductRedemption',
  'policy_name' => NULL,
  'controller' => 'App\\Http\\Controllers\\ProductRedemptionController',
  'description' => NULL,
  'generate_permissions' => 1,
  'server_side' => 1,
  'details' => '{"order_column":null,"order_display_column":null,"order_direction":"asc","default_search_key":null,"scope":null}',
  'created_at' => '2025-02-28 14:15:17',
  'updated_at' => '2025-04-15 18:05:43',
)
        );

        DB::table('data_rows')->where('data_type_id', 42)->delete();

        DB::table('data_rows')->insert(array (
  'data_type_id' => 42,
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
  'data_type_id' => 42,
  'field' => 'product_order_id',
  'type' => 'text',
  'display_name' => 'Product Order Id',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 4,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 42,
  'field' => 'fund_status',
  'type' => 'text',
  'display_name' => 'Fund Status',
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
  'data_type_id' => 42,
  'field' => 'type',
  'type' => 'text',
  'display_name' => 'Type',
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
  'data_type_id' => 42,
  'field' => 'amount',
  'type' => 'text',
  'display_name' => 'Amount (RM)',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 8,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 42,
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
  'order' => 10,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 42,
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
  'order' => 12,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 42,
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
  'order' => 14,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 42,
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
  'order' => 16,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 42,
  'field' => 'status_checker',
  'type' => 'select_dropdown',
  'display_name' => 'Status Checker',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"default":"PENDING_CHECKER","options":{"APPROVE_CHECKER":"APPROVED","PENDING_CHECKER":"PENDING","REJECT_CHECKER":"REJECTED"}}',
  'order' => 18,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 42,
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
  'order' => 19,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 42,
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
  'order' => 20,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 42,
  'field' => 'checker_updated_at',
  'type' => 'timestamp',
  'display_name' => 'Checker Updated At',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 21,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 42,
  'field' => 'status_approver',
  'type' => 'select_dropdown',
  'display_name' => 'Status Approver',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"default":"PENDING_APPROVER","options":{"APPROVE_APPROVER":"APPROVED","PENDING_APPROVER":"PENDING","REJECT_APPROVER":"REJECTED"}}',
  'order' => 22,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 42,
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
  'order' => 23,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 42,
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
  'order' => 24,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 42,
  'field' => 'approver_updated_at',
  'type' => 'timestamp',
  'display_name' => 'Approver Updated At',
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
  'data_type_id' => 42,
  'field' => 'product_redemption_belongsto_product_order_relationship',
  'type' => 'relationship',
  'display_name' => 'Agreement Number',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\ProductOrder","table":"product_order","type":"belongsTo","column":"product_order_id","key":"id","label":"agreement_file_name","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 3,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 42,
  'field' => 'payment_status',
  'type' => 'text',
  'display_name' => 'Payment Status',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 9,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 42,
  'field' => 'payment_date',
  'type' => 'timestamp',
  'display_name' => 'Payment Date',
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
  'data_type_id' => 42,
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
  'order' => 13,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 42,
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
  'order' => 15,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 42,
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
  'order' => 17,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 42,
  'field' => 'product_redemption_hasone_product_redemption_relationship',
  'type' => 'relationship',
  'display_name' => 'Client Name',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\ProductRedemption","table":"product_redemption","type":"hasOne","column":"id","key":"id","label":"client_name","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 2,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 42,
  'field' => 'product_redemption_hasone_product_redemption_relationship_1',
  'type' => 'relationship',
  'display_name' => 'Amount (RM)',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\ProductRedemption","table":"product_redemption","type":"hasOne","column":"id","key":"id","label":"formatted_amount","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 7,
));

    }
}
