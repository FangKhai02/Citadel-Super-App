<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\IndividualBeneficiaries;
use App\Models\IndividualGuardian;

class IndividualBeneficiaryGuardian extends Model
{
    use HasFactory;

    protected $table = 'individual_beneficiary_guardian'; // Use 'individual_beneficiary_guardian' if your table is named 'individual_beneficiary_guardian'

    // Define the relationship to IndividualBeneficiaries
    public function beneficiary()
    {
        return $this->belongsTo(IndividualBeneficiaries::class, 'individual_beneficiary_id');
    }

    // Define the relationship to IndividualGuardian
    public function guardian()
    {
        return $this->belongsTo(IndividualGuardian::class, 'individual_guardian_id');
    }

}
