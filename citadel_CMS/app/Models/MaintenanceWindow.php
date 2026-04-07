<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;

class MaintenanceWindow extends Model
{
    use HasFactory;
    protected $table = 'maintenance_window';

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
