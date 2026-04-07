<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Agent;
use App\Models\UserDetails;
use App\Models\BankDetails;
use App\Models\EmploymentDetails;
use App\Models\IndividualBeneficiaries;
use App\Models\IndividualGuardian;

class ProductCommissionHistory extends Model
{
    use HasFactory;

    protected $table = 'product_commission_history';
    public $additional_attributes = ['approve_status'];

    public function getApproveStatusAttribute()
    {
        if( $this->status_checker == 'APPROVE_CHECKER' )
        {
            return str_replace('_', ' ', $this->status_approver);
        }
        else
            return str_replace('_', ' ', $this->status_checker);
    }
}
