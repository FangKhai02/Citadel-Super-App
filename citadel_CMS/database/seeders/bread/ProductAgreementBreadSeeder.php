<?php

namespace Database\Seeders\Bread;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ProductAgreementBreadSeeder extends Seeder
{
    public function run()
    {
        DB::table('data_types')->updateOrInsert(
            ['slug' => 'product-agreement'],
            array (
  'id' => 18,
  'name' => 'product_agreement',
  'slug' => 'product-agreement',
  'display_name_singular' => 'Product Agreement',
  'display_name_plural' => 'Product Agreements',
  'icon' => NULL,
  'model_name' => 'App\\Models\\ProductAgreement',
  'policy_name' => NULL,
  'controller' => 'App\\Http\\Controllers\\ProductAgreementController',
  'description' => NULL,
  'generate_permissions' => 1,
  'server_side' => 1,
  'details' => '{"order_column":"id","order_display_column":null,"order_direction":"desc","default_search_key":null,"scope":null}',
  'created_at' => '2024-09-30 08:51:50',
  'updated_at' => '2025-05-09 10:12:03',
)
        );

        DB::table('data_rows')->where('data_type_id', 18)->delete();

        DB::table('data_rows')->insert(array (
  'data_type_id' => 18,
  'field' => 'id',
  'type' => 'text',
  'display_name' => 'Document ID',
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
  'data_type_id' => 18,
  'field' => 'document_type_id',
  'type' => 'text',
  'display_name' => 'Document Type Id',
  'required' => 1,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"validation":{"rule":"required"}}',
  'order' => 5,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 18,
  'field' => 'name',
  'type' => 'text',
  'display_name' => 'Product Agreement Name',
  'required' => 1,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"validation":{"rule":"required"}}',
  'order' => 6,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 18,
  'field' => 'description',
  'type' => 'text',
  'display_name' => 'Product Agreement Description',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"validation":{"rule":"required"}}',
  'order' => 7,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 18,
  'field' => 'upload_document',
  'type' => 'file',
  'display_name' => 'Upload Document',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{}',
  'order' => 9,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 18,
  'field' => 'document_editor',
  'type' => 'rich_text_box',
  'display_name' => 'Document Editor',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 1,
  'add' => 0,
  'delete' => 1,
  'details' => '{}',
  'order' => 11,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 18,
  'field' => 'valid_from',
  'type' => 'timestamp',
  'display_name' => 'Valid From',
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
  'data_type_id' => 18,
  'field' => 'valid_until',
  'type' => 'timestamp',
  'display_name' => 'Valid Until',
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
  'data_type_id' => 18,
  'field' => 'status',
  'type' => 'checkbox',
  'display_name' => 'Status',
  'required' => 1,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"on":"Active","off":"Inactive","checked":false}',
  'order' => 14,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 18,
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
  'order' => 15,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 18,
  'field' => 'updated_at',
  'type' => 'timestamp',
  'display_name' => 'Updated At',
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
  'data_type_id' => 18,
  'field' => 'use_document_editor',
  'type' => 'checkbox',
  'display_name' => 'Use Document Editor',
  'required' => 0,
  'browse' => 0,
  'read' => 1,
  'edit' => 1,
  'add' => 0,
  'delete' => 1,
  'details' => '{"on":"Active","off":"Inactive","checked":false}',
  'order' => 10,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 18,
  'field' => 'product_agreement_belongsto_document_type_relationship',
  'type' => 'relationship',
  'display_name' => 'Document Type',
  'required' => 1,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"scope":"active","model":"App\\\\Models\\\\DocumentType","table":"document_type","type":"belongsTo","column":"document_type_id","key":"id","label":"name","pivot_table":"agency","pivot":"0","taggable":"0"}',
  'order' => 2,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 18,
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
  'order' => 16,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 18,
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
  'order' => 18,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 18,
  'field' => 'client_type',
  'type' => 'radio_btn',
  'display_name' => 'Client Type',
  'required' => 0,
  'browse' => 1,
  'read' => 1,
  'edit' => 1,
  'add' => 1,
  'delete' => 1,
  'details' => '{"default":"INDIVIDUAL","options":{"CORPORATE":"Corporate","INDIVIDUAL":"Individual"}}',
  'order' => 4,
));

        DB::table('data_rows')->insert(array (
  'data_type_id' => 18,
  'field' => 'overwrite_agreement_key',
  'type' => 'text',
  'display_name' => 'Overwrite Agreement Key',
  'required' => 0,
  'browse' => 0,
  'read' => 0,
  'edit' => 0,
  'add' => 0,
  'delete' => 0,
  'details' => '{}',
  'order' => 8,
));
    }
}
