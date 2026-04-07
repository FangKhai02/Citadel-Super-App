<?php

namespace Database\Seeders\Bread;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ClientBreadSeeder extends Seeder
{
    public function run()
    {
        DB::table('data_types')->updateOrInsert(
            ['slug' => 'client'],
            array (
  'id' => 9,
  'name' => 'client',
  'slug' => 'client',
  'display_name_singular' => 'Client',
  'display_name_plural' => 'Clients',
  'icon' => NULL,
  'model_name' => 'App\\Models\\Client',
  'policy_name' => NULL,
  'controller' => 'App\\Http\\Controllers\\ClientController',
  'description' => NULL,
  'generate_permissions' => 1,
  'server_side' => 1,
  'details' => '{"order_column":null,"order_display_column":null,"order_direction":"asc","default_search_key":null,"scope":null}',
  'created_at' => '2024-09-26 04:37:20',
  'updated_at' => '2024-12-23 11:25:09',
)
        );

        DB::table('data_rows')->where('data_type_id', 9)->delete();

        DB::table('data_rows')->insert(array (
  'data_type_id' => 9,
  'field' => 'id',
  'type' => 'text',
  'display_name' => 'Client ID Backend',
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
  'data_type_id' => 9,
  'field' => 'user_detail_id',
  'type' => 'text',
  'display_name' => 'User Detail Id',
  'required' => 0,
  'browse' => 1,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 6,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 9,
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
  'order' => 29,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 9,
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
  'order' => 28,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 9,
  'field' => 'client_belongsto_user_detail_relationship',
  'type' => 'relationship',
  'display_name' => 'Name',
  'required' => 0,
  'browse' => 1,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\UserDetails","table":"user_details","type":"belongsTo","column":"user_detail_id","key":"id","label":"name","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 4,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 9,
  'field' => 'client_belongsto_user_detail_relationship_1',
  'type' => 'relationship',
  'display_name' => 'ID Number',
  'required' => 0,
  'browse' => 1,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\UserDetails","table":"user_details","type":"belongsTo","column":"user_detail_id","key":"id","label":"identity_card_number","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 7,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 9,
  'field' => 'client_belongsto_user_detail_relationship_2',
  'type' => 'relationship',
  'display_name' => 'Mobile Number',
  'required' => 0,
  'browse' => 1,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\Client","table":"client","type":"hasOne","column":"id","key":"id","label":"full_mobile_number","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 8,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 9,
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
  'data_type_id' => 9,
  'field' => 'agent_id',
  'type' => 'text',
  'display_name' => 'Agent',
  'required' => 0,
  'browse' => 1,
  'read' => 0,
  'edit' => 1,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 11,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 9,
  'field' => 'status',
  'type' => 'checkbox',
  'display_name' => 'Status',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"on":"Active","off":"Inactive","checked":true}',
  'order' => 12,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 9,
  'field' => 'client_id',
  'type' => 'text',
  'display_name' => 'Client ID',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 1,
  'delete' => 1,
  'details' => '{}',
  'order' => 3,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 9,
  'field' => 'pin',
  'type' => 'text',
  'display_name' => 'Pin',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 1,
  'delete' => 1,
  'details' => '{}',
  'order' => 9,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 9,
  'field' => 'employment_type',
  'type' => 'text',
  'display_name' => 'Employment Type',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 1,
  'delete' => 1,
  'details' => '{}',
  'order' => 10,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 9,
  'field' => 'employer_name',
  'type' => 'text',
  'display_name' => 'Employer Name',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 1,
  'delete' => 1,
  'details' => '{}',
  'order' => 13,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 9,
  'field' => 'industry_type',
  'type' => 'text',
  'display_name' => 'Industry Type',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 1,
  'delete' => 1,
  'details' => '{}',
  'order' => 14,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 9,
  'field' => 'job_title',
  'type' => 'text',
  'display_name' => 'Job Title',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 1,
  'delete' => 1,
  'details' => '{}',
  'order' => 15,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 9,
  'field' => 'employer_address',
  'type' => 'text',
  'display_name' => 'Employer Address',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 1,
  'delete' => 1,
  'details' => '{}',
  'order' => 16,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 9,
  'field' => 'employer_postcode',
  'type' => 'text',
  'display_name' => 'Employer Postcode',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 1,
  'delete' => 1,
  'details' => '{}',
  'order' => 17,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 9,
  'field' => 'employer_city',
  'type' => 'text',
  'display_name' => 'Employer City',
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
  'data_type_id' => 9,
  'field' => 'employer_state',
  'type' => 'text',
  'display_name' => 'Employer State',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 1,
  'delete' => 1,
  'details' => '{}',
  'order' => 19,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 9,
  'field' => 'employer_country',
  'type' => 'text',
  'display_name' => 'Employer Country',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 1,
  'delete' => 1,
  'details' => '{}',
  'order' => 20,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 9,
  'field' => 'annual_income_declaration',
  'type' => 'text',
  'display_name' => 'Annual Income Declaration',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 1,
  'delete' => 1,
  'details' => '{}',
  'order' => 21,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 9,
  'field' => 'source_of_income',
  'type' => 'text',
  'display_name' => 'Source Of Income',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 1,
  'delete' => 1,
  'details' => '{}',
  'order' => 23,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 9,
  'field' => 'source_of_income_remark',
  'type' => 'text',
  'display_name' => 'Source Of Income Remark',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 1,
  'delete' => 1,
  'details' => '{}',
  'order' => 24,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 9,
  'field' => 'pep_info_id',
  'type' => 'text',
  'display_name' => 'Pep Info Id',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 1,
  'delete' => 1,
  'details' => '{}',
  'order' => 5,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 9,
  'field' => 'client_hasone_client_relationship',
  'type' => 'relationship',
  'display_name' => 'Agency Name',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 1,
  'delete' => 1,
  'details' => '{"model":"App\\\\Models\\\\Client","table":"client","type":"hasOne","column":"id","key":"id","label":"agent_agency_name","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 26,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 9,
  'field' => 'client_belongsto_agent_relationship',
  'type' => 'relationship',
  'display_name' => 'Agent',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"model":"App\\\\Models\\\\Agent","table":"agent","type":"belongsTo","column":"agent_id","key":"id","label":"agent_name","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 27,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 9,
  'field' => 'member_id',
  'type' => 'text',
  'display_name' => 'Member Id',
  'required' => 1,
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
