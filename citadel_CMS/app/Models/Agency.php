<?php

namespace App\Models;

use App\Models\Product;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;
use App\Models\Agent;

class Agency extends Model
{
    use HasFactory;
    protected $table = 'agency'; // Use 'agency' if your table is named 'agency'
    public $additional_attributes =['number_of_agents'];



    public function products()
    {
        return $this->belongsToMany(Product::class, 'agency_product'); // Use 'agency_product' if your pivot table is named 'agency_product'
    }

    // Agent to Agency Relationship
    public function agents()
    {
        return $this->hasMany(Agent::class,'agency_id');
    }

    public function agency()
    {
        return $this->hasOne(Agency::class,'id');
    }

    // Accessor for number_of_agents
    public function getNumberOfAgentsAttribute()
    {
        return $this->agents()->count();
    }

    protected static function boot()
    {

        parent::boot();

        static::creating(function ($model) {
            if (empty($model->created_by)) {
                $model->created_at = Carbon::now();
                $model->created_by = Auth::user()->email;
            }
        });

        static::updating(function ($model) {
            // Only update `updated_by` field without modifying `created_by`
            $model->updated_by = Auth::user()->email;
            $model->updated_at = Carbon::now();
            // Make sure `created_by` is not being reset to null
            $model->created_by = $model->getOriginal('created_by');
        });
    }
}
