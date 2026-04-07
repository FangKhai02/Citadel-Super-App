<?php

namespace Database\Seeders\Bread;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class AgentCommissionConfigurationBreadSeeder extends Seeder
{
    public function run()
    {
        DB::table('data_types')->updateOrInsert(
            ['slug' => 'agent-commission-configuration'],
            array (
  'name' => 'agent_commission_configuration',
  'slug' => 'agent-commission-configuration',
  'display_name_singular' => 'In-House Commission Configuration',
  'display_name_plural' => 'In-House Commission Configurations',
  'icon' => NULL,
  'model_name' => 'App\\Models\\AgentCommissionConfiguration',
  'policy_name' => NULL,
  'controller' => 'App\\Http\\Controllers\\AgentCommissionConfigurationController',
  'description' => NULL,
  'generate_permissions' => 1,
  'server_side' => 1,
  'details' => '{"order_column":null,"order_display_column":null,"order_direction":"asc","default_search_key":null,"scope":null}',
  'created_at' => '2025-02-12 18:41:52',
  'updated_at' => '2025-02-13 18:24:33',
)
        );

        DB::table('data_rows')->where('data_type_id', 38)->delete();

        DB::table('data_rows')->insert(array (
  'data_type_id' => 38,
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
  'data_type_id' => 38,
  'field' => 'product_id',
  'type' => 'text',
  'display_name' => 'Product Id',
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
  'data_type_id' => 38,
  'field' => 'product_order_type',
  'type' => 'select_dropdown',
  'display_name' => 'Product Order Type',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"default":"New","options":{"NEW":"New","ROLLOVER":"Rollover"}}',
  'order' => 4,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 38,
  'field' => 'year',
  'type' => 'number',
  'display_name' => 'Year',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{}',
  'order' => 5,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 38,
  'field' => 'mgr_commission',
  'type' => 'number',
  'display_name' => 'MGR Commission',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{}',
  'order' => 6,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 38,
  'field' => 'p2p_commission',
  'type' => 'number',
  'display_name' => 'P2P Commission',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{}',
  'order' => 7,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 38,
  'field' => 'sm_commission',
  'type' => 'number',
  'display_name' => 'SM Commission',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{}',
  'order' => 8,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 38,
  'field' => 'avp_commission',
  'type' => 'number',
  'display_name' => 'AVP Commission',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{}',
  'order' => 9,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 38,
  'field' => 'vp_commission',
  'type' => 'number',
  'display_name' => 'VP Commission',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{}',
  'order' => 10,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 38,
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
  'order' => 11,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 38,
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
  'order' => 12,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 38,
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
  'order' => 13,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 38,
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
  'order' => 14,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 38,
  'field' => 'agent_commission_configuration_belongsto_product_relationship',
  'type' => 'relationship',
  'display_name' => 'Product Code',
  'required' => 1,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"model":"App\\\\Models\\\\Product","table":"product","type":"belongsTo","column":"product_id","key":"id","label":"code","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 2,
));

    }
}
