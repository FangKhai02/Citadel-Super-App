<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;



class Roles extends Model
{
    use HasFactory;

    protected $table = 'roles'; // Use 'wealth_income' if your table is named 'individual_wealth_income'


        public function permissions()
    {
        return $this->belongsToMany(Permissions::class, 'permission_role', 'role_id', 'permission_id');
    }

}
