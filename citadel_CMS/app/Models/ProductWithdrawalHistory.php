<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\ProductOrder;

class ProductWithdrawalHistory extends Model
{
    use HasFactory;
    protected $table = 'product_early_redemption_history';
    public $additional_attributes = ['client_name','formatted_withdrawal_amount','formatted_penalty_amount'];

    //belong to many product order
    public function productOrder()
    {
        return $this->belongsTo(ProductOrder::class, 'product_order_id', 'id');
    }

    public function getClientNameAttribute()
    {
        if ($this->productOrder->client_id != null) {
            return $this->productOrder->client->userDetails->name;
        } else if ($this->productOrder->corporateClient != null) {
            return $this->productOrder->corporateClient->corporateDetail->entity_name;
        } else {
            // Fallback if neither exists
            return 'N/A';
        }
    }

    public function getFormattedWithdrawalAmountAttribute()
    {
        return number_format($this->withdrawal_amount, 2, '.', ',');
    }

    public function getFormattedPenaltyAmountAttribute()
    {
        return number_format($this->penalty_amount, 2, '.', ',');
    }
}
