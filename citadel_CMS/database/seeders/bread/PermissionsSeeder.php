<?php

namespace Database\Seeders\Bread;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class PermissionsSeeder extends Seeder
{
    public function run()
    {
        DB::table('permissions')->updateOrInsert(
            ['id' => 1],
            array (
  'id' => 1,
  'key' => 'browse_admin',
  'table_name' => NULL,
  'created_at' => '2024-09-26 03:11:16',
  'updated_at' => '2024-09-26 03:11:16',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 2],
            array (
  'id' => 2,
  'key' => 'browse_bread',
  'table_name' => NULL,
  'created_at' => '2024-09-26 03:11:16',
  'updated_at' => '2024-09-26 03:11:16',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 3],
            array (
  'id' => 3,
  'key' => 'browse_database',
  'table_name' => NULL,
  'created_at' => '2024-09-26 03:11:16',
  'updated_at' => '2024-09-26 03:11:16',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 4],
            array (
  'id' => 4,
  'key' => 'browse_media',
  'table_name' => NULL,
  'created_at' => '2024-09-26 03:11:16',
  'updated_at' => '2024-09-26 03:11:16',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 5],
            array (
  'id' => 5,
  'key' => 'browse_compass',
  'table_name' => NULL,
  'created_at' => '2024-09-26 03:11:16',
  'updated_at' => '2024-09-26 03:11:16',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 6],
            array (
  'id' => 6,
  'key' => 'browse_menus',
  'table_name' => 'menus',
  'created_at' => '2024-09-26 03:11:16',
  'updated_at' => '2024-09-26 03:11:16',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 7],
            array (
  'id' => 7,
  'key' => 'read_menus',
  'table_name' => 'menus',
  'created_at' => '2024-09-26 03:11:16',
  'updated_at' => '2024-09-26 03:11:16',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 8],
            array (
  'id' => 8,
  'key' => 'edit_menus',
  'table_name' => 'menus',
  'created_at' => '2024-09-26 03:11:16',
  'updated_at' => '2024-09-26 03:11:16',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 9],
            array (
  'id' => 9,
  'key' => 'add_menus',
  'table_name' => 'menus',
  'created_at' => '2024-09-26 03:11:16',
  'updated_at' => '2024-09-26 03:11:16',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 10],
            array (
  'id' => 10,
  'key' => 'delete_menus',
  'table_name' => 'menus',
  'created_at' => '2024-09-26 03:11:16',
  'updated_at' => '2024-09-26 03:11:16',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 11],
            array (
  'id' => 11,
  'key' => 'browse_roles',
  'table_name' => 'roles',
  'created_at' => '2024-09-26 03:11:16',
  'updated_at' => '2024-09-26 03:11:16',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 12],
            array (
  'id' => 12,
  'key' => 'read_roles',
  'table_name' => 'roles',
  'created_at' => '2024-09-26 03:11:16',
  'updated_at' => '2024-09-26 03:11:16',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 13],
            array (
  'id' => 13,
  'key' => 'edit_roles',
  'table_name' => 'roles',
  'created_at' => '2024-09-26 03:11:16',
  'updated_at' => '2024-09-26 03:11:16',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 14],
            array (
  'id' => 14,
  'key' => 'add_roles',
  'table_name' => 'roles',
  'created_at' => '2024-09-26 03:11:16',
  'updated_at' => '2024-09-26 03:11:16',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 15],
            array (
  'id' => 15,
  'key' => 'delete_roles',
  'table_name' => 'roles',
  'created_at' => '2024-09-26 03:11:16',
  'updated_at' => '2024-09-26 03:11:16',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 16],
            array (
  'id' => 16,
  'key' => 'browse_users',
  'table_name' => 'users',
  'created_at' => '2024-09-26 03:11:16',
  'updated_at' => '2024-09-26 03:11:16',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 17],
            array (
  'id' => 17,
  'key' => 'read_users',
  'table_name' => 'users',
  'created_at' => '2024-09-26 03:11:16',
  'updated_at' => '2024-09-26 03:11:16',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 18],
            array (
  'id' => 18,
  'key' => 'edit_users',
  'table_name' => 'users',
  'created_at' => '2024-09-26 03:11:16',
  'updated_at' => '2024-09-26 03:11:16',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 19],
            array (
  'id' => 19,
  'key' => 'add_users',
  'table_name' => 'users',
  'created_at' => '2024-09-26 03:11:16',
  'updated_at' => '2024-09-26 03:11:16',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 20],
            array (
  'id' => 20,
  'key' => 'delete_users',
  'table_name' => 'users',
  'created_at' => '2024-09-26 03:11:16',
  'updated_at' => '2024-09-26 03:11:16',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 21],
            array (
  'id' => 21,
  'key' => 'browse_settings',
  'table_name' => 'settings',
  'created_at' => '2024-09-26 03:11:16',
  'updated_at' => '2024-09-26 03:11:16',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 22],
            array (
  'id' => 22,
  'key' => 'read_settings',
  'table_name' => 'settings',
  'created_at' => '2024-09-26 03:11:16',
  'updated_at' => '2024-09-26 03:11:16',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 23],
            array (
  'id' => 23,
  'key' => 'edit_settings',
  'table_name' => 'settings',
  'created_at' => '2024-09-26 03:11:16',
  'updated_at' => '2024-09-26 03:11:16',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 24],
            array (
  'id' => 24,
  'key' => 'add_settings',
  'table_name' => 'settings',
  'created_at' => '2024-09-26 03:11:16',
  'updated_at' => '2024-09-26 03:11:16',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 25],
            array (
  'id' => 25,
  'key' => 'delete_settings',
  'table_name' => 'settings',
  'created_at' => '2024-09-26 03:11:16',
  'updated_at' => '2024-09-26 03:11:16',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 41],
            array (
  'id' => 41,
  'key' => 'browse_agent',
  'table_name' => 'agent',
  'created_at' => '2024-09-26 04:34:58',
  'updated_at' => '2024-09-26 04:34:58',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 42],
            array (
  'id' => 42,
  'key' => 'read_agent',
  'table_name' => 'agent',
  'created_at' => '2024-09-26 04:34:58',
  'updated_at' => '2024-09-26 04:34:58',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 43],
            array (
  'id' => 43,
  'key' => 'edit_agent',
  'table_name' => 'agent',
  'created_at' => '2024-09-26 04:34:58',
  'updated_at' => '2024-09-26 04:34:58',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 44],
            array (
  'id' => 44,
  'key' => 'add_agent',
  'table_name' => 'agent',
  'created_at' => '2024-09-26 04:34:58',
  'updated_at' => '2024-09-26 04:34:58',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 45],
            array (
  'id' => 45,
  'key' => 'delete_agent',
  'table_name' => 'agent',
  'created_at' => '2024-09-26 04:34:58',
  'updated_at' => '2024-09-26 04:34:58',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 46],
            array (
  'id' => 46,
  'key' => 'browse_client',
  'table_name' => 'client',
  'created_at' => '2024-09-26 04:37:20',
  'updated_at' => '2024-09-26 04:37:20',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 47],
            array (
  'id' => 47,
  'key' => 'read_client',
  'table_name' => 'client',
  'created_at' => '2024-09-26 04:37:20',
  'updated_at' => '2024-09-26 04:37:20',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 48],
            array (
  'id' => 48,
  'key' => 'edit_client',
  'table_name' => 'client',
  'created_at' => '2024-09-26 04:37:20',
  'updated_at' => '2024-09-26 04:37:20',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 49],
            array (
  'id' => 49,
  'key' => 'add_client',
  'table_name' => 'client',
  'created_at' => '2024-09-26 04:37:20',
  'updated_at' => '2024-09-26 04:37:20',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 50],
            array (
  'id' => 50,
  'key' => 'delete_client',
  'table_name' => 'client',
  'created_at' => '2024-09-26 04:37:20',
  'updated_at' => '2024-09-26 04:37:20',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 51],
            array (
  'id' => 51,
  'key' => 'browse_agency',
  'table_name' => 'agency',
  'created_at' => '2024-09-30 08:01:10',
  'updated_at' => '2024-09-30 08:01:10',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 52],
            array (
  'id' => 52,
  'key' => 'read_agency',
  'table_name' => 'agency',
  'created_at' => '2024-09-30 08:01:10',
  'updated_at' => '2024-09-30 08:01:10',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 53],
            array (
  'id' => 53,
  'key' => 'edit_agency',
  'table_name' => 'agency',
  'created_at' => '2024-09-30 08:01:10',
  'updated_at' => '2024-09-30 08:01:10',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 54],
            array (
  'id' => 54,
  'key' => 'add_agency',
  'table_name' => 'agency',
  'created_at' => '2024-09-30 08:01:10',
  'updated_at' => '2024-09-30 08:01:10',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 55],
            array (
  'id' => 55,
  'key' => 'delete_agency',
  'table_name' => 'agency',
  'created_at' => '2024-09-30 08:01:10',
  'updated_at' => '2024-09-30 08:01:10',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 56],
            array (
  'id' => 56,
  'key' => 'browse_product_type',
  'table_name' => 'product_type',
  'created_at' => '2024-09-30 08:12:49',
  'updated_at' => '2024-09-30 08:12:49',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 57],
            array (
  'id' => 57,
  'key' => 'read_product_type',
  'table_name' => 'product_type',
  'created_at' => '2024-09-30 08:12:49',
  'updated_at' => '2024-09-30 08:12:49',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 58],
            array (
  'id' => 58,
  'key' => 'edit_product_type',
  'table_name' => 'product_type',
  'created_at' => '2024-09-30 08:12:49',
  'updated_at' => '2024-09-30 08:12:49',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 59],
            array (
  'id' => 59,
  'key' => 'add_product_type',
  'table_name' => 'product_type',
  'created_at' => '2024-09-30 08:12:49',
  'updated_at' => '2024-09-30 08:12:49',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 60],
            array (
  'id' => 60,
  'key' => 'delete_product_type',
  'table_name' => 'product_type',
  'created_at' => '2024-09-30 08:12:49',
  'updated_at' => '2024-09-30 08:12:49',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 61],
            array (
  'id' => 61,
  'key' => 'browse_product',
  'table_name' => 'product',
  'created_at' => '2024-09-30 08:26:47',
  'updated_at' => '2024-09-30 08:26:47',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 62],
            array (
  'id' => 62,
  'key' => 'read_product',
  'table_name' => 'product',
  'created_at' => '2024-09-30 08:26:47',
  'updated_at' => '2024-09-30 08:26:47',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 63],
            array (
  'id' => 63,
  'key' => 'edit_product',
  'table_name' => 'product',
  'created_at' => '2024-09-30 08:26:47',
  'updated_at' => '2024-09-30 08:26:47',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 64],
            array (
  'id' => 64,
  'key' => 'add_product',
  'table_name' => 'product',
  'created_at' => '2024-09-30 08:26:47',
  'updated_at' => '2024-09-30 08:26:47',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 65],
            array (
  'id' => 65,
  'key' => 'delete_product',
  'table_name' => 'product',
  'created_at' => '2024-09-30 08:26:47',
  'updated_at' => '2024-09-30 08:26:47',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 66],
            array (
  'id' => 66,
  'key' => 'browse_document_type',
  'table_name' => 'document_type',
  'created_at' => '2024-09-30 08:39:39',
  'updated_at' => '2024-09-30 08:39:39',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 67],
            array (
  'id' => 67,
  'key' => 'read_document_type',
  'table_name' => 'document_type',
  'created_at' => '2024-09-30 08:39:39',
  'updated_at' => '2024-09-30 08:39:39',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 68],
            array (
  'id' => 68,
  'key' => 'edit_document_type',
  'table_name' => 'document_type',
  'created_at' => '2024-09-30 08:39:39',
  'updated_at' => '2024-09-30 08:39:39',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 69],
            array (
  'id' => 69,
  'key' => 'add_document_type',
  'table_name' => 'document_type',
  'created_at' => '2024-09-30 08:39:39',
  'updated_at' => '2024-09-30 08:39:39',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 70],
            array (
  'id' => 70,
  'key' => 'delete_document_type',
  'table_name' => 'document_type',
  'created_at' => '2024-09-30 08:39:39',
  'updated_at' => '2024-09-30 08:39:39',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 71],
            array (
  'id' => 71,
  'key' => 'browse_product_agreement',
  'table_name' => 'product_agreement',
  'created_at' => '2024-09-30 08:51:50',
  'updated_at' => '2024-09-30 08:51:50',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 72],
            array (
  'id' => 72,
  'key' => 'read_product_agreement',
  'table_name' => 'product_agreement',
  'created_at' => '2024-09-30 08:51:50',
  'updated_at' => '2024-09-30 08:51:50',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 73],
            array (
  'id' => 73,
  'key' => 'edit_product_agreement',
  'table_name' => 'product_agreement',
  'created_at' => '2024-09-30 08:51:50',
  'updated_at' => '2024-09-30 08:51:50',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 74],
            array (
  'id' => 74,
  'key' => 'add_product_agreement',
  'table_name' => 'product_agreement',
  'created_at' => '2024-09-30 08:51:50',
  'updated_at' => '2024-09-30 08:51:50',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 75],
            array (
  'id' => 75,
  'key' => 'delete_product_agreement',
  'table_name' => 'product_agreement',
  'created_at' => '2024-09-30 08:51:50',
  'updated_at' => '2024-09-30 08:51:50',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 81],
            array (
  'id' => 81,
  'key' => 'browse_bank_file_upload',
  'table_name' => 'bank_file_upload',
  'created_at' => '2024-09-30 09:44:31',
  'updated_at' => '2024-09-30 09:44:31',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 82],
            array (
  'id' => 82,
  'key' => 'read_bank_file_upload',
  'table_name' => 'bank_file_upload',
  'created_at' => '2024-09-30 09:44:31',
  'updated_at' => '2024-09-30 09:44:31',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 83],
            array (
  'id' => 83,
  'key' => 'edit_bank_file_upload',
  'table_name' => 'bank_file_upload',
  'created_at' => '2024-09-30 09:44:31',
  'updated_at' => '2024-09-30 09:44:31',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 84],
            array (
  'id' => 84,
  'key' => 'add_bank_file_upload',
  'table_name' => 'bank_file_upload',
  'created_at' => '2024-09-30 09:44:31',
  'updated_at' => '2024-09-30 09:44:31',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 85],
            array (
  'id' => 85,
  'key' => 'delete_bank_file_upload',
  'table_name' => 'bank_file_upload',
  'created_at' => '2024-09-30 09:44:31',
  'updated_at' => '2024-09-30 09:44:31',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 86],
            array (
  'id' => 86,
  'key' => 'browse_checker',
  'table_name' => 'checker',
  'created_at' => '2024-09-30 09:45:07',
  'updated_at' => '2024-09-30 09:45:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 87],
            array (
  'id' => 87,
  'key' => 'read_checker',
  'table_name' => 'checker',
  'created_at' => '2024-09-30 09:45:07',
  'updated_at' => '2024-09-30 09:45:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 88],
            array (
  'id' => 88,
  'key' => 'edit_checker',
  'table_name' => 'checker',
  'created_at' => '2024-09-30 09:45:07',
  'updated_at' => '2024-09-30 09:45:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 89],
            array (
  'id' => 89,
  'key' => 'add_checker',
  'table_name' => 'checker',
  'created_at' => '2024-09-30 09:45:07',
  'updated_at' => '2024-09-30 09:45:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 90],
            array (
  'id' => 90,
  'key' => 'delete_checker',
  'table_name' => 'checker',
  'created_at' => '2024-09-30 09:45:07',
  'updated_at' => '2024-09-30 09:45:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 91],
            array (
  'id' => 91,
  'key' => 'browse_approver',
  'table_name' => 'approver',
  'created_at' => '2024-09-30 09:45:20',
  'updated_at' => '2024-09-30 09:45:20',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 92],
            array (
  'id' => 92,
  'key' => 'read_approver',
  'table_name' => 'approver',
  'created_at' => '2024-09-30 09:45:20',
  'updated_at' => '2024-09-30 09:45:20',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 93],
            array (
  'id' => 93,
  'key' => 'edit_approver',
  'table_name' => 'approver',
  'created_at' => '2024-09-30 09:45:20',
  'updated_at' => '2024-09-30 09:45:20',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 94],
            array (
  'id' => 94,
  'key' => 'add_approver',
  'table_name' => 'approver',
  'created_at' => '2024-09-30 09:45:20',
  'updated_at' => '2024-09-30 09:45:20',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 95],
            array (
  'id' => 95,
  'key' => 'delete_approver',
  'table_name' => 'approver',
  'created_at' => '2024-09-30 09:45:20',
  'updated_at' => '2024-09-30 09:45:20',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 96],
            array (
  'id' => 96,
  'key' => 'browse_product_order',
  'table_name' => 'product_order',
  'created_at' => '2024-10-11 18:12:37',
  'updated_at' => '2024-10-11 18:12:37',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 97],
            array (
  'id' => 97,
  'key' => 'read_product_order',
  'table_name' => 'product_order',
  'created_at' => '2024-10-11 18:12:37',
  'updated_at' => '2024-10-11 18:12:37',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 98],
            array (
  'id' => 98,
  'key' => 'edit_product_order',
  'table_name' => 'product_order',
  'created_at' => '2024-10-11 18:12:37',
  'updated_at' => '2024-10-11 18:12:37',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 99],
            array (
  'id' => 99,
  'key' => 'add_product_order',
  'table_name' => 'product_order',
  'created_at' => '2024-10-11 18:12:37',
  'updated_at' => '2024-10-11 18:12:37',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 100],
            array (
  'id' => 100,
  'key' => 'delete_product_order',
  'table_name' => 'product_order',
  'created_at' => '2024-10-11 18:12:37',
  'updated_at' => '2024-10-11 18:12:37',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 101],
            array (
  'id' => 101,
  'key' => 'browse_corporate_client',
  'table_name' => 'corporate_client',
  'created_at' => '2024-10-17 15:53:37',
  'updated_at' => '2024-10-17 15:53:37',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 102],
            array (
  'id' => 102,
  'key' => 'read_corporate_client',
  'table_name' => 'corporate_client',
  'created_at' => '2024-10-17 15:53:37',
  'updated_at' => '2024-10-17 15:53:37',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 103],
            array (
  'id' => 103,
  'key' => 'edit_corporate_client',
  'table_name' => 'corporate_client',
  'created_at' => '2024-10-17 15:53:37',
  'updated_at' => '2024-10-17 15:53:37',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 104],
            array (
  'id' => 104,
  'key' => 'add_corporate_client',
  'table_name' => 'corporate_client',
  'created_at' => '2024-10-17 15:53:37',
  'updated_at' => '2024-10-17 15:53:37',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 105],
            array (
  'id' => 105,
  'key' => 'delete_corporate_client',
  'table_name' => 'corporate_client',
  'created_at' => '2024-10-17 15:53:37',
  'updated_at' => '2024-10-17 15:53:37',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 106],
            array (
  'id' => 106,
  'key' => 'browse_redemption_details',
  'table_name' => 'redemption_details',
  'created_at' => '2024-12-06 13:48:40',
  'updated_at' => '2024-12-06 13:48:40',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 107],
            array (
  'id' => 107,
  'key' => 'read_redemption_details',
  'table_name' => 'redemption_details',
  'created_at' => '2024-12-06 13:48:40',
  'updated_at' => '2024-12-06 13:48:40',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 108],
            array (
  'id' => 108,
  'key' => 'edit_redemption_details',
  'table_name' => 'redemption_details',
  'created_at' => '2024-12-06 13:48:40',
  'updated_at' => '2024-12-06 13:48:40',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 109],
            array (
  'id' => 109,
  'key' => 'add_redemption_details',
  'table_name' => 'redemption_details',
  'created_at' => '2024-12-06 13:48:40',
  'updated_at' => '2024-12-06 13:48:40',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 110],
            array (
  'id' => 110,
  'key' => 'delete_redemption_details',
  'table_name' => 'redemption_details',
  'created_at' => '2024-12-06 13:48:40',
  'updated_at' => '2024-12-06 13:48:40',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 111],
            array (
  'id' => 111,
  'key' => 'browse_product_dividend_history',
  'table_name' => 'product_dividend_history',
  'created_at' => '2024-12-17 11:38:55',
  'updated_at' => '2024-12-17 11:38:55',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 112],
            array (
  'id' => 112,
  'key' => 'read_product_dividend_history',
  'table_name' => 'product_dividend_history',
  'created_at' => '2024-12-17 11:38:55',
  'updated_at' => '2024-12-17 11:38:55',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 113],
            array (
  'id' => 113,
  'key' => 'edit_product_dividend_history',
  'table_name' => 'product_dividend_history',
  'created_at' => '2024-12-17 11:38:55',
  'updated_at' => '2024-12-17 11:38:55',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 114],
            array (
  'id' => 114,
  'key' => 'add_product_dividend_history',
  'table_name' => 'product_dividend_history',
  'created_at' => '2024-12-17 11:38:55',
  'updated_at' => '2024-12-17 11:38:55',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 115],
            array (
  'id' => 115,
  'key' => 'delete_product_dividend_history',
  'table_name' => 'product_dividend_history',
  'created_at' => '2024-12-17 11:38:55',
  'updated_at' => '2024-12-17 11:38:55',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 116],
            array (
  'id' => 116,
  'key' => 'browse_product_commission_history',
  'table_name' => 'product_commission_history',
  'created_at' => '2024-12-17 14:08:24',
  'updated_at' => '2024-12-17 14:08:24',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 117],
            array (
  'id' => 117,
  'key' => 'read_product_commission_history',
  'table_name' => 'product_commission_history',
  'created_at' => '2024-12-17 14:08:24',
  'updated_at' => '2024-12-17 14:08:24',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 118],
            array (
  'id' => 118,
  'key' => 'edit_product_commission_history',
  'table_name' => 'product_commission_history',
  'created_at' => '2024-12-17 14:08:24',
  'updated_at' => '2024-12-17 14:08:24',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 119],
            array (
  'id' => 119,
  'key' => 'add_product_commission_history',
  'table_name' => 'product_commission_history',
  'created_at' => '2024-12-17 14:08:24',
  'updated_at' => '2024-12-17 14:08:24',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 120],
            array (
  'id' => 120,
  'key' => 'delete_product_commission_history',
  'table_name' => 'product_commission_history',
  'created_at' => '2024-12-17 14:08:24',
  'updated_at' => '2024-12-17 14:08:24',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 121],
            array (
  'id' => 121,
  'key' => 'browse_product_agreement_schedule',
  'table_name' => 'product_agreement_schedule',
  'created_at' => '2024-12-27 16:11:35',
  'updated_at' => '2024-12-27 16:11:35',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 122],
            array (
  'id' => 122,
  'key' => 'read_product_agreement_schedule',
  'table_name' => 'product_agreement_schedule',
  'created_at' => '2024-12-27 16:11:35',
  'updated_at' => '2024-12-27 16:11:35',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 123],
            array (
  'id' => 123,
  'key' => 'edit_product_agreement_schedule',
  'table_name' => 'product_agreement_schedule',
  'created_at' => '2024-12-27 16:11:35',
  'updated_at' => '2024-12-27 16:11:35',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 124],
            array (
  'id' => 124,
  'key' => 'add_product_agreement_schedule',
  'table_name' => 'product_agreement_schedule',
  'created_at' => '2024-12-27 16:11:35',
  'updated_at' => '2024-12-27 16:11:35',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 125],
            array (
  'id' => 125,
  'key' => 'delete_product_agreement_schedule',
  'table_name' => 'product_agreement_schedule',
  'created_at' => '2024-12-27 16:11:35',
  'updated_at' => '2024-12-27 16:11:35',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 126],
            array (
  'id' => 126,
  'key' => 'browse_product_target_return',
  'table_name' => 'product_target_return',
  'created_at' => '2024-12-30 21:49:59',
  'updated_at' => '2024-12-30 21:49:59',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 127],
            array (
  'id' => 127,
  'key' => 'read_product_target_return',
  'table_name' => 'product_target_return',
  'created_at' => '2024-12-30 21:49:59',
  'updated_at' => '2024-12-30 21:49:59',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 128],
            array (
  'id' => 128,
  'key' => 'edit_product_target_return',
  'table_name' => 'product_target_return',
  'created_at' => '2024-12-30 21:49:59',
  'updated_at' => '2024-12-30 21:49:59',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 129],
            array (
  'id' => 129,
  'key' => 'add_product_target_return',
  'table_name' => 'product_target_return',
  'created_at' => '2024-12-30 21:49:59',
  'updated_at' => '2024-12-30 21:49:59',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 130],
            array (
  'id' => 130,
  'key' => 'delete_product_target_return',
  'table_name' => 'product_target_return',
  'created_at' => '2024-12-30 21:49:59',
  'updated_at' => '2024-12-30 21:49:59',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 131],
            array (
  'id' => 131,
  'key' => 'browse_product_dividend_schedule',
  'table_name' => 'product_dividend_schedule',
  'created_at' => '2024-12-30 23:40:00',
  'updated_at' => '2024-12-30 23:40:00',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 132],
            array (
  'id' => 132,
  'key' => 'read_product_dividend_schedule',
  'table_name' => 'product_dividend_schedule',
  'created_at' => '2024-12-30 23:40:00',
  'updated_at' => '2024-12-30 23:40:00',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 133],
            array (
  'id' => 133,
  'key' => 'edit_product_dividend_schedule',
  'table_name' => 'product_dividend_schedule',
  'created_at' => '2024-12-30 23:40:00',
  'updated_at' => '2024-12-30 23:40:00',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 134],
            array (
  'id' => 134,
  'key' => 'add_product_dividend_schedule',
  'table_name' => 'product_dividend_schedule',
  'created_at' => '2024-12-30 23:40:00',
  'updated_at' => '2024-12-30 23:40:00',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 135],
            array (
  'id' => 135,
  'key' => 'delete_product_dividend_schedule',
  'table_name' => 'product_dividend_schedule',
  'created_at' => '2024-12-30 23:40:00',
  'updated_at' => '2024-12-30 23:40:00',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 136],
            array (
  'id' => 136,
  'key' => 'browse_maintenance_window',
  'table_name' => 'maintenance_window',
  'created_at' => '2025-01-08 11:33:58',
  'updated_at' => '2025-01-08 11:33:58',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 137],
            array (
  'id' => 137,
  'key' => 'read_maintenance_window',
  'table_name' => 'maintenance_window',
  'created_at' => '2025-01-08 11:33:58',
  'updated_at' => '2025-01-08 11:33:58',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 138],
            array (
  'id' => 138,
  'key' => 'edit_maintenance_window',
  'table_name' => 'maintenance_window',
  'created_at' => '2025-01-08 11:33:58',
  'updated_at' => '2025-01-08 11:33:58',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 139],
            array (
  'id' => 139,
  'key' => 'add_maintenance_window',
  'table_name' => 'maintenance_window',
  'created_at' => '2025-01-08 11:33:58',
  'updated_at' => '2025-01-08 11:33:58',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 140],
            array (
  'id' => 140,
  'key' => 'delete_maintenance_window',
  'table_name' => 'maintenance_window',
  'created_at' => '2025-01-08 11:33:58',
  'updated_at' => '2025-01-08 11:33:58',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 141],
            array (
  'id' => 141,
  'key' => 'browse_product_order_payment_receipt',
  'table_name' => 'product_order_payment_receipt',
  'created_at' => '2025-01-08 13:50:42',
  'updated_at' => '2025-01-08 13:50:42',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 142],
            array (
  'id' => 142,
  'key' => 'read_product_order_payment_receipt',
  'table_name' => 'product_order_payment_receipt',
  'created_at' => '2025-01-08 13:50:42',
  'updated_at' => '2025-01-08 13:50:42',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 143],
            array (
  'id' => 143,
  'key' => 'edit_product_order_payment_receipt',
  'table_name' => 'product_order_payment_receipt',
  'created_at' => '2025-01-08 13:50:42',
  'updated_at' => '2025-01-08 13:50:42',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 144],
            array (
  'id' => 144,
  'key' => 'add_product_order_payment_receipt',
  'table_name' => 'product_order_payment_receipt',
  'created_at' => '2025-01-08 13:50:42',
  'updated_at' => '2025-01-08 13:50:42',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 145],
            array (
  'id' => 145,
  'key' => 'delete_product_order_payment_receipt',
  'table_name' => 'product_order_payment_receipt',
  'created_at' => '2025-01-08 13:50:42',
  'updated_at' => '2025-01-08 13:50:42',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 146],
            array (
  'id' => 146,
  'key' => 'browse_product_agency_commission_configuration',
  'table_name' => 'product_agency_commission_configuration',
  'created_at' => '2025-01-16 16:10:53',
  'updated_at' => '2025-01-16 16:10:53',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 147],
            array (
  'id' => 147,
  'key' => 'read_product_agency_commission_configuration',
  'table_name' => 'product_agency_commission_configuration',
  'created_at' => '2025-01-16 16:10:53',
  'updated_at' => '2025-01-16 16:10:53',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 148],
            array (
  'id' => 148,
  'key' => 'edit_product_agency_commission_configuration',
  'table_name' => 'product_agency_commission_configuration',
  'created_at' => '2025-01-16 16:10:53',
  'updated_at' => '2025-01-16 16:10:53',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 149],
            array (
  'id' => 149,
  'key' => 'add_product_agency_commission_configuration',
  'table_name' => 'product_agency_commission_configuration',
  'created_at' => '2025-01-16 16:10:53',
  'updated_at' => '2025-01-16 16:10:53',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 150],
            array (
  'id' => 150,
  'key' => 'delete_product_agency_commission_configuration',
  'table_name' => 'product_agency_commission_configuration',
  'created_at' => '2025-01-16 16:10:53',
  'updated_at' => '2025-01-16 16:10:53',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 151],
            array (
  'id' => 151,
  'key' => 'browse_agency_commission_configuration',
  'table_name' => 'agency_commission_configuration',
  'created_at' => '2025-01-16 16:12:12',
  'updated_at' => '2025-01-16 16:12:12',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 152],
            array (
  'id' => 152,
  'key' => 'read_agency_commission_configuration',
  'table_name' => 'agency_commission_configuration',
  'created_at' => '2025-01-16 16:12:12',
  'updated_at' => '2025-01-16 16:12:12',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 153],
            array (
  'id' => 153,
  'key' => 'edit_agency_commission_configuration',
  'table_name' => 'agency_commission_configuration',
  'created_at' => '2025-01-16 16:12:12',
  'updated_at' => '2025-01-16 16:12:12',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 154],
            array (
  'id' => 154,
  'key' => 'add_agency_commission_configuration',
  'table_name' => 'agency_commission_configuration',
  'created_at' => '2025-01-16 16:12:12',
  'updated_at' => '2025-01-16 16:12:12',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 155],
            array (
  'id' => 155,
  'key' => 'delete_agency_commission_configuration',
  'table_name' => 'agency_commission_configuration',
  'created_at' => '2025-01-16 16:12:12',
  'updated_at' => '2025-01-16 16:12:12',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 156],
            array (
  'id' => 156,
  'key' => 'browse_agent_commission_configuration',
  'table_name' => 'agent_commission_configuration',
  'created_at' => '2025-02-12 18:41:52',
  'updated_at' => '2025-02-12 18:41:52',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 157],
            array (
  'id' => 157,
  'key' => 'read_agent_commission_configuration',
  'table_name' => 'agent_commission_configuration',
  'created_at' => '2025-02-12 18:41:52',
  'updated_at' => '2025-02-12 18:41:52',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 158],
            array (
  'id' => 158,
  'key' => 'edit_agent_commission_configuration',
  'table_name' => 'agent_commission_configuration',
  'created_at' => '2025-02-12 18:41:52',
  'updated_at' => '2025-02-12 18:41:52',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 159],
            array (
  'id' => 159,
  'key' => 'add_agent_commission_configuration',
  'table_name' => 'agent_commission_configuration',
  'created_at' => '2025-02-12 18:41:52',
  'updated_at' => '2025-02-12 18:41:52',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 160],
            array (
  'id' => 160,
  'key' => 'delete_agent_commission_configuration',
  'table_name' => 'agent_commission_configuration',
  'created_at' => '2025-02-12 18:41:52',
  'updated_at' => '2025-02-12 18:41:52',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 161],
            array (
  'id' => 161,
  'key' => 'browse_product_agreement_date',
  'table_name' => 'product_agreement_date',
  'created_at' => '2025-02-13 20:03:12',
  'updated_at' => '2025-02-13 20:03:12',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 162],
            array (
  'id' => 162,
  'key' => 'read_product_agreement_date',
  'table_name' => 'product_agreement_date',
  'created_at' => '2025-02-13 20:03:12',
  'updated_at' => '2025-02-13 20:03:12',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 163],
            array (
  'id' => 163,
  'key' => 'edit_product_agreement_date',
  'table_name' => 'product_agreement_date',
  'created_at' => '2025-02-13 20:03:12',
  'updated_at' => '2025-02-13 20:03:12',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 164],
            array (
  'id' => 164,
  'key' => 'add_product_agreement_date',
  'table_name' => 'product_agreement_date',
  'created_at' => '2025-02-13 20:03:12',
  'updated_at' => '2025-02-13 20:03:12',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 165],
            array (
  'id' => 165,
  'key' => 'delete_product_agreement_date',
  'table_name' => 'product_agreement_date',
  'created_at' => '2025-02-13 20:03:12',
  'updated_at' => '2025-02-13 20:03:12',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 166],
            array (
  'id' => 166,
  'key' => 'browse_categories',
  'table_name' => 'categories',
  'created_at' => '2025-02-23 02:14:48',
  'updated_at' => '2025-02-23 02:14:48',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 167],
            array (
  'id' => 167,
  'key' => 'read_categories',
  'table_name' => 'categories',
  'created_at' => '2025-02-23 02:14:48',
  'updated_at' => '2025-02-23 02:14:48',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 168],
            array (
  'id' => 168,
  'key' => 'edit_categories',
  'table_name' => 'categories',
  'created_at' => '2025-02-23 02:14:48',
  'updated_at' => '2025-02-23 02:14:48',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 169],
            array (
  'id' => 169,
  'key' => 'add_categories',
  'table_name' => 'categories',
  'created_at' => '2025-02-23 02:14:48',
  'updated_at' => '2025-02-23 02:14:48',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 170],
            array (
  'id' => 170,
  'key' => 'delete_categories',
  'table_name' => 'categories',
  'created_at' => '2025-02-23 02:14:48',
  'updated_at' => '2025-02-23 02:14:48',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 171],
            array (
  'id' => 171,
  'key' => 'browse_pages',
  'table_name' => 'pages',
  'created_at' => '2025-02-23 02:16:08',
  'updated_at' => '2025-02-23 02:16:08',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 172],
            array (
  'id' => 172,
  'key' => 'read_pages',
  'table_name' => 'pages',
  'created_at' => '2025-02-23 02:16:08',
  'updated_at' => '2025-02-23 02:16:08',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 173],
            array (
  'id' => 173,
  'key' => 'edit_pages',
  'table_name' => 'pages',
  'created_at' => '2025-02-23 02:16:08',
  'updated_at' => '2025-02-23 02:16:08',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 174],
            array (
  'id' => 174,
  'key' => 'add_pages',
  'table_name' => 'pages',
  'created_at' => '2025-02-23 02:16:09',
  'updated_at' => '2025-02-23 02:16:09',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 175],
            array (
  'id' => 175,
  'key' => 'delete_pages',
  'table_name' => 'pages',
  'created_at' => '2025-02-23 02:16:09',
  'updated_at' => '2025-02-23 02:16:09',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 186],
            array (
  'id' => 186,
  'key' => 'browse_product_rollover_history',
  'table_name' => 'product_rollover_history',
  'created_at' => '2025-02-28 11:57:23',
  'updated_at' => '2025-02-28 11:57:23',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 187],
            array (
  'id' => 187,
  'key' => 'read_product_rollover_history',
  'table_name' => 'product_rollover_history',
  'created_at' => '2025-02-28 11:57:23',
  'updated_at' => '2025-02-28 11:57:23',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 188],
            array (
  'id' => 188,
  'key' => 'edit_product_rollover_history',
  'table_name' => 'product_rollover_history',
  'created_at' => '2025-02-28 11:57:23',
  'updated_at' => '2025-02-28 11:57:23',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 189],
            array (
  'id' => 189,
  'key' => 'add_product_rollover_history',
  'table_name' => 'product_rollover_history',
  'created_at' => '2025-02-28 11:57:23',
  'updated_at' => '2025-02-28 11:57:23',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 190],
            array (
  'id' => 190,
  'key' => 'delete_product_rollover_history',
  'table_name' => 'product_rollover_history',
  'created_at' => '2025-02-28 11:57:23',
  'updated_at' => '2025-02-28 11:57:23',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 191],
            array (
  'id' => 191,
  'key' => 'browse_product_reallocation',
  'table_name' => 'product_reallocation',
  'created_at' => '2025-02-28 12:02:03',
  'updated_at' => '2025-02-28 12:02:03',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 192],
            array (
  'id' => 192,
  'key' => 'read_product_reallocation',
  'table_name' => 'product_reallocation',
  'created_at' => '2025-02-28 12:02:03',
  'updated_at' => '2025-02-28 12:02:03',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 193],
            array (
  'id' => 193,
  'key' => 'edit_product_reallocation',
  'table_name' => 'product_reallocation',
  'created_at' => '2025-02-28 12:02:03',
  'updated_at' => '2025-02-28 12:02:03',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 194],
            array (
  'id' => 194,
  'key' => 'add_product_reallocation',
  'table_name' => 'product_reallocation',
  'created_at' => '2025-02-28 12:02:03',
  'updated_at' => '2025-02-28 12:02:03',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 195],
            array (
  'id' => 195,
  'key' => 'delete_product_reallocation',
  'table_name' => 'product_reallocation',
  'created_at' => '2025-02-28 12:02:03',
  'updated_at' => '2025-02-28 12:02:03',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 196],
            array (
  'id' => 196,
  'key' => 'browse_product_redemption',
  'table_name' => 'product_redemption',
  'created_at' => '2025-02-28 14:15:18',
  'updated_at' => '2025-02-28 14:15:18',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 197],
            array (
  'id' => 197,
  'key' => 'read_product_redemption',
  'table_name' => 'product_redemption',
  'created_at' => '2025-02-28 14:15:18',
  'updated_at' => '2025-02-28 14:15:18',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 198],
            array (
  'id' => 198,
  'key' => 'edit_product_redemption',
  'table_name' => 'product_redemption',
  'created_at' => '2025-02-28 14:15:18',
  'updated_at' => '2025-02-28 14:15:18',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 199],
            array (
  'id' => 199,
  'key' => 'add_product_redemption',
  'table_name' => 'product_redemption',
  'created_at' => '2025-02-28 14:15:18',
  'updated_at' => '2025-02-28 14:15:18',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 200],
            array (
  'id' => 200,
  'key' => 'delete_product_redemption',
  'table_name' => 'product_redemption',
  'created_at' => '2025-02-28 14:15:18',
  'updated_at' => '2025-02-28 14:15:18',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 201],
            array (
  'id' => 201,
  'key' => 'browse_product_early_redemption_history',
  'table_name' => 'product_early_redemption_history',
  'created_at' => '2025-03-15 23:08:58',
  'updated_at' => '2025-03-15 23:08:58',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 202],
            array (
  'id' => 202,
  'key' => 'read_product_early_redemption_history',
  'table_name' => 'product_early_redemption_history',
  'created_at' => '2025-03-15 23:08:58',
  'updated_at' => '2025-03-15 23:08:58',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 203],
            array (
  'id' => 203,
  'key' => 'edit_product_early_redemption_history',
  'table_name' => 'product_early_redemption_history',
  'created_at' => '2025-03-15 23:08:58',
  'updated_at' => '2025-03-15 23:08:58',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 204],
            array (
  'id' => 204,
  'key' => 'add_product_early_redemption_history',
  'table_name' => 'product_early_redemption_history',
  'created_at' => '2025-03-15 23:08:58',
  'updated_at' => '2025-03-15 23:08:58',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 205],
            array (
  'id' => 205,
  'key' => 'delete_product_early_redemption_history',
  'table_name' => 'product_early_redemption_history',
  'created_at' => '2025-03-15 23:08:58',
  'updated_at' => '2025-03-15 23:08:58',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 206],
            array (
  'id' => 206,
  'key' => 'browse_product_order_finance',
  'table_name' => 'product_order_finance',
  'created_at' => '2025-03-20 12:52:07',
  'updated_at' => '2025-03-20 12:52:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 207],
            array (
  'id' => 207,
  'key' => 'edit_product_order_finance',
  'table_name' => 'product_order_finance',
  'created_at' => '2025-03-20 12:52:07',
  'updated_at' => '2025-03-20 12:52:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 208],
            array (
  'id' => 208,
  'key' => 'browse_product_order_checker',
  'table_name' => 'product_order_checker',
  'created_at' => '2025-03-20 12:52:07',
  'updated_at' => '2025-03-20 12:52:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 209],
            array (
  'id' => 209,
  'key' => 'edit_product_order_checker',
  'table_name' => 'product_order_checker',
  'created_at' => '2025-03-20 12:52:07',
  'updated_at' => '2025-03-20 12:52:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 210],
            array (
  'id' => 210,
  'key' => 'browse_product_order_approver',
  'table_name' => 'product_order_approver',
  'created_at' => '2025-03-20 12:52:07',
  'updated_at' => '2025-03-20 12:52:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 211],
            array (
  'id' => 211,
  'key' => 'edit_product_order_approver',
  'table_name' => 'product_order_approver',
  'created_at' => '2025-03-20 12:52:07',
  'updated_at' => '2025-03-20 12:52:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 212],
            array (
  'id' => 212,
  'key' => 'browse_dividend_checker',
  'table_name' => 'dividend_checker',
  'created_at' => '2025-03-20 12:52:07',
  'updated_at' => '2025-03-20 12:52:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 213],
            array (
  'id' => 213,
  'key' => 'edit_dividend_checker',
  'table_name' => 'dividend_checker',
  'created_at' => '2025-03-20 12:52:07',
  'updated_at' => '2025-03-20 12:52:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 214],
            array (
  'id' => 214,
  'key' => 'browse_dividend_approval',
  'table_name' => 'dividend_approver',
  'created_at' => '2025-03-20 12:52:07',
  'updated_at' => '2025-03-20 12:52:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 215],
            array (
  'id' => 215,
  'key' => 'edit_dividend_approval',
  'table_name' => 'dividend_approver',
  'created_at' => '2025-03-20 12:52:07',
  'updated_at' => '2025-03-20 12:52:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 216],
            array (
  'id' => 216,
  'key' => 'browse_dividend_report',
  'table_name' => 'dividend_report',
  'created_at' => '2025-03-20 12:52:07',
  'updated_at' => '2025-03-20 12:52:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 217],
            array (
  'id' => 217,
  'key' => 'browse_commission_checker',
  'table_name' => 'commission_checker',
  'created_at' => '2025-03-20 12:52:07',
  'updated_at' => '2025-03-20 12:52:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 218],
            array (
  'id' => 218,
  'key' => 'edit_commission_checker',
  'table_name' => 'commission_checker',
  'created_at' => '2025-03-20 12:52:07',
  'updated_at' => '2025-03-20 12:52:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 219],
            array (
  'id' => 219,
  'key' => 'browse_commission_approval',
  'table_name' => 'commission_approver',
  'created_at' => '2025-03-20 12:52:07',
  'updated_at' => '2025-03-20 12:52:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 220],
            array (
  'id' => 220,
  'key' => 'edit_commission_approval',
  'table_name' => 'commission_approver',
  'created_at' => '2025-03-20 12:52:07',
  'updated_at' => '2025-03-20 12:52:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 221],
            array (
  'id' => 221,
  'key' => 'browse_agent_commission_dashboard',
  'table_name' => 'commission_dashboard',
  'created_at' => '2025-03-20 12:52:07',
  'updated_at' => '2025-03-20 12:52:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 222],
            array (
  'id' => 222,
  'key' => 'browse_withdrawal_checker',
  'table_name' => 'withdrawal_checker',
  'created_at' => '2025-03-20 12:52:07',
  'updated_at' => '2025-03-20 12:52:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 223],
            array (
  'id' => 223,
  'key' => 'read_withdrawal_checker',
  'table_name' => 'withdrawal_checker',
  'created_at' => '2025-03-20 12:52:07',
  'updated_at' => '2025-03-20 12:52:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 224],
            array (
  'id' => 224,
  'key' => 'edit_withdrawal_checker',
  'table_name' => 'withdrawal_checker',
  'created_at' => '2025-03-20 12:52:07',
  'updated_at' => '2025-03-20 12:52:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 225],
            array (
  'id' => 225,
  'key' => 'browse_withdrawal_approver',
  'table_name' => 'withdrawal_approver',
  'created_at' => '2025-03-20 12:52:07',
  'updated_at' => '2025-03-20 12:52:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 226],
            array (
  'id' => 226,
  'key' => 'read_withdrawal_approver',
  'table_name' => 'withdrawal_approver',
  'created_at' => '2025-03-20 12:52:07',
  'updated_at' => '2025-03-20 12:52:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 227],
            array (
  'id' => 227,
  'key' => 'edit_withdrawal_approver',
  'table_name' => 'withdrawal_approver',
  'created_at' => '2025-03-20 12:52:07',
  'updated_at' => '2025-03-20 12:52:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 228],
            array (
  'id' => 228,
  'key' => 'browse_redemption_checker',
  'table_name' => 'redemption_checker',
  'created_at' => '2025-03-20 12:52:07',
  'updated_at' => '2025-03-20 12:52:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 229],
            array (
  'id' => 229,
  'key' => 'edit_redemption_checker',
  'table_name' => 'redemption_checker',
  'created_at' => '2025-03-20 12:52:07',
  'updated_at' => '2025-03-20 12:52:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 230],
            array (
  'id' => 230,
  'key' => 'browse_redemption_approver',
  'table_name' => 'redemption_approver',
  'created_at' => '2025-03-20 12:52:07',
  'updated_at' => '2025-03-20 12:52:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 231],
            array (
  'id' => 231,
  'key' => 'edit_redemption_approver',
  'table_name' => 'redemption_approver',
  'created_at' => '2025-03-20 12:52:07',
  'updated_at' => '2025-03-20 12:52:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 232],
            array (
  'id' => 232,
  'key' => 'browse_agentdownline',
  'table_name' => 'agency',
  'created_at' => '2025-03-20 12:52:07',
  'updated_at' => '2025-03-20 12:52:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 233],
            array (
  'id' => 233,
  'key' => 'view_dashboard_sales',
  'table_name' => 'dashboard',
  'created_at' => '2025-03-20 14:36:00',
  'updated_at' => '2025-03-20 14:36:00',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 234],
            array (
  'id' => 234,
  'key' => 'view_dashboard_agent',
  'table_name' => 'dashboard',
  'created_at' => '2025-03-20 14:36:00',
  'updated_at' => '2025-03-20 14:36:00',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 235],
            array (
  'id' => 235,
  'key' => 'browse_agency_commission_dashboard',
  'table_name' => 'commission_dashboard',
  'created_at' => '2025-04-15 15:34:00',
  'updated_at' => '2025-04-15 15:34:00',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 236],
            array (
  'id' => 236,
  'key' => 'browse_early_redemption',
  'table_name' => 'early_redemption',
  'created_at' => '2025-05-16 17:27:51',
  'updated_at' => '2025-05-16 17:28:46',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 237],
            array (
  'id' => 237,
  'key' => 'add_early_redemption',
  'table_name' => 'early_redemption',
  'created_at' => '2025-05-16 17:28:54',
  'updated_at' => '2025-05-16 17:29:03',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 238],
            array (
  'id' => 238,
  'key' => 'read_early_redemption',
  'table_name' => 'early_redemption',
  'created_at' => '2025-05-16 17:29:05',
  'updated_at' => '2025-05-16 17:29:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 239],
            array (
  'id' => 239,
  'key' => 'edit_early_redemption',
  'table_name' => 'early_redemption',
  'created_at' => '2025-05-16 17:29:08',
  'updated_at' => '2025-05-16 17:29:11',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 240],
            array (
  'id' => 240,
  'key' => 'delete_early_redemption',
  'table_name' => 'early_redemption',
  'created_at' => '2025-05-16 17:31:37',
  'updated_at' => '2025-05-16 17:31:39',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 241],
            array (
  'id' => 241,
  'key' => 'browse_app_users',
  'table_name' => 'app_users',
  'created_at' => '2025-08-15 14:31:07',
  'updated_at' => '2025-08-15 14:31:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 242],
            array (
  'id' => 242,
  'key' => 'read_app_users',
  'table_name' => 'app_users',
  'created_at' => '2025-08-15 14:31:07',
  'updated_at' => '2025-08-15 14:31:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 243],
            array (
  'id' => 243,
  'key' => 'edit_app_users',
  'table_name' => 'app_users',
  'created_at' => '2025-08-15 14:31:07',
  'updated_at' => '2025-08-15 14:31:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 244],
            array (
  'id' => 244,
  'key' => 'add_app_users',
  'table_name' => 'app_users',
  'created_at' => '2025-08-15 14:31:07',
  'updated_at' => '2025-08-15 14:31:07',
)
        );
        DB::table('permissions')->updateOrInsert(
            ['id' => 245],
            array (
  'id' => 245,
  'key' => 'delete_app_users',
  'table_name' => 'app_users',
  'created_at' => '2025-08-15 14:31:07',
  'updated_at' => '2025-08-15 14:31:07',
)
        );
    }
}
