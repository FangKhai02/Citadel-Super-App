<?php

namespace App\Providers;


use Illuminate\Support\ServiceProvider;
use TCG\Voyager\Facades\Voyager;
use Illuminate\Support\Facades\Request;
use TCG\Voyager\Http\Controllers\VoyagerController as BaseVoyagerController;
use App\Http\Controllers\Voyager\VoyagerController;

class VoyagerDashboardServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     *
     * @return void
     */
    public function register()
    {
        $this->app->bind(BaseVoyagerController::class, VoyagerController::class);
        //
    }

    /**
     * Bootstrap services.
     *
     * @return void
     */
    public function boot()
    {
        //
    }
}
