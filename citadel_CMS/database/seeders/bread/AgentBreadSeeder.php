<?php

namespace Database\Seeders\Bread;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class AgentBreadSeeder extends Seeder
{
    public function run()
    {
        DB::table('data_types')->updateOrInsert(
            ['slug' => 'agent'],
            array (
  'id' => 8,
  'name' => 'agent',
  'slug' => 'agent',
  'display_name_singular' => 'Agent',
  'display_name_plural' => 'Agents',
  'icon' => NULL,
  'model_name' => 'App\\Models\\Agent',
  'policy_name' => NULL,
  'controller' => 'App\\Http\\Controllers\\AgentController',
  'description' => NULL,
  'generate_permissions' => 1,
  'server_side' => 1,
  'details' => '{"order_column":null,"order_display_column":null,"order_direction":"asc","default_search_key":null,"scope":null}',
  'created_at' => '2025-01-17 16:01:44',
  'updated_at' => '2025-03-17 15:03:43',
)
        );

        DB::table('data_rows')->where('data_type_id', 8)->delete();

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'id',
  'type' => 'text',
  'display_name' => 'Agent ID Back',
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
  'data_type_id' => 8,
  'field' => 'referral_code',
  'type' => 'text',
  'display_name' => 'Referral Code',
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
  'data_type_id' => 8,
  'field' => 'created_at',
  'type' => 'timestamp',
  'display_name' => 'Created Datetime',
  'required' => 0,
  'browse' => 1,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 41,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'updated_at',
  'type' => 'timestamp',
  'display_name' => 'Updated Datetime',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 42,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'agent_belongsto_user_detail_relationship',
  'type' => 'relationship',
  'display_name' => 'Name',
  'required' => 0,
  'browse' => 1,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"relation":"userDetails","model":"App\\\\Models\\\\UserDetails","table":"user_details","type":"belongsTo","column":"user_detail_id","key":"id","label":"name","pivot_table":"agent","pivot":"0","taggable":"0"}',
  'order' => 7,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'agency_id',
  'type' => 'text',
  'display_name' => 'Agency Id',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 1,
  'add' => 1,
  'delete' => 0,
  'details' => '{}',
  'order' => 27,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'agent_belongsto_user_detail_relationship_1',
  'type' => 'relationship',
  'display_name' => 'NRIC / Passport No.',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"relation":"group","model":"App\\\\Models\\\\UserDetails","table":"user_details","type":"belongsTo","column":"user_detail_id","key":"id","label":"id","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 9,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'status',
  'type' => 'select_dropdown',
  'display_name' => 'Status',
  'required' => 0,
  'browse' => 1,
  'read' => 0,
  'edit' => 1,
  'add' => 0,
  'delete' => 0,
  'details' => '{"type":"select_dropdown","display_name":"Status","name":"status","options":{"ACTIVE":"Active","INACTIVE":"Inactive","SUSPENDED":"Suspended","TERMINATED":"Terminated"},"default":"ACTIVE","nullable":false}',
  'order' => 25,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'agent_belongsto_agency_relationship',
  'type' => 'relationship',
  'display_name' => 'Agency Name',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 1,
  'add' => 1,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\Agency","table":"agency","type":"belongsTo","column":"agency_id","key":"id","label":"agency_name","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 17,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'agent_hasone_user_detail_relationship',
  'type' => 'relationship',
  'display_name' => 'Gender',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\UserDetails","table":"user_details","type":"belongsTo","column":"user_detail_id","key":"id","label":"gender","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 20,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'agent_belongsto_app_user_relationship',
  'type' => 'relationship',
  'display_name' => 'Email Address',
  'required' => 0,
  'browse' => 1,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\UserDetails","table":"user_details","type":"belongsTo","column":"user_detail_id","key":"id","label":"email","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 13,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'agent_belongsto_user_detail_relationship_3',
  'type' => 'relationship',
  'display_name' => 'Date of Birth',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"relation":"group","model":"App\\\\Models\\\\UserDetails","table":"user_details","type":"belongsTo","column":"user_detail_id","key":"id","label":"dob","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 10,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'agent_belongsto_user_detail_relationship_4',
  'type' => 'relationship',
  'display_name' => 'Permanent Address',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\UserDetails","table":"user_details","type":"belongsTo","column":"user_detail_id","key":"id","label":"address","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 21,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'agent_belongsto_user_detail_relationship_5',
  'type' => 'relationship',
  'display_name' => 'Postcode',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\UserDetails","table":"user_details","type":"belongsTo","column":"user_detail_id","key":"id","label":"postcode","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 22,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'agent_belongsto_user_detail_relationship_6',
  'type' => 'relationship',
  'display_name' => 'City',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\UserDetails","table":"user_details","type":"belongsTo","column":"user_detail_id","key":"id","label":"city","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 23,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'agent_hasone_user_detail_relationship_1',
  'type' => 'relationship',
  'display_name' => 'State',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\UserDetails","table":"user_details","type":"belongsTo","column":"user_detail_id","key":"id","label":"state","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 24,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'agent_hasone_user_detail_relationship_2',
  'type' => 'relationship',
  'display_name' => 'Country',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\UserDetails","table":"user_details","type":"belongsTo","column":"user_detail_id","key":"id","label":"country","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 26,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'agent_belongsto_user_detail_relationship_7',
  'type' => 'relationship',
  'display_name' => 'IC Document',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\UserDetails","table":"user_details","type":"belongsTo","column":"user_detail_id","key":"id","label":"id","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 28,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'agent_belongsto_user_detail_relationship_8',
  'type' => 'relationship',
  'display_name' => 'Address Proof',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\UserDetails","table":"user_details","type":"belongsTo","column":"user_detail_id","key":"id","label":"selfie_document_key","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 29,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'agent_hasone_user_detail_relationship_3',
  'type' => 'relationship',
  'display_name' => 'Selfie Document',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\UserDetails","table":"user_details","type":"belongsTo","column":"user_detail_id","key":"id","label":"selfie_document_key","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 30,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'agent_belongsto_bank_detail_relationship',
  'type' => 'relationship',
  'display_name' => 'Bank Name',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\BankDetails","table":"bank_details","type":"belongsTo","column":"id","key":"id","label":"bank_name","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 31,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'agent_belongsto_bank_detail_relationship_1',
  'type' => 'relationship',
  'display_name' => 'Account Holder Name',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\BankDetails","table":"bank_details","type":"belongsTo","column":"id","key":"id","label":"account_holder_name","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 33,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'agent_belongsto_bank_detail_relationship_2',
  'type' => 'relationship',
  'display_name' => 'Permanent Address',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\BankDetails","table":"bank_details","type":"belongsTo","column":"id","key":"id","label":"permanent_address","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 34,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'agent_hasone_bank_detail_relationship',
  'type' => 'relationship',
  'display_name' => 'Postcode',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\BankDetails","table":"bank_details","type":"belongsTo","column":"id","key":"id","label":"postcode","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 35,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'agent_belongsto_bank_detail_relationship_3',
  'type' => 'relationship',
  'display_name' => 'City',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\BankDetails","table":"bank_details","type":"belongsTo","column":"id","key":"id","label":"city","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 36,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'agent_belongsto_bank_detail_relationship_4',
  'type' => 'relationship',
  'display_name' => 'State',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\BankDetails","table":"bank_details","type":"belongsTo","column":"id","key":"id","label":"state","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 37,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'agent_belongsto_bank_detail_relationship_5',
  'type' => 'relationship',
  'display_name' => 'Country',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\BankDetails","table":"bank_details","type":"belongsTo","column":"id","key":"id","label":"country","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 39,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'agent_belongsto_bank_detail_relationship_6',
  'type' => 'relationship',
  'display_name' => 'SWIFT Code',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\BankDetails","table":"bank_details","type":"belongsTo","column":"id","key":"id","label":"swift_code","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 38,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'agent_belongsto_bank_detail_relationship_7',
  'type' => 'relationship',
  'display_name' => 'Proof of Bank Account',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\BankDetails","table":"bank_details","type":"belongsTo","column":"id","key":"id","label":"bank_account_proof_key","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 40,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'user_detail_id',
  'type' => 'text',
  'display_name' => 'User Detail Id',
  'required' => 1,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 3,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'agent_belongsto_bank_detail_relationship_8',
  'type' => 'relationship',
  'display_name' => 'Account Number',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\BankDetails","table":"bank_details","type":"belongsTo","column":"id","key":"id","label":"account_number","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 32,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'app_user_id',
  'type' => 'text',
  'display_name' => 'App User Id',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 2,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'agent_belongsto_agent_role_setting_relationship',
  'type' => 'relationship',
  'display_name' => 'Agent Role',
  'required' => 1,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"relation":"role","model":"App\\\\Models\\\\AgentRoleSettings","table":"agent_role_settings","type":"belongsTo","column":"agent_role_id","key":"id","label":"role_description","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 8,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'agent_id',
  'type' => 'text',
  'display_name' => 'Agent ID',
  'required' => 1,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 1,
  'delete' => 1,
  'details' => '{}',
  'order' => 4,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'recruit_manager_id',
  'type' => 'text',
  'display_name' => 'Recruit Manager Id',
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
  'data_type_id' => 8,
  'field' => 'agent_belongsto_user_detail_relationship_9',
  'type' => 'relationship',
  'display_name' => 'Recruiter Name',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"scope":"recruiter","model":"App\\\\Models\\\\Agent","table":"agent","type":"belongsTo","column":"recruit_manager_id","key":"id","label":"agent_name","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 14,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'agent_belongsto_agent_role_setting_relationship_1',
  'type' => 'relationship',
  'display_name' => 'Recruiter Role',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 1,
  'delete' => 1,
  'details' => '{"relation":"agent","model":"App\\\\Models\\\\Agent","table":"agent","type":"belongsTo","column":"recruit_manager_id","key":"id","label":"role_display_name","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 16,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'agent_belongsto_user_detail_relationship_10',
  'type' => 'relationship',
  'display_name' => 'Mobile Country Code',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\UserDetails","table":"user_details","type":"belongsTo","column":"user_detail_id","key":"id","label":"mobile_country_code","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 11,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'agent_belongsto_user_detail_relationship_2',
  'type' => 'relationship',
  'display_name' => 'Mobile No',
  'required' => 0,
  'browse' => 1,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\UserDetails","table":"user_details","type":"belongsTo","column":"user_detail_id","key":"id","label":"full_mobile_number","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 12,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'agent_role_id',
  'type' => 'text',
  'display_name' => 'Agent Role Id',
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
  'data_type_id' => 8,
  'field' => 'agency_agreement_date',
  'type' => 'date',
  'display_name' => 'Agency Agreement Date',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 1,
  'delete' => 1,
  'details' => '{}',
  'order' => 15,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'agency_agreement_key',
  'type' => 'file',
  'display_name' => 'Agency Agreement for Agent',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 1,
  'delete' => 1,
  'details' => '{}',
  'order' => 18,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
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
  'order' => 11,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
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
  'order' => 13,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 8,
  'field' => 'pin',
  'type' => 'text',
  'display_name' => 'Pin',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 7,
));

    }
}
