<?php

namespace Database\Seeders\Bread;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class AppUsersBreadSeeder extends Seeder
{
    public function run()
    {
        DB::table('data_types')->updateOrInsert(
            ['slug' => 'app-users'],
            array (
  'id' => 44,
  'name' => 'app_users',
  'slug' => 'app-users',
  'display_name_singular' => 'App User',
  'display_name_plural' => 'App Users',
  'icon' => 'voyager-mail',
  'model_name' => 'App\\Models\\AppUser',
  'policy_name' => NULL,
  'controller' => 'App\\Http\\Controllers\\AppUserController',
  'description' => NULL,
  'generate_permissions' => 1,
  'server_side' => 1,
  'details' => '{"order_column":null,"order_display_column":null,"order_direction":"asc","default_search_key":null,"scope":null}',
  'created_at' => '2025-08-15 14:31:06',
  'updated_at' => '2025-08-15 15:00:33',
)
        );

        DB::table('data_rows')->where('data_type_id', 44)->delete();

        DB::table('data_rows')->insert(array (
  'data_type_id' => 44,
  'field' => 'id',
  'type' => 'text',
  'display_name' => 'Id',
  'required' => 1,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 1,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 44,
  'field' => 'email_address',
  'type' => 'text',
  'display_name' => 'Email Address',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 0,
  'details' => '{}',
  'order' => 2,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 44,
  'field' => 'password',
  'type' => 'text',
  'display_name' => 'Password',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 3,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 44,
  'field' => 'user_type',
  'type' => 'text',
  'display_name' => 'User Type',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 4,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 44,
  'field' => 'created_at',
  'type' => 'timestamp',
  'display_name' => 'Created At',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 5,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 44,
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
  'order' => 6,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 44,
  'field' => 'is_deleted',
  'type' => 'text',
  'display_name' => 'Is Deleted',
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
  'data_type_id' => 44,
  'field' => 'app_user_hasone_client_relationship',
  'type' => 'relationship',
  'display_name' => 'Client',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\Client","table":"client","type":"hasOne","column":"app_user_id","key":"id","label":"client_id","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 8,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 44,
  'field' => 'app_user_hasone_agent_relationship',
  'type' => 'relationship',
  'display_name' => 'Agent',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\Agent","table":"agent","type":"hasOne","column":"app_user_id","key":"id","label":"agent_id","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 9,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 44,
  'field' => 'app_user_hasone_user_detail_relationship',
  'type' => 'relationship',
  'display_name' => 'UserDetails Email',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{"model":"App\\\\Models\\\\UserDetails","table":"user_details","type":"hasOne","column":"app_user_id","key":"id","label":"email","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 10,
));

    }
}
