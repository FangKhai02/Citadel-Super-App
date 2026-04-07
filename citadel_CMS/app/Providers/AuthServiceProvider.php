<?php

namespace App\Providers;

use App\Policies\MenuItemPolicy;
use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;
use Illuminate\Support\Facades\Gate;
use TCG\Voyager\Models\MenuItem;

class AuthServiceProvider extends ServiceProvider
{
    /**
     * The policy mappings for the application.
     *
     * @var array<class-string, class-string>
     */
    protected $policies = [
        // 'App\Models\Model' => 'App\Policies\ModelPolicy',
        MenuItem::class => MenuItemPolicy::class,
    ];

    protected $gates = [
        'browse_product_order_finance',
        'edit_product_order_finance',
        'browse_product_order_checker',
        'edit_product_order_checker',
        'browse_product_order_approver',
        'edit_product_order_approver',

        'browse_dividend_checker',
        'edit_dividend_checker',
        'browse_dividend_approval',
        'edit_dividend_approval',
        'browse_dividend_report',

        'browse_commission_checker',
        'edit_commission_checker',
        'browse_commission_approval',
        'edit_commission_approval',
        'browse_agent_commission_dashboard',
        'browse_agency_commission_dashboard',

        'browse_withdrawal_checker',
        'read_withdrawal_checker',
        'edit_withdrawal_checker',
        'browse_withdrawal_approver',
        'read_withdrawal_approver',
        'edit_withdrawal_approver',

        'browse_redemption_checker',
        'edit_redemption_checker',
        'browse_redemption_approver',
        'edit_redemption_approver',

        'browse_agentdownline',

        'view_dashboard_sales',
        'view_dashboard_agent',

        'browse_early_redemption',
        'add_early_redemption',
        'read_early_redemption',
        'edit_early_redemption',
        'delete_early_redemption'

    ];

    /**
     * Register any authentication / authorization services.
     *
     * @return void
     */
    public function boot()
    {
        $this->registerPolicies();

        // Gates
        foreach ($this->gates as $gate) {
            Gate::define($gate, function ($user) use ($gate) {
                return $user->hasPermission($gate);
            });
        }
    }
}
