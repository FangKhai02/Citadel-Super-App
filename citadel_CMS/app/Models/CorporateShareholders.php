<?php

namespace App\Models;


use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;


class CorporateShareholders extends Model
{
    use HasFactory;
    protected $table = 'corporate_shareholders';
    protected $fillable = ['client_id'];

    public function corporateClients()
    {
        return $this->belongsToMany(CorporateClient::class, 'corporate_shareholders_pivot', 'corporate_shareholder_id', 'corporate_client_id');
    }

    public function pepInfo()
    {
        return $this->belongsTo(PepInfo::class, 'pep_info');
    }

    public function client()
    {
        return $this->belongsTo(Client::class, 'client_id');
    }
}
