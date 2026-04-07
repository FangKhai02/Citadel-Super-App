<?php
namespace App\Models;

use App\Models\Agency;
use App\Models\Agent;
use App\Models\AppUser;
use App\Models\BankDetails;
use App\Models\Client;
use App\Models\CorporateClient;
use App\Models\PaymentTransaction;
use App\Models\Product;
use App\Models\ProductBeneficiaries;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductOrder extends Model
{
    use HasFactory;

    protected $table = 'product_order'; // Use 'product_order' if your table is named 'product_order'
    public $additional_attributes = ['client_type', 'purchaser_id', 'client_name', 'order_type', 'formatted_amount','id_number'];

    protected static function boot()
    {
        parent::boot();
    }
    protected $casts = [
        'agreement_date'       => 'date',
        'start_tenure'         => 'date',
        'end_tenure'           => 'date',
        'period_starting_date' => 'date',
        'period_ending_date'   => 'date',
    ];

    public function client()
    {
        return $this->belongsTo(Client::class, 'client_id');
    }
    public function corporateClient()
    {
        return $this->belongsTo(CorporateClient::class, 'corporate_client_id');
    }
    public function product()
    {
        return $this->belongsTo(Product::class, 'product_id');
    }
    public function agent()
    {
        return $this->belongsTo(Agent::class, 'agent_id');
    }
    public function agency()
    {
        return $this->belongsTo(Agency::class, 'agency_id');
    }
    public function bankDetails()
    {
        return $this->belongsTo(BankDetails::class, 'bank_details_id');
    }
    public function paymentTransaction()
    {
        return $this->belongsTo(PaymentTransaction::class, 'payment_transaction_id');
    }
    public function createdBy()
    {
        return $this->belongsTo(AppUser::class, 'created_by');
    }
    public function productBeneficiaries()
    {
        return $this->hasMany(ProductBeneficiaries::class, 'product_order_id');
    }
    public function productOrder()
    {
        return $this->hasOne(ProductOrder::class, 'id', 'id');
    }

    // Accessor for client type
    public function getClientTypeAttribute()
    {
        return $this->client_id ? 'Individual' : 'Corporate';
    }

    // Accessor for client ID
    public function getPurchaserIDAttribute()
    {
        if ($this->client_id && $this->client) {
            return $this->client->client_id;
        } else if ($this->corporate_client_id && $this->corporateClient) {
            return $this->corporateClient->corporate_client_id;
        } else {
            // Fallback if neither exists
            return 'N/A';
        }
    }

    public function getClientNameAttribute()
    {
        if ($this->client_id && $this->client) {
            return $this->client->userDetails->name;
        } else if ($this->corporate_client_id && $this->corporateClient) {
            return $this->corporateClient->corporateDetail->entity_name;
        } else {
            // Fallback if neither exists
            return 'N/A';
        }
    }

    public function getOrderTypeAttribute()
    {
        $agreementFileName = $this->agreement_file_name;
        // If there's no file name, return "NEW"
        if (empty($agreementFileName)) {
            return 'NEW';
        }

        // If the file name contains "REALLOCATE", return "REALLOCATE"
        if (strpos($agreementFileName, 'REALLOCATE') !== false) {
            return 'REALLOCATE';
        }

        // If the file name contains "ROLLOVER", return "ROLLOVER"
        if (strpos($agreementFileName, 'ROLLOVER') !== false) {
            return 'ROLLOVER';
        }

        // Otherwise, return "NEW"
        return 'NEW';

    }

    public function getFormattedAmountAttribute()
    {
        return number_format($this->purchased_amount, 2, '.', ',');
    }

    public function getIdNumberAttribute()
    {
        if ($this->client_id && $this->client) {
            return $this->client->userDetails->identity_card_number;
        } else if ($this->corporate_client_id && $this->corporateClient) {
            return $this->corporateClient->corporateDetail->registration_number;
        } else {
            // Fallback if neither exists
            return 'N/A';
        }
    }
}
