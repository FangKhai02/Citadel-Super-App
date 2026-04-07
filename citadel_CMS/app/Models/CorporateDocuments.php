<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CorporateDocuments extends Model
{
    use HasFactory;

    protected $table = 'corporate_documents';

    protected $fillable = [ 'corporate_details_id' , 'company_document_key'];

    public function corporateDetails()
    {
        return $this->belongsTo(CorporateDetails::class, 'corporate_details_id');
    }
}
