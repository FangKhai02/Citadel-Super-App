<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CorporateShareholdersPivot extends Model
{
    use HasFactory;

    protected $table = 'corporate_shareholders_pivot';  // Correct table name

    // Many-to-one relationship with CorporateClient
    public function corporateClient()
    {
        return $this->belongsTo(CorporateClient::class, 'corporate_client_id');
    }

    // Many-to-one relationship with CorporateShareholder
    public function corporateShareholder()
    {
        return $this->belongsTo(CorporateShareholders::class, 'corporate_shareholder_id');
    }
}
