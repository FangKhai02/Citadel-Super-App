<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class EmploymentDetails extends Model
{
    use HasFactory;

    protected $fillable = [
        'employment_type',
        'employer_name',
        'industry_type',
        'job_title',
        'employer_address',
        'employer_postcode',
        'employer_city',
        'employer_state',
        'employer_country'
    ];
    protected $table = 'employment_details'; // Use 'employment_details' if your table is named 'employment_details'

}
