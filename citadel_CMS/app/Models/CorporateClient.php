<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Scopes\AgencyScope;

class CorporateClient extends Model
{
    use HasFactory;

    protected $table = 'corporate_client';
    public $additional_attributes = ['corporate_id','corporate_name','registration_number','agent_name','agency_name'];

    protected static function booted()
    {
        static::addGlobalScope(new AgencyScope);

        static::addGlobalScope('activeStatus', function ($query) {
            $query->where('is_deleted', 0)
                ->whereExists(function ($subQuery) {
                    $subQuery->select('id')
                        ->from('client')
                        ->whereColumn('client.id', 'corporate_client.client_id')
                        ->where('client.status', 1);
                });
        });
    }


    public function agency()
    {
        return $this->client->agent->agency;
    }
    // Relationship with Client
    public function client()
    {
        return $this->belongsTo(Client::class, 'client_id'); // Foreign key in corporate_client
    }

    // Relationship with UserDetails
    public function userDetails()
    {
        return $this->belongsTo(UserDetails::class, 'user_detail_id'); // Foreign key in corporate_client
    }

    public function corporateDetail()
    {
        return $this->belongsTo(CorporateDetails::class, 'corporate_details_id');
    }

    public function corporateShareholders()
    {
        return $this->belongsToMany(CorporateShareholders::class, 'corporate_shareholders_pivot', 'corporate_client_id', 'corporate_shareholder_id');
    }

    public function corporateBankDetails()
    {
        return $this->hasMany(CorporateBankDetails::class,'corporate_client_id');
    }
    public function corporateBeneficiaries()
    {
        return $this->hasMany(CorporateBeneficiaries::class, 'corporate_client_id');
    }
    public function redemptionDetails()
    {
        return $this->hasMany(ProductRedemption::class, 'corporate_client_id'); // corporate_client_id is the foreign key
    }

    public function getCorporateIdAttribute()
    {

        if( $this->corporate_client_id != null){
            return $this->corporate_client_id;
        }else
            return "-" ;
    }

    public function getCorporateNameAttribute()
    {
        return $this->corporateDetail ? $this->corporateDetail->entity_name : 'N/A';
    }

    public function getRegistrationNumberAttribute()
    {
        $registrationNumber = $this->corporateDetail->registration_number;

        return $registrationNumber;
    }

    public function getAgentNameAttribute()
    {
        // Check if the agent exists before trying to access the userDetails
        if ($this->client && $this->client->agent) {
            // Access the agent's userDetails and return the name
            return $this->client->agent->userDetails->name ?? 'No agent assigned';
        }

        // Return a default message if there's no agent
        return 'No agent assigned';
    }

    public function getAgencyNameAttribute(){
        if ($this->client && $this->client->agent) {
            // Access the agent's userDetails and return the name
            return $this->client->agent->agency->agency_name ?? 'No agent assigned';
        }
        return 'No agent assigned';
    }

}
