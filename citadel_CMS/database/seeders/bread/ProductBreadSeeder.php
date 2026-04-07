<?php

namespace Database\Seeders\Bread;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ProductBreadSeeder extends Seeder
{
    public function run()
    {
        DB::table('data_types')->updateOrInsert(
            ['slug' => 'product'],
            array (
  'id' => 13,
  'name' => 'product',
  'slug' => 'product',
  'display_name_singular' => 'Product Configuration',
  'display_name_plural' => 'Product Configuration',
  'icon' => NULL,
  'model_name' => 'App\\Models\\Product',
  'policy_name' => NULL,
  'controller' => 'App\\Http\\Controllers\\ProductController',
  'description' => NULL,
  'generate_permissions' => 1,
  'server_side' => 1,
  'details' => '{"order_column":"created_at","order_display_column":null,"order_direction":"desc","default_search_key":null,"scope":null}',
  'created_at' => '2024-09-30 08:26:46',
  'updated_at' => '2025-04-23 18:19:43',
)
        );

        DB::table('data_rows')->where('data_type_id', 13)->delete();

        DB::table('data_rows')->insert(array (
  'data_type_id' => 13,
  'field' => 'id',
  'type' => 'text',
  'display_name' => 'Product ID',
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
  'data_type_id' => 13,
  'field' => 'product_type_id',
  'type' => 'text',
  'display_name' => 'Product Type ID',
  'required' => 1,
  'browse' => 0,
  'read' => 0,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{}',
  'order' => 3,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 13,
  'field' => 'product_description',
  'type' => 'text_area',
  'display_name' => 'Description',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{}',
  'order' => 6,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 13,
  'field' => 'incremental',
  'type' => 'number',
  'display_name' => 'Multiples of (RM)',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"validation":{"rule":"required"}}',
  'order' => 11,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 13,
  'field' => 'investment_tenure_month',
  'type' => 'number',
  'display_name' => 'Trust Tenure (Months)',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"validation":{"rule":"required"}}',
  'order' => 7,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 13,
  'field' => 'product_catalogue_url',
  'type' => 'file',
  'display_name' => 'Product Catalogue',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{}',
  'order' => 21,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 13,
  'field' => 'image_of_product_url',
  'type' => 'image',
  'display_name' => 'Product Image',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{}',
  'order' => 22,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 13,
  'field' => 'status',
  'type' => 'checkbox',
  'display_name' => 'Status',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"on":"Enabled","off":"Disabled","checked":false}',
  'order' => 25,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 13,
  'field' => 'created_at',
  'type' => 'timestamp',
  'display_name' => 'Created Date',
  'required' => 0,
  'browse' => 1,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 29,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 13,
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
  'order' => 31,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 13,
  'field' => 'product_belongsto_product_type_relationship',
  'type' => 'relationship',
  'display_name' => 'Category',
  'required' => 1,
  'browse' => 0,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"scope":"active","model":"App\\\\Models\\\\ProductType","table":"product_type","type":"belongsTo","column":"product_type_id","key":"id","label":"name","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 2,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 13,
  'field' => 'product_belongsto_product_agreement_relationship',
  'type' => 'relationship',
  'display_name' => 'Agreement',
  'required' => 1,
  'browse' => 0,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"scope":"active","model":"App\\\\Models\\\\ProductAgreement","table":"product_agreement","type":"belongsToMany","column":"id","key":"id","label":"name","pivot_table":"product_agreement_pivot","pivot":"1","taggable":"0"}',
  'order' => 20,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 13,
  'field' => 'name',
  'type' => 'text',
  'display_name' => 'Product Name',
  'required' => 1,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"validation":{"rule":"required"}}',
  'order' => 4,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 13,
  'field' => 'code',
  'type' => 'text',
  'display_name' => 'Product Code',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"validation":{"rule":"required"}}',
  'order' => 5,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 13,
  'field' => 'tranche_size',
  'type' => 'text',
  'display_name' => 'Fund Size (RM)',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"validation":{"rule":"required"}}',
  'order' => 9,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 13,
  'field' => 'minimum_subscription_amount',
  'type' => 'text',
  'display_name' => 'Minimum Subscription Amount (RM)',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"validation":{"rule":"required"}}',
  'order' => 10,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 13,
  'field' => 'lock_in_period_option',
  'type' => 'select_dropdown',
  'display_name' => 'Lock In Period Option',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"default":"YEAR","options":{"YEAR":"Year","MONTH":"Month"},"validation":{"rule":"required"}}',
  'order' => 12,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 13,
  'field' => 'lock_in_period_value',
  'type' => 'text',
  'display_name' => 'Lock In Period',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"validation":{"rule":"required"}}',
  'order' => 13,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 13,
  'field' => 'trust_structure_id',
  'type' => 'select_dropdown',
  'display_name' => 'Trust Structure',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"default":"Mudarabah","options":{"MUDARABAH":"Mudarabah"}}',
  'order' => 15,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 13,
  'field' => 'bank_name',
  'type' => 'select_dropdown',
  'display_name' => 'Bank Name',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"default":"CIMB","options":{"CIMB":"CIMB","AFFIN":"AFFIN"}}',
  'order' => 17,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 13,
  'field' => 'is_published',
  'type' => 'checkbox',
  'display_name' => 'Publish',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"on":"Yes","off":"No","checked":false}',
  'order' => 23,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 13,
  'field' => 'product_hasone_product_relationship_1',
  'type' => 'relationship',
  'display_name' => 'Agency',
  'required' => 1,
  'browse' => 0,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"model":"App\\\\Models\\\\Agency","table":"agency","type":"belongsToMany","column":"id","key":"id","label":"agency_code","pivot_table":"agency_product","pivot":"1","taggable":"0"}',
  'order' => 14,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 13,
  'field' => 'is_prorated',
  'type' => 'checkbox',
  'display_name' => 'Prorated',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"on":"Yes","off":"No","checked":false}',
  'order' => 8,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 13,
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
  'order' => 30,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 13,
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
  'order' => 32,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 13,
  'field' => 'product_hasmany_product_target_return_relationship',
  'type' => 'relationship',
  'display_name' => 'product_target_return',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\ProductTargetReturn","table":"product_target_return","type":"hasMany","column":"product_id","key":"id","label":"id","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 33,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 13,
  'field' => 'product_hasmany_product_reallocation_relationship',
  'type' => 'relationship',
  'display_name' => 'Reallocation Upon Maturity (Fund Name)',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"foreign_pivot_key":"product_id","related_pivot_key":"reallocatable_product_id","parent_key":"id","model":"App\\\\Models\\\\Product","table":"product","type":"belongsToMany","column":"id","key":"id","label":"code","pivot_table":"product_reallocation_configuration","pivot":"1","taggable":"on"}',
  'order' => 16,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 13,
  'field' => 'profit_sharing_footer_note',
  'type' => 'rich_text_box',
  'display_name' => 'Profit Sharing Footer Note',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{}',
  'order' => 24,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 13,
  'field' => 'bank_account_name',
  'type' => 'text',
  'display_name' => 'Bank Account Name',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{}',
  'order' => 18,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 13,
  'field' => 'bank_account_number',
  'type' => 'text',
  'display_name' => 'Bank Account Number',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{}',
  'order' => 19,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 13,
  'field' => 'enable_living_trust',
  'type' => 'checkbox',
  'display_name' => 'Enable Living Trust',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 0,
  'details' => '{"on":"Enabled","off":"Disabled","checked":true}',
  'order' => 26,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 13,
  'field' => 'trustee_fee_first_dividend',
  'type' => 'select_dropdown',
  'display_name' => 'Trustee Fee First Dividend (%)',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 0,
  'details' => '{"default":0,"options":{"0":"0","1":"1","2":"2"}}',
  'order' => 27,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 13,
  'field' => 'trustee_fee_last_dividend',
  'type' => 'select_dropdown',
  'display_name' => 'Trustee Fee Last Dividend (%)',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 0,
  'details' => '{"default":0,"options":{"0":"0","1":"1","2":"2"}}',
  'order' => 28,
));

    }
}
