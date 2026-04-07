<?php

namespace Database\Seeders\Bread;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class AgencyCommissionConfigurationBreadSeeder extends Seeder
{
    public function run()
    {
        DB::table('data_types')->updateOrInsert(
            ['slug' => 'agency-commission-configuration'],
            array (
  'id' => 37,
  'name' => 'agency_commission_configuration',
  'slug' => 'agency-commission-configuration',
  'display_name_singular' => 'Agency Commission Configuration',
  'display_name_plural' => 'Agency Commission Configurations',
  'icon' => NULL,
  'model_name' => 'App\\Models\\AgencyCommissionConfiguration',
  'policy_name' => NULL,
  'controller' => 'App\\Http\\Controllers\\AgencyCommissionConfigurationController',
  'description' => NULL,
  'generate_permissions' => 1,
  'server_side' => 1,
  'details' => '{"order_column":null,"order_display_column":null,"order_direction":"asc","default_search_key":null,"scope":null}',
  'created_at' => '2025-01-16 16:12:12',
  'updated_at' => '2025-05-06 16:14:40',
)
        );

        DB::table('data_rows')->where('data_type_id', 37)->delete();

        DB::table('data_rows')->insert(array (
  'data_type_id' => 37,
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
  'data_type_id' => 37,
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
  'data_type_id' => 37,
  'field' => 'product_order_type',
  'type' => 'select_dropdown',
  'display_name' => 'Product Type',
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
  'data_type_id' => 37,
  'field' => 'condition',
  'type' => 'select_dropdown',
  'display_name' => 'Condition',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"default":null,"options":{"":null,"ABOVE":"Above","BELOW":"Below","TIER2":"Tier2"}}',
  'order' => 5,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 37,
  'field' => 'threshold',
  'type' => 'number',
  'display_name' => 'Threshold',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 1,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 7,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 37,
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
  'order' => 8,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 37,
  'field' => 'commission',
  'type' => 'text',
  'display_name' => 'Commission',
  'required' => 1,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"validation":{"rule":"required"}}',
  'order' => 9,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 37,
  'field' => 'created_at',
  'type' => 'timestamp',
  'display_name' => 'Created Datetime',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 10,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 37,
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
  'order' => 11,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 37,
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
  'order' => 12,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 37,
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
  'order' => 13,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 37,
  'field' => 'agency_commission_configuration_belongsto_product_relationship',
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

        DB::table('data_rows')->insert(array (
  'data_type_id' => 37,
  'field' => 'agency_commission_configuration_hasone_agency_commission_configuration_relationship',
  'type' => 'relationship',
  'display_name' => 'Threshold',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 1,
  'delete' => 1,
  'details' => '{"model":"App\\\\Models\\\\AgencyCommissionConfiguration","table":"agency_commission_configuration","type":"hasOne","column":"id","key":"id","label":"formatted_threshold","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 6,
));

    }
}
