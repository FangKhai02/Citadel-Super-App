<?php

namespace App\Policies;

use Illuminate\Support\Facades\Log;
use TCG\Voyager\Contracts\User;
use TCG\Voyager\Facades\Voyager;
use TCG\Voyager\Policies\MenuItemPolicy as VoyagerMenuItemPolicy;
use Illuminate\Auth\Access\HandlesAuthorization;

class MenuItemPolicy extends VoyagerMenuItemPolicy
{
    use HandlesAuthorization;

    protected function checkPermission(User $user, $model, $action)
    {
//        Log::info('MenuItemPolicy: Checking permission...', [
//            'user_role' => $user->role->name ?? 'Unknown',
//            'menu_item' => $model->title ?? 'Unknown',
//            'menu_url' => $model->url ?? 'Unknown',
//            'action' => $action
//        ]);

        if (self::$permissions == null) {
            self::$permissions = Voyager::model('Permission')->all();
        }

        if (self::$datatypes == null) {
            self::$datatypes = Voyager::model('DataType')::all()->keyBy('slug');
        }

        $regex = str_replace('/', '\/', preg_quote(route('voyager.dashboard')));
        $slug = preg_replace('/'.$regex.'/', '', $model->link(true));
        $slug = str_replace('/', '', $slug);

//        Log::info('Slug determined:', ['slug' => $slug]);

        if ($slug === 'dividend-history') {
            $slug = 'product_dividend_history';
        }
        if ($slug === 'downline') {
            $slug = 'agentdownline';
        }

        $slug = str_replace('-', '_', $slug);

        if ($str = self::$datatypes->get($slug)) {
            $slug = $str->name;
        }
//        Log::info('(2) Slug determined:', ['slug' => $slug]);

        if ($slug == '') {
            $slug = 'admin';
        } elseif ($slug == 'compass' && !\App::environment('local') && !config('voyager.compass_in_production', false)) {
            return false;
        }

        if (empty($action)) {
            $action = 'browse';
        }

//        Log::info('Checking permission:', ['permission' => $action . '_' . $slug]);

        // If permission doesn't exist, we can't check it!
        if (!self::$permissions->contains('key', $action.'_'.$slug)) {
            Log::info('Permission check result:', [
                'No Permission'
            ]);
            return true;
        }

        $hasPermission = $user->hasPermission($action . '_' . $slug);

//        Log::info('Permission check result:', [
//            'user_has_permission' => $hasPermission
//        ]);

        return $hasPermission;
    }
}
