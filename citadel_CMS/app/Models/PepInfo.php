<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PepInfo extends Model
{
    use HasFactory;
    protected $table = 'pep_info'; // Use 'individual_pep_info' if your table is named 'individual_pep_info'

    protected $fillable = [
        'pep',
        'pep_type',
        'pep_immediate_family_name',
        'pep_position',
        'pep_organisation'
    ];
}
