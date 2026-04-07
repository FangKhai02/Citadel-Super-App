<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\IndividualBeneficiaries;

class ProductBeneficiaries extends Model
{
    protected $table = 'product_beneficiaries';
    use HasFactory;

    public function clientBeneficiary()
    {
        return $this->hasMany(IndividualBeneficiaries::class, 'id', 'individual_beneficiary_id');
    }

    public function corporateBeneficiary()
    {
        return $this->hasMany(CorporateBeneficiaries::class, 'id','corporate_beneficiary_id');
    }
}
