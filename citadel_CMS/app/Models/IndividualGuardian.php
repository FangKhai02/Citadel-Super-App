<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\IndividualGuardian;


class IndividualGuardian extends Model
{
    use HasFactory;

    protected $table = 'individual_guardian'; // Use 'individual_guardian' if your table is named 'individual_guardian'
    protected $fillable = [
        'full_name',
        'identity_card_number',
        'dob',
        'gender',
        'nationality',
        'address',
        'postcode',
        'city',
        'state',
        'country',
        'residential_status',
        'marital_status',
        'mobile_number',
        'email',
        'ic_document_key',
        'address_proof_key',
    ];

//    public function beneficiaries()
//    {
//        return $this->hasMany(IndividualBeneficiaries::class, 'guardian_id' , 'id');
//    }

    public function client()
    {
        return $this->belongsTo(Client::class);
    }

    public function beneficiaries()
    {
        return $this->belongsToMany(
            IndividualBeneficiaries::class, // Related Model
            IndividualBeneficiaryGuardian::class, // Pivot Table
            'individual_guardian_id', // Foreign Key on Pivot Table for Guardian
            'individual_beneficiary_id' // Foreign Key on Pivot Table for Beneficiary
        )->withPivot('relationship_to_beneficiary');
    }

    public function pivot($beneficiaryId)
    {
        return $this->hasOne(IndividualBeneficiaryGuardian::class, 'individual_guardian_id', 'id')
            ->where('individual_beneficiary_id', $beneficiaryId)
            ->where('is_deleted', false);
    }
}
