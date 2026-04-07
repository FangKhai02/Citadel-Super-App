<?php

namespace Database\Seeders\Bread;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ProductDividendScheduleBreadSeeder extends Seeder
{
    public function run()
    {
        DB::table('data_types')->updateOrInsert(
            ['slug' => 'product-dividend-schedule'],
            array (
  'id' => 33,
  'name' => 'product_dividend_schedule',
  'slug' => 'product-dividend-schedule',
  'display_name_singular' => 'Product Profit Sharing Schedule',
  'display_name_plural' => 'Product Profit Sharing Schedules',
  'icon' => NULL,
  'model_name' => 'App\\Models\\ProductDividendSchedule',
  'policy_name' => NULL,
  'controller' => 'App\\Http\\Controllers\\ProductDividendScheduleController',
  'description' => NULL,
  'generate_permissions' => 1,
  'server_side' => 1,
  'details' => '{"order_column":"id","order_display_column":null,"order_direction":"asc","default_search_key":null,"scope":null}',
  'created_at' => '2024-12-30 23:40:00',
  'updated_at' => '2025-08-25 16:47:39',
)
        );

        DB::table('data_rows')->where('data_type_id', 33)->delete();

        DB::table('data_rows')->insert(array (
  'data_type_id' => 33,
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
  'data_type_id' => 33,
  'field' => 'product_id',
  'type' => 'text',
  'display_name' => 'Product Id',
  'required' => 1,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{}',
  'order' => 3,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 33,
  'field' => 'frequency_of_payout',
  'type' => 'select_dropdown',
  'display_name' => 'Frequency Of Payout',
  'required' => 1,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"default":"QUARTERLY","options":{"MONTHLY":"Monthly","QUARTERLY":"Quarterly","ANNUALLY":"Annually"},"validation":{"rule":"required"}}',
  'order' => 5,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 33,
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
  'order' => 7,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 33,
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
  'order' => 8,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 33,
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
  'order' => 9,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 33,
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
  'order' => 10,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 33,
  'field' => 'structure_type',
  'type' => 'select_dropdown',
  'display_name' => 'Structure Type',
  'required' => 1,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"default":"FIXED","options":{"FLEXIBLE":"Flexible","FIXED":"Fixed"},"validation":{"rule":"required"}}',
  'order' => 4,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 33,
  'field' => 'product_dividend_schedule_belongsto_product_relationship',
  'type' => 'relationship',
  'display_name' => 'Fund Code',
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
  'data_type_id' => 33,
  'field' => 'date_of_month',
  'type' => 'select_dropdown',
  'display_name' => 'Date Of Month',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"default":16,"options":{"1":1,"2":2,"3":3,"4":4,"5":5,"6":6,"7":7,"8":8,"9":9,"10":10,"11":11,"12":12,"13":13,"14":14,"15":15,"16":16,"17":17,"18":18,"19":19,"20":20,"21":21,"22":22,"23":23,"24":24,"25":25,"26":26,"27":27,"28":28,"29":29,"30":30,"31":31,"99":"Last Day of Month"}}',
  'order' => 6,
));

    }
}
