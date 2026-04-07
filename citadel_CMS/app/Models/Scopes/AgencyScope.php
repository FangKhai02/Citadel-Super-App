<?php

namespace App\Models\Scopes;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Scope;
use App\Models\Agent;
use App\Models\Client;

class AgencyScope implements Scope
{
    public function apply(Builder $builder, Model $model)
    {
        if (auth()->check() && auth()->user()->agency_id) {
            if ($model instanceof Client) {
                // For Client model, filter via agent relationship
                $builder->whereHas('agent', function (Builder $query) {
                    $query->where('agency_id', auth()->user()->agency_id);
                });
            } elseif ($model instanceof Agent) {
                // For Agent model, directly filter by agency_id
                $builder->where('agency_id', auth()->user()->agency_id);
            }
            elseif ($model instanceof \App\Models\CorporateClient) {
                // Filter CorporateClient via nested relationships
                $builder->whereHas('client.agent', function (Builder $query) {
                    $query->where('agency_id', auth()->user()->agency_id);
                });
            }
            elseif ($model instanceof \App\Models\Product) 
            {
                // For Product model, filter via agencies relationship (many-to-many)
                $builder->whereHas('agencies', function (Builder $query) {
                    $query->where('agency_product.agency_id', auth()->user()->agency_id);
                });
            }
        }
    }
}
