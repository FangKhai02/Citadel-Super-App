<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\IndividualBeneficiaryGuardian;

class IndividualBeneficiaries extends Model
{
    use HasFactory;

    protected $table = 'individual_beneficiaries'; // Use 'individual_beneficiary' if your table is named 'individual_beneficiary'

    // Define the relationship to the pivot table
//    public function guardians()
//    {
//        return $this->belongsTo(IndividualGuardian::class, 'guardian_id');
//    }

    public function guardians()
    {
        return $this->hasManyThrough(
            IndividualGuardian::class,
            IndividualBeneficiaryGuardian::class,
            'individual_beneficiary_id', // Foreign key on pivot table
            'id', // Foreign key on guardians table
            'id', // Local key on beneficiaries table
            'individual_guardian_id' // Local key on pivot table
        );
    }
}
