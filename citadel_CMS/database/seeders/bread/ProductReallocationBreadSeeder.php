<?php

namespace Database\Seeders\Bread;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ProductReallocationBreadSeeder extends Seeder
{
    public function run()
    {
        DB::table('data_types')->updateOrInsert(
            ['slug' => 'product-reallocation'],
            array (
  'id' => 40,
  'name' => 'product_reallocation',
  'slug' => 'product-reallocation',
  'display_name_singular' => 'Product Reallocation',
  'display_name_plural' => 'Product Reallocations',
  'icon' => NULL,
  'model_name' => 'App\\Models\\ProductReallocation',
  'policy_name' => NULL,
  'controller' => 'App\\Http\\Controllers\\ProductReallocationController',
  'description' => NULL,
  'generate_permissions' => 1,
  'server_side' => 1,
  'details' => '{"order_column":null,"order_display_column":null,"order_direction":"asc","default_search_key":null,"scope":null}',
  'created_at' => '2025-02-28 12:02:03',
  'updated_at' => '2025-03-11 01:00:02',
)
        );

        DB::table('data_rows')->where('data_type_id', 40)->delete();

        DB::table('data_rows')->insert(array (
  'data_type_id' => 40,
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
  'data_type_id' => 40,
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
  'order' => 11,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 40,
  'field' => 'amount',
  'type' => 'text',
  'display_name' => 'Amount',
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
  'data_type_id' => 40,
  'field' => 'reallocate_product_id',
  'type' => 'text',
  'display_name' => 'Reallocate Product Id',
  'required' => 1,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 15,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 40,
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
  'order' => 18,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 40,
  'field' => 'created_at',
  'type' => 'timestamp',
  'display_name' => 'Created At',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 19,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 40,
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
  'order' => 20,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 40,
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
  'order' => 21,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 40,
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
  'order' => 22,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 40,
  'field' => 'status_checker',
  'type' => 'text',
  'display_name' => 'Status Checker',
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
  'data_type_id' => 40,
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
  'order' => 24,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 40,
  'field' => 'checked_by',
  'type' => 'text',
  'display_name' => 'Checked By',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 25,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 40,
  'field' => 'checker_updated_at',
  'type' => 'timestamp',
  'display_name' => 'Checker Updated At',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 26,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 40,
  'field' => 'status_approver',
  'type' => 'text',
  'display_name' => 'Status Approver',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 27,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 40,
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
  'order' => 28,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 40,
  'field' => 'approved_by',
  'type' => 'text',
  'display_name' => 'Approved By',
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
  'data_type_id' => 40,
  'field' => 'approver_updated_at',
  'type' => 'timestamp',
  'display_name' => 'Approver Updated At',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 30,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 40,
  'field' => 'product_reallocation_belongsto_product_order_relationship',
  'type' => 'relationship',
  'display_name' => 'Order Reference Number',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\ProductOrder","table":"product_order","type":"belongsTo","column":"product_order_id","key":"id","label":"order_reference_number","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 3,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 40,
  'field' => 'product_reallocation_belongsto_product_relationship',
  'type' => 'relationship',
  'display_name' => 'Product Name',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\Product","table":"product","type":"belongsTo","column":"id","key":"id","label":"name","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 12,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 40,
  'field' => 'product_reallocation_belongsto_product_relationship_1',
  'type' => 'relationship',
  'display_name' => 'Reallocate Product',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\Product","table":"product","type":"belongsTo","column":"reallocate_product_id","key":"id","label":"name","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 14,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 40,
  'field' => 'product_reallocation_hasone_product_reallocation_relationship_7',
  'type' => 'relationship',
  'display_name' => 'Agreement Number',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\ProductOrder","table":"product_order","type":"belongsTo","column":"product_order_id","key":"id","label":"agreement_file_name","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 4,
));

    }
}
