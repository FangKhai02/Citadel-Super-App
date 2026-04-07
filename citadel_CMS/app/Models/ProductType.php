<?php

namespace App\Models;

use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class ProductType extends Model
{
    use HasFactory;
    protected $table = 'product_type'; // Use 'product_type' if your table is named 'product_type'

    public function scopeActive($query)
    {
        return $query->where('status', 1);
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

    public function product(){
        return $this->hasMany(Product::class, 'product_type_id');
    }
    
    public function productAgreementSchedules()
    {
        return $this->belongsToMany(ProductAgreementSchedule::class, 'product_agreement_schedule_pivot', 'product_type_id', 'product_agreement_schedule_id');
    }
}
