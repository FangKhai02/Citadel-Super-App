<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CorporateDetails extends Model
{
    use HasFactory;

    protected $table = 'corporate_details';

    public function corporateClient()
    {
        return $this->hasOne(CorporateClient::class,'corporate_details_id');
    }
    protected $fillable = [
        'entity_name',
        'entity_type',
        'registration_number',
        'date_incorporation',
        'place_incorporation',
        'business_type',
        'registered_address',
        'postcode',
        'city',
        'state',
        'country',
        'business_address',
        'business_postcode',
        'business_city',
        'business_state',
        'registered_address_postcode',
        'registered_address_city',
        'registered_address_state',
        'selfie_image_key',
        'business_country',
        'digital_signature_key',
        'company_document',
    ];

}
