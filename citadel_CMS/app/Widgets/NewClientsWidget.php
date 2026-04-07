<?php

namespace App\Widgets;

use Arrilot\Widgets\AbstractWidget;
use Illuminate\Support\Facades\DB;

class NewClientsWidget extends AbstractWidget
{
    protected $config = [];

    public function run()
    {
        // where user
        $daily = DB::table('app_users')->where('user_type', 'CLIENT')->whereDate('created_at', today())->count();
        $monthly = DB::table('app_users')->where('user_type', 'CLIENT')->whereMonth('created_at', date('m'))->count();
        $yearly = DB::table('app_users')->where('user_type', 'CLIENT')->whereYear('created_at', date('Y'))->count();

        return view('voyager::widgets.number_card', [
            'title' => 'New Clients',
            'data' => [
                'daily' => $daily,
                'monthly' => $monthly,
                'yearly' => $yearly,
            ],
        ]);
    }
}
