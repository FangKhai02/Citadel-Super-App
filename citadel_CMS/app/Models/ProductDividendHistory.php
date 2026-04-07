<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;


class ProductDividendHistory extends Model
{
    use HasFactory;
    protected $table = 'product_dividend_history';
    public $additional_attributes = ['approve_status'];

    public function getApproveStatusAttribute()
    {
        if( $this->status_checker == 'APPROVE_CHECKER' )
        {
            return str_replace('_', ' ', $this->status_approver);
        }
        else
            return str_replace('_', ' ', $this->status_checker);
    }
}
