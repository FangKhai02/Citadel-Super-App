<?php

namespace App\Models;

use Illuminate\Support\Carbon;
use App\Models\ProductAgreement;
use Illuminate\Support\Facades\Auth;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class DocumentType extends Model
{
    use HasFactory;
    protected $table = 'document_type'; // Use 'document_type' if your table is named 'document_type'

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

    public function productAgreements()
    {
        return $this->hasMany(ProductAgreement::class, 'document_type_id');
    }

    public function scopeActive($query)
    {
        return $query->where('status', 1);
    }
}
