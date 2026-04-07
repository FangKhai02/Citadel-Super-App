<?php

namespace App\Widgets;

use Arrilot\Widgets\AbstractWidget;
use Illuminate\Support\Facades\DB;

class ClientsNationalityWidget extends AbstractWidget
{
    protected $config = [];

    public function run()
    {
        $nationalities = DB::table('user_details')
            ->select('nationality', DB::raw('COUNT(*) as user_count'))
            ->groupBy('nationality')
            ->orderByDesc('user_count')
            ->get();

        return view('voyager::widgets.nationality', [
            'nationalities' => $nationalities
        ]);
    }
}
