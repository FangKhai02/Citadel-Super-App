<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CorporateBeneficiaries extends Model
{
    use HasFactory;

    protected $table = 'corporate_beneficiaries';

    public function corporateGuardians()
    {
        return $this->belongsTo(CorporateGuardian::class, 'company_guardian_id');
    }

}
