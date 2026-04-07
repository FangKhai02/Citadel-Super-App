<?php

namespace Database\Seeders\Bread;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ProductEarlyRedemptionHistoryBreadSeeder extends Seeder
{
    public function run()
    {
        DB::table('data_types')->updateOrInsert(
            ['slug' => 'product-early-redemption-history'],
            array (
  'id' => 43,
  'name' => 'product_early_redemption_history',
  'slug' => 'product-early-redemption-history',
  'display_name_singular' => 'Product Early Redemption',
  'display_name_plural' => 'Product Early Redemptions',
  'icon' => NULL,
  'model_name' => 'App\\Models\\ProductWithdrawalHistory',
  'policy_name' => NULL,
  'controller' => 'App\\Http\\Controllers\\ProductEarlyRedemptionHistoryController',
  'description' => NULL,
  'generate_permissions' => 1,
  'server_side' => 1,
  'details' => '{"order_column":null,"order_display_column":null,"order_direction":"asc","default_search_key":null,"scope":null}',
  'created_at' => '2025-03-15 23:08:58',
  'updated_at' => '2025-04-30 15:00:34',
)
        );

        DB::table('data_rows')->where('data_type_id', 43)->delete();

        DB::table('data_rows')->insert(array (
  'data_type_id' => 43,
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
  'data_type_id' => 43,
  'field' => 'redemption_reference_number',
  'type' => 'text',
  'display_name' => 'Redemption Reference Number',
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
  'data_type_id' => 43,
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
  'order' => 3,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 43,
  'field' => 'order_reference_number',
  'type' => 'text',
  'display_name' => 'Order Reference Number',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 6,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 43,
  'field' => 'withdrawal_method',
  'type' => 'select_dropdown',
  'display_name' => 'Withdrawal Method',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"default":"PARTIAL_AMOUNT","options":{"ALL":"ALL","PARTIAL_AMOUNT":"PARTIAL"}}',
  'order' => 7,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 43,
  'field' => 'withdrawal_amount',
  'type' => 'text',
  'display_name' => 'Withdrawal Amount',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 9,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 43,
  'field' => 'penalty_amount',
  'type' => 'text',
  'display_name' => 'Penalty Amount',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 11,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 43,
  'field' => 'penalty_percentage',
  'type' => 'text',
  'display_name' => 'Penalty Percentage',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 12,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 43,
  'field' => 'withdrawal_reason',
  'type' => 'text',
  'display_name' => 'Withdrawal Reason',
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
  'data_type_id' => 43,
  'field' => 'withdrawal_status',
  'type' => 'text',
  'display_name' => 'Withdrawal Status',
  'required' => 1,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 14,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 43,
  'field' => 'withdrawal_agreement_key',
  'type' => 'file',
  'display_name' => 'Withdrawal Agreement',
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
  'data_type_id' => 43,
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
  'data_type_id' => 43,
  'field' => 'updated_by',
  'type' => 'text',
  'display_name' => 'Updated By',
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
  'data_type_id' => 43,
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
  'order' => 18,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 43,
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
  'order' => 19,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 43,
  'field' => 'status_approver',
  'type' => 'select_dropdown',
  'display_name' => 'Status Approver',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"default":"PENDING_APPROVER","options":{"APPROVE_APPROVER":"APPROVED","PENDING_APPROVER":"PENDING","REJECT_APPROVER":"REJECTED"}}',
  'order' => 20,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 43,
  'field' => 'remark_approver',
  'type' => 'text',
  'display_name' => 'Remark Approver',
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
  'data_type_id' => 43,
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
  'order' => 22,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 43,
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
  'order' => 23,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 43,
  'field' => 'status_checker',
  'type' => 'select_dropdown',
  'display_name' => 'Status Checker',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"default":"PENDING_CHECKER","options":{"APPROVE_CHECKER":"APPROVED","PENDING_CHECKER":"PENDING","REJECT_CHECKER":"REJECTED"}}',
  'order' => 24,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 43,
  'field' => 'remark_checker',
  'type' => 'text',
  'display_name' => 'Remark Checker',
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
  'data_type_id' => 43,
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
  'order' => 26,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 43,
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
  'order' => 27,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 43,
  'field' => 'client_signature_status',
  'type' => 'text',
  'display_name' => 'Client Signature Status',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 28,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 43,
  'field' => 'client_signature_key',
  'type' => 'text',
  'display_name' => 'Client Signature Key',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 29,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 43,
  'field' => 'client_signature_date',
  'type' => 'text',
  'display_name' => 'Client Signature Date',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 30,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 43,
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
  'order' => 31,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 43,
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
  'order' => 33,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 43,
  'field' => 'product_early_redemption_history_belongsto_product_order_relationship',
  'type' => 'relationship',
  'display_name' => 'Fund Agreement',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\ProductOrder","table":"product_order","type":"belongsTo","column":"product_order_id","key":"id","label":"agreement_file_name","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 5,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 43,
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
  'order' => 32,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 43,
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
  'order' => 34,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 43,
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
  'order' => 35,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 43,
  'field' => 'product_early_redemption_history_hasone_product_early_redemption_history_relationship',
  'type' => 'relationship',
  'display_name' => 'Client Name',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\ProductWithdrawalHistory","table":"product_early_redemption_history","type":"hasOne","column":"id","key":"id","label":"client_name","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 2,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 43,
  'field' => 'product_early_redemption_history_hasone_product_early_redemption_history_relationship_1',
  'type' => 'relationship',
  'display_name' => 'Withdrawal Amount (RM)',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\ProductWithdrawalHistory","table":"product_early_redemption_history","type":"hasOne","column":"id","key":"id","label":"formatted_withdrawal_amount","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 8,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 43,
  'field' => 'product_early_redemption_history_hasone_product_early_redemption_history_relationship_2',
  'type' => 'relationship',
  'display_name' => 'Penalty Amount (RM)',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\ProductWithdrawalHistory","table":"product_early_redemption_history","type":"hasOne","column":"id","key":"id","label":"formatted_penalty_amount","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 10,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 43,
  'field' => 'witness_signature_status',
  'type' => 'text',
  'display_name' => 'Witness Signature Status',
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
  'data_type_id' => 43,
  'field' => 'agent_id',
  'type' => 'text',
  'display_name' => 'Agent Id',
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
  'data_type_id' => 43,
  'field' => 'supporting_document_key',
  'type' => 'file',
  'display_name' => 'Supporting Document',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 34,
));

    }
}
