<?php

namespace App\Models;

use App\Models\Product;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AgencyProduct extends Model
{
    use HasFactory;
    protected $table = 'agency_product';

    public function product()
    {
        return $this->belongsTo(Product::class, 'product_id');
    }

    public function agency()
    {
        return $this->belongsTo(Agency::class, 'agency_id');
    }

}
