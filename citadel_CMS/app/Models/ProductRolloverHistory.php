<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;

class ProductRolloverHistory extends Model
{
    use HasFactory;
    protected $table = 'product_rollover_history';
    public $additional_attributes = ['client_name','agreement_number','agent_name','client_digital_id',
        'permanent_address','mobile_number','email_address','admin_email','id_number','approve_status','product_name','created_by_email'];

    public function client()
    {
        return $this->belongsTo(Client::class,'client_id'); // Foreign key is client_id by default
    }

    // Define the relationship to the CorporateClient model
    public function corporateClient()
    {
        return $this->belongsTo(CorporateClient::class, 'corporate_client_id'); // Foreign key is corporate_client_id
    }

    // Define the relationship to the Product model
    public function productOrder()
    {
        return $this->belongsTo(ProductOrder::class,'product_order_id');
    }

    public function getProductNameAttribute(){
        return $this->productOrder->product->name ?? '-';
    }

    public function getClientNameAttribute()
    {
        if( $this->productOrder->client_id != null)
        {
            return $this->productOrder->client->userDetails->name;
        }
        else if( $this->productOrder->corporate_client_id != null){
            return $this->productOrder->corporateClient->userDetails->name;
        }else
            return "-" ;
    }

    public function getAgreementNumberAttribute()
    {
        if ($this->productOrder) {
            return ($this->productOrder->agreement_file_name ?? '-');
        }
        return '-';
    }
    public function getClientDigitalIdAttribute()
    {
        if( $this->client_id != null)
        {
            return $this->client->client_id;
        }
        else if( $this->corporate_client_id != null){
            return $this->corporateClient->corporate_cient_id;
        }else
            return "No ID found, please add." ;
    }

    public function getPermanentAddressAttribute()
    {
        if( $this->client_id != null)
        {
            $userDetails = $this->client->userDetails;
            $address = $userDetails && $userDetails->address ? $userDetails->address : "";
            $city = $userDetails && $userDetails->city ? $userDetails->city : "";
            $postcode = $userDetails && $userDetails->postcode ? $userDetails->postcode : "";
            $state = $userDetails && $userDetails->state ? $userDetails->state : "";
            $country = $userDetails && $userDetails->country ? $userDetails->country : "";

            return trim($address . ' ' . $city . ' ' . $postcode . ' ' . $state . ' ' . $country);
        }
        else if( $this->corporate_client_id != null){
            $userDetails = $this->corporateClient->userDetails;
            $address = $userDetails && $userDetails->address ? $userDetails->address : "";
            $city = $userDetails && $userDetails->city ? $userDetails->city : "";
            $postcode = $userDetails && $userDetails->postcode ? $userDetails->postcode : "";
            $state = $userDetails && $userDetails->state ? $userDetails->state : "";
            $country = $userDetails && $userDetails->country ? $userDetails->country : "";

            return trim($address . ' ' . $city . ' ' . $postcode . ' ' . $state . ' ' . $country);
        }else
            return "No address found, please add";
    }

    public function getMobileNumberAttribute()
    {
        if( $this->client_id != null)
        {
            $countryCode = $this->client->userDetails->mobile_country_code ?? '';
            $mobileNumber = $this->client->userDetails->mobile_number ?? '';

            return $countryCode . ' ' . $mobileNumber;
        }
        else if( $this->corporate_client_id != null){
            $countryCode = $this->corpoarteClient->userDetails->mobile_country_code ?? '';
            $mobileNumber = $this->corporateClient->userDetails->mobile_number ?? '';

            return $countryCode . ' ' . $mobileNumber;
        }else
            return "No mobile number stored, please add." ;
    }

    public function getEmailAddressAttribute()
    {
        if( $this->client_id != null)
        {
            $email = $this->client->userDetails->email ?? '';

            return $email;
        }
        else if( $this->corporate_client_id != null){

            $email = $this->corporateClient->userDetails->email ?? '';

            return $email;
        }else
            return "No email stored, please add." ;
    }

    public function getAdminEmailAttribute()
    {
        $user = Auth::user(); // Get the authenticated user

        // Check if the user is not null and has an email
        if ($user && isset($user->email)) {
            return $user->email;
        }

        return null; // Return null if the user is not authenticated or email is not set
    }

    public function getIdNumberAttribute()
    {
        if( $this->client_id != null)
        {
            $email = $this->client->userDetails->identity_card_number ?? '';

            return $email;
        }
        else if( $this->corporate_client_id != null){

            $email = $this->corporateClient->userDetails->identity_card_number ?? '';

            return $email;
        }else
            return "No ID stored, please add." ;
    }

    public function appUser()
    {
        return $this->belongsTo(AppUser::class, 'created_by');
    }

    public function getCreatedByEmailAttribute()
    {
        return optional($this->appUser)->userDetails->email ?? '-';
    }

}
