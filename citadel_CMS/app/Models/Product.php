<?php
namespace App\Models;

use App\Models\Agency;
use App\Models\ProductType;
use App\Models\AgencyProduct;
use Illuminate\Support\Carbon;
use App\Models\ProductAgreement;
use App\Models\ProductRedemption;
use App\Models\Scopes\AgencyScope;
use Illuminate\Support\Facades\Auth;
use App\Models\ProductEarlyRedemption;
use Illuminate\Database\Eloquent\Model;
use App\Models\ProductAgreementSchedule;
use App\Models\AgentCommissionConfiguration;
use App\Models\AgencyCommissionConfiguration;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Product extends Model
{
    use HasFactory;
    protected $table = 'product'; // Use 'product' if your table is named 'product'
    public $additional_attributes = ['category','agency','reallocation_upon_maturity','agreement','product_type_name', 'product_agreement_name', 'product_agency_name'];

    protected static function booted()
    {
        static::addGlobalScope(new AgencyScope);
    }

    protected static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            if (empty($model->created_by)) {
                $model->created_at = Carbon::now();
                $model->created_by = Auth::user()->email;
            }
        });

        static::updating(function ($model) {
            // Only update `updated_by` field without modifying `created_by`
            $model->updated_by = Auth::user()->email;
            $model->updated_at = Carbon::now();
            // Make sure `created_by` is not being reset to null
            $model->created_by = $model->getOriginal('created_by');
        });
    }

    public function agencies()
    {
        return $this->belongsToMany(Agency::class, 'agency_product', 'product_id', 'agency_id');
    }
    public function productType()
    {
        return $this->belongsTo(ProductType::class, 'product_type_id');
    }
    public function productAgreement()
    {
        return $this->belongsToMany(ProductAgreement::class, ProductAgreementPivot::class,'product_id','product_agreement_id');
    }
    public function productEarlyRedemption()
    {
        return $this->hasMany(ProductEarlyRedemption::class, 'product_id');
    }
    public function agencyCommissionConfiguration()
    {
        return $this->hasMany(AgencyCommissionConfiguration::class, 'product_id');
    }
    public function agentCommissionConfiguration()
    {
        return $this->hasMany(AgentCommissionConfiguration::class, 'product_id');
    }
    public function productAgreementSchedule()
    {
        return $this->hasMany(ProductAgreementSchedule::class, 'product_id');
    }
    public function redemptionDetails()
    {
        return $this->hasMany(ProductRedemption::class); // product_id is the foreign key
    }

    public function agencyProduct()
    {
        return $this->hasMany(AgencyProduct::class);
    }

    // public function productAgency()
    // {
    //     return $this->hasMany(ProductAgency::class);
    // }

    public function productReallocation()
    {
        return $this->belongsToMany(Product::class, ProductReallocation::class, 'product_id', 'reallocate_product_id');
    }

    public function productTargetReturns()
    {
        return $this->hasMany(ProductTargetReturn::class, 'product_id', 'id');
    }
    public function productReallocationConfiguration()
    {
        return $this->belongsToMany(Product::class,ProductReallocationConfiguration::class,'product_id','reallocatable_product_id');
    }

    public function getCategoryAttribute()
    {
     return $this->productType->name;
    }

    public function getAgencyAttribute()
    {
        return optional($this->agencies->first())->agency_code;
    }

    public function getReallocationUponMaturityAttribute()
    {
        return $this->productReallocationConfiguration->pluck('code')->implode(', ');
    }

    public function getAgreementAttribute()
    {
        return $this->productAgreement->name ?? '-';
    }

}
