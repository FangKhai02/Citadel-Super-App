<?php

namespace App\Providers;

use Illuminate\Pagination\Paginator;
use Illuminate\Support\ServiceProvider;
use TCG\Voyager\Facades\Voyager;
use TCG\Voyager\Actions\EditAction;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        // Register your custom actions
        Voyager::addAction(\App\Actions\CustomAction::class);
        Voyager::replaceAction(EditAction::class,\App\Actions\CustomEditAction::class);
        Voyager::addFormField(\App\FormFields\MultipleFileHandler::class);
        Paginator::useBootstrap();
    }
}
