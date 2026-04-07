<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\UserDetails;
use App\Models\BankDetails;
use App\Models\Scopes\AgencyScope;
use Illuminate\Support\Facades\Auth;

class Agent extends Model
{
    use HasFactory;
    protected $table = 'agent'; // Use 'agent' if your table is named 'agent'
    public $additional_attributes = ['full_mobile_number', 'role_display_name', 'agent_name'];

    protected $fillable = [
        'user_detail_id',
        'agency_id',
        'referral_code',
        'recruit_manager',
        'bank_details_id',
        'status',
        'agent_role',
    ];

    protected static function booted()
    {
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
    }

    public function userDetails()
    {
        return $this->belongsTo(UserDetails::class, 'user_detail_id');
    }

    public function bankDetails()
    {
        return $this->hasOne(BankDetails::class, 'app_user_id', 'app_user_id');
    }

    public function agency() // Add this method to define the relationship
    {
        return $this->belongsTo(Agency::class, 'agency_id'); // Assuming 'agency_id' is the foreign key
    }

    public function appUser()
    {
        return $this->belongsTo(AppUser::class, 'app_user_id');
    }

    public function recruitManager()
    {
        return $this->belongsTo(Agent::class, 'recruit_manager_id');
    }

    public function role()
    {
        return $this->belongsTo(AgentRoleSettings::class, 'agent_role_id', 'id');
    }

    public function getRoleDisplayNameAttribute()
    {
        return $this->role->role_code;
    }

    public function getAgentNameAttribute()
    {
        return $this->userDetails->name;
    }

    /*********Agent Downline Management********/
    public function agentsUnder()
    {
        return $this->hasMany(Agent::class, 'recruit_manager_id');
    }

    public function scopeRecruiter($query)
    {
        $recruiterId = request()->id;
        // exclude id
        return $query->where('id', '!=', $recruiterId);
    }

}
