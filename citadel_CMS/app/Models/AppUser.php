<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AppUser extends Model
{
    use HasFactory;

    protected $table = 'app_users';

    public function userDetails()
    {
        return $this->hasOne(UserDetails::class, 'app_user_id');
    }

    protected static function boot(): void
    {
        parent::boot();

        static::saved(function ($model) {
            $userDetails = $model->userDetails;
            if ($userDetails) {
                $userDetails->email = $model->email_address;
                $userDetails->save();
            }
        });
    }
}
