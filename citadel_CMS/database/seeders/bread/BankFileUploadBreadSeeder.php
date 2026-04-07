<?php

namespace Database\Seeders\Bread;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class BankFileUploadBreadSeeder extends Seeder
{
    public function run()
    {
        DB::table('data_types')->updateOrInsert(
            ['slug' => 'bank-file-upload'],
            array (
  'name' => 'bank_file_upload',
  'slug' => 'bank-file-upload',
  'display_name_singular' => 'Bank Status Upload',
  'display_name_plural' => 'Bank Status Uploads',
  'icon' => NULL,
  'model_name' => 'App\\Models\\BankFileUpload',
  'policy_name' => NULL,
  'controller' => 'App\\Http\\Controllers\\BankFileUploadController',
  'description' => NULL,
  'generate_permissions' => 1,
  'server_side' => 1,
  'details' => '{"order_column":null,"order_display_column":null,"order_direction":"asc","default_search_key":null,"scope":null}',
  'created_at' => '2024-09-30 09:44:31',
  'updated_at' => '2025-02-18 16:21:04',
)
        );

        DB::table('data_rows')->where('data_type_id', 20)->delete();

        DB::table('data_rows')->insert(array (
  'data_type_id' => 20,
  'field' => 'id',
  'type' => 'text',
  'display_name' => 'File ID',
  'required' => 1,
  'browse' => 1,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 1,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 20,
  'field' => 'upload_document',
  'type' => 'file',
  'display_name' => 'File',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 2,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 20,
  'field' => 'description',
  'type' => 'text',
  'display_name' => 'Description',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 1,
  'delete' => 0,
  'details' => '{}',
  'order' => 3,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 20,
  'field' => 'status',
  'type' => 'select_dropdown',
  'display_name' => 'Status',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"default":"PENDING","options":{"PENDING":"Pending","SUCCESS":"Success","FAIL":"Fail"}}',
  'order' => 4,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 20,
  'field' => 'checker_id',
  'type' => 'text',
  'display_name' => 'Checker Id',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 5,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 20,
  'field' => 'approver_id',
  'type' => 'text',
  'display_name' => 'Approver Id',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"options":{"PENDING":"Pending Approval","APPROVED":"Approved","REJECTED":"Rejected"}}',
  'order' => 7,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 20,
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
  'order' => 9,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 20,
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
  'order' => 10,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 20,
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
  'order' => 11,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 20,
  'field' => 'bank_file_upload_belongsto_checker_relationship',
  'type' => 'relationship',
  'display_name' => 'Checker Status',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"scope":"status","model":"App\\\\Models\\\\Checker","table":"checker","type":"belongsTo","column":"checker_id","key":"id","label":"status","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 6,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 20,
  'field' => 'bank_file_upload_belongsto_approver_relationship',
  'type' => 'relationship',
  'display_name' => 'Approver Status',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"options":{"PENDING":"Pending Approval","APPROVED":"Approved","REJECTED":"Rejected"},"model":"App\\\\Models\\\\Approver","table":"approver","type":"belongsTo","column":"approver_id","key":"id","label":"status","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 8,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 20,
  'field' => 'remarks',
  'type' => 'text',
  'display_name' => 'Remarks',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{}',
  'order' => 10,
));

    }
}
