<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Checker extends Model
{
    use HasFactory;
    protected $table = 'checker'; // Use 'checker' if your table is named 'checker'


    public function scopeStatus($query)
    {
        return 1;
    }
}


