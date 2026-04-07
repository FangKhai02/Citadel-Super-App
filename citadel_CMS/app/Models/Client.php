<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Scopes\AgencyScope;
use Illuminate\Support\Facades\Auth;

class Client extends Model
{
    use HasFactory;
    protected $table = 'client';
    protected static function booted()
    {
        // filter by agency
        static::addGlobalScope(new AgencyScope);
    }
    protected static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            if (Auth::check()) {
                $model->created_by = Auth::user()->email;
            }
        });

        static::updating(function ($model) {
            if (Auth::check()) {
                $model->updated_by = Auth::user()->email;
                // Make sure `created_by` is not being reset to null
                $model->created_by = $model->getOriginal('created_by');
            }

        });

        static::addGlobalScope('activeStatus', function ($query) {
            $query->where('status', 1);
        });
    }
    public $additional_attributes = ['agent_agency_name','full_mobile_number'];

    public function agent() {
        return $this->belongsTo(Agent::class, 'agent_id');
    }


    public function getAgency()
    {
        return $this->agent->agency;
    }

    public function appUser() {
        return $this->belongsTo(AppUser::class, 'app_user_id');
    }

    public function userDetails() {
        return $this->belongsTo(UserDetails::class, 'user_detail_id');
    }

    public function employmentDetails() {
        return $this->hasOne(EmploymentDetails::class, 'client_id');
    }

    public function bankDetails()
    {
        return $this->hasMany(BankDetails::class, 'app_user_id', 'app_user_id');
    }

    public function beneficiaries()
    {
        return $this->hasMany(IndividualBeneficiaries::class, 'client_id', 'id');
    }

    public function beneficiaryGuardians()
    {
        return $this->hasMany(IndividualGuardian::class, 'client_id', 'id');
    }

    // Define the inverse relationship to the RedemptionDetail model
    public function productRedemption()
    {
        return $this->hasMany(ProductRedemption::class); // client_id is the foreign key
    }

    public function corporateClient() {
        return $this->hasOne(CorporateClient::class, 'client_id');
    }

    public function getAgentAgencyNameAttribute()
    {
        $agencyName = $this->agent && $this->agent->agency ? $this->agent->agency->agency_name : 'N/A';

        return $agencyName;
    }

    public function getFullMobileNumberAttribute()
    {
        $countryCode = $this->userDetails->mobile_country_code ?? '';
        $mobileNumber = $this->userDetails->mobile_number ?? '';

        return $countryCode . ' ' . $mobileNumber;
    }

    public function scopeActive($query) {
        return $query->where('status', 1);
    }

    public function getName()
    {
        return $this->userDetails ? $this->userDetails->name : 'N/A';
    }
}
