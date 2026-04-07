<?php

namespace Database\Seeders\Bread;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ProductOrderBreadSeeder extends Seeder
{
    public function run()
    {
        DB::table('data_types')->updateOrInsert(
            ['slug' => 'product-order'],
            array (
  'id' => 23,
  'name' => 'product_order',
  'slug' => 'product-order',
  'display_name_singular' => 'Product Order',
  'display_name_plural' => 'Product Orders',
  'icon' => NULL,
  'model_name' => 'App\\Models\\ProductOrder',
  'policy_name' => NULL,
  'controller' => 'App\\Http\\Controllers\\ProductOrderController',
  'description' => NULL,
  'generate_permissions' => 1,
  'server_side' => 1,
  'details' => '{"order_column":"id","order_display_column":null,"order_direction":"desc","default_search_key":null,"scope":null}',
  'created_at' => '2024-10-11 18:12:37',
  'updated_at' => '2025-07-16 11:50:07',
)
        );

        DB::table('data_rows')->where('data_type_id', 23)->delete();

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
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
  'data_type_id' => 23,
  'field' => 'client_id',
  'type' => 'text',
  'display_name' => 'Client Id',
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
  'data_type_id' => 23,
  'field' => 'corporate_client_id',
  'type' => 'text',
  'display_name' => 'Corporate Client Id',
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
  'data_type_id' => 23,
  'field' => 'product_id',
  'type' => 'text',
  'display_name' => 'Product Id',
  'required' => 1,
  'browse' => 1,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 7,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'bank_details_id',
  'type' => 'text',
  'display_name' => 'Bank Details Id',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 73,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
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
  'order' => 17,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
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
  'order' => 50,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'created_by',
  'type' => 'text',
  'display_name' => 'Created By',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 48,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'order_reference_number',
  'type' => 'text',
  'display_name' => 'Order ID',
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
  'data_type_id' => 23,
  'field' => 'purchased_amount',
  'type' => 'text',
  'display_name' => 'Placement Amount (RM)',
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
  'data_type_id' => 23,
  'field' => 'dividend',
  'type' => 'text',
  'display_name' => 'Expected Profit Sharing (%) Per Annum',
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
  'data_type_id' => 23,
  'field' => 'investment_tenure_month',
  'type' => 'text',
  'display_name' => 'Investment Tenure Month',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 52,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
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
  'order' => 39,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'submission_date',
  'type' => 'timestamp',
  'display_name' => 'Submission Date',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 54,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
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
  'order' => 49,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'payment_method',
  'type' => 'text',
  'display_name' => 'Payment Method',
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
  'data_type_id' => 23,
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
  'order' => 23,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
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
  'order' => 55,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'status_finance',
  'type' => 'text',
  'display_name' => 'Finance Status',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 29,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'remark_finance',
  'type' => 'text',
  'display_name' => 'Finance Remark',
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
  'data_type_id' => 23,
  'field' => 'financed_by',
  'type' => 'text',
  'display_name' => 'Finance Updated By',
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
  'data_type_id' => 23,
  'field' => 'finance_updated_at',
  'type' => 'timestamp',
  'display_name' => 'Finance Updated Date',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 32,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'status_checker',
  'type' => 'text',
  'display_name' => 'Checker Status',
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
  'data_type_id' => 23,
  'field' => 'remark_checker',
  'type' => 'text',
  'display_name' => 'Checker Remark',
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
  'data_type_id' => 23,
  'field' => 'checked_by',
  'type' => 'text',
  'display_name' => 'Checker Updated By',
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
  'data_type_id' => 23,
  'field' => 'checker_updated_at',
  'type' => 'timestamp',
  'display_name' => 'Checker Updated Date',
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
  'data_type_id' => 23,
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
  'order' => 33,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'remark_approver',
  'type' => 'text',
  'display_name' => 'Approver Remark',
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
  'data_type_id' => 23,
  'field' => 'approved_by',
  'type' => 'text',
  'display_name' => 'Approver Updated By',
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
  'data_type_id' => 23,
  'field' => 'approver_updated_at',
  'type' => 'timestamp',
  'display_name' => 'Approver Updated Date',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 36,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'agreement_key',
  'type' => 'file',
  'display_name' => 'Declaration of Trust & Trust Deed (e-Signed)',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 41,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'agreement_date',
  'type' => 'date',
  'display_name' => 'Agreement Date',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"format":"%Y-%m-%d"}',
  'order' => 11,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'client_agreement_status',
  'type' => 'text',
  'display_name' => 'Client Agreement Status',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 56,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'witness_agreement_status',
  'type' => 'text',
  'display_name' => 'Witness Agreement Status',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 57,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'start_tenure',
  'type' => 'date',
  'display_name' => 'Start Tenure',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"format":"%Y-%m-%d"}',
  'order' => 37,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'end_tenure',
  'type' => 'date',
  'display_name' => 'End Tenure',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"format":"%Y-%m-%d"}',
  'order' => 38,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'period_starting_date',
  'type' => 'date',
  'display_name' => 'Period Starting Date',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 59,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'period_ending_date',
  'type' => 'date',
  'display_name' => 'Period Ending Date',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 61,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'official_receipt_key',
  'type' => 'file',
  'display_name' => 'Official Receipt',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 1,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 45,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'official_receipt_date',
  'type' => 'timestamp',
  'display_name' => 'Official Receipt Date',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 62,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'soa_key',
  'type' => 'file',
  'display_name' => 'Statement of Account',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 47,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'soa_date',
  'type' => 'timestamp',
  'display_name' => 'Soa Date',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 65,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'is_prorated',
  'type' => 'text',
  'display_name' => 'Is Prorated',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 67,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'structure_type',
  'type' => 'text',
  'display_name' => 'Structure Type',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 68,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'payout_frequency',
  'type' => 'text',
  'display_name' => 'Payout Frequency',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 70,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'last_dividend_calculation_date',
  'type' => 'timestamp',
  'display_name' => 'Last Dividend Calculation Date',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 72,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'product_order_belongsto_product_relationship',
  'type' => 'relationship',
  'display_name' => 'Product',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\Product","table":"product","type":"belongsTo","column":"product_id","key":"id","label":"code","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 8,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'product_order_belongstomany_product_order_payment_receipt_relationship',
  'type' => 'relationship',
  'display_name' => 'Payment Attachment',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\ProductOrderPaymentReceipt","table":"product_order_payment_receipt","type":"hasMany","column":"product_order_id","key":"id","label":"payment_receipt_key","pivot_table":"product_order_payment_receipt","pivot":"0","taggable":"0"}',
  'order' => 40,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'remark',
  'type' => 'text',
  'display_name' => 'Remark',
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
  'data_type_id' => 23,
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
  'order' => 51,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'client_signature_date',
  'type' => 'text',
  'display_name' => 'Client Signature Date',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 53,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'product_order_type',
  'type' => 'select_dropdown',
  'display_name' => 'Product Order Type',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"default":"NEW","options":{"NEW":"New","ROLLOVER":"Rollover","REALLOCATE":"Reallocate"}}',
  'order' => 16,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'client_name',
  'type' => 'text',
  'display_name' => 'Client Name',
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
  'data_type_id' => 23,
  'field' => 'agent_id',
  'type' => 'text',
  'display_name' => 'Agent Id',
  'required' => 0,
  'browse' => 1,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 13,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'agency_id',
  'type' => 'text',
  'display_name' => 'Agency Id',
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
  'data_type_id' => 23,
  'field' => 'agreement_file_name',
  'type' => 'text',
  'display_name' => 'Agreement Number',
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
  'data_type_id' => 23,
  'field' => 'product_order_belongsto_product_order_relationship',
  'type' => 'relationship',
  'display_name' => 'Client Type',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\ProductOrder","table":"product_order","type":"hasOne","column":"id","key":"id","label":"client_type","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 5,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'product_order_hasone_product_order_relationship',
  'type' => 'relationship',
  'display_name' => 'Client ID',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\ProductOrder","table":"product_order","type":"hasOne","column":"id","key":"id","label":"purchaser_id","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 4,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'product_order_belongsto_agent_relationship',
  'type' => 'relationship',
  'display_name' => 'Agent',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\Agent","table":"agent","type":"belongsTo","column":"agent_id","key":"id","label":"agent_id","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 12,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'product_order_belongsto_app_user_relationship',
  'type' => 'relationship',
  'display_name' => 'Created By',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\AppUser","table":"app_users","type":"belongsTo","column":"created_by","key":"id","label":"user_type","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 14,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'profit_sharing_schedule_key',
  'type' => 'file',
  'display_name' => 'Profit Sharing Schedule',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 46,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'dividend_counter',
  'type' => 'text',
  'display_name' => 'Dividend Counter',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 63,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'product_order_hasone_product_order_relationship_1',
  'type' => 'relationship',
  'display_name' => 'Order Type',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\ProductOrder","table":"product_order","type":"hasOne","column":"id","key":"id","label":"order_type","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 15,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'product_order_hasone_product_order_relationship_2',
  'type' => 'relationship',
  'display_name' => 'Placement Amount (RM)',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\ProductOrder","table":"product_order","type":"hasOne","column":"id","key":"id","label":"formatted_amount","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 9,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'enable_living_trust',
  'type' => 'checkbox',
  'display_name' => 'Enable Living Trust',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"on":"Yes","off":"No","checked":false}',
  'order' => 58,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'product_order_hasone_product_order_relationship_3',
  'type' => 'relationship',
  'display_name' => 'ID Number',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\ProductOrder","table":"product_order","type":"hasOne","column":"id","key":"id","label":"id_number","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 74,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'imported',
  'type' => 'text',
  'display_name' => 'Imported',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 60,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'unsigned_agreement_key',
  'type' => 'file',
  'display_name' => 'Declaration of Trust & Trust Deed (Unsigned)',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 42,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'physical_signed_agreement_files',
  'type' => 'multiple_file',
  'display_name' => 'Declaration of Trust & Trust Deed (Physical Signed)',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 1,
  'add' => 0,
  'delete' => 0,
  'details' => '{"accept":".pdf"}',
  'order' => 43,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'physical_signed_agreement_files_updated_at',
  'type' => 'timestamp',
  'display_name' => 'Physical Signed Agreement Files Updated At',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 64,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'physical_signed_agreement_files_updated_by',
  'type' => 'text',
  'display_name' => 'Physical Signed Agreement Files Updated By',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 66,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'received_physical_signed_agreement_files',
  'type' => 'checkbox',
  'display_name' => 'Receive Status',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 0,
  'delete' => 0,
  'details' => '{"on":"Yes","off":"No","checked":false}',
  'order' => 44,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'received_physical_signed_agreement_files_updated_at',
  'type' => 'timestamp',
  'display_name' => 'Received Physical Signed Agreement Files Updated At',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 69,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 23,
  'field' => 'received_physical_signed_agreement_files_updated_by',
  'type' => 'text',
  'display_name' => 'Received Physical Signed Agreement Files Updated By',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 71,
));

    }
}
