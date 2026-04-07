<?php

namespace App\Models;

use App\Models\DocumentType;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class ProductAgreement extends Model
{
    use HasFactory;
    protected $table = 'product_agreement'; // Use 'product_agreement' if your table is named 'product_agreement'

    protected $fillable = [
        'document_id',
        'document_editor',
        'use_document_editor',
        'name',
        'description',
        'status',
        'valid_from',
        'valid_until',
        'created_by',
        'updated_by'
    ];

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

    public function documentType()
    {
        return $this->belongsTo(DocumentType::class, 'document_id');
    }


    public function scopeActive($query)
    {
        return $query->where('status', 1);
    }
}
