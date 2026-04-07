<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CorporateBankDetails extends Model
{
    use HasFactory;

    protected $table = 'corporate_bank_details';

    protected $fillable = [
        'corporate_client_id',   // Foreign key to associate with CorporateClient
        'bank_name',             // Name of the bank
        'account_number',        // Bank account number
        'account_holder_name',   // Name of the account holder
        'bank_address',          // Address of the bank
        'postcode',              // Postcode of the bank's location
        'city',                  // City of the bank's location
        'state',                 // State of the bank's location
        'country',               // Country of the bank
        'swift_code',            // SWIFT/BIC code for international transactions
        'bank_account_proof_key' // File key for the bank account proof document
    ];

}
