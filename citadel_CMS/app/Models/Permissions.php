<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use TCG\Voyager\Models\Permission;

class Permissions extends Model
{
    use HasFactory;

    protected $table = 'permissions'; // Use 'wealth_income' if your table is named 'individual_wealth_income'

}
