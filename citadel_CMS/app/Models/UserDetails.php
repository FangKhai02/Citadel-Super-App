<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Agent;

class UserDetails extends Model
{
    use HasFactory;
    protected $table = 'user_details'; // Use 'user_details' if your table is named 'user_details'
    public $additional_attributes = ['full_mobile_number'];
    protected $fillable = [
        'name',
        'identity_card_number',
        'dob',
        'mobile_number',
        'email',
        'address',
        'city',
        'state',
        'postcode',
        'country',
        'identity_card_front_image_key',
        'identity_card_back_image_key',
        'selfie_image_key',
//        'proof_of_address_file_key',
        'onboarding_agreement_key'
        // Add any other fields you want to allow
    ];
    public function agents()
    {
        return $this->hasOne(Agent::class, 'user_detail_id'); // has one Agent
    }

    public function getFullMobileNumberAttribute()
    {
        $countryCode = $this->mobile_country_code ?? '';
        $mobileNumber = $this->mobile_number ?? '';

        return $countryCode . ' ' . $mobileNumber;
    }
}
