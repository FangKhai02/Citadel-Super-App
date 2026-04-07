<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\IndividualBeneficiaries;
use App\Models\IndividualGuardian;

class CorporateGuardian extends Model
{
    use HasFactory;

    protected $table = 'corporate_guardian';

    public function corporateClient()
    {
        return $this->belongsTo(CorporateBeneficiaries::class, 'corporate_client_id');
    }

    public function beneficiaries()
    {
        return $this->hasMany(CorporateBeneficiaries::class, 'company_guardian_id');
    }

}
