<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BankDetails extends Model
{
    use HasFactory;

    protected $table = 'bank_details';
    protected $fillable = [
        'app_user_id',
        'individual_beneficiary_id',
        'corporate_shareholders_id',
        'agency_id',
        'bank_name',
        'account_number',
        'account_holder_name',
        'bank_address',
        'postcode',
        'city',
        'state',
        'country',
        'swift_code',
        'bank_account_proof_key',
        'is_deleted',
    ];
}
