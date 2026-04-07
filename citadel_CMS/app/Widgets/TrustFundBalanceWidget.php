<?php

namespace App\Widgets;

use Arrilot\Widgets\AbstractWidget;
use Illuminate\Support\Facades\DB;

class TrustFundBalanceWidget extends AbstractWidget
{
    protected $config = [];

    public function run()
    {
        // Fetch product fund balance
        $products = DB::table('product_order as po')
            ->join('product as p', 'po.product_id', '=', 'p.id')
            ->select(
                'p.code',
                'p.tranche_size',
                DB::raw('SUM(po.purchased_amount) as total_purchased'),
                DB::raw('(p.tranche_size - SUM(po.purchased_amount)) as balance')
            )
            ->groupBy('p.code', 'p.tranche_size')
            ->orderBy('p.code')
            ->get();

        return view('voyager::widgets.trustfund_balance', [
            'products' => $products
        ]);
    }
}
