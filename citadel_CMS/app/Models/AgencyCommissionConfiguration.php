<?php

namespace App\Models;

use App\Models\Product;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class AgencyCommissionConfiguration extends Model
{
    use HasFactory;
    protected $table = 'agency_commission_configuration';
    public $additional_attributes = ['formatted_threshold'];
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

    public function product()
    {
        return $this->belongsTo(Product::class, 'product_id');
    }



    public function productType()
    {
        return $this->belongsTo(ProductType::class, 'product_id');
    }


    public function getFormattedThresholdAttribute()
    {
        return number_format($this->threshold, 2, '.', ',');
    }
}
