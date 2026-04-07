<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class WealthIncome extends Model
{
    use HasFactory;
    protected $fillable = [
        'annual_income_declaration',
        'source_of_income',
        'source_of_income_remark',
    ];
    protected $table = 'wealth_income'; // Use 'wealth_income' if your table is named 'individual_wealth_income'
}
