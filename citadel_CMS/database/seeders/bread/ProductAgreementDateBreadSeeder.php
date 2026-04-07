<?php

namespace Database\Seeders\Bread;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ProductAgreementDateBreadSeeder extends Seeder
{
    public function run()
    {
      DB::table('data_types')->updateOrInsert(
        ['slug' => 'product-agreement-date'], 
        [
            'id' => 39,
            'name' => 'product_agreement_date',
            'slug' => 'product-agreement-date',
            'display_name_singular' => 'Product Agreement Date',
            'display_name_plural' => 'Product Agreement Dates',
            'icon' => NULL,
            'model_name' => 'App\\Models\\ProductAgreementDate',
            'policy_name' => NULL,
            'controller' => 'App\\Http\\Controllers\\ProductAgreementDateController',
            'description' => NULL,
            'generate_permissions' => 1,
            'server_side' => 1,
            'details' => '{"order_column":null,"order_display_column":null,"order_direction":"asc","default_search_key":null,"scope":null}',
            'created_at' => now(),
            'updated_at' => now(),
        ]
    );

        DB::table('data_rows')->where('data_type_id', 39)->delete();

        DB::table('data_rows')->insert(array (
  'data_type_id' => 39,
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
  'data_type_id' => 39,
  'field' => 'product_type_id',
  'type' => 'text',
  'display_name' => 'Product Type Id',
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
  'data_type_id' => 39,
  'field' => 'date_of_month',
  'type' => 'select_dropdown',
  'display_name' => 'Date Of Month',
  'required' => 1,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"default":15,"options":{"1":"1","2":"2","3":"3","4":"4","5":"5","6":"6","7":"7","8":"8","9":"9","10":"10","11":"11","12":"12","13":"13","14":"14","15":"15","16":"16","17":"17","18":"18","19":"19","20":"20","21":"21","22":"22","23":"23","24":"24","25":"25","26":"26","27":"27","28":"28","29":"29","30":"30","99":"Last day of month"}}',
  'order' => 4,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 39,
  'field' => 'created_at',
  'type' => 'timestamp',
  'display_name' => 'Created Datetime',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 1,
  'details' => '{}',
  'order' => 5,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 39,
  'field' => 'updated_at',
  'type' => 'timestamp',
  'display_name' => 'Updated Datetime',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 1,
  'details' => '{}',
  'order' => 6,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 39,
  'field' => 'created_by',
  'type' => 'text',
  'display_name' => 'Created By',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 1,
  'details' => '{}',
  'order' => 7,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 39,
  'field' => 'updated_by',
  'type' => 'text',
  'display_name' => 'Updated By',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 1,
  'details' => '{}',
  'order' => 8,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 39,
  'field' => 'product_agreement_date_belongsto_product_type_relationship',
  'type' => 'relationship',
  'display_name' => 'Product Code',
  'required' => 1,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"model":"App\\\\Models\\\\ProductType","table":"product_type","type":"belongsTo","column":"product_type_id","key":"id","label":"name","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 2,
));

    }
}
